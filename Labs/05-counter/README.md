# 1 
## A) Figure with connection of push buttons on Nexys A7 board 
![alt text](https://github.com/xsedla1l/Digital-electronics-1/blob/main/Labs/05-counter/Images/image1.png)
#### In this position the button is open. The input (for example P17) is log 0 (0V / GND). If we press the button bring to input P17 log 1 (3,3V). 
## B) Table with calculated values
 | **Time interval** | **Number of clk periods** | **Number of clk periods in hex** | **Number of clk periods in binary** |
   | :-: | :-: | :-: | :-: |
   | 2&nbsp;ms      | 200 000       | `x"3_0d40"`     | `b"0011_0000_1101_0100_0000"`           |
   | 4&nbsp;ms      | 400 000       | `x"6_1A80"`     | `b"1100001101010000000"`                |
   | 10&nbsp;ms     | 1 000 000     | `x"F_4240"`     | `b"11110100001001000000"`               |
   | 250&nbsp;ms    | 25 000 000    | `x"17D_7840"`   | `b"1011111010111100001000000"`          |
   | 500&nbsp;ms    | 50 000 000    | `x"2FA_F080"`   | `b"10111110101111000010000000"`         |
   | 1&nbsp;sec     | 100 000 000   | `x"5F5_E100"`   | `b"0101_1111_0101_1110_0001_0000_0000"` |

# 2
## A) Listing of VHDL code of the process p_cnt_up_down
```VHDL
 p_cnt_up_down : process(clk)
    begin
        if rising_edge(clk) then
        
            if (reset = '1') then               -- Synchronous reset
                s_cnt_local <= (others => '0'); -- Clear all bits

            elsif (en_i = '1') then       -- Test if counter is enabled
                s_cnt_local <= (others => '0');
                               

             if (cnt_up_i = '1') then
                s_cnt_local <= s_cnt_local + 1;
                
             else             
                s_cnt_local <= s_cnt_local - 1;
                
             end if;
            end if;
        end if;
    end process p_cnt_up_down;
```

## B) Listing of VHDL reset processes

```VHDL
 p_reset_gen : process
    begin
        s_reset <= '0';
        wait for 14 ns;
        s_reset <= '1';                 -- Reset activated
        wait for 17 ns;
        s_reset <= '0';
        wait;
    end process p_reset_gen;
```

## B) Listing of VHDL stimulus processes

```VHDL
p_stimulus : process
    begin
        report "Stimulus process started" severity note;

        s_en     <= '1';                -- Enable counting
        s_cnt_up <= '1';
        wait for 150 ns;                -- Change counter direction
        s_cnt_up <= '0';
        wait for 320 ns;
        s_en     <= '0';                -- Disable counting

        report "Stimulus process finished" severity note;
        wait;
    end process p_stimulus;
```

## C) Screenshot with simulated

![alt text](https://github.com/xsedla1l/Digital-electronics-1/blob/main/Labs/05-counter/Images/image2.png)

# 3
## A) Listing of VHDL code from source file top.vhd
```VHDL
     clk_en0 : entity work.clock_enable
        generic map(
            g_MAX => 100000000
        )
        port map(
            clk => CLK100MHZ,
            reset => BTNC,
            ce_o => s_en
        );

    --------------------------------------------------------------------
    -- Instance (copy) of cnt_up_down entity
    bin_cnt0 : entity work.cnt_up_down
        generic map(
            g_CNT_WIDTH => 4
        )
        port map(
            clk         => CLK100MHZ,
            reset       => BTNC,
            en_i        => s_en,
            cnt_up_i    => SW(0),
            cnt_o       => s_cnt
        );

    -- Display input value on LEDs
    LED(3 downto 0) <= s_cnt;

    --------------------------------------------------------------------
    -- Instance (copy) of hex_7seg entity
    hex2seg : entity work.hex_7seg
        port map(
            hex_i    => s_cnt,
            seg_o(6) => CA,
            seg_o(5) => CB,
            seg_o(4) => CC,
            seg_o(3) => CD,
            seg_o(2) => CE,
            seg_o(1) => CF,
            seg_o(0) => CG
        );
    -- Connect one common anode to 3.3V
    AN <= b"1111_1110";
```

## B) Image of the top layer including both counters
![alt text](https://github.com/xsedla1l/Digital-electronics-1/blob/main/Labs/05-counter/Images/image3.png)
