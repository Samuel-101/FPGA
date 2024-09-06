This project is a two bit password system.The two inputs is taken via two switches of the DE 10 Lite board.When the inputs are given in the order 00 01 11 10, the given led turns on.


## State Diagram

The state diagram can be obtained from the *netlist viewer* in Quartus,after *Analysis and Sysnthesis*,

<img src="https://github.com/user-attachments/assets/468080c5-4399-42a6-8832-a288e87a0d38" width="690"/>

***********
<img src="https://github.com/user-attachments/assets/1c39cc25-5011-43a2-9719-9272628ab329" width="900"/>


    strst: The initial/reset state, where the system waits for both din1 and din2 to be 0 to move to st1.
    
    st1: Transitions to st2 when din1 is 0 and din2 is 1.
    
    st2: Transitions to st3 when both din1 and din2 are 1.
    
    st3: Moves to st4 when din1 is 1 and din2 is 0.
    
    st4: Output dout is set to 1 and the state either stays in st4 or resets to strst based on the inputs.
