# LAB_5:
Design of a 7-segment driver chip, along with a binary to (inverted)octal decoder for
selection of a particular display on the FPGA.
## Truth Tables:
### Truth table of the chip:


![truth table of 7_segment_decoder](./docs/truth_table_7_segment.png)
------------

### Truth table of the binary-octal decoder:
The following table has been implemented in an inverted form, because the common anodes were active _low_;

![truth table of binary-octal-decoder](./docs/b-to-oct-decoder-truth-table.png)
-------------------

## Schematics:
### Structural schematic:
![schematics-of-the-chips](./docs/structural_schematic.png)
### Behavorial schematic:
![schematics-of-the-chips](./docs/behavorial_schematic.png)