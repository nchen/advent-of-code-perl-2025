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

    # zip the operators and numbers by columns (pure-Perl interleave)
    my @formulas = map {
        my $col = $_;
        my @col_vals = map { $_->[$col] } @nums;
        my @tokens = ($col_vals[0]);
        for my $i (1 .. $#col_vals) {
            push @tokens, $operators[$col], $col_vals[$i];
        }
        \@tokens;
    } 0 .. $#operators;

    my $total = 0;

    for my $formula (@formulas) {
        my $result = evaluate($formula);
        $total += $result;
    }

    sub assert {
        my ($cond, $msg) = @_;
        die $msg unless $cond;
    }

    my $expected = 4771265398012;
    assert($total == $expected, "Assertion failed: expected $expected, got $total");
    print "Assertion passed: total == $expected\n";
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

part_1();
