# Memory Mapping

By using the meta data bits for internal routing before overwriting, we can save addr size while still have a large address space for each area. This also allows us to have a single memory map for the CPU, and then have the northbridge handle the routing to the correct memory or peripheral based on the meta data bits.

## Internal CPU Memory Map

Addr[29:28] will be used for internal routing areas

| Addr[29:28] | [31:28] | Area |
| --- | --- | --- |
| `0b00` | `0x0` | Standard on Chip Memory |
| `0b01` | `0x1` | VGA Frame Memory |
| `0b10` | `0x2` | Northbridge communication |
| `0b11` | `0x3` | Internal Config Registers |

Addr[25:0] will be actual memory addresses, but still need to fit in the ranges availible to each Area


| Address Range | Description |
| --- | --- |
| `0x0000_0000 - 0x0x0000_1FFF` | Standard on Chip Memory |
| `0x1000_0000 - 0x1000_774F` | VGA Frame Memory (Red)* |
| `0x1001_0000 - 0x1001_774F` | VGA Frame Memory (Green)* |
| `0x1002_0000 - 0x1002_774F` | VGA Frame Memory (Blue)* |
| `0x1003_0000` | Writing swaps VGA frames |

\* VGA Frame memory is split into 3 colors, and each color is to be indexed by X value in Addr[7:0] up to `0x4f`(80) by 2 4-bit chunks and Y value in Addr[15:8] up to `0x77`(120)

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
