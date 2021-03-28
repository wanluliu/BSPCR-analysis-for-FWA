#!/usr/bin/perl
###usage perl script.pl read1.fastq
my @library1;
$library1[0] = "TTCTTATATCATATAATAAATTACTATTTCAAAACATAAATATTTAATTATCT";
$library1[1] = "AATTTTAAATAAGTAAATATTAAATYYAATTGATTTTTTATTAAATTTAGTAAT";
$library1[2] = "TCATATAAAAAAAAAATTAAATTTCATTTCACAATAACCATT";
$library1[3] = "GTATGGGYTTYGATAAAGAATATATGAGATTYT";
$library1[4] = "CTCATATATACCTTATCCCATTCAACATTCATA";
$library1[5] = "AAGATYTGATATTTGGYTGGAAAAAAYAATAATAAT";
$library1[6] = "CRCTCTTTATCCCATTCAACATTCATAC";
$library1[7] = "TTTGGTTGAAAAAAATAATAAAAATTTGATTGTYAGTAT";
$library1[8] = "AAAGTTATATAGTTGATYATAAATATTTTATGTAAAGTTTTAAGTTT";
$library1[9] = "ATACTTAATTAATCTTAACTTTACTTCTATCTAAATACTTTCTTAA";
$library1[10] = "AAGYTGTATTTTTGTGGAAGATAGTATTATTTAAAAATTA";
$library1[11] = "CAAACAATTTTAATCATCAAAAAAAAACTRAATTCCT";
@library1_len=(length($library1[0]),length($library1[1]),length($library1[2]),length($library1[3]),length($library1[4]),length($library1[5]),length($library1[6]),length($library1[7]),length($library1[8]),length($library1[9]),length($library1[10]),length($library1[11]));

for (my $i = 0; $i <= $#library1; $i++) {
	$library1[$i] =~ s/Y/[CT]/g;
	$library1[$i] =~ s/R/[AG]/g;
}

open(IN1, $ARGV[0]) or die "can't open file $ARGV[0]";
$file=$ARGV[0];
if ($file =~ /(\S+)\.fastq/){
    $file = $1;
}
open(OUTPUT,">$file\_region.fastq");

while (<IN1>) {
	$line11 = $_;
	$line12 = <IN1>;
	$line13 = <IN1>;
	$line14 = <IN1>;
#	print "$line12\n";
    for (my $i = 0; $i <= $#library1; $i++) {
		$toMatch1 = $library1[$i];
#		print "$toMatch1\n";
		if ($line12 =~ m/^$toMatch1/) {
            #print "$line12\n";
            #print "$toMatch1\n";
            #print "$i\n";
            #print "$library1_len[$i]";
			$line12 = substr $line12, $library1_len[$i];
            #print "$line12";
			$line14 = substr $line14, $library1_len[$i];
			print OUTPUT "$line11";
			print OUTPUT "$line12";
			print OUTPUT "$line13";
			print OUTPUT "$line14";
        }
    }
}
