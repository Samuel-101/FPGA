library IEEE;                                         -- This line tells the compiler where to find standard functions and definitions.
use IEEE.STD_LOGIC_1164.ALL;                          -- This line includes standard logic types and operations.

entity fsmlock is 
Port (
     clk  : in  STD_LOGIC; -- Input port for clock signal.
    din1 : in  STD_LOGIC; -- Input port for din1 signal.
    din2 : in  STD_LOGIC; -- Input port for din2 signal.
    rst  : in  STD_LOGIC; -- Input port for reset signal.
    dout : out STD_LOGIC  -- Output port for dout signal.
);
end fsmlock;

architecture Behavioral of fsmlock is 
type state is (strst, st1, st2, st3, st4);             -- This defines a custom type 'state' with possible values.

signal present_state, next_state : state;              -- These signals hold the current and next state values.

begin

synchronous_process: process (clk, rst)                -- This is a process sensitive to clk and rst signals.
begin
    if rising_edge(clk) then            
        if (rst = '1') then 
            present_state <= strst;                    -- Set present_state to starting state.
        else		 
            present_state <= next_state;               -- Update present_state with next_state.
        end if;                
    end if;
end process;


output_decoder : process(present_state, din1, din2)   -- This process updates next_state based on present_state and inputs.
begin
    case (present_state) is  
        when strst => 
            if (din1 = '0'and din2= '0') then -- If both inputs are low...
                next_state <= st1; -- Move to state 1.
            else
                next_state <= strst; -- Stay in starting state.
            end if;
        when st1 => -- If in state 1...
            if (din1 = '0'and din2= '1') then 
                next_state <= st2;
            else
                next_state <= st1; 
            end if;
        when st2 => -- If in state 2...
            if (din1 = '1'and din2= '1') then 
                next_state <= st3; 
            else
                next_state <= st2; 
            end if;
        when st3 =>
            if (din1 = '1'and din2= '0') then 
                next_state <= st4;
            else
                next_state <= st3;
            end if; 
        when st4 => 
              if (din1 = '1'and din2= '0') then 
                next_state <= st4; 
            else
                next_state <= strst; 
            end if;
        when others => 
            next_state <= strst; 
    end case;
end process; 


next_state_decoder : process(present_state) 
begin
    case present_state is  -- Based on the current state...
        when strst => -- If in starting state...
            dout <= '0'; -- Output low.
        when st1 => -- If in state 1...
            dout <= '0'; -- Output low.
        when st2 => -- If in state 2...
            dout <= '0'; -- Output low.
        when st3 => -- If in state 3...
            dout <= '0'; -- Output low.
        when st4 => -- If in state 4...
            dout <= '1'; -- Output high.
        when others => -- For any other state...
            dout <= '0'; -- Output low.
    end case;
end process;

end Behavioral;
