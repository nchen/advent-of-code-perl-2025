use strict;
use warnings;
use autodie;

use List::Util qw(sum);

open(my $file, "./inputs/day2.txt");
my @lines = <$file>;
close($file);

print "Read ", scalar(@lines), " lines from the file.\n";

sub part_1() {
    my @ranges = split(',', $lines[0]);
    print scalar(@ranges), " ranges.\n";

    my %invalid_ids = ();

    foreach my $range (@ranges) {
        my ($start, $end) = $range =~ /(\d+)-(\d+)/;

        for (my $i = $start; $i <= $end; $i++) {
            if (length($i) % 2 == 0 && 
                substr($i, 0, length($i)/2) eq substr($i, length($i)/2)) {
                $invalid_ids{$i} = 1;
            }
        }
    }
    print "Total invalid IDs: ", scalar(keys %invalid_ids), "\n";
    print sum(keys %invalid_ids), "\n";
}

part_1();
