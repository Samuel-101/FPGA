library ieee;
use ieee.std_logic_1164.all;                                      -- Importing the IEEE library, specifically for standard logic (std_logic and std_ulogic types).

entity half_adder is                                              -- Declares the entity for the half adder circuit.

port(
    a: in std_ulogic;                                             -- Input signal 'a' of type std_ulogic (unresolved logic).
    b: in std_ulogic;                                             -- Input signal 'b' of type std_ulogic (unresolved logic).
    o: out std_ulogic;                                            -- Output signal 'o' for the sum of 'a' and 'b', also of type std_ulogic.
    c: out std_ulogic                                             -- Output signal 'c' for the carry of 'a' and 'b', of type std_ulogic.
    );

end half_adder;                                                  -- End of the entity declaration.

architecture behave of half_adder is                             -- The architecture "behave" defines the behavior of the half adder.
begin 
    o <= a xor b;                                                -- The sum output 'o' is assigned the result of XOR operation between 'a' and 'b'.
    c <= a and b;                                                -- The carry output 'c' is assigned the result of AND operation between 'a' and 'b'.

end behave;                                                      -- End of the architecture.
