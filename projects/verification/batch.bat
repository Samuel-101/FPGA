    @echo off

    set "vcd_file=dump.vcd"
    set "output_file=output.txt"

    rem Extract values of 'o' and 'c' and save to the text file
    findstr /c:"o: " /c:"c: " "%vcd_file%" > "%output_file%"

    echo "Values extracted and saved to %output_file%"
