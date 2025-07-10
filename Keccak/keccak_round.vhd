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

entity keccak_round is
    port (
            round_number	: in	unsigned(4 downto 0);
            round_in		: in	k_state;
            round_out		: out	k_state;
            data4checkpoint	: out	k_state
    );
end keccak_round;

architecture Behavioural of keccak_round is
    	
	signal theta_out	: k_state;
	signal rho_out		: k_state;
	signal pi_out		: k_state;
	signal chi_out		: k_state;

	begin
	
	data4checkpoint <= pi_out;	
	
	m_theta:        entity work.theta port map (theta_in => round_in, theta_out => theta_out);
        m_rho:          entity work.rho   port map (rho_in => theta_out, rho_out => rho_out);
        m_pi:           entity work.pi    port map (pi_in => rho_out, pi_out => pi_out);
        m_chi:          entity work.chi   port map (chi_in => pi_out, chi_out => chi_out);
        m_iota:         entity work.iota  port map (round_number => round_number, iota_in => chi_out, iota_out => round_out); 
end Behavioural;
