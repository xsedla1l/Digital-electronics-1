 # 07-FLIP-FLOPS

# 1) Characteristic equations and completed tables for D, JK, T flip-flops

## D

   | **clk** | **d** | **q(n)** | **q(n+1)** | **Comments** |
   | :-: | :-: | :-: | :-: | :-- |
   | up | 0 | 0 |  |  |
   | up | 0 | 1 |  |  |
   | up | 1 |  |  |  |
   | up | 1 |  |  |  |

## q_{n+1}^D =&~ \\ 

## JK

 | **clk** | **j** | **k** | **q(n)** | **q(n+1)** | **Comments** |
   | :-: | :-: | :-: | :-: | :-: | :-- |
   | ![rising](https://github.com/xsedla1l/Digital-electronics-1/blob/main/Labs/07-ffs/image/eq_uparrow.png) | 0 | 0 | 0 | 0 | No change |
   | ![rising](https://github.com/xsedla1l/Digital-electronics-1/blob/main/Labs/07-ffs/image/eq_uparrow.png) | 0 | 0 | 1 | 1 | No change |
   | ![rising](https://github.com/xsedla1l/Digital-electronics-1/blob/main/Labs/07-ffs/image/eq_uparrow.png) | 0 |  |  |  |  |
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
## A) VHDL code listing of the process p_d_latch 

```VHDL
p_d_latch : process (d, arst, en)
        begin 
            if (arst = '1') then
                q     <= '0';
                q_bar <= '1';
            elsif (en = '1') then
                q     <= d;
                q_bar <= not d;  
            
            end if;
        end process p_d_latch;
```

## B) Listing of VHDL reset and stimulus processes from the testbench

```VHDL
 p_arst_gen : process
    begin
        s_arst <= '0';
        wait for 10 ns;        
        
        -- arst activated
        s_arst <= '1';
        wait for 10 ns;

        -- arst deactivated
        s_arst <= '0';
        wait for 200 ns;
        
        s_arst <= '1';         

        wait;
    end process p_arst_gen;

         p_stimulus : process
    begin
        report "Stimulus process started" severity note;
            
          s_en <= '0';
          s_d <= '0';         
         
          wait for 6 ns;          
          s_d   <= '1';
          wait for 5 ns;
          s_d   <= '0';
          wait for 8 ns;
           s_d  <= '1';
          wait for 6 ns;
          s_d   <= '0';
          wait for 9 ns;
          s_d   <= '1';
          wait for 4 ns;
          s_d   <= '0';
          wait for 5 ns;          
          
          s_en  <= '1';
          wait for 6 ns;          
          s_d   <= '1';
          wait for 3 ns;
          s_d   <= '0';
          wait for 10 ns;
          s_d   <= '1';
          wait for 5 ns;
          s_d   <= '0';
          wait for 6 ns;
          s_d  <= '1';
          wait for 25 ns;
          s_d   <= '0';
          wait for 15 ns;
          s_en  <= '0';
          wait for 4 ns;
          s_d  <= '1';
          wait for 16 ns;
          
          s_en  <= '1';
          wait for 6 ns;          
          s_d   <= '1';
          wait for 5 ns;
          s_d   <= '0';
          wait for 5 ns;
           s_d  <= '1';
          wait for 5 ns;
          s_d   <= '0';
          wait for 5 ns;
           s_d  <= '1';
          wait for 5 ns;
          s_d   <= '0';
          wait for 17 ns;
          
          s_d   <= '1';
          wait for 10 ns;
          s_en  <= '0';
          wait for 10 ns;
          s_d   <= '0';          
          wait for 6 ns;          
          s_d   <= '1';
          wait for 15 ns;
          s_d   <= '0';
          wait for 6 ns;
           s_d  <= '1';
           wait for 5 ns;
          s_en  <= '1';
          wait for 3 ns;
          s_d   <= '0';
          wait for 5 ns;
           s_d  <= '1';
          wait for 8 ns;
          s_d   <= '0';
          wait for 15 ns;
         
        report "Stimulus process finished" severity note;
        wait;
    end process p_stimulus;
    
   p_assert : process
    begin
      wait for 80 ns;
              
        -- assert in 80 ns
        assert(s_q = '1' and s_q_bar = '0')
        report "Error - conditions in 80 ns are not met" severity error;
        
      wait for 45 ns;
         -- assert in 125 ns
        assert(s_q = '0' and s_q_bar = '1')
        report "Error - conditions in 125 ns are not met" severity error;
       
    end process p_assert;
          
```

## C)  Screenshot
![alt text](https://github.com/xsedla1l/Digital-electronics-1/blob/main/Labs/02-logic/Images02/logic2.png)

# 3) 


### Reported error:
![alt text](https://github.com/xsedla1l/Digital-electronics-1/blob/main/Labs/02-logic/Images02/logic1.png)

### Link to EDA Playground
[EDA Playground](https://www.edaplayground.com/x/8QkY)
