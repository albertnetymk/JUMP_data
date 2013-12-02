my $count = $ARGV[0];
my $i = 1;
my $line = 1;
open (my $file, '<', $ARGV[1]);
my $first_column = '';
while(<$file>) {
    if ($i == 1) {
        if ($line > 3) {
            printf "|v%do", $line - 3;
        } else {
            print "|v$line";
        }
    }
    chomp();
    print "|", $_;
    if ($i == $count) {
        $i = 0;
        $line++;
        print "|\n";
    }
    $i++;
}
close ($file);
