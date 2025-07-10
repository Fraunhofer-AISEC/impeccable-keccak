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

entity l4_lane_coder is 
	port(	
		lane_in : in	std_logic_vector(63 downto 0);
		lane_out: out	std_logic_vector(63 downto 0)
	);
end l4_lane_coder;

architecture Behavioural of l4_lane_coder is begin
	l4_lane_coder_01: for i in 15 downto 0 generate
		m_l4_lane_coder: entity work.l4_coder
			port map ( data_in(3)  => lane_in(4*i+3),
				   data_in(2)  => lane_in(4*i+2),
				   data_in(1)  => lane_in(4*i+1),
				   data_in(0)  => lane_in(4*i),
				   data_out(3) => lane_out(4*i+3),
				   data_out(2) => lane_out(4*i+2),
				   data_out(1) => lane_out(4*i+1),
				   data_out(0) => lane_out(4*i));
	end generate;
end Behavioural;

