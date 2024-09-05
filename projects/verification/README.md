## INTRODUCTION

* This project showcases a comprehensive verification flow for a Half Adder circuit, starting with its RTL design
   in VHDL and progressing through simulation, waveform analysis, and automated result comparison. 

* The half-adder’s behavior is modeled using VHDL, while a dedicated testbench applies various input combinations to validate the circuit's outputs.
  The simulation is conducted using GHDL, and the resulting waveforms are captured in a VCD file for detailed analysis using GTKWave. 

* Additionally, a batch script extracts key output signals, and a Perl script compares the actual outputs against the expected results,
  ensuring precise functionality. 

* This fully automated flow integrates design, simulation, and verification,
  providing a robust framework for hardware validation and debugging.

## DESIGN FLOW 

**VHDL RTL Code:**

    half_adder.vhd

The first step involves designing the half-adder using VHDL. The RTL code defines how the half-adder computes the sum and carry outputs from two input bits using simple logic gates (XOR for sum, AND for carry).

**Testbench:**

    half_adder_testbench.vhd

A VHDL testbench is created to apply a set of input combinations ('00', '01', '10', '11') to the half-adder and observe the corresponding outputs. This testbench also captures any unexpected behavior by using assert statements to indicate when the test completes.

**Perl Script:**

    perl_script.pl

Finally, an automation script compiles and simulates the VHDL files using GHDL, launches the simulation in GTKWave (a waveform viewer), and runs the Perl script to verify that the half-adder behaves correctly.

**Simulation:**

    dump.vcd
    
This file is obtained when we run the perl script, ie while the design and testbench code is compiled.

The testbench is simulated using GHDL, a VHDL simulator. The simulation runs the half-adder for different input combinations, and the waveforms are recorded in a VCD (Value Change Dump) file.

**Batch File:**
    
    batch.bat

A batch script extracts the sum (o) and carry (c) output signals from the VCD file and saves them into a text file. This allows for easy extraction of the results from the simulation.

**Verification Script:**

    verification_script.pl
    
A Perl script is used to compare the simulation results (outputs) with the expected values. It reads the actual outputs from the VCD file and compares them to a predefined set of expected outputs, ensuring the half-adder works as intended. If the values match, it reports "Matching"; otherwise, it reports "Not Matching."


**RTL simulation from Quartus**

![image](https://github.com/user-attachments/assets/026743ba-cc52-4503-a41a-30422801e83c)

