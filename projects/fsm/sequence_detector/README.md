# IMPLEMENTATION OF SEQUENCE DETECTOR WITH INPUT VIA SERIAL COMMUNICATION (ARDUINO)

In this project, we take input serially from arduino. This input is given into a sequence detector FSM in our FPGA (which detects the sequence "1011" in this case).
We do not use the inbuilt FPGA clock,instead we generate a clock in the arduino which is given as input to the FPGA.

## STATE DIAGRAM

![image](https://github.com/user-attachments/assets/8f8d05d1-b4cd-472d-9b67-de41b38db5da)
