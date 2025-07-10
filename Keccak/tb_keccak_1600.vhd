--This file is based on the orignal Keccak implementation from https://keccak.team/hardware.html

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
library std;
	use std.textio.all;
	
library ieee;
	use ieee.std_logic_1164.all;
	use ieee.std_logic_textio.all;
	use ieee.numeric_std.all;


entity tb_keccak_1600 is
end tb_keccak_1600;
	
architecture tb of tb_keccak_1600 is

	signal clk		: std_logic;
	signal rst_n		: std_logic;
	signal m_axis_tdata	: k_state;
	signal m_axis_tready	: std_logic;
	signal m_axis_tvalid	: std_logic;
	signal s_axis_tdata	: k_state;
	signal s_axis_tready	: std_logic;
	signal s_axis_tvalid	: std_logic;
	signal keccak_error	: std_logic;

 	type st_type is (st0,st_05,st1,STOP);
 	signal st : st_type;
	signal input_select : std_logic; 
 
	begin
		m_keccak_system : entity work.keccak_1600 port map (
						axis_aclk => clk,
						axis_rst => rst_n,
						s_axis_tdata => m_axis_tdata,
						s_axis_tvalid => m_axis_tvalid,
						s_axis_tready => m_axis_tready,
						m_axis_tdata => s_axis_tdata,
						m_axis_tvalid => s_axis_tvalid,
						m_axis_tready => s_axis_tready,
						keccak_error => keccak_error);

		m_axis_tvalid <= '1' when st = st_05 else '0';
		s_axis_tready <= '1';
		rst_n <= '0', '1' after 10 ps;

		main_process : process(clk)
						
			variable line_in : line;
			variable line_out : line;
			
			variable buffer_in: std_logic_vector(63 downto 0);		
			variable buffer_out: std_logic_vector(63 downto 0);
			
			
			file filein : text open read_mode is "../../../../test_generator/test_vectors/test_in.txt";
			file fileout : text open write_mode is "../../../../test_generator/test_vectors/simulation_out.txt";
						
			begin
				if(rst_n='0') then
					st <= st0;		
				elsif(clk'event and clk='1') then
					case st is
					when st0 =>
						if (m_axis_tready = '1') then
							readline(filein,line_in);
							if(line_in(1)='.') then
								FILE_CLOSE(filein);
								FILE_CLOSE(fileout);
								assert false report "Simulation completed" severity failure;
								st <= STOP;
							else
							    for y in 0 to 4 loop
							        for x in 0 to 4 loop
								        hread(line_in, buffer_in);
								        m_axis_tdata(y)(x) <= buffer_in;
								        readline(filein, line_in);
								    end loop;
								end loop;
							end if;
							st <= st_05;
						end if;
					when st_05 => 
						st <= st1;
					when st1 =>
						if s_axis_tready = '1' and s_axis_tvalid = '1' then
							for y in 0 to 4 loop
						        	for x in 0 to 4 loop
							        	buffer_out := s_axis_tdata(y)(x);
							        	hwrite(line_out,buffer_out);
							        	writeline(fileout,line_out);
								end loop;
							end loop;
							write(fileout,string'("-"));
							writeline(fileout,line_out);
							st<=st0;
						end if;
					when STOP => null;
					end case;
				end if;
			end process;

		clkgen : process
			begin
				clk <= '1';
				loop
					wait for 100 ps;
					clk<=not clk;
				end loop;
			end process;

end tb;
