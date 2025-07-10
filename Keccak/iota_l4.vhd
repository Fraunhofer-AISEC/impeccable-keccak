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



entity iota_l4 is

	port(
	
		round_number:	in	unsigned(4 downto 0);
		state_in :	in	k_state;
		state_out: 	out	k_state
	);
end iota_l4;

architecture Behavioural of iota_l4 is
	
	type t_matrix_24_64 is array (0 to 23) of std_logic_vector(63 downto 0);
	signal index : std_logic_vector(63 downto 0);
	constant round_constants : t_matrix_24_64 := (  
            X"0000000000000007",
	    X"000000000000e0eb",
	    X"e00000000000e0e5",
	    X"e0000000e000e000",
	    X"000000000000e0e2",
	    X"00000000e0000007",
	    X"e0000000e000e0e7",
	    X"e00000000000e009",
	    X"00000000000000e5",
	    X"00000000000000ee",
	    X"00000000e000e009",
	    X"00000000e0000005",
	    X"00000000e000e0e2",
	    X"e0000000000000e2",
	    X"e00000000000e0e9",
	    X"e00000000000e00c",
	    X"e00000000000e00b",
	    X"e0000000000000e0",
	    X"000000000000e005",
	    X"e0000000e0000005",
	    X"e0000000e000e0e7",
	    X"e00000000000e0e0",
	    X"00000000e0000007",
	    X"e0000000e000e00e");

	begin
	index <= round_constants(to_integer(round_number));
	iota_l4_01 : for y in 1 to 4 generate
		iota_l4_02 : for x in 0 to 4 generate
			iota_l4_03 : for z in 0 to 63 generate
				state_out(y)(x)(z) <= state_in(y)(x)(z);
			end generate;
		end generate;
	end generate;

	iota_l4_04 : for x in 1 to 4 generate
		iota_l4_05 : for z in 0 to 63 generate
			state_out(0)(x)(z) <= state_in(0)(x)(z);
		end generate;
	end generate;

	iota_l4_06 : for z in 0 to 63 generate
		state_out(0)(0)(z) <= state_in(0)(0)(z) xor index(z);
	end generate;

end Behavioural;
