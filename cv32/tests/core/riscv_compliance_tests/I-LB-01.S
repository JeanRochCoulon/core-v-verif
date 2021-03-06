# RISC-V Compliance Test I-LB-01
#
# Copyright (c) 2017, Codasip Ltd.
# Copyright (c) 2018, Imperas Software Ltd. Additions
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#      * Redistributions of source code must retain the above copyright
#        notice, this list of conditions and the following disclaimer.
#      * Redistributions in binary form must reproduce the above copyright
#        notice, this list of conditions and the following disclaimer in the
#        documentation and/or other materials provided with the distribution.
#      * Neither the name of the Codasip Ltd., Imperas Software Ltd. nor the
#        names of its contributors may be used to endorse or promote products
#        derived from this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
# IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
# THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
# PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL Codasip Ltd., Imperas Software Ltd.
# BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
# LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
# ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
# THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
# Specification: RV32I Base Integer Instruction Set, Version 2.0
# Description: Testing instruction LB.

#include "compliance_test.h"
#include "compliance_io.h"
#include "test_macros.h"

# Test Virtual Machine (TVM) used by program.
RV_COMPLIANCE_RV32M

# Test code region
RV_COMPLIANCE_CODE_BEGIN

    RVTEST_IO_INIT
    RVTEST_IO_ASSERT_GPR_EQ(x0, 0x00000000)
    RVTEST_IO_WRITE_STR("# Test Begin Reserved regs ra(x1) a0(x10) t0(x5)\n")

    # ------------------0x00000000---------------------------------------------------------------------------
    RVTEST_IO_WRITE_STR("# Test part A1 - test base address + 0\n");

    # Addresses for test data and results
    la      x31, test_A1_data
    la      x2, test_A1_res

    # Test
    lb      x3, 0(x31)
    lb      x4, 1(x31)
    lb      x5, 2(x31)
    lb      x6, 3(x31)

    # Store results
    sw      x3, 0(x2)
    sw      x4, 4(x2)
    sw      x5, 8(x2)
    sw      x6, 12(x2)

    //
    // Assert
    //
    RVTEST_IO_CHECK()
    RVTEST_IO_ASSERT_GPR_EQ(x3, 0x00000022)
    RVTEST_IO_ASSERT_GPR_EQ(x4, 0xFFFFFFF2)
    RVTEST_IO_ASSERT_GPR_EQ(x5, 0x00000011)
    RVTEST_IO_ASSERT_GPR_EQ(x6, 0x00000011)

    RVTEST_IO_WRITE_STR("# Test part A1  - Complete\n");

    # ---------------------------------------------------------------------------------------------
    RVTEST_IO_WRITE_STR("# Test part A2 - test base address - 1\n");

    # Addresses for test data and results
    la      x24, test_A2_data + 1
    la      x5, test_A2_res

    # Test
    lb      x25, -1(x24)
    lb      x26, +0(x24)
    lb      x27, +1(x24)
    lb      x28, +2(x24)

    # Store results
    sw      x25, 0(x5)
    sw      x26, 4(x5)
    sw      x27, 8(x5)
    sw      x28, 12(x5)

    RVTEST_IO_ASSERT_GPR_EQ(x25, 0xFFFFFFF4)
    RVTEST_IO_ASSERT_GPR_EQ(x26, 0x00000044)
    RVTEST_IO_ASSERT_GPR_EQ(x27, 0x00000033)
    RVTEST_IO_ASSERT_GPR_EQ(x28, 0xFFFFFFF3)

    RVTEST_IO_WRITE_STR("# Test part A2  - Complete\n");

    # ---------------------------------------------------------------------------------------------
    RVTEST_IO_WRITE_STR("# Test part A3 - test base address + 1\n");

    # Addresses for test data and results
    la      x7, test_A3_data - 1
    la      x8, test_A3_res

    # Test
    lb      x30, 1(x7)
    lb      x31, 2(x7)
    lb      x1, 3(x7)
    lb      x2, 4(x7)

    # Store results
    sw      x30, 0(x8)
    sw      x31, 4(x8)
    sw      x1, 8(x8)
    sw      x2, 12(x8)

    RVTEST_IO_ASSERT_GPR_EQ(x30, 0x00000066)
    RVTEST_IO_ASSERT_GPR_EQ(x31, 0xFFFFFFF6)
    #RVTEST_IO_ASSERT_GPR_EQ(x1, 0x80000920)
    RVTEST_IO_ASSERT_GPR_EQ(x2, 0x00000055)

    RVTEST_IO_WRITE_STR("# Test part A3  - Complete\n");

    # ---------------------------------------------------------------------------------------------
    RVTEST_IO_WRITE_STR("# Test part A4 - test base address - 2048\n");

    # Addresses for test data and results
    la      x10, test_A4_data + 2048
    la      x11, test_A4_res

    # Test
    lb      x12, 0xFFFFF800(x10)
    lb      x13, 0xFFFFF801(x10)
    lb      x14, 0xFFFFF802(x10)
    lb      x15, 0xFFFFF803(x10)

    # Store results
    sw      x12, 0(x11)
    sw      x13, 4(x11)
    sw      x14, 8(x11)
    sw      x15, 12(x11)

    RVTEST_IO_ASSERT_GPR_EQ(x12, 0xFFFFFFF8)
    RVTEST_IO_ASSERT_GPR_EQ(x13, 0xFFFFFF88)
    RVTEST_IO_ASSERT_GPR_EQ(x14, 0x00000077)
    RVTEST_IO_ASSERT_GPR_EQ(x15, 0xFFFFFFF7)

    RVTEST_IO_WRITE_STR("# Test part A4  - Complete\n");

    # ---------------------------------------------------------------------------------------------
    RVTEST_IO_WRITE_STR("# Test part A5 - test base address + 2047\n");

    # Addresses for test data and results
    la      x13, test_A5_data - 2044
    la      x14, test_A5_res

    # Test
    lb      x15, 0x7FC(x13)
    lb      x16, 0x7FD(x13)
    lb      x17, 0x7FE(x13)
    lb      x18, 0x7FF(x13)

    # Store results
    sw      x15, 0(x14)
    sw      x16, 4(x14)
    sw      x17, 8(x14)
    sw      x18, 12(x14)

    RVTEST_IO_ASSERT_GPR_EQ(x15, 0xFFFFFFAA)
    RVTEST_IO_ASSERT_GPR_EQ(x16, 0x0000000A)
    RVTEST_IO_ASSERT_GPR_EQ(x17, 0x00000009)
    RVTEST_IO_ASSERT_GPR_EQ(x18, 0xFFFFFF99)

    RVTEST_IO_WRITE_STR("# Test part A5  - Complete\n");

    # ---------------------------------------------------------------------------------------------
    RVTEST_IO_WRITE_STR("# Test part B - test base address + -4,-1, ..., 6, 7\n");

    # Addresses for test data and results
    la      x16, test_B_data
    la      x17, test_B_res

    # Test
    lb      x18, -4(x16)
    lb      x19, -3(x16)
    lb      x20, -2(x16)
    lb      x21, -1(x16)
    lb      x22, 0(x16)
    lb      x23, 1(x16)
    lb      x24, 2(x16)
    lb      x25, 3(x16)
    lb      x26, 4(x16)
    lb      x27, 5(x16)
    lb      x28, 6(x16)
    lb      x29, 7(x16)

    # Store results
    sw      x18, 0(x17)
    sw      x19, 4(x17)
    sw      x20, 8(x17)
    sw      x21, 12(x17)
    sw      x22, 16(x17)
    sw      x23, 20(x17)
    sw      x24, 24(x17)
    sw      x25, 28(x17)
    sw      x26, 32(x17)
    sw      x27, 36(x17)
    sw      x28, 40(x17)
    sw      x29, 44(x17)

    RVTEST_IO_ASSERT_GPR_EQ(x18, 0x0000000C)
    RVTEST_IO_ASSERT_GPR_EQ(x19, 0xFFFFFFCC)
    RVTEST_IO_ASSERT_GPR_EQ(x20, 0xFFFFFFBB)
    RVTEST_IO_ASSERT_GPR_EQ(x21, 0x0000000B)
    RVTEST_IO_ASSERT_GPR_EQ(x22, 0xFFFFFFEE)
    RVTEST_IO_ASSERT_GPR_EQ(x23, 0x0000000E)
    RVTEST_IO_ASSERT_GPR_EQ(x24, 0x0000000D)
    RVTEST_IO_ASSERT_GPR_EQ(x25, 0xFFFFFFDD)
    RVTEST_IO_ASSERT_GPR_EQ(x26, 0xFFFFFFF0)
    RVTEST_IO_ASSERT_GPR_EQ(x27, 0x00000000)
    RVTEST_IO_ASSERT_GPR_EQ(x28, 0xFFFFFFFF)
    RVTEST_IO_ASSERT_GPR_EQ(x29, 0x0000000F)

    RVTEST_IO_WRITE_STR("# Test part B  - Complete\n");

    # ---------------------------------------------------------------------------------------------
    RVTEST_IO_WRITE_STR("# Test part C - test load to x0\n");

    # Addresses for test data and results
    la      x21, test_C_data
    la      x22, test_C_res

    # Test
    lb      x0, 0(x21)

    # Store results
    sw      x0, 0(x22)

    RVTEST_IO_ASSERT_GPR_EQ(x0, 0x00000000)

    RVTEST_IO_WRITE_STR("# Test part C  - Complete\n");

    # ---------------------------------------------------------------------------------------------
    RVTEST_IO_WRITE_STR("# Test part D - test for forwarding\n");

    # Addresses for test data and results
    la      x21, test_D_data
    la      x22, test_D_res

    # Test
    lw      x23, 0(x21)
    lb      x24, 0(x23)
    mv      x25, x24

    # Store results
    sw      x25, 0(x22)

    RVTEST_IO_ASSERT_GPR_EQ(x25, 0xFFFFFFF0)

    RVTEST_IO_WRITE_STR("# Test part D  - Complete\n");

    # ---------------------------------------------------------------------------------------------
    RVTEST_IO_WRITE_STR("# Test part E1 - test store with same base and destination address\n");

    # Addresses for test data and results
    la      x25, test_E1_data
    la      x26, test_E1_res

    # Test
    lb      x25, 0(x25)

    # Store results
    sw      x25, 0(x26)

    RVTEST_IO_ASSERT_GPR_EQ(x25, 0x00000010)

    RVTEST_IO_WRITE_STR("# Test part E  - Complete\n");

    # ---------------------------------------------------------------------------------------------
    RVTEST_IO_WRITE_STR("# Test part E2 - test store with same base and destination address, base with offset\n");

    # Addresses for test data and results
    la      x27, test_E2_data + 1
    la      x28, test_E2_res

    # Test
    lb      x27, -1(x27)

    # Store results
    sw      x27, 0(x28)

    RVTEST_IO_ASSERT_GPR_EQ(x27, 0xFFFFFF98)

    RVTEST_IO_WRITE_STR("# Test part A1  - Complete\n");

    RVTEST_IO_WRITE_STR("# Test End\n")

 # ---------------------------------------------------------------------------------------------
    # HALT
    RV_COMPLIANCE_HALT

RV_COMPLIANCE_CODE_END

# Input data section.
    .data
    .align 4

test_A1_data:
    .word 0x11F1F222
test_A2_data:
    .word 0xF33344F4
test_A3_data:
    .word 0x55F5F666
test_A4_data:
    .word 0xF77788F8
test_A5_data:
    .word 0x99090AAA
    .word 0x0BBBCC0C
test_B_data:
    .word 0xDD0D0EEE
    .word 0x0FFF00F0
test_C_data:
    .word 0x12345678
test_D_data:
    .word test_D_data2_label
test_D_data2_label:
    .word 0x9ABCDEF0
test_E1_data:
    .word 0x76543210
test_E2_data:
    .word 0xFEDCBA98


# Output data section.
RV_COMPLIANCE_DATA_BEGIN
    .align 4

test_A1_res:
    .fill 4, 4, -1
test_A2_res:
    .fill 4, 4, -1
test_A3_res:
    .fill 4, 4, -1
test_A4_res:
    .fill 4, 4, -1
test_A5_res:
    .fill 4, 4, -1
test_B_res:
    .fill 12, 4, -1
test_C_res:
    .fill 1, 4, -1
test_D_res:
    .fill 1, 4, -1
test_E1_res:
    .fill 1, 4, -1
test_E2_res:
    .fill 1, 4, -1

RV_COMPLIANCE_DATA_END
