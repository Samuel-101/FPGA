use strict;                                       # Enforce strict variable declaration rules.
use warnings;                                     # Enable warnings for potential issues in the code.

my $input_file = 'input.txt';                     # Define the input file name.

open my $input_fh, '<', $input_file or die "Cannot open input file: $!";
                                                  # Open the input file for reading. Die if it can't be opened.

my $expected_output_file = 'expected_output.txt'; # Define the expected output file name.

open my $eoutput_fh, '<', $expected_output_file or die "Cannot open expected output file: $!";
                                                  # Open the expected output file for reading. Die if it can't be opened.

my $output_file = 'output.txt';                   # Define the actual output file name.

open my $output_fh, '<', $output_file or die "Cannot open output file: $!";
                                                  # Open the output file for reading. Die if it can't be opened.

while (my $input_line = <$input_fh>, my $eoutput_line = <$eoutput_fh>, my $output_line = <$output_fh>) {
    # Read each line from the input file, expected output file, and actual output file simultaneously.

    print "Input: $input_line\n";                 # Print the current input line.

    my ($eout_a, $eout_b) = split /,/, $eoutput_line;
                                                  # Split the expected output line by commas into two variables, $eout_a and $eout_b.
    
    my ($out_a, $out_b) = split /,/, $output_line;
                                                  # Split the actual output line by commas into two variables, $out_a and $out_b.

    if ($eout_a == $out_a && $eout_b == $out_b) {
        # Compare expected output values to actual output values.

        print "Matching\n";                       # If both parts match, print "Matching".
    } else {
        print "Not Matching\n";                   # If either part doesn't match, print "Not Matching".
    }
}

close $input_fh;                                  # Close the input file handle.
close $eoutput_fh;                                # Close the expected output file handle.
close $output_fh;                                 # Close the output file handle.
