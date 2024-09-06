LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

-- Declare the entity
ENTITY testbench IS
END testbench;

-- Define the architecture
ARCHITECTURE behavior OF testbench IS 

    -- Declare the component 'design'
    COMPONENT design
    PORT(
        clk : IN  std_logic;                          -- Clock input
        din1 : IN  std_logic;                         -- Data input
        dout : OUT  std_logic                         -- Data output
    );
    END COMPONENT;
    
    -- Signal declarations for clock, data input, and output
    signal clk : std_logic := '0';   
    signal din1 : std_logic := '0';  
    signal dout : std_logic; 

  
    constant clk_period : time := 10 ns;  

BEGIN

    -- Instantiate the 'design' component (Unit Under Test - UUT)
    uut: design PORT MAP (
        clk => clk,                                  -- Map clock signal
        din1 => din1,                                -- Map data input signal
        dout => dout                                 -- Map data output signal
    );

    -- Clock generation process
    clk_process :process
    begin
        clk <= '1';                                  -- Set clock high
        wait for 500 ms;                             -- Wait for half the period
        clk <= '0';                                  -- Set clock low
        wait for 500 ms;                             -- Wait for half the period again
    end process;

   
    process
    begin  
        -- Apply various input values to din1 with a wait of 1 second between changes
        wait for 1 sec;
        din1 <= '0';  
        wait for 1 sec;
        din1 <= '1';  
        wait for 1 sec;
        din1 <= '0';  
        wait for 1 sec;
        din1 <= '1';  
        wait for 1 sec;
        din1 <= '1';  
        wait for 1 sec;
        din1 <= '0';  
        wait for 1 sec;
        din1 <= '0';  
        wait for 1 sec;
        din1 <= '1'; 
        wait for 1 sec;
        din1 <= '0'; 
        wait for 1 sec;
        din1 <= '1';  
        wait for 1 sec;
        din1 <= '1';  
        wait for 1 sec;
        din1 <= '0';

        wait;  
    end process;

END;
