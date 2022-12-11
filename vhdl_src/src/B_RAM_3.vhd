library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;

entity B_RAM_3 is
	port (
		clk 		: in std_logic;
		we 			: in std_logic;
		fetch		: in std_logic;
		addr_inst 	: in std_logic_vector (29 downto 0);
		addr_data	: in std_logic_vector (29 downto 0);
		data_in 	: in std_logic_vector (7 downto 0);

		inst_out 	: out std_logic_vector (7 downto 0);
		data_out 	: out std_logic_vector (7 downto 0)
	);
end B_RAM_3;

-- 8 kB BRAM
architecture behavioral of B_RAM_3 is

	type ram_type is array (0 to 8192) of std_logic_vector(7 downto 0);
	signal ram : ram_type := (
		0 => x"00",
		1 => x"01",
		2 => x"30",
		3 => x"00",
		4 => x"85",
		5 => x"21",
		6 => x"00",
		7 => x"ff",
		8 => x"00",
		9 => x"01",
		10 => x"47",
		11 => x"08",
		12 => x"00",
		13 => x"00",
		14 => x"30",
		15 => x"f8",
		16 => x"00",
		17 => x"00",
		18 => x"00",
		19 => x"00",
		20 => x"00",
		21 => x"00",
		22 => x"00",
		23 => x"00",
		24 => x"02",
		25 => x"02",
		26 => x"02",
		27 => x"02",
		28 => x"02",
		29 => x"03",
		30 => x"03",
		31 => x"03",
		32 => x"05",
		33 => x"05",
		34 => x"05",
		35 => x"05",
		36 => x"05",
		37 => x"05",
		38 => x"05",
		39 => x"05",
		40 => x"07",
		41 => x"07",
		42 => x"07",
		43 => x"07",
		44 => x"07",
		45 => x"00",
		46 => x"00",
		47 => x"00",
		48 => x"00",
		49 => x"00",
		50 => x"01",
		51 => x"01",
		52 => x"01",
		53 => x"01",
		54 => x"02",
		55 => x"02",
		56 => x"02",
		57 => x"02",
		58 => x"03",
		59 => x"03",
		60 => x"03",
		61 => x"03",
		62 => x"04",
		63 => x"04",
		64 => x"04",
		65 => x"04",
		66 => x"05",
		67 => x"05",
		68 => x"05",
		69 => x"05",
		70 => x"06",
		71 => x"06",
		72 => x"06",
		73 => x"06",
		74 => x"07",
		75 => x"07",
		76 => x"00",
		77 => x"fe",
		78 => x"00",
		79 => x"02",
		80 => x"34",
		81 => x"fe",
		82 => x"fe",
		83 => x"00",
		84 => x"01",
		85 => x"02",
		86 => x"00",
		87 => x"fe",
		88 => x"00",
		89 => x"02",
		90 => x"fe",
		91 => x"fe",
		92 => x"30",
		93 => x"00",
		94 => x"01",
		95 => x"02",
		96 => x"00",
		97 => x"fe",
		98 => x"00",
		99 => x"02",
		100 => x"fe",
		101 => x"fe",
		102 => x"30",
		103 => x"00",
		104 => x"01",
		105 => x"02",
		106 => x"00",
		107 => x"fe",
		108 => x"00",
		109 => x"02",
		110 => x"fe",
		111 => x"fe",
		112 => x"30",
		113 => x"00",
		114 => x"01",
		115 => x"02",
		116 => x"00",
		117 => x"fe",
		118 => x"00",
		119 => x"02",
		120 => x"fe",
		121 => x"fe",
		122 => x"30",
		123 => x"00",
		124 => x"01",
		125 => x"02",
		126 => x"00",
		127 => x"fe",
		128 => x"00",
		129 => x"02",
		130 => x"30",
		131 => x"fe",
		132 => x"fe",
		133 => x"00",
		134 => x"01",
		135 => x"02",
		136 => x"00",
		137 => x"ff",
		138 => x"00",
		139 => x"00",
		140 => x"01",
		141 => x"50",
		142 => x"13",
		143 => x"7d",
		144 => x"00",
		145 => x"08",
		146 => x"0f",
		147 => x"00",
		148 => x"ff",
		149 => x"ff",
		150 => x"00",
		151 => x"00",
		152 => x"01",
		153 => x"00",
		154 => x"00",
		155 => x"00",
		156 => x"53",
		157 => x"53",
		158 => x"00",
		159 => x"00",
		160 => x"00",
		161 => x"00",
		162 => x"00",
		163 => x"00",
		164 => x"00",
		165 => x"00",
		166 => x"00",
		167 => x"00",
		168 => x"00",
		169 => x"00",
		170 => x"51",
		171 => x"0c",
		172 => x"00",
		173 => x"00",
		174 => x"00",
		175 => x"01",
		176 => x"00",
		177 => x"fe",
		178 => x"00",
		179 => x"02",
		180 => x"fe",
		181 => x"fe",
		182 => x"fe",
		183 => x"fe",
		184 => x"52",
		185 => x"52",
		186 => x"00",
		187 => x"00",
		188 => x"00",
		189 => x"53",
		190 => x"53",
		191 => x"00",
		192 => x"00",
		193 => x"00",
		194 => x"00",
		195 => x"00",
		196 => x"00",
		197 => x"00",
		198 => x"00",
		199 => x"00",
		200 => x"00",
		201 => x"00",
		202 => x"00",
		203 => x"00",
		204 => x"01",
		205 => x"02",
		206 => x"00",
		207 => x"ff",
		208 => x"00",
		209 => x"00",
		210 => x"01",
		211 => x"08",
		212 => x"e0",
		213 => x"00",
		214 => x"e5",
		215 => x"00",
		216 => x"00",
		217 => x"00",
		218 => x"01",
		219 => x"00",
		220 => x"fd",
		221 => x"02",
		222 => x"03",
		223 => x"fc",
		224 => x"fe",
		225 => x"02",
		226 => x"fe",
		227 => x"fd",
		228 => x"00",
		229 => x"00",
		230 => x"00",
		231 => x"00",
		232 => x"fe",
		233 => x"00",
		234 => x"fe",
		235 => x"fe",
		236 => x"fd",
		237 => x"00",
		238 => x"00",
		239 => x"fc",
		240 => x"00",
		241 => x"00",
		242 => x"02",
		243 => x"03",
		244 => x"00",
		245 => x"fb",
		246 => x"04",
		247 => x"05",
		248 => x"fa",
		249 => x"fa",
		250 => x"fb",
		251 => x"fe",
		252 => x"fe",
		253 => x"04",
		254 => x"fe",
		255 => x"fb",
		256 => x"02",
		257 => x"fe",
		258 => x"fe",
		259 => x"fb",
		260 => x"02",
		261 => x"fe",
		262 => x"fe",
		263 => x"03",
		264 => x"0f",
		265 => x"fe",
		266 => x"ff",
		267 => x"00",
		268 => x"fc",
		269 => x"fe",
		270 => x"00",
		271 => x"fe",
		272 => x"fe",
		273 => x"fa",
		274 => x"fe",
		275 => x"ff",
		276 => x"fe",
		277 => x"02",
		278 => x"fe",
		279 => x"ff",
		280 => x"00",
		281 => x"fd",
		282 => x"00",
		283 => x"00",
		284 => x"fe",
		285 => x"ff",
		286 => x"fe",
		287 => x"fe",
		288 => x"fc",
		289 => x"00",
		290 => x"00",
		291 => x"04",
		292 => x"05",
		293 => x"00",
		294 => x"fe",
		295 => x"00",
		296 => x"00",
		297 => x"02",
		298 => x"c8",
		299 => x"fe",
		300 => x"fe",
		301 => x"80",
		302 => x"00",
		303 => x"00",
		304 => x"d9",
		305 => x"02",
		306 => x"51",
		307 => x"ea",
		308 => x"01",
		309 => x"fe",
		310 => x"ef",
		311 => x"53",
		312 => x"e9",
		313 => x"00",
		314 => x"ff",
		315 => x"00",
		316 => x"01",
		317 => x"01",
		318 => x"02",
		319 => x"00",
		320 => x"6c",
		321 => x"6f",
		322 => x"21",
		323 => x"00",
		324 => x"6b",
		325 => x"00",
		326 => x"78",
		327 => x"74",
		328 => x"6d",
		329 => x"73",
		330 => x"6f",
		331 => x"2c",
		332 => x"00",
		others => (others => '0')
	);

begin

	process(clk)
	begin
		if (rising_edge(clk)) then
			if (fetch = '1') then
				inst_out <= ram(to_integer(unsigned(addr_inst(12 downto 0))));
			end if;

			if (we = '1') then
				ram(to_integer(unsigned(addr_data(12 downto 0)))) <= data_in;
			end if;
			
			data_out <= ram(to_integer(unsigned(addr_data(12 downto 0))));
		end if;
	end process;

end behavioral ; -- arch

