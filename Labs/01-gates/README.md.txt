# lab 01-gates
## Tabuľka

| **c** | **b** |**a** | **f(c,b,a)** |
| :-: | :-: | :-: | :-: |
| 0 | 0 | 0 | 1 |
| 0 | 0 | 1 | 1 |
| 0 | 1 | 0 | 0 |
| 0 | 1 | 1 | 0 |
| 1 | 0 | 0 | 0 |
| 1 | 0 | 1 | 1 |
| 1 | 1 | 0 | 0 |
| 1 | 1 | 1 | 0 |

## Obrázok
![alt text](https://github.com/xsedla1l/Digital-electronics-1/blob/main/Images/01-gates1.png)

## Kód VHDL

```VHDL
library ieee;               -- Standard library
use ieee.std_logic_1164.all;-- Package for data types and logic operations

------------------------------------------------------------------------
-- Entity declaration for basic gates
------------------------------------------------------------------------
entity gates is
    port(
        a_i     : in  std_logic;         -- Data input
        b_i     : in  std_logic;
        c_i	    : in  std_logic;-- Data input
        for_o   : out std_logic;        -- OR output function
        fnand_o : out std_logic;         -- AND output function
        fnor_o  : out std_logic
        -- XOR output function
    );
end entity gates;

------------------------------------------------------------------------
-- Architecture body for basic gates
------------------------------------------------------------------------
architecture dataflow of gates is
begin
    for_o  <= ((not b_i) and a_i) or ((not c_i) and (not b_i));
    fnand_o <= not( not ((not b_i) and a_i) and not((not c_i) and (not b_i))) ;
    fnor_o <= not( b_i or (not a_i)) or not( c_i or b_i);
    
    

end architecture dataflow;
```
![De Morgan's low simulation](Images/01-gates1.png)