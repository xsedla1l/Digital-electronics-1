----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.04.2021 20:02:31
-- Design Name: 
-- Module Name: tb_smart_traffic_fsm - Behavioral
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

entity tb_smart_traffic_fsm is
--  Port ( );
end tb_smart_traffic_fsm;

architecture Behavioral of tb_smart_traffic_fsm is
         constant c_CLK_100MHZ_PERIOD : time := 10 ns;

    --Local signals
    signal s_clk_100MHz : std_logic;
    signal s_reset      : std_logic;
    signal s_south      : std_logic_vector(3 - 1 downto 0);
    signal s_west       : std_logic_vector(3 - 1 downto 0);
    signal s_Sensor_S   : std_logic;
    signal s_Sensor_W   : std_logic;
begin
         uut_smart_traffic_fsm : entity work.smart_traffic_fsm
        port map(
            clk     => s_clk_100MHz,
            reset   => s_reset,
            south_o => s_south,
            west_o  => s_west,
            Sensor_S_i => s_Sensor_S,
            Sensor_W_i => s_Sensor_W
        );
        
         --------------------------------------------------------------------
    -- Clock generation process
    --------------------------------------------------------------------
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

    --------------------------------------------------------------------
    -- Reset generation process
    --------------------------------------------------------------------
    p_reset_gen : process
    begin
        s_reset <= '0'; wait for 200 ns;
        -- Reset activated
        s_reset <= '1'; wait for 500 ns;
        -- Reset deactivated
        s_reset <= '0';
        wait;
    end process p_reset_gen;

    --------------------------------------------------------------------
    -- Data generation process
    --------------------------------------------------------------------
    p_stimulus : process
    begin
        
        s_Sensor_S <= '1';        
        s_Sensor_W <= '1';
        
        wait for 1200 ns;
        
        s_Sensor_S <= '1';        
        s_Sensor_W <= '0';
        
        wait for 2000 ns;
        
        s_Sensor_S <= '0';        
        s_Sensor_W <= '1';
        
        wait for 2000 ns;
        
        s_Sensor_S <= '0';
        s_Sensor_W <= '0';
        
        wait for 2000 ns;
        
        s_Sensor_S <= '1';
        s_Sensor_W <= '1';
        
        wait;
    end process p_stimulus;


end Behavioral;
