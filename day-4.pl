use strict;
use warnings;
use autodie;

use List::Util qw(sum);

open(my $file, "./inputs/day4.txt");
my @lines = <$file>;
close($file);

print "Read ", scalar(@lines), " lines from the file.\n";

sub check_1 {
    my @directions = (
        [-1, -1], [-1, 0], [-1, 1],
        [ 0, -1],          [ 0, 1],
        [ 1, -1], [ 1, 0], [ 1, 1],
    ); # eight neighbors
    my @states = ();

    for my $line (@lines) {
        chomp($line);
        my @cells = split('', $line);
        push @states, \@cells;
    }

    my $accessible_locations = 0;

    for (my $i = 0; $i < scalar(@states); $i++) {
        for (my $j = 0; $j < scalar(@{$states[$i]}); $j++) {
            my $current = $states[$i][$j];
            next if $current eq '.';

            my $count = 0;
            for my $dir (@directions) {
                my $next_i = $i + $dir->[0];
                my $next_j = $j + $dir->[1];
                next if $next_i < 0 || $next_j < 0 || 
                    $next_i >= scalar(@states) || $next_j >= scalar(@{$states[$next_i]});
                if ($states[$next_i][$next_j] eq '@') {
                    $count++;
                }
            }

            if ($count < 4) {
                $accessible_locations++;
            }
        }
    }

    print "Accessible locations: ", $accessible_locations;
}

check_1;
