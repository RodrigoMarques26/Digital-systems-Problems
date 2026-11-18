-- This exercise implements a lighting control system for a room with three doors.
-- Each door has a switch that changes state whenever someone enters or leaves.
-- Whenever a switch changes state, the lamp also changes its state.
-- The XOR operation is used to determine the lamp state.

-- Libraries used in this project
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ProjetosDeCasa is
    port
    (
        -- Physical inputs and outputs
        -- Note: No changes are required in this section!

        -- DE0-Nano board
        -- Input ports
        CLOCK_50 : in std_logic; -- 50 MHz clock oscillator
        KEY : in std_logic_vector(1 downto 0); -- Push-buttons on the DE0-Nano board

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
end ProjetosDeCasa;

architecture Ex1_Cap6 of ProjetosDeCasa is

begin

-- Combine the states of the three door switches using the XOR operation.
-- The result determines whether the lamp is on or off.
LED(0) <= (ehkey(0) xor ehkey(1) xor ehkey(2));

-- Keep all remaining LEDs turned off.
LED(7 downto 1) <= "0000000";

end Ex1_Cap6;