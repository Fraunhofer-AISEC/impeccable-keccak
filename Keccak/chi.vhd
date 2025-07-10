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

entity chi is
	port (
		chi_in  : in  k_state;
		chi_out : out k_state
	);
end chi;

architecture Behavioral of chi is
    
begin
	chi_001: for y in 0 to 4 generate
		chi_002: for x in 0 to 2 generate
			chi_003: for z in 0 to 63 generate
				chi_out(y)(x)(z)<=chi_in(y)(x)(z) xor  ( not(chi_in (y)(x+1)(z))and chi_in (y)(x+2)(z));
			end generate;	
		end generate;
	end generate;
        
	chi_004: for y in 0 to 4 generate
		chi_005: for z in 0 to 63 generate
			chi_out(y)(3)(z)<=chi_in(y)(3)(z) xor  ( not(chi_in (y)(4)(z))and chi_in (y)(0)(z));
		end generate;	
	end generate;
        
	chi_006: for y in 0 to 4 generate
		chi_007: for z in 0 to 63 generate
			chi_out(y)(4)(z)<=chi_in(y)(4)(z) xor  ( not(chi_in (y)(0)(z))and chi_in (y)(1)(z));
		end generate;	
	end generate;

end Behavioral;
