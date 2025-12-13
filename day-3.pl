use strict;
use warnings;
use autodie;

use List::Util qw(sum);

open(my $file, "./inputs/day3.txt");
my @lines = <$file>;
close($file);

print "Read ", scalar(@lines), " lines from the file.\n";

sub part_1 {
    my $total = 0;

    for my $line (@lines) {
        chomp($line);
        my $result = find_largest_num($line);
        # print "Largest number in line: $result\n";
        $total += int($result);
    }
    print "Total sum of largest numbers: $total\n";
}

sub find_largest_num {
    my (@line) = @_;
    my @digeits = split('', $line[0]);

    my $first_num = -1;
    my $first_pos = -1;

    for (my $i = 0; $i < scalar(@digeits) - 1; $i++) {
        my $digit = int($digeits[$i]);
        if ($digit > $first_num) {
            $first_num = $digit;
            $first_pos = $i;
        }
    }

    my $second_num = -1;

    for (my $i = $first_pos + 1; $i < scalar(@digeits); $i++) {
        my $digit = int($digeits[$i]);
        if ($digit > $second_num) {
            $second_num = $digit;
        }
    }

    return $first_num . $second_num;
}

part_1;
