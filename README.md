# Computer Simulation
Simulates the insertion and execution of instructions in a computer.  
The output (if any) is subsequently printed to the console.

## Minimum Requirements
- Ruby
- RSpec

## How to Run
From your console:

`ruby app/main.rb`

## Description
The computer includes 3 separate components:
- CPU
- Memory
- Instruction Table

The computer runs in three separate phases:  
1. Construction Phase
  - Computer is initialized
  - Memory is allocated to a certain size . 
  - Cpu's program counter is set to 0 as the starting point . 

2. Setup Phase
  - The program counter is set a certain address in memory
  - Insertion of various instructions and values into memory

3. Execution Phase (CPU)
  - Instruction table is referenced to decode what actions to perform
  - Performs various actions on the memory stack:
    - Stores values
    - Removes values
    - Multiplies values
    - Moves the program counter
    - Prints values as output
    - Stops the program
    
### CPU
CPU processes the data loaded into memory to produce actions.  
The CPU runs in three separate phases to form a cycle:  
1. Fetch Phase
  - Uses the program counter as a reference for the address of the data (instruction, value) on the stack
  - If the instruction is 'STOP' the cycle halts and the program is stopped

2. Decode Phase
  - An instruction table is included into the CPU.
  - The fetched instruction from memory is referenced to the instruction table which provides the actions.

3. Execute Phase
  - The action is taken from the instruction table and takes place in the CPU
  - Certain instructions (PUSH, PRINT, RET) require an incrementation to occur on the program counter
  - Some instructions (CALL, RET) do not require a program counter incrementation because their corresponding actions have already included them.
  - The process starts again with the Fetch Phase.

### Memory
Memory refers to the stack of instructions that the computer needs to run through.

### Instruction Table
Instruction Table is used as a reference for the actions to be taken depending on the command

## Tests
RSpec needs to be installed:

`gem install rspec`

RSpec can be run from the console:

`rspec`

## Errors
Custom Errors have been strategically placed in areas where there is a high potential for errors to occur.

In the CPU, the `ExecuteError` and `ProcessError` are called when a `StandardError` has been raised in the `#execute` and `#process` functions respectively.  
These two errors "prettify" the error message, providing useful debugging information at the point of error such as:
- Error type
- Location of occurence
- Original Message from `StandardError`
- Backtrace
- Snapshot of the variables after the error was raised

Another custom error, `InstructionError` is also raised in the case where an instruction is given to the computer during the insertion phase but is not recognized in the computer's instruction table.

## Todos
### Tests
**`spec/cpu_spec.rb` > `#execute`**
- need to figure out how to test this without causing an infinite loop  
`expect(cpu).to receive(:execute)` causes an infinite loop

### Comments
**`app/main.rb`**
- Some commented out code to test error messages needs to be removed after demonstration.
