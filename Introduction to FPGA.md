 # FGPA

A field-programmable gate array (FPGA) is an integrated circuit 
designed to be configured by a customer or a designer after 
manufacturing – hence the term field-programmable.
An FPGA is based on a matrix of configurable logic blocks (CLBs) 
connected via programmable interconnects. CLBs constitute the 
basic FPGA cell and includes two 16-bit function generators, one 8-bit function generator, two 
registers (flip-flops or latches), and reprogrammable routing controls (multiplexers). CLBs are 
used to implement macros and other designed functions.
FPGAs are capable of parallel operations, so different processing operations do not compete for 
the same resources. Each independent task is assigned to a dedicated section of the chip and can 
function autonomously without influence from other logic blocks. Consequently, the performance 
of one part of the application is unaffected as more operations are added.
FPGAs are designed to be programmed using Hardware Description Language such as Verilog or 
VHDL. Because they are reprogrammable, FPGAs differ from ASIC ICs, which are designed to 
do specifically designed tasks.

## What are the types of FPGAs?

There are several types of FPGAs, including:
1. **SRAM-based FPGAs**: These FPGAs store their configuration in static random-access 
memory (SRAM). This type of FPGA is reprogrammable and can be configured at run time, 
but it requires external memory to store its configuration.

2. **Antifuse-based FPGAs**: These FPGAs use antifuses, which are one-time programmable 
elements that are programmed by applying a high voltage. Once an antifuse is programmed, it 
cannot be changed.

3. **Flash-based FPGAs**: These FPGAs store their configuration in flash memory, which is non-volatile and can be reprogrammed.

4. **EEPROM-based FPGAs**: These FPGAs store their configuration in electrically erasable 
programmable read-only memory (EEPROM), which is non-volatile and can be 
reprogrammed.

5. **Hybrid FPGAs**: These FPGAs combine different types of programmable elements, such as 
SRAM-based logic and flash-based memory, to provide a balance of performance, flexibility, 
and non-volatility.

## Input/Output (IO) Blocks

They are the components through which data transfers in to and out of the FPGA. Input and output on 
the chip goes through component groups called IO banks, which consist of 50 individual IO blocks. 
The IO blocks themselves are configurable in a number of ways depending on the type of data the 
user is either expecting to receive or transmit.

## Configurable Logic Block(CLBs)

Configurable logic blocks (CLBs) are the basic logic unit of an FPGA. A CLB gives the FPGA its 
ability to accept different hardware configurations. CLBs can be programmed to perform almost any 
logic function. The individual CLB contains a number of discrete logic components including look-up 
tables (LUTs) and flip-flops.

## Flip-Flops
![image](https://github.com/user-attachments/assets/8efa6daa-739e-4b5e-b7a6-68aff1ababc0)


A flip-flop is a circuit that has two stable states and can be used to store state information. Flip-flops 
are binary shift registers that synchronize logic and save logical states between clock cycles within an 
FPGA circuit. A flip-flop stores a single bit of data.
Flip-flops are binary shift registers used to synchronize logic and save logical states between 
clock cycles within an FPGA circuit. On every clock edge, a flip-flop latches the 1 or 0 (TRUE or 
FALSE) value on its input and holds that value constant until the next clock edge.
the clock is what allows a Flip-Flop to be used as a data storage element. Any data storage 
elements are known as sequential logic or registered logic. Sequential logic operates on 
the transitions of a clock. 99.9% of the time this will be the rising edge (when the clock goes 
from 0 to 1). When a Flip-Flop sees a rising edge of the clock, it registers the data from 
the Input D to the Output Q

## Lookup Tables(LUT)
![alt text](image-3.png)

A lookup table (LUT) determines what the output is for any given input(s). In the context of 
combinational logic, it is the truth table and defines how combinatorial logic behaves. A truth table 
is a predefined list of outputs for each combination of inputs. The LUT holds a custom truth table that 
is loaded when the chip is powered up.
The LUT is the basic building block of an FPGA and is capable of implementing any logic function of 
N Boolean variables. Essentially, this element is a truth table in which different combinations of the 
inputs implement different functions to yield output values. The limit on the size of the truth table is 
N, where N represents the number of inputs to the LUT. For the general N-input LUT, the number of 
memory locations accessed by the table is 2N
. This allows the table to implement 2N^N functions.
The hardware implementation of a LUT can be thought of as a collection of memory cells connected 
to a set of multiplexers. The inputs to the LUT act as selector bits on the multiplexer to select the 
result at a given point in time. It is important to keep this representation in mind, because a LUT can 
be used as both a function compute engine and a data storage element
So, we can conclude, that Lookup Tables basically serve to act like logic gates in various 
combinations. Instead of having to connect a number of different gates, you can simply use a Lookup 
Table to get all the possible combinations.

## The Issue of Glitch in Lookup Tables

A glitch is produced when there is an asynchronization between what the output is being shown as 
and what it should be due to the changing and rearranging of bits inside the SRAM of the Lookup 
table. As such, the block is uncertain of what the answer should be and produces a glitch which is 
basically an inaccurate output for a period of time. 

## Advantages and Disadvantages of Lookup Tables
**Advantages:**

• Ability to implement any Boolean function

• Simplicity and ease of use

• Ability to be easily reconfigured

• Generally faster than programmable logic elements (PLEs)

**Disadvantages:**

• May require a large number of input variables and corresponding output values for certain 
functions, leading to impractical sizes

• May consume more resources within the FPGA compared to other implementation methods

• May have limited flexibility in terms of logical operations that can be performed compared to 
PLEs and other implementation methods

## MUXIPLIERS
![alt text](image-4.png)

The inputs to the mux are a,b,c,d,e,f, sel, the output is out. a,b,c,d,e,f, are the Data inputs 
that get selected to the output. sel is the control signal. Muxes comes in all possible 
combinations.Typically, some number of inputs are selected to a single output. However the 
reverse could be true and it would still be a mux
multiplexer selects a single input out of set based on the value of its select input. Here is its symbol:
The number of inputs will vary but the multiplexer always just has one output.
The way the select input is encoded will also vary. Usually, you will see it as a binary number, but the 
simpler circuit uses a **one-hot encoding**. A one-hot encoding is simply a binary value where there is always 
exactly one 1. The position of the 1 is the important thing.
A decoder takes a binary value and turns it into a one-hot signal. An encoder turns a one-hot value into a 
binary number. These can be used to make a one-hot multiplexer accept binary values.

## DSP Slices
![alt text](image-5.png)

A DSP slice, or sometimes referred to as a block or cell, is one of the specialized components in an 
FPGA. It carries out digital signal processing functions, like filtering or multiplying, more efficiently 
than using many CLBs. This multiplier circuitry saves on LUT and flip-flop usage in math and signal 
processing applications.
DSP’s accelerate typical signal processing tasks suck as fast fourier tranforms(FFTs) and finite 
impulse response filtering(FIR).DPS blocks also include multipliers which an be implemented 
directly into LUT’s,but it takes significant recources. Hence FPGA’s dedicate space to DPS blocks.
Two ways of incorporating DSP’s into FPGA designs:

• Explicitly instantiate the DSP primitive

• Infer the DSP using rgular multiplication in Verilog or VDHL

## Block RAM
The memory available on an FPGA chip is referred to as block RAM or BRAM. These blocks can be 
subdivided or cascaded to make smaller or larger sizes of BRAM available. Digital signal processing 
algorithms frequently need to keep track of an entire block of data and without onboard memory. 
Many processing functions do not fit within the configurable logic of an FPGA chip.it’s used to store 
“large” amounts of data inside of your FPGA. It’s also possible to store data outside of your FPGA, 
but that would be done with a device like an SRAM, DRAM, EPROM, SD Card, etc.

**Single Port BRAM Configuration**

![alt text](image-6.png)

The Single Port Block RAM configuration is useful when there is just one interface that needs to 
retrieve data. This is also the simplest configuration and is useful for some applications. One example 
would be storing Read-Only Data that is written to a fixed value when the FPGA is programmed. 
That’s one thing about Block RAM, is that they can all be initialized
The way they work is all based on a Clock. Data will be read out on the positive edge of the clock 
cycle at the address specified by Addr as long as Wr En signal is not active. Read values come out 
on Rd Data, this is the data stored in the BRAM. Note that you can only read one Rd Data value per 
clock cycle. So if your Block RAM is 1024 values deep, it will take at least 1024 clock cycles to read 
the entire thing out.
There might be an application where you want to write some data into the Block RAM buffer, then 
read it out at a later time. This would involve driving Wr En high for one clock cycle and Wr 
Data would have your write data. For the single port configuration, you can either read or write data 
on Port A, you can’t do both at the same time. If you want to read and write data at the same time, you 
will need a Dual Port Block RAM!

**Dual Port BRAM Configuration**

![alt text](image-7.png)

The Dual Port Block RAM (or DPRAM) configuration behaves exactly the same way as the single 
port configuration, except you have another port available for reading and writing data. Both Port A 
and Port B behave exactly the same. Port A can perform a read on Address 0 on the same clock cycle 
that Port B is writing to address 200. Therefore a DPRAM is able to perform a write on one address 
while reading from a completely different address. I personally find that I have more use cases for 
DPRAMs than I do for Single-Port RAMs.
One possible use case would be storing data off of an external device. For example you want to read 
data off an SD Card, you could store it in a Dual Port RAM, then read it out later. Or maybe you want 
to interface to an Analog to Digital Converter (ADC) and will need some place to store the converted 
ADC values. A DPRAM would be great for this. Additionally, Dual Port RAMs are commonly turned 
into FIFOs, which are probably one of the most common use-cases for Block RAM on an FPGA.

## Why are FPGAs needed?
FPGAs are needed for several reasons:
1. **Customization:** FPGAs can be programmed and reprogrammed to perform specific tasks or 
functions. This flexibility allows designers to customize the FPGA to meet the specific 
requirements of the application. This is especially useful for applications that require high performance computing or signal processing, where custom logic circuits can be implemented 
to achieve optimal performance.
2. **Speed:** FPGAs are capable of processing data in parallel, which allows them to perform 
operations much faster than traditional processors. This makes them well-suited for 
applications that require high-speed data processing, such as real-time signal processing, 
video processing, and encryption/decryption.
3. **Power Efficiency:** FPGAs can be designed to consume less power than traditional 
processors, while still providing high-performance computing. This is especially useful for 
applications that require long battery life or operate in environments with limited power.
4. **Prototyping:** FPGAs can be used as a prototyping tool to test and validate new designs or 
algorithms before implementing them in hardware. This can help reduce development time 
and costs, as well as improve the quality of the final product.
5. **Reusability:** As mentioned earlier, FPGAs can be reprogrammed and reused for multiple 
applications or designs. This provides a cost-effective solution for companies that need to 
develop multiple products with similar functionality.
6. **Offloading:** FPGAs can be used to offload computationally intensive tasks from 
a CPU or GPU, reducing congestion and latency; they can also be used to accelerate 
AI/ML/DL workloads, performing specific operations like matrix multiplication that enhance 
the overall performance of a system.

## What Are the Advantages of FPGA?
There are many benefits of FPGAs for embedded system design. Some advantages of FPGA are 
the reconfigurability, the ability to work in parallel, time-critical processing, and optimal 
performance, making them well-suited for numerous applications.

**Performance**

The parallel nature of FPGAs allows them to offer higher processing power, speeds, better 
response times, and overall improved performance when compared to other modern 
microprocessors.

**Reprogrammable hardware structure**

Because FPGAs are reprogrammable, functionality can be redefined even after manufacturing. 
Users can program new product features and functions, adapt to new standards, and reconfigure 
hardware applications after the product has been installed in the field. This flexibility gives 
FPGA-based designs advantages over microcontroller-based systems. A user can make a mistake 
in programming, then later modify or change the FPGA with a new configuration file and without 
having to create prototypes or additional hardware, saving time and reducing cost.

**Quicker time to market**

FPGAs are readily available and allow users to quickly develop systems based upon this 
technology. ASICs require manufacturing cycles taking several months. FPGA users can ship 
systems as soon as a product design is working and tested.

**Lower overall costs**

Compared to the costs of manufacturing an ASIC, FPGAs are relatively inexpensive. The design 
cycle for an ASIC is long and production tooling is costly. Plus, any changes in the design will 
require a new chip, versus an FPGA which can be simply updated with a new program.

**Low maintenance**

Unlike ASICs, FPGAs are reprogrammable and can be upgraded or enhanced in the field without 
the time and resource investment that would be required to reconfigure circuit boards and 
hardware. Engineering costs are also considerably lower to that of ASICs. System requirements 
can change over time and the cost of making incremental changes to an FPGA is small when 
compared to the large expense of retooling for an ASIC.

## FPGA Applications
Due to their programmable nature, FPGAs are an ideal fit for many different markets such as:

• **Aerospace & Defense** - Radiation-tolerant FPGAs along with intellectual property for image 
processing, waveform generation, and partial reconfiguration for SDRs.

• **ASIC Prototyping** - ASIC prototyping with FPGAs enables fast and accurate SoC system 
modeling and verification of embedded software

• **Automotive** - Automotive silicon and IP solutions for gateway and driver assistance systems, 
comfort, convenience, and in-vehicle infotainment.

• **Broadcast & Pro AV** - Adapt to changing requirements faster and lengthen product life cycles 
with Broadcast Targeted Design Platforms and solutions for high-end professional broadcast 
systems.

• **Consumer Electronics** - Cost-effective solutions enabling next generation, full-featured 
consumer applications, such as converged handsets, digital flat panel displays, information 
appliances, home networking, and residential set top boxes.

• **Data Center** - Designed for high-bandwidth, low-latency servers, networking, and storage 
applications to bring higher value into cloud deployments.

• **High Performance Computing and Data Storage** - Solutions for Network Attached Storage 
(NAS), Storage Area Network (SAN), servers, and storage appliances.

• **Industrial** - FPGAs and targeted design platforms for Industrial, Scientific and Medical (ISM) 
enable higher degrees of flexibility, faster time-to-market, and lower overall non-recurring 
engineering costs (NRE) for a wide range of applications such as industrial imaging and 
surveillance, industrial automation, and medical imaging equipment.

• **Medical** - For diagnostic, monitoring, and therapy applications, the Virtex FPGA and 
Spartan™ FPGA families can be used to meet a range of processing, display, and I/O 
interface requirements.

• **Security** - FPGAs offers solutions that meet the evolving needs of security applications, from 
access control to surveillance and safety systems.

• **Video & Image Processing** - FPGAs and targeted design platforms enable higher degrees of 
flexibility, faster time-to-market, and lower overall non-recurring engineering costs (NRE) for 
a wide range of video and imaging applications.

• **Wired Communications** - End-to-end solutions for the Reprogrammable Networking Linecard 
Packet Processing, Framer/MAC, serial backplanes, and more

• **Wireless Communications** - RF, base band, connectivity, transport and networking solutions 
for wireless equipment, addressing standards such as WCDMA, HSDPA, WiMAX and others.
