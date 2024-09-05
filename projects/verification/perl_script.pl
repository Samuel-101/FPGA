    use strict;
    use warnings;

    my $input_file = 'input.txt';

    open my $input_fh, '<', $input_file or die "Cannot open input file: $!";

    my $expected_output_file = 'expected_output.txt';

    open my $eoutput_fh, '<', $expected_output_file or die "Cannot open expected output file: $!";

    my $output_file = 'output.txt';

    open my $output_fh, '<', $output_file or die "Cannot open expected output file: $!";

    while (my $input_line = <$input_fh>, my $eoutput_line = <$eoutput_fh>, my $output_line = <$output_fh>) {
        print "Input: $input_line\n";
        
        my ($eout_a, $eout_b) = split /,/, $eoutput_line;
        my ($out_a, $out_b) = split /,/, $output_line;
        
        if ($eout_a == $out_a && $eout_b == $out_b) {
            print "Matching\n";
        } else {
            print "Not Matching\n";
        }
    }

    close $input_fh;
    close $eoutput_fh;
    close $output_fh;
