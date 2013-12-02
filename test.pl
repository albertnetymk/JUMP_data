my @mean = ();
my @std = ();
my $odd = 1;
while(<>) {
    chomp();
    if (/^\s+0\s+([^ .]*)(\.)?.*$/) {
        if ($odd) {
            push(@mean, $1);
        } else {
            push(@std, $1);
        }
        $odd ^= 1;
    }
}
foreach (@mean) {
    print $_, "\n";
}
foreach (@std) {
    print $_, "\n";
}

