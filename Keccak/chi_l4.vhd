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

entity chi_l4 is
	port (
		state_in:	in	k_state;
		state_out:	out	k_state
	);
end chi_l4;

architecture Behavioural of chi_l4 is

    signal not_state_in : k_state;
	signal product : k_state;

	begin
	chi_l4_01 : for y in 4 downto 0 generate
		chi_l4_02 : for x in 4 downto 0 generate
			chi_l4_03 : for z in 63 downto 0 generate
				not_state_in(y)(x)(z) <= not state_in(y)(x)(z);
			end generate;
		end generate;
	end generate;

	chi_l4_04 : for y in 4 downto 0 generate
		chi_l4_05 : for x in 2 downto 0 generate
			chi_l4_06 : for i in 15 downto 0 generate
				m_and_l4 : entity work.and_l4 port map (
							in_1  => not_state_in(y)(x+1)(i*4+3 downto i*4),
							in_2  => state_in(y)(x+2)(i*4+3 downto i*4),
							out_1 => product(y)(x)(i*4+3 downto i*4));
			end generate;
		end generate;
		chi_l4_07 : for i in 15 downto 0 generate
				m_and_l4 : entity work.and_l4 port map (
							in_1  => not_state_in(y)(4)(i*4+3 downto i*4),
							in_2  => state_in(y)(0)(i*4+3 downto i*4),
							out_1 => product(y)(3)(i*4+3 downto i*4));
		end generate;
		chi_l4_08 : for i in 15 downto 0 generate
				m_and_l4 : entity work.and_l4 port map (
							in_1  => not_state_in(y)(0)(i*4+3 downto i*4),
							in_2  => state_in(y)(1)(i*4+3 downto i*4),
							out_1 => product(y)(4)(i*4+3 downto i*4));
		end generate;
	end generate;
	
	chi_l4_09 : for y in 4 downto 0 generate
		chi_l4_10 : for x in 4 downto 0 generate
			chi_l4_11 : for z in 63 downto 0 generate
				state_out(y)(x)(z) <= state_in(y)(x)(z) xor product(y)(x)(z);
			end generate;
		end generate;
	end generate;

end Behavioural;
							
