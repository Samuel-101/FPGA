    use strict;
    use warnings;

    my $vhdl_file = "half_adder .vhdl";
    my $tb_file = "half_adder_testbench.vhdl";
    my $vcd_file = "dump.vcd";
    my $perl_file = "verification_script.pl";
    system("ghdl -s $vhdl_file");
    system("ghdl -a $vhdl_file $tb_file");
    system("ghdl -e half_adder_testbench");

    system("ghdl -r half_adder_testbench --vcd=$vcd_file --stop-time=100ns");

    system("gtkwave $vcd_file");

    system("perl $perl_file");
