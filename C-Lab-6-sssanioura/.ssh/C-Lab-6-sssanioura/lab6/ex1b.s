#     int array1[] = {1, 2, 3, 4, 5};
#     int array2[] = {6, 7, 8, 9, 10};
#     int result[5];
#     for (int i = 0; i < 5; i++) {
#         result[i] = array1[i] + array2[i];
#     }


# Before you start make sure you understand the difference between la, li, and lw
# la loads the address of a label into a register. reg = pointer(variable_name)
# li loads an immediate value into a register reg = value
# lw loads the value at an address into a register reg = *pointer


.data
array1: .word 1, 2, 3, 4, 5
array2: .word 6, 7, 8, 9, 10
result: .space 20  # Allocate space for 5 integers


.text
.globl _start
_start:
la s0, array1      # Load address of array1 into s0
la s1, array2      # Load address of array2 into s1
la s2, result      # Load address of result array into s2

li s3, 5           # Load the length of the arrays into s3
li s4, 0           # Initialize index to 0

loop:
beq s4, s3, end    # If index equals length, exit loop

lw s5, 0(s0)       # Load word from array1 into s5
lw s6, 0(s1)       # Load word from array2 into s6
add s7, s5, s6     # Add the two words
sw s7, 0(s2)       # Store the result in the result array

# UNCOMMENT TO PRINT THE ARRAY VALUES
li a0, 1           # Load the syscall number for print_int
mv a1, s5          # Load the value to print
ecall              # Print the value

# TODO: PRINT OUT THE VALUES of the array2

addi s0, s0, 4     # Move to the next element in array1
addi s1, s1, 4     # Move to the next element in array2
addi s2, s2, 4     # Move to the next element in result array
addi s4, s4, 1     # Increment index
j loop             # Jump back to the start of the loop

end:
# Exit the program (assuming an environment that supports ecall for exit)
li a0, 10          # ecall for exit
ecall