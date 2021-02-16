
# lab 01-gates 
# De Morgan's Laws
## Tabuľka

c | b | a | f(c,b,a)
------------ | ------------- | ------------- | -------------
0 | 0 | 0 | 1
0 | 0 | 1 | 1
0 | 1 | 0 | 0
0 | 1 | 1 | 0
1 | 0 | 0 | 0
1 | 0 | 1 | 1
1 | 1 | 0 | 0
1 | 1 | 1 | 0


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

## Obrázok
![alt text](Images/O1-gates1.png)

## Link
[Link](https://www.edaplayground.com/x/qJja)


# Distributive law

## Kód 

```VHDL

library ieee;               -- Standard library
use ieee.std_logic_1164.all;-- Package for data types and logic operations

------------------------------------------------------------------------
-- Entity declaration for basic gates
------------------------------------------------------------------------
entity gates is
    port(
        
        x_i 		: in  std_logic;
        y_i 		: in  std_logic;
        z_i 		: in  std_logic;
        f1_o    	: out std_logic;         
        f2_o    	: out std_logic;        
        f3_o    	: out std_logic;        
        f4_o    	: out std_logic        
                 
                
        -- XOR output function
    );
end entity gates;

------------------------------------------------------------------------
-- Architecture body for basic gates
------------------------------------------------------------------------
architecture dataflow of gates is
begin
    
    
    
    f1_o <= (x_i and y_i) or (x_i and z_i);
    f2_o <=  x_i and (y_i or z_i);
    f3_o <= (x_i or y_i) and (x_i or z_i);
    f4_o <= x_i or (y_i and z_i);


end architecture dataflow;

```

## Obrázok
![alt text](Images/O1-gates2.png)

## Link
[Link](https://www.edaplayground.com/x/qJja)



