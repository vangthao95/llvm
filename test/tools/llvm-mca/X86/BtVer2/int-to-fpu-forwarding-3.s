# NOTE: Assertions have been autogenerated by utils/update_mca_test_checks.py
# RUN: llvm-mca -mtriple=x86_64-unknown-unknown -mcpu=btver2 -iterations=500 -timeline -timeline-max-iterations=3 < %s | FileCheck %s

# Throughput for the code snippet below should tend to 1.00 IPC.

add %eax, %eax
vpinsrb $0, %eax, %xmm0, %xmm0
vpinsrb $1, %eax, %xmm0, %xmm0

# CHECK:      Iterations:        500
# CHECK-NEXT: Instructions:      1500
# CHECK-NEXT: Total Cycles:      7004
# CHECK-NEXT: Total uOps:        2500

# CHECK:      Dispatch Width:    2
# CHECK-NEXT: uOps Per Cycle:    0.36
# CHECK-NEXT: IPC:               0.21
# CHECK-NEXT: Block RThroughput: 2.5

# CHECK:      Instruction Info:
# CHECK-NEXT: [1]: #uOps
# CHECK-NEXT: [2]: Latency
# CHECK-NEXT: [3]: RThroughput
# CHECK-NEXT: [4]: MayLoad
# CHECK-NEXT: [5]: MayStore
# CHECK-NEXT: [6]: HasSideEffects (U)

# CHECK:      [1]    [2]    [3]    [4]    [5]    [6]    Instructions:
# CHECK-NEXT:  1      1     0.50                        addl	%eax, %eax
# CHECK-NEXT:  2      7     0.50                        vpinsrb	$0, %eax, %xmm0, %xmm0
# CHECK-NEXT:  2      7     0.50                        vpinsrb	$1, %eax, %xmm0, %xmm0

# CHECK:      Resources:
# CHECK-NEXT: [0]   - JALU0
# CHECK-NEXT: [1]   - JALU1
# CHECK-NEXT: [2]   - JDiv
# CHECK-NEXT: [3]   - JFPA
# CHECK-NEXT: [4]   - JFPM
# CHECK-NEXT: [5]   - JFPU0
# CHECK-NEXT: [6]   - JFPU1
# CHECK-NEXT: [7]   - JLAGU
# CHECK-NEXT: [8]   - JMul
# CHECK-NEXT: [9]   - JSAGU
# CHECK-NEXT: [10]  - JSTC
# CHECK-NEXT: [11]  - JVALU0
# CHECK-NEXT: [12]  - JVALU1
# CHECK-NEXT: [13]  - JVIMUL

# CHECK:      Resource pressure per iteration:
# CHECK-NEXT: [0]    [1]    [2]    [3]    [4]    [5]    [6]    [7]    [8]    [9]    [10]   [11]   [12]   [13]
# CHECK-NEXT: 0.50   0.50    -      -      -     1.00   1.00    -      -      -      -     1.00   1.00    -

# CHECK:      Resource pressure by instruction:
# CHECK-NEXT: [0]    [1]    [2]    [3]    [4]    [5]    [6]    [7]    [8]    [9]    [10]   [11]   [12]   [13]   Instructions:
# CHECK-NEXT: 0.50   0.50    -      -      -      -      -      -      -      -      -      -      -      -     addl	%eax, %eax
# CHECK-NEXT:  -      -      -      -      -      -     1.00    -      -      -      -      -     1.00    -     vpinsrb	$0, %eax, %xmm0, %xmm0
# CHECK-NEXT:  -      -      -      -      -     1.00    -      -      -      -      -     1.00    -      -     vpinsrb	$1, %eax, %xmm0, %xmm0

# CHECK:      Timeline view:
# CHECK-NEXT:                     0123456789          0123456789
# CHECK-NEXT: Index     0123456789          0123456789          012345

# CHECK:      [0,0]     DeER .    .    .    .    .    .    .    .    .   addl	%eax, %eax
# CHECK-NEXT: [0,1]     .DeeeeeeeER    .    .    .    .    .    .    .   vpinsrb	$0, %eax, %xmm0, %xmm0
# CHECK-NEXT: [0,2]     . D======eeeeeeeER  .    .    .    .    .    .   vpinsrb	$1, %eax, %xmm0, %xmm0
# CHECK-NEXT: [1,0]     .  DeE-----------R  .    .    .    .    .    .   addl	%eax, %eax
# CHECK-NEXT: [1,1]     .   D===========eeeeeeeER.    .    .    .    .   vpinsrb	$0, %eax, %xmm0, %xmm0
# CHECK-NEXT: [1,2]     .    D=================eeeeeeeER   .    .    .   vpinsrb	$1, %eax, %xmm0, %xmm0
# CHECK-NEXT: [2,0]     .    .DeE----------------------R   .    .    .   addl	%eax, %eax
# CHECK-NEXT: [2,1]     .    . D======================eeeeeeeER .    .   vpinsrb	$0, %eax, %xmm0, %xmm0
# CHECK-NEXT: [2,2]     .    .  D============================eeeeeeeER   vpinsrb	$1, %eax, %xmm0, %xmm0

# CHECK:      Average Wait times (based on the timeline view):
# CHECK-NEXT: [0]: Executions
# CHECK-NEXT: [1]: Average time spent waiting in a scheduler's queue
# CHECK-NEXT: [2]: Average time spent waiting in a scheduler's queue while ready
# CHECK-NEXT: [3]: Average time elapsed from WB until retire stage

# CHECK:            [0]    [1]    [2]    [3]
# CHECK-NEXT: 0.     3     1.0    1.0    11.0      addl	%eax, %eax
# CHECK-NEXT: 1.     3     12.0   0.0    0.0       vpinsrb	$0, %eax, %xmm0, %xmm0
# CHECK-NEXT: 2.     3     18.0   0.0    0.0       vpinsrb	$1, %eax, %xmm0, %xmm0
