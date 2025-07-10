--This file is based on the orignal Keccak implementation from https://keccak.team/hardware.html

--Copyright 2024 Fraunhofer Institute for Applied and Integrated Security (AISEC).

--Licensed under the Apache License, Version 2.0 (the "License");
--you may not use this file except in compliance with the License.
--You may obtain a copy of the License at

--    http://www.apache.org/licenses/LICENSE-2.0

--Unless required by applicable law or agreed to in writing, software
--distributed under the License is distributed on an "AS IS" BASIS,
--WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
--See the License for the specific language governing permissions and
--limitations under the License.

library work;
	use work.keccak_globals.all;
	
library ieee;
	use ieee.std_logic_1164.all;
	use ieee.numeric_std.all;	


entity keccak_round_constants_gen is
port(
	    round_number		: 	in unsigned(4 downto 0);
	    round_constant_signal_out	: 	out std_logic_vector(63 downto 0)
    );

end keccak_round_constants_gen;

architecture rtl of keccak_round_constants_gen is
 
signal round_constant_signal: std_logic_vector(63 downto 0);
 
begin

round_constants : process (round_number)
begin
	case round_number is
		when "00000" => round_constant_signal <= X"0000000000000001" ;
		when "00001" => round_constant_signal <= X"0000000000008082" ;
		when "00010" => round_constant_signal <= X"800000000000808A" ;
		when "00011" => round_constant_signal <= X"8000000080008000" ;
		when "00100" => round_constant_signal <= X"000000000000808B" ;
		when "00101" => round_constant_signal <= X"0000000080000001" ;
		when "00110" => round_constant_signal <= X"8000000080008081" ;
		when "00111" => round_constant_signal <= X"8000000000008009" ;
		when "01000" => round_constant_signal <= X"000000000000008A" ;
		when "01001" => round_constant_signal <= X"0000000000000088" ;
		when "01010" => round_constant_signal <= X"0000000080008009" ;
		when "01011" => round_constant_signal <= X"000000008000000A" ;
		when "01100" => round_constant_signal <= X"000000008000808B" ;
		when "01101" => round_constant_signal <= X"800000000000008B" ;
		when "01110" => round_constant_signal <= X"8000000000008089" ;
		when "01111" => round_constant_signal <= X"8000000000008003" ;
		when "10000" => round_constant_signal <= X"8000000000008002" ;
		when "10001" => round_constant_signal <= X"8000000000000080" ;
		when "10010" => round_constant_signal <= X"000000000000800A" ;
		when "10011" => round_constant_signal <= X"800000008000000A" ;
		when "10100" => round_constant_signal <= X"8000000080008081" ;
		when "10101" => round_constant_signal <= X"8000000000008080" ;
		when "10110" => round_constant_signal <= X"0000000080000001" ;
		when "10111" => round_constant_signal <= X"8000000080008008" ;	    	    
		when others => round_constant_signal <=(others => '0');
        end case;
end process round_constants;

round_constant_signal_out<=round_constant_signal;
end rtl;
