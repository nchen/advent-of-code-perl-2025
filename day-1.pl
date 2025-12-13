use strict;
use warnings;
use autodie;

open(my $file, "./inputs/day1.txt");
my @lines = <$file>;
close($file);

print "Read ", scalar(@lines), " lines from the file.\n";

sub part_1() {
    my $pos = 50;
    my $zeros = 0;

    foreach my $line (@lines) {
        chomp($line);
        
        my $dir = substr($line, 0, 1);
        my $steps = int(substr($line, 1));

        # or:
        # my ($dir, $steps) = $line =~ /^\s*([RL])\s*(\d+)\s*$/;

        $steps = int($steps);

        if ($dir eq "R") {
            $pos += $steps;
        } else { # L
            $pos -= $steps;
        }

        # normalize to 0..99, because Perl's % operator can yield negative results
        $pos = ($pos % 100 + 100) % 100;

        $zeros++ if $pos == 0;
    }

    print "Zeros encountered: $zeros\n";
}

sub part_2() {
    my $pos = 50;
    my $zeros = 0;

    foreach my $line (@lines) {
        chomp($line);
        
        my $dir = substr($line, 0, 1);
        my $steps = int(substr($line, 1));
        $steps = int($steps);

        my $passes = 0;
        my $steps_to_zero = 0;
        
        if ($dir eq "R") {
            if ($pos == 0) {
                $steps_to_zero = 100;
            } else {
                $steps_to_zero = 100 - $pos;
            }
        } else { # L
            if ($pos == 0) {
                $steps_to_zero = 100;
            } else {
                $steps_to_zero = $pos;
            }
        }

        if ($steps >= $steps_to_zero) {
            $passes = int(($steps - $steps_to_zero) / 100) + 1;
        }
        
        $zeros += $passes;

        if ($dir eq "R") {
            $pos = ($pos + $steps) % 100;
        } else { # L
            $pos = ($pos - $steps) % 100;
        }

        # normalize to 0..99, because Perl's % operator can yield negative results
        $pos = ($pos % 100 + 100) % 100;
    }
    print "Zeros encountered: $zeros\n";
}

part_1();
part_2();
