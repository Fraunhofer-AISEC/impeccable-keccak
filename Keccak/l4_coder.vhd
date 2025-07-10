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
	use ieee.std_logic_misc.all;

entity l4_coder is
	port(
		    data_in: 	in	std_logic_vector(3 downto 0);
		    data_out:	out	std_logic_vector(3 downto 0)
	);
end l4_coder;

architecture Behavioural of l4_coder is begin
	l4_coder_01: for i in 3 downto 0 generate
		data_out(i) <= XOR_REDUCE(generator_4(i) and data_in);
	end generate;
end Behavioural;
