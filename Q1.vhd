-- The goal of this exercise is to implement a multiplier using two 2-bit inputs.
-- The 4-bit binary result is displayed on four LEDs,
-- while its decimal value is shown on the 7-segment display.

-- Libraries used in this project
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ProjetosDeCasa is
    port
    (
        -- Physical inputs and outputs

        -- DE0-Nano board
        -- Input ports
        CLOCK_50 : in std_logic; -- 50 MHz clock oscillator
        KEY : in std_logic_vector(1 downto 0); -- On-board push-buttons

        -- Output ports
        LED : out std_logic_vector(7 downto 0); -- On-board LEDs

        -- UFPE/DES expansion header
        -- Input ports
        ehkey : in std_logic_vector(9 downto 0);
        -- Bits 0-7: switches; bits 8-9: push-buttons

        -- Output ports
        dig7seg : out std_logic_vector(1 downto 0); -- 7-segment display selector
        d7seg : out std_logic_vector(8 downto 0) -- Signals for the selected 7-segment display

    );
end ProjetosDeCasa;

architecture Exercicio_1 of ProjetosDeCasa is

signal x,y,z: integer;

begin

-- Decode the first 2-bit input from the switches
with ehkey(1 downto 0) select
    x <=    0 when "00",
           1 when "01",
           2 when "10",
           3 when "11",
           0 when others;

-- Decode the second 2-bit input from the switches
with ehkey(3 downto 2) select
    y <=    0 when "00",
           1 when "01",
           2 when "10",
           3 when "11",
           0 when others;

-- Multiply both inputs
    z <= x*y;

-- Display the 4-bit binary result on the LEDs
LED (3 downto 0) <= std_logic_vector(to_unsigned(z,4));
LED (7 downto 4) <= "0000";

-- Set the 7-segment display selector
dig7seg <= "00";

-- Select the corresponding 7-segment pattern based on the result
with z select
    d7seg <= "001111110" when 0,
             "000001100" when 1,
             "010110110" when 2,
             "010011110" when 3,
             "011001100" when 4,
             "011011010" when 5,
             "011111010" when 6,
             "000001110" when 7,
             "011111110" when 8,
             "011011110" when 9,
             "000000000" when others;

end Exercicio_1;