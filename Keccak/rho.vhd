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

entity rho is
	port (
		rho_in  : in  k_state;
		rho_out : out k_state
	);
end rho;

architecture Behavioral of rho is
   
begin
	rho_001: for z in 0 to 63 generate
		rho_out(0)(0)(z)<=rho_in(0)(0)(z);
	end generate;	
        
	rho_002: for z in 0 to 63 generate
		rho_out(0)(1)(z)<=rho_in(0)(1)((z-1)mod 64);
	end generate;
        
	rho_003: for z in 0 to 63 generate
		rho_out(0)(2)(z)<=rho_in(0)(2)((z-62)mod 64);
	end generate;
        
	rho_004: for z in 0 to 63 generate
		rho_out(0)(3)(z)<=rho_in(0)(3)((z-28)mod 64);
	end generate;
        
	rho_005: for z in 0 to 63 generate
		rho_out(0)(4)(z)<=rho_in(0)(4)((z-27)mod 64);
	end generate;
        
	rho_006: for z in 0 to 63 generate
		rho_out(1)(0)(z)<=rho_in(1)(0)((z-36)mod 64);
	end generate;	
        
	rho_007: for z in 0 to 63 generate
		rho_out(1)(1)(z)<=rho_in(1)(1)((z-44)mod 64);
	end generate;
        
	rho_008: for z in 0 to 63 generate
		rho_out(1)(2)(z)<=rho_in(1)(2)((z-6)mod 64);
	end generate;
        
	rho_009: for z in 0 to 63 generate
		rho_out(1)(3)(z)<=rho_in(1)(3)((z-55)mod 64);
	end generate;
        
	rho_010: for z in 0 to 63 generate
		rho_out(1)(4)(z)<=rho_in(1)(4)((z-20)mod 64);
	end generate;
        
	rho_011: for z in 0 to 63 generate
		rho_out(2)(0)(z)<=rho_in(2)(0)((z-3)mod 64);
	end generate;	
        
	rho_012: for z in 0 to 63 generate
		rho_out(2)(1)(z)<=rho_in(2)(1)((z-10)mod 64);
	end generate;
        
	rho_013: for z in 0 to 63 generate
		rho_out(2)(2)(z)<=rho_in(2)(2)((z-43)mod 64);
	end generate;
        
	rho_014: for z in 0 to 63 generate
		rho_out(2)(3)(z)<=rho_in(2)(3)((z-25)mod 64);
	end generate;
        
	rho_015: for z in 0 to 63 generate
		rho_out(2)(4)(z)<=rho_in(2)(4)((z-39)mod 64);
	end generate;
        
	rho_016: for z in 0 to 63 generate
		rho_out(3)(0)(z)<=rho_in(3)(0)((z-41)mod 64);
	end generate;	
        
	rho_017: for z in 0 to 63 generate
		rho_out(3)(1)(z)<=rho_in(3)(1)((z-45)mod 64);
	end generate;
        
	rho_018: for z in 0 to 63 generate
		rho_out(3)(2)(z)<=rho_in(3)(2)((z-15)mod 64);
	end generate;
        
	rho_019: for z in 0 to 63 generate
		rho_out(3)(3)(z)<=rho_in(3)(3)((z-21)mod 64);
	end generate;
        
	rho_020: for z in 0 to 63 generate
		rho_out(3)(4)(z)<=rho_in(3)(4)((z-8)mod 64);
	end generate;
        
	rho_021: for z in 0 to 63 generate
		rho_out(4)(0)(z)<=rho_in(4)(0)((z-18)mod 64);
	end generate;	
        
	rho_022: for z in 0 to 63 generate
		rho_out(4)(1)(z)<=rho_in(4)(1)((z-2)mod 64);
	end generate;
        
	rho_023: for z in 0 to 63 generate
		rho_out(4)(2)(z)<=rho_in(4)(2)((z-61)mod 64);
	end generate;
        
	rho_024: for z in 0 to 63 generate
		rho_out(4)(3)(z)<=rho_in(4)(3)((z-56)mod 64);
	end generate;
        
	rho_025: for z in 0 to 63 generate
		rho_out(4)(4)(z)<=rho_in(4)(4)((z-14)mod 64);
	end generate;
end Behavioral;
