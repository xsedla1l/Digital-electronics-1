----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.03.2021 10:11:32
-- Design Name: 
-- Module Name: p_d_ff_rst - Behavioral
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

entity p_d_ff_rst is
Port ( 
           clk       : in STD_LOGIC;
           rst      : in STD_LOGIC;
           d         : in STD_LOGIC;
           q         : out STD_LOGIC;
           q_bar     : out STD_LOGIC
           );
end p_d_ff_rst;

architecture Behavioral of p_d_ff_rst is

begin
     p_d_ff_rst : process (clk)
        begin 
            if rising_edge(clk) then
                q     <= d;
                q_bar <= not d;
           
            
            end if;
        end process p_d_ff_rst;


end Behavioral;
