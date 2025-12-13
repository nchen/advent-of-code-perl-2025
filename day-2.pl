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

sub is_invalid_2 {
    my ($id) = @_;
    my $l = length($id);

    for (my $split = 1; $split <= $l / 2; $split++) {
        if ($l % $split != 0) {
            next;
        }

        my $is_same = 1;
        my $pos = 0;

        while ($pos < $l - $split) {
            if (substr($id, $pos, $split) ne substr($id, $pos + $split, $split)) {
                $is_same = 0;
                last;
            }
            $pos += $split;
        }

        if ($is_same) {
            return 1;
        }
    }
    return 0;
}

# print is_invalid_2("2121212121"), "\n";
# print is_invalid_2("824824824"), "\n";
# print is_invalid_2("123123123123"), "\n";
# print is_invalid_2("12341234"), "\n";
# print is_invalid_2("1212121212"), "\n";
# print is_invalid_2("1212121312"), "\n";

check(\&is_invalid_1);
check(\&is_invalid_2);
