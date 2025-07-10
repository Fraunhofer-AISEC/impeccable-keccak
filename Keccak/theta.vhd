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
	use ieee.std_logic_arith.all;

entity theta is
	port (
		theta_in  : in  k_state;
		theta_out : out k_state
	);
end theta;

architecture Behavioral of theta is
	signal parity_plane : k_plane;
    
begin
	parity_001: for x in 0 to 4 generate
		parity_002: for z in 0 to 63 generate
			parity_plane(x)(z)<=theta_in(0)(x)(z) xor theta_in(1)(x)(z) xor theta_in(2)(x)(z) xor theta_in(3)(x)(z) xor theta_in(4)(x)(z);
		end generate;	
	end generate;

	theta_001: for y in 0 to 4 generate
		theta_002: for x in 1 to 3 generate
			theta_out(y)(x)(0)<=theta_in(y)(x)(0) xor parity_plane(x-1)(0) xor parity_plane(x+1)(63);
			theta_003: for z in 1 to 63 generate
				theta_out(y)(x)(z)<=theta_in(y)(x)(z) xor parity_plane(x-1)(z) xor parity_plane(x+1)(z-1);
			end generate;	
		end generate;
	end generate;

	theta_004: for y in 0 to 4 generate
		theta_out(y)(0)(0)<=theta_in(y)(0)(0) xor parity_plane(4)(0) xor parity_plane(1)(63);
		theta_005: for z in 1 to 63 generate
			theta_out(y)(0)(z)<=theta_in(y)(0)(z) xor parity_plane(4)(z) xor parity_plane(1)(z-1);
		end generate;	
	end generate;

	theta_006: for y in 0 to 4 generate
		theta_out(y)(4)(0)<=theta_in(y)(4)(0) xor parity_plane(3)(0) xor parity_plane(0)(63);
		theta_007: for z in 1 to 63 generate
			theta_out(y)(4)(z)<=theta_in(y)(4)(z) xor parity_plane(3)(z) xor parity_plane(0)(z-1);
		end generate;	
	end generate;

end Behavioral;
