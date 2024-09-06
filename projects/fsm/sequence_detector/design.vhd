library IEEE;  
use IEEE.STD_LOGIC_1164.ALL;  
-- Sequence :10111
entity design is 
    Port (
        clk  : in  STD_LOGIC;  -- Input clock signal
        din1 : in  STD_LOGIC;  -- Input data signal
        dout : out STD_LOGIC;  -- Output data signal
        a0 : out STD_LOGIC;    -- Additional output signals
        a2 : out STD_LOGIC;
        a3 : out STD_LOGIC;
        a4 : out STD_LOGIC;
        a5 : out STD_LOGIC;
        a6 : out STD_LOGIC;
        a7 : out STD_LOGIC;
        a8 : out STD_LOGIC;
        a9 : out STD_LOGIC
    );
end design;

architecture Behavioral of design is
    -- Declare state type with 5 possible states
    type state is (strst, st1, st2, st3, st4);  
    signal present_state, next_state : state;  -- Signals for current and next state
begin

    
    synchronous_process: process (clk)
    begin
        if rising_edge(clk) then
            present_state <= next_state;  -- Update present state to next state at clock edge
        end if;
    end process;

    
    output_decoder : process(present_state, din1)
    begin
        case (present_state) is 
            when strst =>  -- Initial state
                -- Reset all output signals to '0' in the initial state
                a0 <= '0'; a2 <= '0'; a3 <= '0'; a4 <= '0'; a5 <= '0';
                a6 <= '0'; a7 <= '0'; a8 <= '0'; a9 <= '0';
                -- Transition to state 1 if din1 is '1'
                if (din1 = '1') then
                    next_state <= st1;  -- Move to state 1
                else
                    next_state <= strst;  -- Remain in reset state
                end if;
            when st1 =>  
                -- Transition to state 2 if din1 is '0', otherwise stay in state 1
                if (din1 = '0') then
                    next_state <= st2;  
                else
                    next_state <= st1;  
                end if;
            when st2 =>  
                -- Transition to state 3 if din1 is '1', otherwise go back to reset
                if (din1 = '1') then
                    next_state <= st3;  
                else
                    next_state <= strst;  
                end if;
            when st3 =>  
                -- Transition to state 4 if din1 is '1', otherwise go back to state 2
                if (din1 = '1') then
                    next_state <= st4;  
                else
                    next_state <= st2;  
                end if;
            when st4 =>  
                -- If din1 is '1', loop back to state 1; if not, return to state 2
                if (din1 = '1') then
                    next_state <= st1;  
                else
                    next_state <= st2;  
                end if;
            when others =>
                next_state <= strst;  -- Default case to return to the reset state
        end case;
    end process; 

    
    next_state_decoder : process(present_state)
    begin
        case present_state is 
            when strst =>
                dout <= '0';  -- Output '0' in reset state
            when st1 =>
                dout <= '0';  -- Output remains '0' in state 1
            when st2 =>
                dout <= '0';  -- Output remains '0' in state 2
            when st3 =>
                dout <= '0';  -- Output remains '0' in state 3
            when st4 =>
                dout <= '1';  -- Output becomes '1' in state 4
            when others =>
                dout <= '0';  -- Default output is '0'
        end case;
    end process;

end Behavioral;
