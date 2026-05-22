# Memory Mapping

By using the meta data bits for internal routing before overwriting, we can save addr size while still have a large address space for each area. This also allows us to have a single memory map for the CPU, and then have the northbridge handle the routing to the correct memory or peripheral based on the meta data bits.

## Internal CPU Memory Map

Addr[29:28] will be used for internal routing areas

| Addr[29:28] | [31:28] | Area |
| --- | --- | --- |
| `0b00` | `0x0` | Standard on Chip Memory |
| `0b01` | `0x1` | VGA Frame Memory |
| `0b10` | `0x2,0x6,0xA,0xE` | Northbridge communication |
| `0b11` | `0x3` | Internal Module Registers |

Accesses will be aligned to size

## VGA Memory

Addr[25:0] will be actual memory addresses, but still need to fit in the ranges availible to each Area


| Address Range | Description |
| --- | --- |
| `0x0000_0000 - 0x0x0000_1FFF` | Standard on Chip Memory |
| `0x1000_0000 - 0x1000_779F` | VGA Frame Memory* |
| `0x1000_8000 - 0x1000_80FF` | VGA Frame Palette (Red)** |
| `0x1000_8100 - 0x1000_81FF` | VGA Frame Palette (Green)** |
| `0x1000_8200 - 0x1000_82FF` | VGA Frame Palette (Blue)** |
| `0x1003_0000` | Writing swaps VGA frames |

\* VGA Frame memory is only row-contiguous and is to be indexed by X value in Addr[7:0] up to `0x9f`(160) by 2 4-bit chunks and Y value in Addr[15:8] up to `0x77`(120)

\*\* VGA Palette entries per color are nibble sized with the higher bits padded to fill up the byte

There are 2 frame buffers in memory that alternate being the active frame and the frame that is being written to. They overlap in the `0x1000_XXXX` address range.

## Northbridge Communication

Addr[31:30] will be used for northbridge routing areas

| Addr[31:30] | [31:28] | Area |
| --- | --- | --- |
| `0b00` | `0x2` | PSRAM |
| `0b01` | `0x6` | Flash |
| `0b10` | `0xA` | SD card |
| `0b11` | `0xE` | Southbridge communication |

Addr[25:0] will be actual memory addresses, but still need to fit in the ranges availible to each Area

| Address Range | Description |
| --- | --- |
| `0x0000_0000 - 0x0x0000_0000` | Example Range |

Addr[29:26] will be overwritten on dispatch to north bridge as meta data for Byte addresibility and read/write

| Addr[29:27] | Byte Adressing |
| --- | --- |
| `0b000` | Whole Word |
| `0b001` | First Half Word |
| `0b010` | Second Half Word |
| `0b011` | First Byte |
| `0b100` | Second Byte |
| `0b101` | Third Byte |
| `0b110` | Fourth Byte |

Addr[26] will indicate if the access is a read or a write

| Addr[26] | Byte Adressing |
| --- | --- |
| `0b0` | Read |
| `0b1` | Write |

## Internal Module Registers








