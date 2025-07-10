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

library ieee;
	use ieee.std_logic_1164.all;
	use ieee.std_logic_misc.all;

entity and_l4 is
	port (	
		in_1:	in 	std_logic_vector(3 downto 0);
		in_2:	in	std_logic_vector(3 downto 0);
		out_1:	out	std_logic_vector(3 downto 0)
	);
end and_l4;

architecture Behavioural of and_l4 is
	signal a : std_logic_vector(3 downto 0);
	signal b : std_logic_vector(3 downto 0);
	signal c : std_logic_vector(3 downto 0);

	type t_matrix_4_3 is array (3 downto 0) of std_logic_vector(2 downto 0);
	type t_matrix_3_4 is array (2 downto 0) of std_logic_vector(3 downto 0);

	signal a_dif : t_matrix_4_3;
	signal b_dif : t_matrix_3_4;

	type t_matrix_3 is array (2 downto 0) of std_logic_vector(3 downto 0);
	type t_matrix_4 is array (3 downto 0) of std_logic_vector(3 downto 0);
	type t_matrix_4_3_4 is array (3 downto 0) of t_matrix_3;
	type t_matrix_3_4_4 is array (2 downto 0) of t_matrix_4;

	constant X : t_matrix_4_3_4 :=  (("0011", "0101", "0110"),
					("0011", "1001", "1010"),
					("0101", "1001", "1100"),
					("0110", "1010", "1100"));
	constant X_t : t_matrix_3_4_4:= (("0011", "0011", "0101", "0110"),
					("0101", "1001", "1001", "1010"),
					("0110", "1010", "1100", "1100"));
	begin

	a <= in_1;
	b <= in_2;
	out_1 <= c;

	and_l4_01 : for i in 0 to 3 generate 
		and_l4_02 : for j in 0 to 2 generate
			a_dif(i)(j) <= XOR_REDUCE(a and X(i)(j));
			b_dif(j)(i) <= XOR_REDUCE(b and X_t(j)(i));
		end generate;
	end generate;

	and_l4_03 : for i in 0 to 3 generate
		c(i) <= (a(i) and b(i)) xor XOR_REDUCE(a_dif(i) and (b_dif(2)(i) & b_dif(1)(i) & b_dif(0)(i)));
	end generate;
end Behavioural;
