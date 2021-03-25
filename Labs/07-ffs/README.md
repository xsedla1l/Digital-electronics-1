 # 07-FLIP-FLOPS

# 1) Characteristic equations and completed tables for D, JK, T flip-flops

## D

   | **clk** | **d** | **q(n)** | **q(n+1)** | **Comments** |
   | :-: | :-: | :-: | :-: | :-- |
   | ![rising](Images/eq_uparrow.png) | 0 | 0 |  |  |
   | ![rising](Images/eq_uparrow.png) | 0 | 1 |  |  |
   | ![rising](Images/eq_uparrow.png) | 1 |  |  |  |
   | ![rising](Images/eq_uparrow.png) | 1 |  |  |  |

## q_{n+1}^D =&~ \\ 

## JK

 | **clk** | **j** | **k** | **q(n)** | **q(n+1)** | **Comments** |
   | :-: | :-: | :-: | :-: | :-: | :-- |
   | ![rising](Images/eq_uparrow.png) | 0 | 0 | 0 | 0 | No change |
   | ![rising](Images/eq_uparrow.png) | 0 | 0 | 1 | 1 | No change |
   | ![rising](Images/eq_uparrow.png) | 0 |  |  |  |  |
   | ![rising](Images/eq_uparrow.png) | 0 |  |  |  |  |
   | ![rising](Images/eq_uparrow.png) | 1 |  |  |  |  |
   | ![rising](Images/eq_uparrow.png) | 1 |  |  |  |  |
   | ![rising](Images/eq_uparrow.png) | 1 |  |  |  |  |
   | ![rising](Images/eq_uparrow.png) | 1 |  |  |  |  |

## q_{n+1}^{JK} =&\\ 

## T   
   | **clk** | **t** | **q(n)** | **q(n+1)** | **Comments** |
   | :-: | :-: | :-: | :-: | :-- |
   | ![rising](Images/eq_uparrow.png) | 0 | 0 |  |  |
   | ![rising](Images/eq_uparrow.png) | 0 | 1 |  |  |
   | ![rising](Images/eq_uparrow.png) | 1 |  |  |  |
   | ![rising](Images/eq_uparrow.png) | 1 |  |  |  |

## q_{n+1}^T =&\\

# 2)
## ***Karnaugh maps***

### *The K-map for the "equals" function*
|           |           |         |  **A1,A0**  |           |           |
| :-:       | :-:       | :-:     | :-:         | :-:       | :-:       | 
|           |           | ***0 0*** | ***0 1***     | ***1 1***   | ***1 0***   | 
|           | ***0 0***  | **1**   | 0           | 0         | 0         | 
| **B1,B0** |  ***0 1***  | 0       | **1**       | 0         |  0        |
|           | ***1 1***   | 0       | 0           | **1**     | 0         |
|           | ***1 0***   | 0       | 0           | 0         | **1**     |



### *The K-map for the "graeter than" function*
|           |           |         |  **A1,A0**  |           |           |
| :-:       | :-:       | :-:     | :-:         | :-:       | :-:       | 
|           |           | ***0 0*** | ***0 1***     | ***1 1***   | ***1 0***   | 
|           | ***0 0***   | 0   | 0           | 0         | 0         | 
| **B1,B0** |  ***0 1***  | **1**        | 0       | 0         |  0        |
|           | ***1 1***   | **1**        | **1**            | 0    | **1**         |
|           | ***1 0***   | **1**        | **1**            | 0         | 0     |

#### Simplified SoP form of the "greater than" function : 
#### GreaterSoP = B1./A1 + /A1./A0.B0 + /A0.B1.B0 
##### '/' -> negation 


### *The K-map for the "less than" function*
|           |           |         |  **A1,A0**  |           |           |
| :-:       | :-:       | :-:     | :-:         | :-:       | :-:       | 
|           |           | ***0 0*** | ***0 1***     | ***1 1***   | ***1 0***   | 
|           | ***0 0***   | **0**   | 1           | 1         | 1         | 
| **B1,B0** |  ***0 1***  | **0**       | **0**       | 1         |  1        |
|           | ***1 1***   | **0**       | **0**            | **0**     | **0**          |
|           | ***1 0***   | **0**       | **0**            | 1         | **0**     |

#### Simplified PoS form of the "less than" function : 
#### LessPoS = (A1+A0).(/B1+/B2).(A1+/B1).(A1+/B0).(A0+/B1)
##### '/' -> negation 

# 3)

### ***VHDL Code (design.vhd)***

```VHDL
library ieee;
use ieee.std_logic_1164.all;


entity comparator_4bit is
    port(
        a_i           : in  std_logic_vector(4 - 1 downto 0);
		b_i           : in  std_logic_vector(4 - 1 downto 0);

        							-- COMPLETE ENTITY DECLARATION
		B_greater_A_o : out std_logic;
        B_equals_A_o  : out std_logic;

        B_less_A_o    : out std_logic       -- B is less than A
    );
end entity comparator_4bit;


architecture Behavioral of comparator_4bit is
begin
    B_greater_A_o 	 <= '1' when (b_i > a_i) else '0';
    B_equals_A_o 	 <= '1' when (b_i = a_i) else '0';
    B_less_A_o		 <= '1' when (b_i < a_i) else '0';
    


    


end architecture Behavioral;


```

### ***VHDL Code (testbench.vhd)***

```VHDL
library ieee;
use ieee.std_logic_1164.all;

------------------------------------------------------------------------
-- Entity declaration for testbench
------------------------------------------------------------------------
entity tb_comparator_4bit is
    -- Entity of testbench is always empty
end entity tb_comparator_4bit;

-----------------------------------------------------------------------
-- Architecture body for testbench
------------------------------------------------------------------------
architecture testbench of tb_comparator_4bit is

    -- Local signals
    signal s_a       : std_logic_vector(4 - 1 downto 0);
    signal s_b       : std_logic_vector(4 - 1 downto 0);
    signal s_B_greater_A : std_logic;
    signal s_B_equals_A  : std_logic;
    signal s_B_less_A    : std_logic;

begin
    -- Connecting testbench signals with comparator_2bit entity (Unit Under Test)
    uut_comparator_4bit : entity work.comparator_4bit
        port map(
            a_i           => s_a,
            b_i           => s_b,
            B_greater_A_o => s_B_greater_A,
            B_equals_A_o  => s_B_equals_A,
            B_less_A_o    => s_B_less_A
        );

    --------------------------------------------------------------------
    -- Data generation process
    --------------------------------------------------------------------
    p_stimulus : process
    begin
        -- Report a note at the begining of stimulus process
        report "Stimulus process started" severity note;
        
        
        
        -- First test values
        s_b <= "0000"; s_a <= "0000"; wait for 100 ns;
                -- Expected output
        assert ((s_B_greater_A = '0') and (s_B_equals_A = '1') and (s_B_less_A = '0'))
        -- If false, then report an error
      
        report "Test failed for input combination: 0000, 0000" severity error;
        
        
        -- Second test values
        s_b <= "0000"; s_a <= "0001"; wait for 100 ns;
                -- Expected output
        assert ((s_B_greater_A = '0') and (s_B_equals_A = '0') and (s_B_less_A = '1'))
        -- If false, then report an error
      
        report "Test failed for input combination: 0000, 0001" severity error;
        
        
        -- Third test values
        s_b <= "0000"; s_a <= "0010"; wait for 100 ns;
                -- Expected output
        assert ((s_B_greater_A = '0') and (s_B_equals_A = '0') and (s_B_less_A = '1'))
        -- If false, then report an error
      
        report "Test failed for input combination: 0000, 0010" severity error;
        
        
        -- Fourth test values
        s_b <= "0000"; s_a <= "0100"; wait for 100 ns;
                -- Expected output
        assert ((s_B_greater_A = '0') and (s_B_equals_A = '0') and (s_B_less_A = '1'))
        -- If false, then report an error
      
        report "Test failed for input combination: 0000, 0100" severity error;
        
        
        -- Fifth test values
        s_b <= "1000"; s_a <= "0000"; wait for 100 ns;
                -- Expected output
        assert ((s_B_greater_A = '1') and (s_B_equals_A = '0') and (s_B_less_A = '0'))
        -- If false, then report an error
      
        report "Test failed for input combination: 1000, 0000" severity error;
        
        
        -- Sixth test values
        s_b <= "1000"; s_a <= "0100"; wait for 100 ns;
                -- Expected output
        assert ((s_B_greater_A = '1') and (s_B_equals_A = '0') and (s_B_less_A = '0'))
        -- If false, then report an error
      
        report "Test failed for input combination: 1000, 0100" severity error;
        
        
        -- Seventh test values
        s_b <= "0010"; s_a <= "0100"; wait for 100 ns;
                -- Expected output
        assert ((s_B_greater_A = '0') and (s_B_equals_A = '0') and (s_B_less_A = '1'))
        -- If false, then report an error
      
        report "Test failed for input combination: 0010, 0100" severity error;
        
        
        -- Eighth test values
        s_b <= "1000"; s_a <= "1000"; wait for 100 ns;
                -- Expected output
        assert ((s_B_greater_A = '0') and (s_B_equals_A = '1') and (s_B_less_A = '0'))
        -- If false, then report an error
      
        report "Test failed for input combination: 1000, 1000" severity error;
        
        
        -- Ninth test values
        s_b <= "1100"; s_a <= "0100"; wait for 100 ns;
                -- Expected output
        assert ((s_B_greater_A = '1') and (s_B_equals_A = '0') and (s_B_less_A = '0'))
        -- If false, then report an error
      
        report "Test failed for input combination: 1100, 0100" severity error;
        
        
         -- Tenth test values
        s_b <= "0110"; s_a <= "0011"; wait for 100 ns;
                -- Expected output
        assert ((s_B_greater_A = '1') and (s_B_equals_A = '1') and (s_B_less_A = '0'))
        -- If false, then report an error
        report "Test failed for input combination: 0110, 0011" severity error;


        -- Report a note at the end of stimulus process
        report "Stimulus process finished" severity note;
        wait;
    end process p_stimulus;

end architecture testbench;

```

### Simulator console output:
![alt text](https://github.com/xsedla1l/Digital-electronics-1/blob/main/Labs/02-logic/Images02/logic2.png)

### Reported error:
![alt text](https://github.com/xsedla1l/Digital-electronics-1/blob/main/Labs/02-logic/Images02/logic1.png)

### Link to EDA Playground
[EDA Playground](https://www.edaplayground.com/x/8QkY)
