module ex_alu (
    // Input
    input logic i_clk,
    input logic i_reset_n,
    input logic [31:0] i_A,
    input logic [31:0] i_B,
    input macro_pkg::alu_ctrl_t i_ctrlALU,  //ALU OP(2), Func3(3), Func7(7)
    
    // Enable/Stallun
    input logic en_ALU,
    output logic o_stall,

    //Output
    output logic [31:0] o_result,
    output logic o_zero
);

    // Internal Signals
    macro_pkg::dsp_bus_t mult;
    macro_pkg::dsp_bus_t multSU;
    macro_pkg::dsp_bus_t multU;
    macro_pkg::dsp_bus_t div;
    macro_pkg::dsp_bus_t divU;
    logic w_dspEn;
    logic w_dspDone;


    // Combinational Logic
    always_comb begin
        // DSP routing
        // [64] en, [63:32] A, [31:0] B                     (driven here)
        // [128:65] Output, [129] done(mult doesn't use)    (driven by DSP)
        mult[64:0] = 0;
        mult.done = 0;
        multSU[64:0] = 0;
        multSU.done = 0;
        multU[64:0] = 0;
        multU.done = 0;
        div[64:0] = 0;
        divU[64:0] = 0;
        w_dspDone = 0;


        o_zero = 1'b0;


        case (i_ctrlALU.aluOp)
            2'b00:      // Load/Store
                o_result = i_A + i_B;
            2'b01:      // Branch
            begin
                case (i_ctrlALU.func3)
                    3'b000: o_zero = (i_A == i_B);  // BEQ
                    3'b001: o_zero = (i_A != i_B);  // BNE
                    3'b100: o_zero = ($signed(i_A) < $signed(i_B));  // BLT
                    3'b101: o_zero = ($signed(i_A) >= $signed(i_B)); // BGE
                    3'b110: o_zero = (i_A < i_B);    // BLTU
                    3'b111: o_zero = (i_A >= i_B);   // BGEU
                    default:
                        o_zero = 1'b0;
                endcase
                o_result = i_A - i_B;
            end
            2'b10:      // OP instruction, if m-extension, overwrite o_result later
            begin
                case (i_ctrlALU.func3)
                    3'b000:   // ADD / SUB
                        case (i_ctrlALU.func7)
                            7'b000_0000: o_result = i_A + i_B;    // ADD
                            7'b010_0000: o_result = i_A - i_B;    // SUB
                            default : o_result = 32'b0;
                        endcase
                    3'b001:   // SLL
                        o_result = i_A << i_B[4:0];
                    3'b010:   // SLT
                        if( $signed(i_A) < $signed(i_B) ) begin
                            o_result = 32'd1;
                        end else begin
                            o_result = 32'b0;
                        end
                    3'b011:
                        if( i_A < i_B ) begin
                            o_result = 32'd1;
                        end else begin
                            o_result = 32'b0;
                        end
                    3'b100:   // XOR
                        o_result = i_A ^ i_B;
                    3'b101:   // SRL / SRA
                        case (i_ctrlALU.func7)
                            7'b000_0000: o_result = i_A >> i_B[4:0];    // SRL
                            7'b010_0000: o_result = $signed(i_A) >>> i_B[4:0]; // SRA
                            default : o_result = 32'b0;
                        endcase
                    3'b110:   // OR
                        o_result = i_A | i_B;
                    3'b111:   // AND
                        o_result = i_A & i_B;
                    default : o_result = 32'b0;
                endcase

                if(i_ctrlALU.func7 == 7'b000_0001) begin    // m-extension
                    case (i_ctrlALU.func3)
                        3'b000: begin   // MUL (lower, uses signed)
                            mult.input_A = i_A;
                            mult.input_B = i_B;
                            mult.en = w_dspEn;
                            o_result = mult.out[31:0];
                            w_dspDone = mult.done;
                        end
                        3'b001: begin   // MULH (upper signed)
                            mult.input_A = i_A;
                            mult.input_B = i_B;
                            mult.en = w_dspEn;
                            o_result = mult.out[63:32];
                            w_dspDone = mult.done;
                        end
                        3'b010: begin   // MULHSU (upper sign/unsign)
                            multSU.input_A = i_A;
                            multSU.input_B = i_B;
                            multSU.en = w_dspEn;
                            o_result = multSU.out[63:32];
                            w_dspDone = multSU.done;
                        end
                        3'b011: begin   // MULHU (upper unsigned)
                            multU.input_A = i_A;
                            multU.input_B = i_B;
                            multU.en = w_dspEn;
                            o_result = multU.out[63:32];
                            w_dspDone = multU.done;
                        end
                        3'b100: begin   // DIV
                            div.input_A = i_A;
                            div.input_B = i_B;
                            div.en = w_dspEn;
                            o_result = div.out[63:32];
                            w_dspDone = div.done;
                        end
                        3'b101: begin   // DIVU
                            divU.input_A = i_A;
                            divU.input_B = i_B;
                            divU.en = w_dspEn;
                            o_result = divU.out[63:32];
                            w_dspDone = divU.done;
                        end
                        3'b110: begin   // REM
                            div.input_A = i_A;
                            div.input_B = i_B;
                            div.en = w_dspEn;
                            o_result = div.out[31:0];
                            w_dspDone = div.done;
                        end
                        3'b111: begin   // REMU
                            divU.input_A = i_A;
                            divU.input_B = i_B;
                            divU.en = w_dspEn;
                            o_result = divU.out[31:0];
                            w_dspDone = divU.done;
                        end
                        default : /* default */;
                    endcase
                end
            end
            default : o_result = 32'b0;
        endcase
        // Zero Flag
        if(i_ctrlALU.aluOp != 2'b01) begin
            if(o_result == 32'b0) begin
                o_zero = 1'b1;
            end else begin
                o_zero = 1'b0;
            end
        end
    end

    // DSP stall FSM
    ex_alu_fsm ALU_FSM (
        .i_clk    (i_clk),
        .i_reset_n(i_reset_n),
        .en_ALU   (en_ALU),
        .i_ctrlALU(i_ctrlALU),
        .i_dspDone(w_dspDone),
        .o_stall  (o_stall),
        .o_dspEn  (w_dspEn)
    );

    // DSP modules
    `ifndef SIMULATION
    mult_gen_32_64 DSP_MULT(
      .CLK(i_clk), // input wire CLK
      .A(mult.input_A), // input wire [31:0] A
      .B(mult.input_B), // input wire [31:0] B
      .CE(mult.en), // input wire CE
      .P(mult.out) // output wire [63:0] P
    );

    mult_gen_32su_64s DSP_MULTSU (
      .CLK(i_clk), // input wire CLK
      .A(multSU.input_A), // input wire [31:0] A
      .B(multSU.input_B), // input wire [31:0] B
      .CE(multSU.en), // input wire CE
      .P(multSU.out) // output wire [63:0] P
    );

    mult_gen_32u_64u DSP_MULTU (
      .CLK(i_clk), // input wire CLK
      .A(multU.input_A), // input wire [31:0] A
      .B(multU.input_B), // input wire [31:0] B
      .CE(multU.en), // input wire CE
      .P(multU.out) // output wire [63:0] P
    );

    div_gen_32_64 DSP_DIV (
      .aclk(i_clk),                                      // input wire aclk
      .s_axis_divisor_tvalid(div.en),    // input wire s_axis_divisor_tvalid
      .s_axis_divisor_tdata(div.input_B),      // input wire [31 : 0] s_axis_divisor_tdata
      .s_axis_dividend_tvalid(div.en),  // input wire s_axis_dividend_tvalid
      .s_axis_dividend_tdata(div.input_A),    // input wire [31 : 0] s_axis_dividend_tdata
      .m_axis_dout_tvalid(div.done),          // output wire m_axis_dout_tvalid
      .m_axis_dout_tdata(div.out)            // output wire [63 : 0] m_axis_dout_tdata
    );

    div_gen_32u_64u DSP_DIVU (
      .aclk(i_clk),                            // input wire aclk
      .s_axis_divisor_tvalid(divU.en),            // input wire s_axis_divisor_tvalid
      .s_axis_divisor_tdata(divU.input_B),              // input wire [31 : 0] s_axis_divisor_tdata
      .s_axis_dividend_tvalid(divU.en),           // input wire s_axis_dividend_tvalid
      .s_axis_dividend_tdata(divU.input_A),             // input wire [31 : 0] s_axis_dividend_tdata
      .m_axis_dout_tvalid(divU.done),          // output wire m_axis_dout_tvalid
      .m_axis_dout_tdata(divU.out)       // output wire [63 : 0] m_axis_dout_tdata
    );
    `endif

endmodule : ex_alu
