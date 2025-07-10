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
	
entity keccak_1600 is
	port (
		axis_aclk	: in std_logic;
		axis_rst	: in std_logic;
		s_axis_tdata 	: in k_state;
		s_axis_tvalid 	: in std_logic;
		s_axis_tready 	: out std_logic;
		m_axis_tdata 	: out k_state;
		m_axis_tvalid 	: out std_logic;
		m_axis_tready 	: in std_logic;
		keccak_error    : out std_logic
	);
end keccak_1600;
	
architecture Behavioural of keccak_1600 is
	type t_keccak_fsm is (idle,hash,store);
	signal state : t_keccak_fsm := idle;
	signal counter : unsigned (4 downto 0);

	signal round_in		: k_state;		
	signal round_out	: k_state;
	signal cround_in	: k_state;
	signal cround_out	: k_state;
	signal l4_coder_in	: k_state;
	signal l4_coder_out	: k_state;
	signal message		: k_state;
	signal data4checkpoint	: k_state;
	signal cdata4checkpoint	: k_state;
	
	signal m_axis_tvalid_s	: std_logic;
	signal s_axis_tready_s	: std_logic;
	signal keccak_ready	: std_logic;
	signal keccak_finished	: std_logic;

	begin  
		m_keccak_round : entity work.keccak_round port map(
					        round_number => counter, 
						round_in => round_in,
						round_out => round_out,
						data4checkpoint => data4checkpoint);

		m_keccak_round_l4 : entity work.keccak_round_l4 port map(
					        round_number => counter, 
						round_in => cround_in,
						round_out => cround_out,
						data4checkpoint => cdata4checkpoint);
	
		m_coding_l4 : entity work.l4_state_coder port map(
						state_in => l4_coder_in,
						state_out => l4_coder_out);

		keccak_error	<= '1' when (l4_coder_out /= cdata4checkpoint and state = hash) or (l4_coder_out /= cround_out and state = store) else '0';
		keccak_ready 	<= '1' when (state = idle) else '0';
		keccak_finished <= '1' when (state = store) else '0';
	
		l4_coder_in	<= message when state = idle else data4checkpoint when state = hash else round_out;

		message 	<= s_axis_tdata;
		m_axis_tdata 	<= round_out;
		m_axis_tvalid 	<= m_axis_tvalid_s;
		s_axis_tready 	<= s_axis_tready_s;
		m_axis_tvalid_s <= keccak_finished;
		s_axis_tready_s <= keccak_ready;

		main : process(axis_aclk) begin
			if rising_edge(axis_aclk) then
				if(axis_rst='0') then
					state <= idle;
					round_in <= zero_state;
					cround_in <= zero_state;
					counter <= "00000";	
				else 
					case state is
						when idle =>
							if (s_axis_tvalid = '1' and s_axis_tready_s = '1') then
								round_in <= message;
								cround_in <= l4_coder_out;
								state <= hash;
								counter <= (others => '0');
							end if;
						when hash =>
							if counter = 23 then
						        	state <= store;
							else 
								round_in <= round_out;
								cround_in <= cround_out;
								counter <= counter+1;
							end if;
						when store =>
							if (m_axis_tvalid_s = '1' and m_axis_tready = '1') then
								state <= idle;
							end if;
					end case;
				end if;
			end if;
		end process;
end Behavioural;
