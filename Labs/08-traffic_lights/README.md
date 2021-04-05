# Trafic
# 1) 
## A) State table
| **Input P** | `0` | `0` | `1` | `1` | `0` | `1` | `0` | `1` | `1` | `1` | `1` | `0` | `0` | `1` | `1` | `1` |
| :-- | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: |
| **Clock** | ![rising](Images/eq_uparrow.png) | ![rising](Images/eq_uparrow.png) | ![rising](Images/eq_uparrow.png) | ![rising](Images/eq_uparrow.png) | ![rising](Images/eq_uparrow.png) | ![rising](Images/eq_uparrow.png) | ![rising](Images/eq_uparrow.png) | ![rising](Images/eq_uparrow.png) | ![rising](Images/eq_uparrow.png) | ![rising](Images/eq_uparrow.png) | ![rising](Images/eq_uparrow.png) | ![rising](Images/eq_uparrow.png) | ![rising](Images/eq_uparrow.png) | ![rising](Images/eq_uparrow.png) | ![rising](Images/eq_uparrow.png) | ![rising](Images/eq_uparrow.png) |
| **State** | A | A | B | C | C | D | A | B | C | D | D | A | A | B | C | D |
| **Output R** | `0` | `0` | `0` | `0` | `0` | `1` | `0` | `0` | `0` | `1` | `1` | `0` | `0` | `0` | `0` | `1` |

## B) Nexys A7 board
![alt text](https://github.com/xsedla1l/Digital-electronics-1/blob/main/Labs/08-traffic_lights/Images/image1.png)
 ## Table with color settings
 | **RGB LED** | **Artix-7 pin names** | **Red** | **Yellow** | **Green** |
| :-: | :-: | :-: | :-: | :-: |
| LD16 | N15, M16, R12 | `1,0,0` | `1,1,0` | `0,1,0` |
| LD17 | N16, R11, G14 | `1,0,0` | `1,1,0` | `0,1,0` |

# 2) 
## A) State diagram
![alt text](https://github.com/xsedla1l/Digital-electronics-1/blob/main/Labs/08-traffic_lights/Images/image2.jpg)

## B) Listing of VHDL code of sequential process p_traffic_fsm
```VHDL
p_traffic_fsm : process(clk)
    begin
        if rising_edge(clk) then
            if (reset = '1') then       -- Synchronous reset
                s_state <= STOP1 ;      -- Set initial state
                s_cnt   <= c_ZERO;      -- Clear all bits

            elsif (s_en = '1') then
                -- Every 250 ms, CASE checks the value of the s_state 
                -- variable and changes to the next state according 
                -- to the delay value.
                case s_state is

                    -- If the current state is STOP1, then wait 1 sec
                    -- and move to the next GO_WAIT state.
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
                        -- Count up to c_DELAY_4SEC
                        if (s_cnt < c_DELAY_4SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            -- Move to the next state
                            s_state <= WEST_WAIT;
                            -- Reset local counter value
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
                        -- Count up to c_DELAY_4SEC
                        if (s_cnt < c_DELAY_4SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            -- Move to the next state
                            s_state <= SOUTH_WAIT;
                            -- Reset local counter value
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
    end process p_traffic_fsm;
```

## B) Listing of VHDL code of combinatorial process p_output_fsm
```VHDL
p_output_fsm : process(s_state)
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
    end process p_output_fsm;
```

## C) Screenshot 
![alt text](https://github.com/xsedla1l/Digital-electronics-1/blob/main/Labs/08-traffic_lights/Images/image3.png)

# 3)
## A) State table 
| **Current state** | **Direction South** | **Direction West** | **Delay** |
| :-- | :-: | :-: | :-: |
| `STOP`      | red    | red | 1 sec |
| `GO`      | green    | green | 1 sec |
| `STOP1`      | red    | red | 1 sec |
| `WEST_GO`    | red    | green | 4 sec |
| `WEST_WAIT`  | red    | yellow | 2 sec |
| `STOP2`      | red    | red | 1 sec |
| `SOUTH_GO`   | green  | red | 4 sec |
| `SOUTH_WAIT` | yellow | red | 2 sec |

## B) State table
![alt text](https://github.com/xsedla1l/Digital-electronics-1/blob/main/Labs/08-traffic_lights/Images/image3.png)

## C) Listing of VHDL code of sequential process p_p_smart_traffic_fsm
```VHDL
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
```