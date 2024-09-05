    use strict;
    use warnings;

    my $vhdl_file = "ha .vhdl";
    my $tb_file = "ha_tb.vhdl";
    my $vcd_file = "dump5.vcd";
    my $perl_file = "perl_script.pl";
    system("ghdl -a $vhdl_file $tb_file");
    system("ghdl -e ha_tb");

    system("ghdl -r ha_tb --vcd=$vcd_file --stop-time=100ns");

    system("gtkwave $vcd_file");

    system("perl $perl_file");
