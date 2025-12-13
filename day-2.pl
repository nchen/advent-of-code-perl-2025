use strict;
use warnings;
use autodie;

use List::Util qw(sum);

open(my $file, "./inputs/day2.txt");
my @lines = <$file>;
close($file);

print "Read ", scalar(@lines), " lines from the file.\n";

sub check {
    my ($is_invalid) = @_;

    my @ranges = split(',', $lines[0]);
    print scalar(@ranges), " ranges.\n";

    my %invalid_ids = ();

    foreach my $range (@ranges) {
        my ($start, $end) = $range =~ /(\d+)-(\d+)/;

        for (my $i = $start; $i <= $end; $i++) {
            if ($is_invalid->($i)) {
                $invalid_ids{$i} = 1;
            }
        }
    }
    print "Total invalid IDs: ", scalar(keys %invalid_ids), "\n";
    print sum(keys %invalid_ids), "\n";
}

sub is_invalid_1 {
    my ($id) = @_;
    if (length($id) % 2 == 0 && 
        substr($id, 0, length($id)/2) eq substr($id, length($id)/2)) {
        return 1;
    }
    return 0;
}

sub part_2 {

}

check(\&is_invalid_1);
