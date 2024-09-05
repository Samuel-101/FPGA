    use strict;
    use warnings;

    my $vhdl_file = "half_adder.vhdl";
    my $tb_file = "half_adder_testbench.vhdl";
    my $vcd_file = "dump.vcd";
    my $perl_file = "verification_script.pl";
   system("ghdl -s $vhdl_file");               # Check the syntax of the VHDL source file.
system("ghdl -a $vhdl_file $tb_file");         # Analyze and compile the VHDL design and testbench files.
system("ghdl -e half_adder_testbench");        # Elaborate the half adder testbench, preparing it for simulation.

system("ghdl -r half_adder_testbench --vcd=$vcd_file --stop-time=100ns"); 
                                               # Run the testbench, generate the VCD file, and stop after 100 ns.

system("gtkwave $vcd_file");                   # Open the waveform file in GTKWave for analysis.

system("perl $perl_file");                     # Execute a separate Perl script for verification (optional/automated testing).
