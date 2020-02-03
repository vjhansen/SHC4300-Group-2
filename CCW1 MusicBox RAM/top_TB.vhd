----------------------------------------------------------------------------------
-- UART Testbench
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.NUMERIC_STD.ALL;

entity top_TB is
end top_TB;

architecture Behavioral of top_TB is
-- Define constants
    constant clk_period : time := 10 ns;    
    constant bit_period : time := 52083ns; -- time for 1 bit.. 1bit/19200bps = 52.08 us
    constant rx_data_ascii_B4: std_logic_vector(7 downto 0) := "01000010"; -- send Tone B4
    constant rx_data_ascii_B5: std_logic_vector(7 downto 0) := "01100010"; -- send Tone B5
    constant rx_data_ascii_C4: std_logic_vector(7 downto 0) := "01000011"; -- send Tone C4
    constant rx_data_ascii_F4: std_logic_vector(7 downto 0) := "01000110"; -- send Tone F4

-- Define signals
    signal clk, rst:        std_logic := '1';
    signal rx, td_on, play: std_logic;
    signal led:             std_logic_vector(7 downto 0);

----------------------------------------------------------------------------------   
begin
    UUT: entity work.top(Behavioral)
    port map (
        clk => clk, rst => rst, rx => rx, led => led, play => play);
     
    clk_proc: process begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process;

------------------------------------------------------------
   
-- Begin simulation
    stim_proc: process begin
    -- Initial
        --rst <= '1';
        wait for clk_period*2;
        rst <= '0';
        td_on <= '0';
        wait for clk_period*2;
        td_on <= '1';

    -- Test Tone B4
        rx <= '0'; -- start bit = 0
        wait for bit_period;
        for i in 0 to 7 loop
            rx <= rx_data_ascii_B4(i); -- 8 data bits
            wait for bit_period;
        end loop;
        rx <= '1'; -- stop bit = 1
        wait for bit_period;
        
    -- Test Tone B5
        rx <= '0'; -- start bit = 0
        wait for bit_period;
        for i in 0 to 7 loop
            rx <= rx_data_ascii_B5(i); -- 8 data bits
            wait for bit_period;
        end loop;
        rx <= '1'; -- stop bit = 1
        wait for bit_period;        
        
     
--    -- Test Tone C4
--        rx <= '0'; -- start bit = 0
--        wait for bit_period;
--        for i in 0 to 7 loop
--            rx <= rx_data_ascii_C4(i); -- 8 data bits
--            wait for bit_period;
--        end loop;
--        rx <= '1'; -- stop bit = 1
--        wait for bit_period;

--    -- Test Tone F4
--        rx <= '0'; -- start bit = 0
--        wait for bit_period;
--        for i in 0 to 7 loop
--            rx <= rx_data_ascii_F4(i); -- 8 data bits
--            wait for bit_period;
--        end loop;
--        rx <= '1'; -- stop bit = 1
--        wait for bit_period;

    end process;
end Behavioral;
