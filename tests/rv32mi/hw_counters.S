# Test for mcycle and mcountinhibit

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_CODE_BEGIN

# Check mcycle is incrementing
li TESTNUM, 1
csrr x5, mcycle
TEST_INSERT_NOPS_5
csrr x6, mcycle
ble x6, x5, fail

li TESTNUM, 2
li x5, 1
csrw mcountinhibit, x5
csrr x5, mcycle
TEST_INSERT_NOPS_5
csrr x6, mcycle
bne x6, x5, fail

li TESTNUM, 3
csrw mcountinhibit, x0
csrr x5, mcycle
TEST_INSERT_NOPS_5
csrr x6, mcycle
ble x6, x5, fail

li TESTNUM, 4
li x8, 4
csrw mcountinhibit, x8
csrr x5, minstret
csrw mcountinhibit, x0
TEST_INSERT_NOPS_5
csrw mcountinhibit, x8
csrr x6, minstret
csrw mcountinhibit, x0
sub x7, x6, x5
li x5, 6
bne x7, x5, fail

li TESTNUM, 5
li x8, 5
csrw mcountinhibit, x8
csrr x5, minstret
csrr x20, mcycle
csrw mcountinhibit, x0
TEST_INSERT_NOPS_5
lw	x10, 0(x0)
add x11, x10, x10
TEST_INSERT_NOPS_5
csrw mcountinhibit, x8
csrr x6, minstret
csrr x21, mcycle
csrw mcountinhibit, x0
sub x7, x6, x5
sub x22, x21, x20
li x5, 13
bne x7, x5, fail
ble x22, x7, fail

TEST_PASSFAIL
