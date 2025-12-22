use strict;
use warnings;
use autodie;

use List::Util qw(sum);

open(my $file, "./inputs/day6.txt");
my @lines = <$file>;
close($file);

print "Read ", scalar(@lines), " lines from the file.\n";

sub part_1 {
    chomp $lines[-1];
    my @operators = split ' ', $lines[-1];
    my @nums = map { [ split ' ', $_ ] } @lines[0..$#lines-1];

    # zip the operators and numbers by columns
    my @formulas = ();
    for my $col (0 .. $#operators) {
        my @formula = ();
        for my $row (0 .. $#nums) {
            push @formula, $nums[$row][$col];
            push @formula, $operators[$col] if $row < $#nums;
        }
        push @formulas, \@formula;
    }

    my $total = 0;

    for my $formula (@formulas) {
        my $result = evaluate($formula);
        $total += $result;
    }

    print "Total sum of evaluated formulas: $total\n";
}

sub evaluate {
    my ($formula_ref) = @_;
    my @tokens = @$formula_ref;

    my $result = shift @tokens;

    while (@tokens) {
        my $op = shift @tokens;
        my $num = shift @tokens;

        if ($op eq '+') {
            $result += $num;
        } elsif ($op eq '*') {
            $result *= $num;
        }
    }

    return $result;
}

part_1;
