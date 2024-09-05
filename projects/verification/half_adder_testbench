library ieee;
    use ieee.std_logic_1164.all;

    entity half_adder_testbench is
    end half_adder_testbench;

    architecture test of half_adder_testbench is
        component half_adder
            port (
                a: in std_logic;
                b: in std_logic;
                o: out std_logic;
                c: out std_logic
            );
        end component;

        signal a, b, o, c: std_logic := '0'; 
    begin
        half_adder: half_adder port map(a => a, b => b, o => o, c => c);

        process
        begin
            a <= 'X';
            b <= 'X';
            wait for 1 ns;

            a <= '0';
            b <= '0';
            wait for 1 ns;

            a <= '0';
            b <= '1';
            wait for 1 ns;

            a <= '1';
            b <= '0';
            wait for 1 ns;

            a <= '1';
            b <= '1';
            wait for 1 ns;

            assert false report "reached the end of test";
            wait;
        end process;
    end test;
