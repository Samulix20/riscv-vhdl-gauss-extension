from elftools.elf.elffile import ELFFile
import sys

tail_lines="""		others => (others => '0')
	);

begin

	process(clk)
	begin
		if (rising_edge(clk)) then
			if (fetch = '1') then
				inst_out <= ram(to_integer(unsigned(addr_inst(14 downto 0))));
			end if;

			if (we = '1') then
				ram(to_integer(unsigned(addr_data(14 downto 0)))) <= data_in;
			end if;
			
			data_out <= ram(to_integer(unsigned(addr_data(14 downto 0))));
		end if;
	end process;

end behavioral ; -- arch"""

ram_head="""library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;

entity B_RAM_{r} is
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
end B_RAM_{r};

-- 32 kB BRAM
architecture behavioral of B_RAM_{r} is

	type ram_type is array (0 to 32768) of std_logic_vector(7 downto 0);
	signal ram : ram_type := ("""

# Tool for creating vhdl RAM files from an elf file
def write_vhdl_memory(ram, data, path, tpath):
    '''Writes VHDL RAM memory'''
    with open(f'{path}/B_RAM_{ram}.vhd', "w", encoding="utf8") as ram_file:
        ram_file.writelines(ram_head.format(r=ram))
        addr = 0
        for j in data:
            ram_file.write(f'\t\t{addr} => x\"{j:02x}\",\n')
            addr += 1
        ram_file.writelines(tail_lines)

def bank_divide(efile):
    '''Divide data in 4 banks'''
    with open(efile, 'rb') as fil:
        elf_file = ELFFile(fil)
        seg_data = elf_file.get_segment(1).data()
        _rams = [[], [], [], []]
        j = 0
        print_out_ram = ""
        for byt in seg_data:
            _rams[j].append(byt)
            print_out_ram = f'{byt:02x}' + print_out_ram
            j += 1
            if j == 4:
                j = 0
                print(f'0x{print_out_ram},')
                print_out_ram = ""
        return _rams

# Main func
# prog elf_path vhdl_path template_path
if len(sys.argv) != 4:
    exit(1)

rams = bank_divide(sys.argv[1])
for i in range(4):
    write_vhdl_memory(i, rams[i], sys.argv[2], sys.argv[3])
