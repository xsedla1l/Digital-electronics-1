# 1) 
## Switches
| **Switches** | **Connections** | **Resistors (10kΩ)** |
| :-: | :-: | :-: |
| SW0 | J15 | R35 |
| SW1 | L16 | R37 |
| SW2 | M13 | R38 |
| SW3 | R15 | R40 |
| SW4 | R17 | R42 |
| SW5 | T18 | R43 |
| SW6 | U18 | R46 |
| SW7 | R13 | R48 |
| SW8 | T8 | R56 |
| SW9 | U8 | R58 | 
| SW10 | R16 | R64 |
| SW11 | T13 | R66 |
| SW12 | H6 | R68 |
| SW13 | U12 | R69 | 
| SW14 | U11 | R71 |
| SW15 | V10 | R73 |

## LEDs
| **Leds** | **Connections** | **Resistors (330Ω)** |
| :-: | :-: | :-: |
| LED0 | H17 | R33 |
| LED1 | K15 | R34 |
| LED2 | J13 | R36 |
| LED3 | N14 | R39 |
| LED4 | R18 | R41 |
| LED5 | V17 | R44 |
| LED6 | U17 | R47 |
| LED7 | U16 | R50 |
| LED8 | V16 | R52 | 
| LED9 | T15 | R54 | 
| LED10 | U14 | R57 | 
| LED11 | T16 | R65 | 
| LED12 | V15 | R67 | 
| LED13 | V14 | R70 | 
| LED14 | V12 | R72 | 
| LED15 | V11 | R74 | 

# 2) 
### Architecture
```vhdl

architecture Behavioral of mux_2bit_4to1 is
begin
   f_o <=   a_i when (sel_i = "00") else
            b_i when (sel_i = "01") else
            c_i when (sel_i = "10") else
            d_i;  


end architecture Behavioral;
```

### Stimulus

```vhdl
p_stimulus : process
    begin        
        report "Stimulus process started" severity note;

        -- First test values
        s_d <= "00"; s_c <= "00"; s_b <= "00"; s_a <= "00"; 
        s_sel <= "00"; wait for 100 ns;
        
        s_d <= "10"; s_c <= "01"; s_b <= "01"; s_a <= "00"; 
        s_sel <= "00"; wait for 100 ns;
       
       s_d <= "10"; s_c <= "01"; s_b <= "01"; s_a <= "11"; 
        s_sel <= "00"; wait for 100 ns;
        
        s_d <= "10"; s_c <= "01"; s_b <= "01"; s_a <= "00"; 
        s_sel <= "01"; wait for 100 ns;
        
        s_d <= "10"; s_c <= "01"; s_b <= "11"; s_a <= "00"; 
        s_sel <= "01"; wait for 100 ns;      
        
        
        -- Report a note at the end of stimulus process
        report "Stimulus process finished" severity note;
        wait;
    end process p_stimulus;
```

### Screenshot
![alt text](https://github.com/xsedla1l/Digital-electronics-1/blob/main/Labs/03-vivado/Images/image1.png)

# 3) 
### Creating a project
#### Click on "Create Project"
![alt text](https://github.com/xsedla1l/Digital-electronics-1/blob/main/Labs/03-vivado/Images/image2.png)

#### Choose the project name and the project location
![alt text](https://github.com/xsedla1l/Digital-electronics-1/blob/main/Labs/03-vivado/Images/image3.png)

### Choose "RTL Project"

#### Create File in VHDL
![alt text](https://github.com/xsedla1l/Digital-electronics-1/blob/main/Labs/03-vivado/Images/image4.png)

#### Choose a "Nexys A7-50T"
![alt text](https://github.com/xsedla1l/Digital-electronics-1/blob/main/Labs/03-vivado/Images/image5.png)

### OR
#### Same way we can create "simulation source"
![alt text](https://github.com/xsedla1l/Digital-electronics-1/blob/main/Labs/03-vivado/Images/image6.png)

#### And click on "Finish"

### Starting the simulation 
#### Click on : Flow/Run Simulation/Run Behavioral Simulation



