## What changed

- Briefly describe the intent of this PR and why the change is needed.
- Link issue/ticket if applicable.

## Scope

- [ ] Small and focused change (or rationale provided for larger scope)
- [ ] Backward-compatible behavior is preserved (or explicitly documented)

## Verification

- [ ] `make build` passes locally
- [ ] `make sim` passes locally
- [ ] Reviewed waveform (`output/dump.vcd`) for the affected path(s)
- [ ] Added/updated test stimulus for the changed behavior
- [ ] CI coverage is sufficient without an OS matrix for this PR
- [ ] If additional coverage is needed, it is by verification mode (test script / pipeline behavior), not by operating system

## RTL correctness checklist

- [ ] Reset behavior verified for modified modules (`*_top`, memory, control)
- [ ] Control signal packing/decoding updated consistently across stages
- [ ] Load/store byte/half/word size and signed/unsigned behavior validated
- [ ] Branch condition behavior validated (BEQ/BNE/BLT/BGE/BLTU/BGEU as relevant)
- [ ] Jump target behavior validated:
  - [ ] JALR uses `(rs1 + imm) & ~1`
  - [ ] JAL/branch target calculation left unmasked (alignment handled separately)
- [ ] No undriven outputs or orphaned ports introduced

## Developer notes

- Risks, assumptions, and follow-up tasks:
  - ...

## Optional artifacts

- Include any useful screenshots/snippets of waveforms or logs.
