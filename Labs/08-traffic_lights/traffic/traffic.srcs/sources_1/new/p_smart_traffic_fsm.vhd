------------------------------------------------------------------------
--
-- Traffic light controller using FSM.
-- Nexys A7-50T, Vivado v2020.1.1, EDA Playground
--
-- Copyright (c) 2020-Present Tomas Fryza
-- Dept. of Radio Electronics, Brno University of Technology, Czechia
-- This work is licensed under the terms of the MIT license.
--
-- This code is inspired by:
-- [1] LBEbooks, Lesson 92 - Example 62: Traffic Light Controller
--     https://www.youtube.com/watch?v=6_Rotnw1hFM
-- [2] David Williams, Implementing a Finite State Machine in VHDL
--     https://www.allaboutcircuits.com/technical-articles/implementing-a-finite-state-machine-in-vhdl/
-- [3] VHDLwhiz, One-process vs two-process vs three-process state machine
--     https://vhdlwhiz.com/n-process-state-machine/
--
------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

------------------------------------------------------------------------
-- Entity declaration for traffic light controller
------------------------------------------------------------------------
entity p_smart_traffic_fsm is
    port(
        clk         : in  std_logic;
        reset       : in  std_logic;
        Sensor_S    : in  std_logic;    -- sensor for South
        Sensor_W    : in  std_logic;    -- sensor fot West
        -- Traffic lights (RGB LEDs) for two directions
        south_o : out std_logic_vector(3 - 1 downto 0);
        west_o  : out std_logic_vector(3 - 1 downto 0)
    );
end entity p_smart_traffic_fsm;

------------------------------------------------------------------------
-- Architecture declaration for traffic light controller
------------------------------------------------------------------------
architecture Behavioral of p_smart_traffic_fsm is

    -- Define the states
    type t_state is (STOP1,
                     WEST_GO,
                     WEST_WAIT,
                     STOP2,
                     SOUTH_GO,
                     SOUTH_WAIT,
                     GO,
                     STOP);
    -- Define the signal that uses different states
    signal s_state  : t_state;

    -- Internal clock enable
    signal s_en     : std_logic;
    --  sensors signas
    signal s_Sensor_S     : std_logic;
    signal s_Sensor_W     : std_logic;
    -- Local delay counter
    signal   s_cnt  : unsigned(5 - 1 downto 0);

    -- Specific values for local counter
    constant c_DELAY_4SEC : unsigned(5 - 1 downto 0) := b"1_0000";
    constant c_DELAY_2SEC : unsigned(5 - 1 downto 0) := b"0_1000";
    constant c_DELAY_1SEC : unsigned(5 - 1 downto 0) := b"0_0100";
    constant c_ZERO       : unsigned(5 - 1 downto 0) := b"0_0000";

    -- Output values
    constant c_RED        : std_logic_vector(3 - 1 downto 0) := b"100";
    constant c_YELLOW     : std_logic_vector(3 - 1 downto 0) := b"110";
    constant c_GREEN      : std_logic_vector(3 - 1 downto 0) := b"010";

begin

    --------------------------------------------------------------------
    -- Instance (copy) of clock_enable entity generates an enable pulse
    -- every 250 ms (4 Hz). Remember that the frequency of the clock 
    -- signal is 100 MHz.
    
    -- JUST FOR SHORTER/FASTER SIMULATION
    s_en <= '1';
--    clk_en0 : entity work.clock_enable
--        generic map(
--            g_MAX =>        -- g_MAX = 250 ms / (1/100 MHz)
--        )
--        port map(
--            clk   => clk,
--            reset => reset,
--            ce_o  => s_en
--        );

    --------------------------------------------------------------------
    -- p_traffic_fsm:
    -- The sequential process with synchronous reset and clock_enable 
    -- entirely controls the s_state signal by CASE statement.
    --------------------------------------------------------------------
    p_p_smart_traffic_fsm : process(clk)
    begin
        if rising_edge(clk) then
            if (reset = '1') then       -- Synchronous reset
                s_state <= STOP ;      -- Set initial state
                s_cnt   <= c_ZERO;      -- Clear all bits
            elsif (s_en = '1') then
                case s_state is
                    when STOP => 
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        elsif (s_Sensor_S = '0' and s_Sensor_W = '0') then -- No cars
                            s_state <= GO;
                            s_cnt   <= c_ZERO;
                        elsif (s_Sensor_S = '1' and s_Sensor_W = '0') then -- Cars from North
                            s_state <= WEST_GO;
                            s_cnt   <= c_ZERO;
                        elsif (s_Sensor_S = '1' and s_Sensor_W = '1') then -- Cars from East ane North
                            s_state <= WEST_GO;
                            s_cnt   <= c_ZERO;
                        elsif (s_Sensor_S = '0' and s_Sensor_W = '1') then -- Cars form East
                            s_state <= SOUTH_GO;
                            s_cnt   <= c_ZERO;
                        end if;
                        
                    when GO => 
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        elsif (s_Sensor_S = '0' and s_Sensor_W = '0') then 
                            s_state <= GO;
                            s_cnt   <= c_ZERO;
                        elsif (s_Sensor_S = '1' and s_Sensor_W = '0') then 
                            s_state <= SOUTH_WAIT;
                            s_cnt   <= c_ZERO;
                        elsif (s_Sensor_S = '1' and s_Sensor_W = '1') then 
                            s_state <= SOUTH_WAIT;
                            s_cnt   <= c_ZERO;
                        elsif (s_Sensor_S = '0' and s_Sensor_W = '1') then 
                            s_state <= WEST_WAIT;
                            s_cnt   <= c_ZERO;
                        end if;
                         
                    when STOP1 =>
                        -- Count up to c_DELAY_1SEC
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            -- Move to the next state
                            s_state <= WEST_GO;
                            -- Reset local counter value
                            s_cnt   <= c_ZERO;
                        end if;
                        
                    when WEST_GO =>
                        if (s_cnt < c_DELAY_4SEC) then
                            s_cnt <= s_cnt + 1;
                        elsif (s_Sensor_S = '0' and s_Sensor_W = '0') then 
                            s_state <= GO;
                            s_cnt   <= c_ZERO;
                        elsif (s_Sensor_S = '1' and s_Sensor_W = '0') then 
                            s_state <= WEST_GO;
                            s_cnt   <= c_ZERO;
                        elsif (s_Sensor_S = '1' and s_Sensor_W = '1') then 
                            s_state <= WEST_WAIT;
                            s_cnt   <= c_ZERO;
                        elsif (s_Sensor_S = '0' and s_Sensor_W = '1') then 
                            s_state <= WEST_WAIT;
                            s_cnt   <= c_ZERO;
                        end if;
                    
                    when WEST_WAIT =>
                        -- Count up to c_DELAY_2SEC
                        if (s_cnt < c_DELAY_2SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            -- Move to the next state
                            s_state <= STOP2;
                            -- Reset local counter value
                            s_cnt   <= c_ZERO;
                        end if;
                        
                   when STOP2 =>
                        -- Count up to c_DELAY_1SEC
                        if (s_cnt < c_DELAY_1SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            -- Move to the next state
                            s_state <= SOUTH_GO;
                            -- Reset local counter value
                            s_cnt   <= c_ZERO;
                        end if;
                        
                  when SOUTH_GO =>
                        if (s_cnt < c_DELAY_4SEC) then
                            s_cnt <= s_cnt + 1;
                        elsif (s_Sensor_S = '0' and s_Sensor_W = '0') then 
                            s_state <= GO;
                            s_cnt   <= c_ZERO;
                        elsif (s_Sensor_S = '1' and s_Sensor_W = '0') then 
                            s_state <= SOUTH_WAIT;
                            s_cnt   <= c_ZERO;
                        elsif (s_Sensor_S = '1' and s_Sensor_W = '1') then 
                            s_state <= SOUTH_WAIT;
                            s_cnt   <= c_ZERO;
                        elsif (s_Sensor_S = '0' and s_Sensor_W = '1') then 
                            s_state <= SOUTH_GO;
                            s_cnt   <= c_ZERO;
                        end if;
                        
                  when SOUTH_WAIT =>
                        -- Count up to c_DELAY_2SEC
                        if (s_cnt < c_DELAY_2SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            -- Move to the next state
                            s_state <= STOP1;
                            -- Reset local counter value
                            s_cnt   <= c_ZERO;
                        end if;                      
                    -- It is a good programming practice to use the 
                    -- OTHERS clause, even if all CASE choices have 
                    -- been made. 
                    when others =>
                        s_state <= STOP1;

                end case;
            end if; -- Synchronous reset
        end if; -- Rising edge
    end process p_p_smart_traffic_fsm;

    --------------------------------------------------------------------
    -- p_output_fsm:
    -- The combinatorial process is sensitive to state changes, and sets
    -- the output signals accordingly. This is an example of a Moore 
    -- state machine because the output is set based on the active state.
    --------------------------------------------------------------------
    p_output_p_smart_traffic_fsm : process(s_state)
    begin
        case s_state is
            when STOP1 =>           -- we defined the states at the beginning of the code
                south_o <= c_RED;   -- RED -> "100"
                west_o  <= c_RED;
                
            when WEST_GO =>
                south_o <= c_RED;
                west_o  <= c_GREEN; -- GREEN -> "010"
                
            when WEST_WAIT =>
                south_o <= c_RED;
                west_o  <= c_YELLOW; -- YELLOW -> "110"
                
            when STOP2 =>
                south_o <= c_RED;
                west_o  <= c_RED;
                
            when SOUTH_GO =>
                south_o <= c_GREEN;
                west_o  <= c_RED;
                
            when SOUTH_WAIT =>
                south_o <= c_YELLOW;
                west_o  <= c_RED;   
                           
            when others =>
                south_o <= c_RED;
                west_o  <= c_RED;
                
        end case;
    end process p_output_p_smart_traffic_fsm;

end architecture Behavioral;