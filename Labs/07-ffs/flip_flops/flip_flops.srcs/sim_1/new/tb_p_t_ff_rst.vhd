----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 29.03.2021 16:40:22
-- Design Name: 
-- Module Name: tb_p_t_ff_rst - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_p_t_ff_rst is
--  Port ( );
end tb_p_t_ff_rst;
        
architecture Behavioral of tb_p_t_ff_rst is
        constant c_CLK_100MHZ_PERIOD : time    := 10 ns;
            
            signal s_clk_100MHz     : STD_LOGIC;
            signal s_t              : STD_LOGIC;
            signal s_rst            : STD_LOGIC;
            signal s_q              : STD_LOGIC;
            signal s_q_bar          : STD_LOGIC;
begin
        
        uut_p_t_ff_rst : entity work.p_t_ff_rst
         port map(
           clk       => s_clk_100MHz,
           t        => s_t,
           rst     => s_rst,
           q        => s_q,
           q_bar    => s_q_bar
        );
        
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

end Behavioral;
