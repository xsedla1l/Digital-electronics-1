----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.04.2021 09:35:36
-- Design Name: 
-- Module Name: tb_big_boi - Behavioral
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

entity tb_big_boi is
--  Port ( );
end tb_big_boi;

architecture Behavioral of tb_big_boi is

           constant c_CLK_100MHZ_PERIOD : time := 10 ns;
            
            signal s_clk_100MHz  : std_logic;
            signal s_reset       : std_logic;
            signal s_data0_i     : std_logic_vector(4 - 1 downto 0);
            signal s_data1_i     : std_logic_vector(4 - 1 downto 0);
            signal s_data2_i     : std_logic_vector(4 - 1 downto 0);
            signal s_data3_i     : std_logic_vector(4 - 1 downto 0);
            signal s_butt_i      : std_logic_vector(4 - 1 downto 0);
            
            signal s_data0_o     : std_logic_vector(4 - 1 downto 0);
            signal s_data1_o     : std_logic_vector(4 - 1 downto 0);
            signal s_data2_o     : std_logic_vector(4 - 1 downto 0);
            signal s_data3_o     : std_logic_vector(4 - 1 downto 0);
            signal s_relay_o     : std_logic;
                  
begin
        uut_big_boi : entity work.big_boi
        port map(
            clk         => s_clk_100MHz,    
            reset       => s_reset,  
            data0_i     => s_data0_i,
            data1_i     => s_data1_i,
            data2_i     => s_data2_i,
            data3_i     => s_data3_i,
            butt_i      => s_butt_i,      
                   
            data0_o     => s_data0_o,
            data1_o     => s_data1_o,
            data2_o     => s_data2_o,
            data3_o     => s_data3_o,
            relay_o     => s_relay_o
                );
                
------------------------------------------------------------------
--copy from tb_smart_traffic_fsm
------------------------------------------------------------------

p_clk_gen : process
    begin
        while now < 10000 ns loop   -- 10 usec of simulation
            s_clk_100MHz <= '0';
            wait for c_CLK_100MHZ_PERIOD / 2;
            s_clk_100MHz <= '1';
            wait for c_CLK_100MHZ_PERIOD / 2;
        end loop;
        wait;
    end process p_clk_gen;
    
    
p_reset_gen : process
    begin
        s_reset <= '0'; wait for 400 ns;
        -- Reset activated
        s_reset <= '1'; wait for 500 ns;
        -- Reset deactivated
        s_reset <= '0';
        wait;
    end process p_reset_gen;
    
    
p_stimulus : process
    begin
        s_data0_i <= "0001";
        s_data1_i <= "0001";
        s_data2_i <= "0001";
        s_data3_i <= "0001";
        
        --wait for 20 ns;
        s_butt_i  <= "0001";
        
        wait for 20 ns;
        s_butt_i  <= "0010";
        
        wait for 20 ns;
        s_butt_i  <= "0001";
        
        wait for 20 ns;
        s_butt_i  <= "0001";
        
         wait for 200 ns;        ---- druhe zadavanie
        s_butt_i  <= "0001";
        
        wait for 20 ns;
        s_butt_i  <= "0001";
        
        wait for 20 ns;
        s_butt_i  <= "0010";
        
        wait for 20 ns;
        s_butt_i  <= "0001";
        
        wait;
    end process p_stimulus;

end Behavioral;
