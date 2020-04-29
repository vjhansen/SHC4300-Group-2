--- ROM
-------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
-------------------------------------------------------
entity unsort_rom is
   port(  addr: in std_logic_vector(5 downto 0);
          data: out std_logic_vector(7 downto 0) );
end unsort_rom;
-------------------------------------------------------
architecture arch of unsort_rom is
   constant ADDR_WIDTH: integer := 6;
   constant DATA_WIDTH: integer := 8;
   type rom_type is array (0 to (2**ADDR_WIDTH) - 1)
        of std_logic_vector(DATA_WIDTH-1 downto 0);
   
   constant unsorted_ROM: rom_type := ( -- 2^6-by-8
    "00000110", "11101100", "01100101", "11100101", "00110001", 
    "10011011", "00000001", "11010101", "00111100", "11111001", 
    "11101100", "01011011", "01010110", "10010001", "11001001",
    "11111101", "00001111", "10011000", "10111011", "11110111",
    "01010110", "00011001", "11010001", "11110100", "01101001", 
    "01010100", "01100001", "00000000", "00100110", "00010011", 
    "10000101", "01010001", "10111100", "10111010", "11001100", 
    "10111010", "00101111", "00010101", "11111010", "11110000", 
    "11111101", "01011111", "00100000", "01101111", "11010010", 
    "00111111", "01011010", "00001101", "00011000", "11011011", 
    "01100110", "00111010", "00111001", "00110110", "00011101", 
    "10010100", "00001110", "11001001", "11111011", "00111110",
    "01010000", "10101010", "01011110", "10001010" ); -- addr 0...63
-------------------------------------------------------
begin
   data <= unsorted_ROM(to_integer(unsigned(addr)));
end arch;