-- This exercise implements a 4-bit equality comparator without using PORT MAP.
-- Each pair of input bits is compared using the XOR operation.
-- The four lower LEDs indicate the comparison result for each bit pair.
-- The upper LED (LED 7) turns on when all four bit pairs are equal.

-- Libraries used in this project
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Ex_71spm is
    port
    (
        -- Physical inputs and outputs
        -- Note: No changes are required in this section!

        -- DE0-Nano board
        -- Input ports
        CLOCK_50 : in std_logic; -- 50 MHz clock oscillator
        KEY : in std_logic_vector( 1 downto 0); -- Push-buttons on the DE0-Nano board

        -- Output ports
        LED : out std_logic_vector(7 downto 0); -- LEDs on the DE0-Nano board

        -- UFPE/DES expansion board
        -- Input ports
        ehkey : in std_logic_vector(9 downto 0);
        -- Bits 0-7: switches; bits 8-9: push-buttons

        -- Output ports
        dig7seg : out std_logic_vector(1 downto 0); -- 7-segment display selector
        d7seg : out std_logic_vector(8 downto 0) -- Signals for the display selected by dig7seg

    );
end Ex_71spm;

architecture resultado of Ex_71spm is

signal Xr: std_logic_vector(3 downto 0); 

begin

-- Compare each pair of input bits using the XOR operation
Xr(0) <= (ehkey(0) xor ehkey(1));
Xr(1) <= (ehkey(2) xor ehkey(3));
Xr(2) <= (ehkey(4) xor ehkey(5));
Xr(3) <= (ehkey(6) xor ehkey(7));

-- Display the individual comparison results on the four lower LEDs
LED(0) <= Xr(0);
LED(1) <= Xr(1);
LED(2) <= Xr(2);
LED(3) <= Xr(3);

-- Keep LEDs 4, 5 and 6 turned off
LED(6 downto 4) <= "000";

-- Turn on LED 7 when all four pairs of bits are equal
LED(7) <= not(Xr(0) or Xr(1) or Xr(2) or Xr(3));

-- Disable the 7-segment display
dig7seg <= "00";
d7seg <= "000000000";

end resultado;