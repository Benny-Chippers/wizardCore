module cdc_bus_handshake #(
    parameter int WIDTH = 8
) (
    // Source domain
    input  logic             clk_src,
    input  logic             rst_src_n,
    input  logic [WIDTH-1:0] src_data,
    input  logic             src_send,
    output logic             src_busy,

    // Destination domain
    input  logic             clk_dst,
    input  logic             rst_dst_n,
    output logic [WIDTH-1:0] dst_data,
    output logic             dst_valid
);

    //--------------------------------------------------------------------------
    // Source domain storage and request toggle
    //--------------------------------------------------------------------------
    logic [WIDTH-1:0] data_hold_src;
    logic             req_toggle_src;
    logic             ack_toggle_src_ff1, ack_toggle_src_ff2;

    logic ack_seen_src;

    always_ff @(posedge clk_src or negedge rst_src_n) begin
        if (!rst_src_n) begin
            data_hold_src       <= '0;
            req_toggle_src      <= 1'b0;
            ack_toggle_src_ff1  <= 1'b0;
            ack_toggle_src_ff2  <= 1'b0;
        end else begin
            ack_toggle_src_ff1 <= ack_toggle_dst;
            ack_toggle_src_ff2 <= ack_toggle_src_ff1;

            if (src_send && !src_busy) begin
                data_hold_src  <= src_data;
                req_toggle_src <= ~req_toggle_src;
            end
        end
    end

    assign ack_seen_src = (ack_toggle_src_ff2 == req_toggle_src);
    assign src_busy     = !ack_seen_src;

    //--------------------------------------------------------------------------
    // Destination domain request synchronization
    //--------------------------------------------------------------------------
    logic req_toggle_dst_ff1, req_toggle_dst_ff2, req_toggle_dst_ff3;
    logic ack_toggle_dst;

    logic req_event_dst;

    always_ff @(posedge clk_dst or negedge rst_dst_n) begin
        if (!rst_dst_n) begin
            req_toggle_dst_ff1 <= 1'b0;
            req_toggle_dst_ff2 <= 1'b0;
            req_toggle_dst_ff3 <= 1'b0;
            dst_data           <= '0;
            dst_valid          <= 1'b0;
            ack_toggle_dst     <= 1'b0;
        end else begin
            req_toggle_dst_ff1 <= req_toggle_src;
            req_toggle_dst_ff2 <= req_toggle_dst_ff1;
            req_toggle_dst_ff3 <= req_toggle_dst_ff2;

            dst_valid <= 1'b0;

            if (req_event_dst) begin
                // Capture the bus after request has been synchronized.
                // Source guarantees data_hold_src remains stable until ack returns.
                dst_data       <= data_hold_src;
                dst_valid      <= 1'b1;
                ack_toggle_dst <= req_toggle_dst_ff2;
            end
        end
    end

    assign req_event_dst = req_toggle_dst_ff2 ^ req_toggle_dst_ff3;

endmodule