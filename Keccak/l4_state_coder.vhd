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

entity l4_state_coder is
	port(	
		state_in:	in	k_state;
		state_out:	out	k_state
	);
end l4_state_coder;

architecture Behavioural of l4_state_coder is begin
	l4_state_coder_01: for y in 4 downto 0 generate
		l4_state_coder_02 : for x in 4 downto 0 generate
			m_l4_lane_coder: entity work.l4_lane_coder
				port map( lane_in => state_in(y)(x), lane_out => state_out(y)(x));
		end generate;
	end generate;
end Behavioural;
