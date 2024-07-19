_start:
    # Set up exception handler
    la t0, exception_handler
    csrw mtvec, t0

    # Initialize PCBs
    la t0, fibonacci
    li t1, 0x0
    sw t0, 0(t1)        # Initial PC for Fibonacci
    li t0, 0x88         # Initial mstatus for Fibonacci
    sw t0, 4(t1)

    la t0, factorial
    li t1, 0x160
    sw t0, 0(t1)        # Initial PC for Factorial
    li t0, 0x88         # Initial mstatus for Factorial
    sw t0, 4(t1)

    # Set up initial timer interrupt
    li t0, 300
    la t1, mtimecmp
    sw t0, 0(t1)
    sw x0, 4(t1)        # Clear upper half

    # Enable interrupts
    csrsi mstatus, 0x8  # Set MIE in mstatus
    li t0, 0x80         # Enable timer interrupt in mie
    csrw mie, t0

    # Start the first process (Fibonacci)
    li t0, 0x0
    lw t1, 0(t0)        # Load initial PC for Fibonacci
    csrw mepc, t1
    lw t1, 4(t0)        # Load initial mstatus for Fibonacci
    csrw mstatus, t1
    mret
    
exception_handler:
    # Check the cause of the exception
    csrr t0, mcause
    li t1, 0x80000007   # Timer interrupt cause
    bne t0, t1, handle_other_exceptions

    # Save the current process state
    csrr t0, mepc
    csrr t1, mstatus
    li t2, 0x0       # Address for Fibonacci PCB
    lw t3, 0(t2)        # Load PC for Fibonacci
    beq t0, t3, save_fibonacci_state

save_fibonacci_state:
    # Save mepc, mstatus, and all general-purpose registers for Fibonacci
    li t2, 0x0
    sw t0, 0(t2)        # Save mepc
    sw t1, 4(t2)        # Save mstatus
    addi t2, t2, 8
    sw x1, 0(t2)
    sw x2, 4(t2)
    sw x3, 8(t2)
    sw x4, 12(t2)
    sw x5, 16(t2)
    sw x6, 20(t2)
    sw x7, 24(t2)
    sw x8, 28(t2)
    sw x9, 32(t2)
    sw x10, 36(t2)
    sw x11, 40(t2)
    sw x12, 44(t2)
    sw x13, 48(t2)
    sw x14, 52(t2)
    sw x15, 56(t2)
    sw x16, 60(t2)
    sw x17, 64(t2)
    sw x18, 68(t2)
    sw x19, 72(t2)
    sw x20, 76(t2)
    sw x21, 80(t2)
    sw x22, 84(t2)
    sw x23, 88(t2)
    sw x24, 92(t2)
    sw x25, 96(t2)
    sw x26, 100(t2)
    sw x27, 104(t2)
    sw x28, 108(t2)
    sw x29, 112(t2)
    sw x30, 116(t2)
    sw x31, 120(t2)
    j load_factorial_state

save_factorial_state:
    # Save the state of the Factorial process
    li t2, 0x160       # Correct address for Factorial PCB
    sw t0, 0(t2)        # Save mepc
    sw t1, 4(t2)        # Save mstatus
    addi t2, t2, 8
    # Save all general-purpose registers
    sw x1, 0(t2)
    sw x2, 4(t2)
    sw x3, 8(t2)
    sw x4, 12(t2)
    sw x5, 16(t2)
    sw x6, 20(t2)
    sw x7, 24(t2)
    sw x8, 28(t2)
    sw x9, 32(t2)
    sw x10, 36(t2)
    sw x11, 40(t2)
    sw x12, 44(t2)
    sw x13, 48(t2)
    sw x14, 52(t2)
    sw x15, 56(t2)
    sw x16, 60(t2)
    sw x17, 64(t2)
    sw x18, 68(t2)
    sw x19, 72(t2)
    sw x20, 76(t2)
    sw x21, 80(t2)
    sw x22, 84(t2)
    sw x23, 88(t2)
    sw x24, 92(t2)
    sw x25, 96(t2)
    sw x26, 100(t2)
    sw x27, 104(t2)
    sw x28, 108(t2)
    sw x29, 112(t2)
    sw x30, 116(t2)
    sw x31, 120(t2)
    j load_fibonacci_state

load_factorial_state:
    # Load state for Factorial process
    li t2, 0x160       # Correct address for Factorial PCB
    lw t0, 0(t2)        # Load mepc
    lw t1, 4(t2)        # Load mstatus
    addi t2, t2, 8
    lw x1, 0(t2)
    lw x2, 4(t2)
    lw x3, 8(t2)
    lw x4, 12(t2)
    lw x5, 16(t2)
    lw x6, 20(t2)
    lw x7, 24(t2)
    lw x8, 28(t2)
    lw x9, 32(t2)
    lw x10, 36(t2)
    lw x11, 40(t2)
    lw x12, 44(t2)
    lw x13, 48(t2)
    lw x14, 52(t2)
    lw x15, 56(t2)
    lw x16, 60(t2)
    lw x17, 64(t2)
    lw x18, 68(t2)
    lw x19, 72(t2)
    lw x20, 76(t2)
    lw x21, 80(t2)
    lw x22, 84(t2)
    lw x23, 88(t2)
    lw x24, 92(t2)
    lw x25, 96(t2)
    lw x26, 100(t2)
    lw x27, 104(t2)
    lw x28, 108(t2)
    lw x29, 112(t2)
    lw x30, 116(t2)
    lw x31, 120(t2)
    li t0 0x160
    lw t1, 0(t0)
    csrw mepc, t1
    lw t1, 4(t0) 
    csrw mstatus, t1


    mret

load_fibonacci_state:
    # Load state for Fibonacci process
    li t2, 0x0
    lw t0, 0(t2)        # Load mepc
    lw t1, 4(t2)        # Load mstatus
    addi t2, t2, 8
    lw x1, 0(t2)
    lw x2, 4(t2)
    lw x3, 8(t2)
    lw x4, 12(t2)
    lw x5, 16(t2)
    lw x6, 20(t2)
    lw x7, 24(t2)
    lw x8, 28(t2)
    lw x9, 32(t2)
    lw x10, 36(t2)
    lw x11, 40(t2)
    lw x12, 44(t2)
    lw x13, 48(t2)
    lw x14, 52(t2)
    lw x15, 56(t2)
    lw x16, 60(t2)
    lw x17, 64(t2)
    lw x18, 68(t2)
    lw x19, 72(t2)
    lw x20, 76(t2)
    lw x21, 80(t2)
    lw x22, 84(t2)
    lw x23, 88(t2)
    lw x24, 92(t2)
    lw x25, 96(t2)
    lw x26, 100(t2)
    lw x27, 104(t2)
    lw x28, 108(t2)
    lw x29, 112(t2)
    lw x30, 116(t2)
    lw x31, 120(t2)
    la t0, fibonacci
    li t1, 0x0
    sw t0, 0(t1)        # Initial PC for Fibonacci
    li t0, 0x88         # Initial mstatus for Fibonacci
    sw t0, 4(t1)

    # Reset the timer interrupt
    li t3, 300
    la t4, mtimecmp
    sw t3, 0(t4)
    sw x0, 4(t4)        # Clear upper half
   
    mret

handle_other_exceptions:
    # Handle other exceptions here if needed
    mret
