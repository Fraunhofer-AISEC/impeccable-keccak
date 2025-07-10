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

library ieee;
use ieee.std_logic_1164.all;

package keccak_globals is

type k_plane is array (4 downto 0) of std_logic_vector(63 downto 0);
type k_state is array (4 downto 0) of k_plane;

type k_plane_ext is array (5 downto 0) of std_logic_vector(63 downto 0);
type k_state_ext is array (4 downto 0) of k_plane_ext;

type t_matrix_64 is array (63 downto 0) of std_logic_vector(63 downto 0);
type t_matrix_4 is array (3 downto 0) of std_logic_vector(3 downto 0);
type t_matrix_4_8 is array (3 downto 0) of std_logic_vector(7 downto 0);
constant zero_lane : std_logic_vector(63 downto 0) := (others => '0');
constant zero_plane : k_plane := (others => zero_lane);
constant zero_state : k_state := (others => zero_plane); 

constant generator_4 : t_matrix_4:=( "1110",
				     "1101",
				     "1011",
				     "0111");

constant rho_l4_rot_1 : t_matrix_4_8 :=(b"00010000",
					b"01101110",
					b"10101110",
					b"11001110");

constant rho_l4_rot_2 : t_matrix_4_8 :=(b"11001110",
					b"11001101",
					b"10110011",
					b"01110011");
			
constant rho_l4_rot_3 : t_matrix_4_8 :=(b"01110011",
					b"01110101",
					b"01110110",
					b"00001000");


end package;
