LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
 
ENTITY Digital_Calculator_with_RAM IS
	PORT
	(
		A   				: INOUT	SIGNED    (3 DOWNTO 0);
		B   				: IN		SIGNED    (3 DOWNTO 0);
		CHOOSE			: IN		STD_LOGIC_VECTOR (1 DOWNTO 0);
		X   				: INOUT	SIGNED    (7 DOWNTO 0);
		ADDRESS			: IN		STD_LOGIC_VECTOR (6 DOWNTO 0);
		CLOCK				: IN		STD_LOGIC  := '1';
		WRITE_ENABLE	: IN		STD_LOGIC ;
		OUTPUT			: OUT		STD_LOGIC_VECTOR (7 DOWNTO 0)
	);
END Digital_Calculator_with_RAM;
 
ARCHITECTURE Digi_Calc OF Digital_Calculator_with_RAM IS
	SIGNAL	TEMP	:	INTEGER	:= 0;
	
	COMPONENT RAM
		PORT
		(
			address	: IN 	STD_LOGIC_VECTOR (6 DOWNTO 0);
			clock		: IN 	STD_LOGIC  := '1';
			data		: IN 	STD_LOGIC_VECTOR (7 DOWNTO 0);
			wren		: IN 	STD_LOGIC ;
			q			: OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
		);
	END COMPONENT RAM;

BEGIN

	Kalkulator : PROCESS(A, B, CHOOSE, TEMP)
	BEGIN
		CASE CHOOSE IS
			WHEN "00" =>								-- Penjumlahan / Adder
				X<=("0000" & A) + ("0000" & B);
			WHEN "01" =>								-- Pengurangan / Subtractor
				X<=("0000" & A) - ("0000" & B);
			WHEN "10" =>								-- Perkalian / Multiplier
				X<=A * B;
			WHEN "11" =>								-- Pembagian / Divider
				X<=("0000" & A) / ("0000" & B);
			WHEN OTHERS =>
			NULL;
		END CASE;
	END PROCESS Kalkulator;

	MEM : RAM	-- Jenis RAM yang digunakan ada 1 PORT RAM dengan ukuran 128x8
		PORT MAP
		(
			address	=> ADDRESS,
			clock		=> CLOCK,
			data		=> STD_LOGIC_VECTOR(X),
			wren		=> WRITE_ENABLE,
			q			=> OUTPUT
		);

END Digi_Calc;