-- This exercise implements a water tank level monitoring system.
-- Eight float sensors (A-H) detect the water level inside the tank.
-- The detected water level is displayed on the 7-segment display,
-- while the LEDs show the corresponding value in BCD.

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

end ProjetosDeCasa;

architecture Ex2_Cap6 of ProjetosDeCasa is

begin

-- Select the first 7-segment display
dig7seg <= "00";

-- Keep the four upper LEDs turned off
LED(7 downto 4) <= "0000"; 

-- Select the 7-segment display pattern according to the detected water level
with ehkey(7 downto 0) select

	d7seg <= "001100000" when "00000001", -- Water level A

		      "011011010" when "00000011", -- Water level B

		      "011110010" when "00000111", -- Water level C

		      "001100110" when "00001111", -- Water level D

		      "010110110" when "00011111", -- Water level E

		      "000111110" when "00111111", -- Water level F

		      "011100000" when "01111111", -- Water level G

		      "011111110" when "11111111", -- Water level H

		      "000000000" when others;

-- Display the detected water level in BCD using the four lower LEDs
with ehkey(7 downto 0) select

	LED(3 downto 0) <= "0001" when "00000001", -- Water level A

			   "0010" when "00000011", -- Water level B

			   "0011" when "00000111", -- Water level C

			   "0100" when "00001111", -- Water level D

			   "0101" when "00011111", -- Water level E

			   "0110" when "00111111", -- Water level F

			   "0111" when "01111111", -- Water level G

			   "1000" when "11111111", -- Water level H

			   "0000" when others;

end Ex2_Cap6;