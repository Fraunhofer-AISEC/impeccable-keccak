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
	use work.keccak_rho_constants.all;

library ieee;
	use ieee.std_logic_1164.all;
	use ieee.std_logic_arith.all;
	use ieee.std_logic_misc.all;

entity theta_l4 is
    port (theta_in  : in  k_state;
          theta_out : out k_state);
end entity;

architecture Behavioural of theta_l4 is
    signal parity_plane : k_plane;
    begin
        parity_l4_001: for x in 0 to 4 generate
	        parity_l4_002: for i in 0 to 63 generate
		        parity_plane(x)(i)<=theta_in(0)(x)(i) xor theta_in(1)(x)(i) xor theta_in(2)(x)(i) xor theta_in(3)(x)(i) xor theta_in(4)(x)(i);
	        end generate;	
        end generate;

	theta_l4_001: for y in 0 to 4 generate
		theta_l4_002: for x in 1 to 3 generate
			theta_l4_003: for z in 0 to 63 generate
				theta_out(y)(x)(z) <= theta_in(y)(x)(z) xor parity_plane(x-1)(z) xor (XOR_REDUCE(parity_plane(x+1) and rho_1(z)));
			end generate;
		end generate;
	end generate;

	theta_l4_004: for y in 0 to 4 generate
		theta_l4_005: for z in 0 to 63 generate
			theta_out(y)(0)(z) <= theta_in(y)(0)(z) xor parity_plane(4)(z) xor (XOR_REDUCE(parity_plane(1) and rho_1(z)));
		end generate;
	end generate;

	thet_l4_006: for y in 0 to 4 generate
		theta_l4_007: for z in 0 to 63 generate
			theta_out(y)(4)(z) <= theta_in(y)(4)(z) xor parity_plane(3)(z) xor (XOR_REDUCE(parity_plane(0) and rho_1(z)));
		end generate;
	end generate;
end Behavioural;
