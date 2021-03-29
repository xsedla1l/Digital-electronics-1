 # 07-FLIP-FLOPS

# 1) Characteristic equations and completed tables for D, JK, T flip-flops

## D

   | **clk** | **d** | **q(n)** | **q(n+1)** | **Comments** |
   | :-: | :-: | :-: | :-: | :-- |
   | ![rising](https://github.com/xsedla1l/Digital-electronics-1/blob/main/Labs/07-ffs/image/eq_uparrow.png) | 0 | 0 | 0 | Clear (Reset) |
   | ![rising](https://github.com/xsedla1l/Digital-electronics-1/blob/main/Labs/07-ffs/image/eq_uparrow.png) | 0 | 1 | 0 | Clear (Reset) |
   | ![rising](https://github.com/xsedla1l/Digital-electronics-1/blob/main/Labs/07-ffs/image/eq_uparrow.png) | 1 | 0 | 1 | Set |
   | ![rising](https://github.com/xsedla1l/Digital-electronics-1/blob/main/Labs/07-ffs/image/eq_uparrow.png) | 1 | 1 | 1 | Set |

## q_{n+1}^D = d 

## JK

 | **clk** | **j** | **k** | **q(n)** | **q(n+1)** | **Comments** |
   | :-: | :-: | :-: | :-: | :-: | :-- |
   | ![rising](https://github.com/xsedla1l/Digital-electronics-1/blob/main/Labs/07-ffs/image/eq_uparrow.png) | 0 | 0 | 0 | 0 | No change |
   | ![rising](https://github.com/xsedla1l/Digital-electronics-1/blob/main/Labs/07-ffs/image/eq_uparrow.png) | 0 | 0 | 1 | 1 | No change |
   | ![rising](https://github.com/xsedla1l/Digital-electronics-1/blob/main/Labs/07-ffs/image/eq_uparrow.png) | 0 | 1 | 0 | 0 | Reset |
   | ![rising](https://github.com/xsedla1l/Digital-electronics-1/blob/main/Labs/07-ffs/image/eq_uparrow.png) | 0 | 1 | 1 | 0 | Reset |
   | ![rising](https://github.com/xsedla1l/Digital-electronics-1/blob/main/Labs/07-ffs/image/eq_uparrow.png) | 1 | 0 | 0 | 1 | Set |
   | ![rising](https://github.com/xsedla1l/Digital-electronics-1/blob/main/Labs/07-ffs/image/eq_uparrow.png) | 1 | 0 | 1 | 1 | Set |
   | ![rising](https://github.com/xsedla1l/Digital-electronics-1/blob/main/Labs/07-ffs/image/eq_uparrow.png) | 1 | 1 | 0 | 1 | Toggle |
   | ![rising](https://github.com/xsedla1l/Digital-electronics-1/blob/main/Labs/07-ffs/image/eq_uparrow.png) | 1 | 1 | 1 | 0 | Toggle |

## q_{n+1}^{JK} = j*/qn + /k*qn 

## T   
   | **clk** | **t** | **q(n)** | **q(n+1)** | **Comments** |
   | :-: | :-: | :-: | :-: | :-- |
   | ![rising](https://github.com/xsedla1l/Digital-electronics-1/blob/main/Labs/07-ffs/image/eq_uparrow.png) | 0 | 0 | 0 | No change |
   | ![rising](https://github.com/xsedla1l/Digital-electronics-1/blob/main/Labs/07-ffs/image/eq_uparrow.png) | 0 | 1 | 1 | No change |
   | ![rising](https://github.com/xsedla1l/Digital-electronics-1/blob/main/Labs/07-ffs/image/eq_uparrow.png) | 1 | 0 | 1 | Invert(Toggle)|
   | ![rising](https://github.com/xsedla1l/Digital-electronics-1/blob/main/Labs/07-ffs/image/eq_uparrow.png) | 1 | 1 | 0 | Invert(Toggle)|

## q_{n+1}^T = t*/qn + /t*qn

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
![alt text](https://github.com/xsedla1l/Digital-electronics-1/blob/main/Labs/07-ffs/image/image1.png)

# 3)  

##  1) p_d_ff_arst

### VHDL code
```VHDL
p_clk_gen : process
    begin
        while now < 750 ns loop         -- 75 periods of 100MHz clock
            s_clk_100MHz <= '0';
            wait for c_CLK_100MHZ_PERIOD / 2;
            s_clk_100MHz <= '1';
            wait for c_CLK_100MHZ_PERIOD / 2;
        end loop;
        wait;
    end process p_clk_gen;
    
    p_arst_gen : process
    begin
        s_arst <= '0';
        wait for 58 ns;       
        
        -- arst activated
        s_arst <= '1';
        wait for 15 ns;

        -- arst deactivated
        s_arst <= '0';         
       

        wait;
    end process p_arst_gen;
    
    p_stimulus : process
    begin
        report "Stimulus process started" severity note;
                 
          wait for 10 ns;          
          s_d   <= '1';
          wait for 10 ns;
          s_d   <= '0';
          wait for 10 ns;
           s_d  <= '1';
          wait for 10 ns;
          s_d   <= '0';
          wait for 10 ns;
          s_d   <= '1';
          wait for 10 ns;
          s_d   <= '0';
          wait for 10 ns;
          s_d   <= '1';
          wait for 10 ns;
          s_d   <= '0';
          wait for 10 ns;
          s_d   <= '1';
          wait for 10 ns;                   
                        
                 
        report "Stimulus process finished" severity note;
        wait;
    end process p_stimulus;
    
    p_assert : process
    begin
      wait for 27 ns;
              
        -- assert in 27 ns
        assert(s_q = '0' and s_q_bar = '1')
        report "Error - conditions in 27 ns are not met" severity error;
        
      wait for 53 ns;
         -- assert in 80 ns
        assert(s_q = '1' and s_q_bar = '0')
        report "Error - conditions in 80 ns are not met" severity error;
       
    end process p_assert;
```
### Screenshot p_d_ff_arst 
![alt text](https://github.com/xsedla1l/Digital-electronics-1/blob/main/Labs/07-ffs/image/image0.1.png)

##  2) p_d_ff_rst

### VHDL code listing of the processes
```VHDL
p_d_ff_rst : process (clk)
        begin 
            if rising_edge(clk) then
                q     <= d;
                q_bar <= not d;
           
            
            end if;
        end process p_d_ff_rst;
```


### Listing of VHDL clock, reset and stimulus processes
```VHDL
 p_clk_gen : process
    begin
        while now < 750 ns loop         -- 75 periods of 100MHz clock
            s_clk_100MHz <= '0';
            wait for c_CLK_100MHZ_PERIOD / 2;
            s_clk_100MHz <= '1';
            wait for c_CLK_100MHZ_PERIOD / 2;
        end loop;
        wait;
    end process p_clk_gen;
    
    p_rst_gen : process
    begin
        s_rst <= '0';
        wait for 58 ns;       
        
        -- rst activated
        s_rst <= '1';
        wait for 15 ns;

        -- rst deactivated
        s_rst <= '0';         
       

        wait;
    end process p_rst_gen;
    
    p_stimulus : process
    begin
        report "Stimulus process started" severity note;
                 
          wait for 10 ns;          
          s_d   <= '1';
          wait for 6 ns;
          s_d   <= '0';
          wait for 6 ns;
           s_d  <= '1';
          wait for 6 ns;
          s_d   <= '0';
          wait for 10 ns;
          s_d   <= '1';
          wait for 10 ns;
          s_d   <= '0';
          wait for 10 ns;
          s_d   <= '1';
          wait for 9 ns;
          s_d   <= '0';
          wait for 9 ns;
          s_d   <= '1';
          wait for 10 ns;
          s_d   <= '0';
          wait for 10 ns;
          s_d   <= '1';
          wait for 10 ns;
          s_d   <= '0';
          wait for 10 ns;
          s_d   <= '1';
          wait for 7 ns;
          s_d   <= '0';
          wait for 9 ns;
          s_d   <= '1';
          wait for 10 ns;                   
                        
                 
        report "Stimulus process finished" severity note;
        wait;
    end process p_stimulus;
    
    p_assert : process
    begin
      wait for 40 ns;
              
        -- assert in 40 ns
        assert(s_q = '0' and s_q_bar = '1')
        report "Error - conditions in 40 ns are not met" severity error;
        
      wait for 30 ns;
         -- assert in 70 ns
        assert(s_q = '1' and s_q_bar = '0')
        report "Error - conditions in 70 ns are not met" severity error;
       
    end process p_assert;
```
### Screenshot p_d_ff_rst
![alt text](https://github.com/xsedla1l/Digital-electronics-1/blob/main/Labs/07-ffs/image/image2.1.png)

##  3) p_jk_ff_rst

### VHDL code listing of the processes
```VHDL
 p_jk_ff_rst : process (clk)
        begin 
         
            if rising_edge(clk) then
                if (rst = '1') then
                    s_q <= '0';
                    
                else 
                    if (j = '0' and k = '0') then
                        s_q <= s_q;
                        
                    elsif (j = '0' and k = '1') then
                        s_q <= '0';
                        
                    elsif (j = '1' and k = '0') then
                        s_q <= '1';
                        
                    elsif (j = '1' and k = '1') then
                        s_q <= not s_q;
                    
                    end if;
                end if;             
            end if;
        end process p_jk_ff_rst;

        q       <= s_q;
        q_bar   <= not s_q;
```


### Listing of VHDL clock, reset and stimulus processes
```VHDL
p_clk_gen : process
    begin
        while now < 750 ns loop         -- 75 periods of 100MHz clock
            s_clk_100MHz <= '0';
            wait for c_CLK_100MHZ_PERIOD / 2;
            s_clk_100MHz <= '1';
            wait for c_CLK_100MHZ_PERIOD / 2;
        end loop;
        wait;
    end process p_clk_gen;
    
    p_rst_gen : process
    begin
        s_rst <= '0';
        wait for 58 ns;       
        
        -- rst activated
        s_rst <= '1';
        wait for 15 ns;

        -- rst deactivated
        s_rst <= '0';         
       

        wait;
    end process p_rst_gen;
    
    p_stimulus : process
    begin
        report "Stimulus process started" severity note;
                 
          wait for 10 ns;          
          s_j   <= '0';
          s_k   <= '0';
           wait for 20 ns;          
          s_j   <= '0';
          s_k   <= '1'; 
           wait for 20 ns;          
          s_j   <= '1';
          s_k   <= '0'; 
           wait for 20 ns;          
          s_j   <= '1';
          s_k   <= '1';                                   
                  
        report "Stimulus process finished" severity note;
        wait;
    end process p_stimulus;
    
    p_assert : process
    begin
      wait for 45 ns;
              
        -- assert in 45 ns
        assert(s_q = '0' and s_q_bar = '1')
        report "Error - conditions in 45 ns are not met" severity error;
        
      wait for 22.5 ns;
         -- assert in 67,5 ns
        assert(s_q = '0' and s_q_bar = '1' and s_rst = '1')
        report "Error - conditions in 67,5 ns are not met" severity error;
       
    end process p_assert;
```
### Screenshot p_d_ff_rst
![alt text](https://github.com/xsedla1l/Digital-electronics-1/blob/main/Labs/07-ffs/image/image2.png)

##  4) p_t_ff_rst

### VHDL code listing of the processes
```VHDL
p_t_ff_rst : process (clk)
        begin 
         
            if rising_edge(clk) then
                if (rst = '1') then
                    s_q <= '0';
                    
                else 
                    if (t = '0') then
                        s_q <= s_q;
                        
                    elsif (t = '1') then
                        s_q <= not s_q;
                    
                    end if;
                end if;             
            end if;
        end process p_t_ff_rst;
        q       <= s_q;
        q_bar   <= not s_q;
```


### Listing of VHDL clock, reset and stimulus processes
```VHDL
p_clk_gen : process
    begin
        while now < 750 ns loop         -- 75 periods of 100MHz clock
            s_clk_100MHz <= '0';
            wait for c_CLK_100MHZ_PERIOD / 2;
            s_clk_100MHz <= '1';
            wait for c_CLK_100MHZ_PERIOD / 2;
        end loop;
        wait;
    end process p_clk_gen;
    
    p_rst_gen : process
    begin
        s_rst <= '0';
        wait for 20 ns;       
        
        -- rst activated
        s_rst <= '1';
        wait for 15 ns;

        -- rst deactivated
        s_rst <= '0';         
       

        wait;
    end process p_rst_gen;
    
    p_stimulus : process
    begin
        report "Stimulus process started" severity note;
                 
          wait for 10 ns;          
          s_t   <= '0';
           wait for 10 ns;          
          s_t   <= '1';
          wait for 10 ns;          
          s_t   <= '0';
           wait for 10 ns;          
          s_t   <= '1';
           wait for 10 ns;          
          s_t   <= '0';
           wait for 10 ns;          
          s_t   <= '1';
           wait for 10 ns;          
          s_t   <= '0';
           wait for 10 ns;          
          s_t   <= '1';
           wait for 10 ns;          
          s_t   <= '0';
           wait for 10 ns;          
          s_t   <= '1'; 
          wait for 10 ns;          
          s_t   <= '0';
           wait for 10 ns;          
          s_t   <= '1';
           wait for 10 ns;          
          s_t   <= '0';
           wait for 10 ns;          
          s_t   <= '1';
           wait for 10 ns;          
          s_t   <= '0';
           wait for 10 ns;          
          s_t   <= '1';
          s_t   <= '0';
           wait for 10 ns;          
          s_t   <= '1';
           wait for 10 ns;          
          s_t   <= '0';
           wait for 10 ns;          
          s_t   <= '1';
           wait for 10 ns;          
          s_t   <= '0';
           wait for 10 ns;          
          s_t   <= '1';                                     
                  
        report "Stimulus process finished" severity note;
        wait;
    end process p_stimulus;
    
    p_assert : process
    begin
      wait for 55 ns;
              
        -- assert in 55 ns
        assert(s_q = '1' and s_q_bar = '0')
        report "Error - conditions in 55 ns are not met" severity error;
        
      wait for 20 ns;
         -- assert in 75 ns
        assert(s_q = '0' and s_q_bar = '1')
        report "Error - conditions in 75 ns are not met" severity error;
       
    end process p_assert;
```
### Screenshot p_d_ff_rst
![alt text](https://github.com/xsedla1l/Digital-electronics-1/blob/main/Labs/07-ffs/image/image4.png)

# 4) Image of the shift register schematic 
![alt text](https://github.com/xsedla1l/Digital-electronics-1/blob/main/Labs/07-ffs/image/image0.1.png)