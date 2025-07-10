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

entity pi is
	port (
		pi_in  : in  k_state;
		pi_out : out k_state
	);
end pi;

architecture Behavioral of pi is
begin
	pi_001: for y in 0 to 4 generate
		pi_002: for x in 0 to 4 generate
			pi_003: for z in 0 to 63 generate
				pi_out((2*x+3*y) mod 5)(0*x+1*y)(z)<=pi_in(y)(x)(z);
			end generate;	
		end generate;
	end generate;

end Behavioral;
