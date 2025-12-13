use strict;
use warnings;
use autodie;

open(my $file, "./inputs/day1.txt");
my @lines = <$file>;
close($file);

print "Read ", scalar(@lines), " lines from the file.\n";

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
