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

entity iota is
	port( 
		round_number    : in unsigned(4 downto 0);
            	iota_in         : in  k_state;
           	iota_out        : out k_state
	);
end iota;

architecture Behavioural of iota is
    
	signal rc : std_logic_vector(63 downto 0);
    
begin
        
	round_constant : entity work.keccak_round_constants_gen
                            port map(round_number => round_number, 
                                     round_constant_signal_out => rc);
        
	iota_001: for y in 1 to 4 generate
		iota_002: for x in 0 to 4 generate
			iota_003: for z in 0 to 63 generate
				iota_out(y)(x)(z)<=iota_in(y)(x)(z);
			end generate;	
		end generate;
	end generate;
        
	i5012: for x in 1 to 4 generate
		i5013: for z in 0 to 63 generate
			iota_out(0)(x)(z)<=iota_in(0)(x)(z);
		end generate;	
	end generate;
        
	i5103: for z in 0 to 63 generate
		iota_out(0)(0)(z)<=iota_in(0)(0)(z) xor rc(z);
	end generate;	
end Behavioural;
