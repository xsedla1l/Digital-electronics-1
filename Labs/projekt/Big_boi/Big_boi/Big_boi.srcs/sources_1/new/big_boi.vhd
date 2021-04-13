----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.04.2021 09:09:17
-- Design Name: 
-- Module Name: big_boi - Behavioral
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
use IEEE.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity big_boi is
    port( 
            clk         : in std_logic;
            reset       : in std_logic;
            data0_i     : in std_logic_vector(4 - 1 downto 0);
            data1_i     : in std_logic_vector(4 - 1 downto 0);
            data2_i     : in std_logic_vector(4 - 1 downto 0);
            data3_i     : in std_logic_vector(4 - 1 downto 0);
            butt_i      : in std_logic_vector(4 - 1 downto 0);
            
            data0_o     : out std_logic_vector(4 - 1 downto 0);
            data1_o     : out std_logic_vector(4 - 1 downto 0);
            data2_o     : out std_logic_vector(4 - 1 downto 0);
            data3_o     : out std_logic_vector(4 - 1 downto 0);
            relay_o     : out std_logic
        );
end big_boi;

architecture Behavioral of big_boi is
    type t_state is (pass0,
                     pass1,
                     pass2,
                     pass3,
                     pass,
                     fail0,
                     fail1,
                     fail2,
                     fail3);
-- LEDs
    constant c_RED        : std_logic_vector(3 - 1 downto 0) := b"100";
    constant c_GREEN      : std_logic_vector(3 - 1 downto 0) := b"010";
                         
    signal p_state, n_state: t_state;                  
    --signal s_t_state  : t_state;
    --signal s_p_state  : std_logic;
    --signal s_n_state  : std_logic; 
    
    -- priprava na 5 sekundovu pauzu
    signal   s_cnt  : unsigned(5 - 1 downto 0);
    constant c_DELAY_4SEC : unsigned(5 - 1 downto 0) := b"1_0000";
    constant c_ZERO       : unsigned(5 - 1 downto 0) := b"0_0000";   
begin
--    p_reset   : process(clk, reset)
--    begin
--            if reset = '1' then
--                    s_p_state <= pass;
--            else
--                    s_p_state <= s_n_state;
--            end if;             
--    end process p_reset;
    
        
    p_big_boi : process(p_state)
    begin 
        --if rising_edge(clk) then
            if (reset = '1') then
                p_state   <= pass;
                s_cnt     <= c_ZERO;
                -- možno doplni nulovanie clear
            else 
                case p_state is 
                    
                    when pass => 
                        if (butt_i = data0_i) then
                            data0_o     <= butt_i;
                            p_state     <= pass0;
                            s_cnt       <= c_ZERO; -- moje pridane koli èasu
                        else
                            data0_o     <= butt_i;
                            p_state     <= fail0;
                        end if;
                    
                    when pass0 =>
                       if (butt_i = data1_i) then
                            data1_o     <= butt_i;
                            p_state     <= pass1;
                        else
                            data1_o     <= butt_i;
                            p_state     <= fail1;
                        end if; 
                        
                    when pass1 => 
                        if (butt_i = data2_i) then
                            data2_o     <= butt_i;
                            p_state     <= pass2;
                        else
                            data2_o     <= butt_i;
                            p_state     <= fail2;
                        end if;
                    
                    when pass2 =>
                       if (butt_i = data3_i) then
                            data3_o     <= butt_i;
                            p_state     <= pass3;
                        else
                            data3_o     <= butt_i;
                            p_state     <= fail3;
                        end if; 
                        
                    when pass3 => 
                        -- doplni èas -> èakanie 5 sekund kym su otvorene dvere
                        if (s_cnt   < c_DELAY_4SEC) then
                            s_cnt   <= s_cnt + 1;
                            -- sem asi prida tu LED èervenu
                            relay_o <= '1';
                        else
                            p_state     <= pass;
                            relay_o     <= '0';
                        end if;
                        
                    when fail0 =>
                        p_state     <= fail1;
                     
                    when fail1 =>
                        p_state     <= fail2;
                        
                    when fail2 =>
                        p_state     <= fail3;
                        
                    when fail3 =>
                        p_state     <= fail0;
                        relay_o     <= '0';      
                            
                    when others =>  
                        p_state     <= pass;                    
                                                
         
                end case;
            end if;
        --end if;        
    end process p_big_boi;
    
--    p_LEDs  : process(p_state)
--    begin
--        case p_state is
--        fail3   <= RED   -- proces na ledky - cervena/zelena 
    
--        end case;
--    end process p_LEDs;
end Behavioral;
