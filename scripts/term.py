'''Output terminal simulator'''

import sys
import re

print_re = re.compile("^\./peripherals/VHDL_PRINT\.vhd.*: ([0-9]+)$")

print("-- Output TERM --")
for line in sys.stdin:
    re_result = print_re.match(line)
    if re_result:
        v = int(re_result.group(1))
        
        if v == 4:
            print("-- EOT Received --")
            exit(0)

        print(chr(v), end='')
