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
        $total += int($result);
    }
    print "Total sum of largest numbers: $total\n";
}

sub find_largest_num {
    my (@line) = @_;
    my @digits = split('', $line[0]);

    my $first_num = -1;
    my $first_pos = -1;

    for (my $i = 0; $i < scalar(@digits) - 1; $i++) {
        my $digit = int($digits[$i]);
        if ($digit > $first_num) {
            $first_num = $digit;
            $first_pos = $i;
        }
    }

    my $second_num = -1;

    for (my $i = $first_pos + 1; $i < scalar(@digits); $i++) {
        my $digit = int($digits[$i]);
        if ($digit > $second_num) {
            $second_num = $digit;
        }
    }

    return $first_num . $second_num;
}

sub part_2 {
    my $total = 0;

    for my $line (@lines) {
        chomp($line);
        my $result = find_largest_num_2($line);
        $total += int($result);
    }
    print "Total sum of largest numbers: $total\n";
}

sub find_largest_num_2 {
    my (@line) = @_;
    my @digits = split('', $line[0]);

    my @result = ();

    my $num_selected = 0;
    my $pos_prev_digit = -1;
    my $num_to_select = 12;

    # Need to select 12 digits from the list
    for (my $i = 0; $i < $num_to_select; $i++) {
        my $current = -1;
        my $current_pos = -1;

        for (my $j = $pos_prev_digit + 1; $j < scalar(@digits) - $num_to_select + 1 + $num_selected; $j++) {
            if (int($digits[$j]) > $current) {
                $current = int($digits[$j]);
                $current_pos = $j;
            }
        }

        push(@result, $current);
        $pos_prev_digit = $current_pos;
        $num_selected++;
    }

    return join('', @result);
}

part_1;
part_2;
