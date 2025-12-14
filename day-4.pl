use strict;
use warnings;
use autodie;

use List::Util qw(sum);

open(my $file, "./inputs/day4.txt");
my @lines = <$file>;
close($file);

print "Read ", scalar(@lines), " lines from the file.\n";

my @directions = (
    [-1, -1], [-1, 0], [-1, 1],
    [ 0, -1],          [ 0, 1],
    [ 1, -1], [ 1, 0], [ 1, 1],
); # eight neighbors

sub part_1 {
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

            if (is_accessible(\@states, $i, $j)) {
                $accessible_locations++;
            }
        }
    }

    print "Accessible locations: ", $accessible_locations, "\n";
}

sub is_accessible {
    my ($states_ref, $i, $j) = @_;
    my $count = 0;
    my $rows = scalar(@$states_ref);

    for my $dir (@directions) {
        my $next_i = $i + $dir->[0];
        my $next_j = $j + $dir->[1];
        next if $next_i < 0 || $next_j < 0;
        next if $next_i >= $rows;
        next if $next_j >= scalar(@{$states_ref->[$next_i]});
        
        if ($states_ref->[$next_i][$next_j] eq '@') {
            $count++;
        }
    }

    return $count < 4;
}

sub part_2 {
    my @states = ();
    for my $line (@lines) {
        chomp($line);
        my @cells = split('', $line);
        push @states, \@cells;
    }

    my $removed = 0;
    my $removed_this_round = 1;

    while ($removed_this_round > 0) {
        $removed_this_round = 0;

        for (my $i = 0; $i < scalar(@states); $i++) {
            for (my $j = 0; $j < scalar(@{$states[$i]}); $j++) {
                next if $states[$i][$j] eq '.';

                if (is_accessible(\@states, $i, $j)) {
                    # Remove it
                    $states[$i][$j] = '.';
                    $removed_this_round++;
                }
            }
        }
        $removed += $removed_this_round;
    }

    print "Removed: ", $removed, "\n";
}

part_1;
part_2;
