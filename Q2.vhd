-- This exercise implements a simplified thermodynamic system.
-- Pressure (P) and volume (V) are defined using physical switches.
-- The temperature (T) is calculated using the equation T = P * V.
-- The 7-segment display indicates the system status:
-- "A": Warning condition detected.
-- "d": System shutdown condition reached.

-- Libraries used in this project
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity projetos_de_casa is
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
end projetos_de_casa;

architecture Exercicio_2 of projetos_de_casa is

-- Declare all signals used in the design here (equivalent to auxiliary variables)
signal P,V,T: integer;

begin

with ehkey(2 downto 0) select
    P <=    0 when "000",
            1 when "001",
            2 when "010",
            3 when "011",
            4 when "100",
            5 when "101",
            6 when "110",
            7 when "111",
            0 when others;

with ehkey(5 downto 3) select
    V <=    0 when "000",
            1 when "001",
            2 when "010",
            3 when "011",
            4 when "100",
            5 when "101",
            6 when "110",
            7 when "111",
            0 when others;

    T <= P*V;

LED (5 downto 0) <= std_logic_vector(to_unsigned(T,6));
LED (7 downto 6) <= "00";

dig7seg <= "00";

-- Check the conditions for a system shutdown
process(T,P,V)
begin
    if (T > 12 and P > 5 and V > 4) then

        d7seg <= "010111100"; -- Display the letter "d" (System shutdown)

    -- Check the conditions for a system warning
    elsif (T > 12 and (P > 5 or V > 4)) then

        d7seg <= "011101110"; -- Display the letter "A" (Warning condition)
    else
        d7seg <= "000000000"; -- Turn off the display
    end if;
end process;

end Exercicio_2;