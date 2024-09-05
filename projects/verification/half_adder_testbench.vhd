library ieee;
use ieee.std_logic_1164.all;
-- Importing the IEEE library, specifically the package for standard logic.

entity half_adder_testbench is
end half_adder_testbench;
-- Declares the entity for the testbench. Since this is a testbench, 
-- there are no ports (inputs/outputs) defined here.

architecture test of half_adder_testbench is
    -- Start of the architecture definition for the testbench.

    component half_adder
        -- Declares a component to instantiate the half adder inside the testbench.
        port (
            a: in std_logic;
            -- Input signal 'a' for the half adder.
            b: in std_logic;
            -- Input signal 'b' for the half adder.
            o: out std_logic;
            -- Output signal 'o' (sum) for the half adder.
            c: out std_logic
            -- Output signal 'c' (carry) for the half adder.
        );
    end component;
    -- End of the component declaration.

    signal a, b, o, c: std_logic := '0'; 
    -- Signals to simulate the input and output connections for the half adder.
    -- 'a' and 'b' are inputs, 'o' (sum) and 'c' (carry) are outputs. 
    -- They are initialized to '0'.

begin
    uut: half_adder port map(a => a, b => b, o => o, c => c);
    -- Instantiates the half adder and maps the signals to the component's ports.
    -- 'a' and 'b' are inputs, 'o' and 'c' are the outputs.

    process
        -- Defines a process block where the test inputs are applied.
    begin
        a <= 'X';
        b <= 'X';
        wait for 1 ns;
        -- Sets 'a' and 'b' to unknown ('X') to test invalid states, waits for 1 ns.

        a <= '0';
        b <= '0';
        wait for 1 ns;
        -- Test case: 'a' = 0, 'b' = 0 (expects output sum = 0, carry = 0).
        
        a <= '0';
        b <= '1';
        wait for 1 ns;
        -- Test case: 'a' = 0, 'b' = 1 (expects output sum = 1, carry = 0).
        
        a <= '1';
        b <= '0';
        wait for 1 ns;
        -- Test case: 'a' = 1, 'b' = 0 (expects output sum = 1, carry = 0).
        
        a <= '1';
        b <= '1';
        wait for 1 ns;
        -- Test case: 'a' = 1, 'b' = 1 (expects output sum = 0, carry = 1).

        assert false report "reached the end of test";
        -- Assertion to mark the end of the test. It reports when the process has finished.
        
        wait;
        -- Wait indefinitely to end the process, as there are no more test cases.
    end process;
    -- End of the process block.
end test;
-- End of the architecture definition.
