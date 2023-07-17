-- 31 bit Max linear-feedback shift register 

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity LFSR_31 is
	generic(
		reset_seed : std_logic_vector(30 downto 0)
	);
	port(
		clk     : in std_logic;
		set     : in std_logic;
		shift	: in std_logic;
		seed    : in std_logic_vector(30 downto 0);
		state   : out std_logic_vector(30 downto 0)
	);
end LFSR_31;

architecture behavioral of LFSR_31 is

	signal internal_state : std_logic_vector(30 downto 0) := reset_seed;
	signal feedback : std_logic;

begin

	process(clk)
	begin
		if rising_edge(clk) then
			
			if set = '1' then
				internal_state <= seed;
			elsif shift = '1' then
				internal_state <= feedback & internal_state(30 downto 1);
			end if;

		end if;
	end process;

	feedback <= internal_state(3) xor internal_state(0);
	state <= internal_state;

end behavioral;
