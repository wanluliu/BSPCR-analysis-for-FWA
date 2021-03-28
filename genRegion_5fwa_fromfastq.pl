#!/usr/bin/perl
###usage perl script.pl read1.fastq read2.fastq
my @library1;
my @library2;
$library1[0] = "TTCTTATATCATATAATAAATTACTATTTCAAAACATAAATATTTAATTATCT";
$library2[0] = "AATTTTAAATAAGTAAATATTAAATYYAATTGATTTTTTATTAAATTTAGTAAT";
$library1[1] = "TCATATAAAAAAAAAATTAAATTTCATTTCACAATAACCATT";
$library2[1] = "GTATGGGYTTYGATAAAGAATATATGAGATTYT";
$library1[2] = "CTCATATATACCTTATCCCATTCAACATTCATA";
$library2[2] = "AAGATYTGATATTTGGYTGGAAAAAAYAATAATAAT";
$library1[3] = "CRCTCTTTATCCCATTCAACATTCATAC";
$library2[3] = "TTTGGTTGAAAAAAATAATAAAAATTTGATTGTYAGTAT";
$library1[4] = "AAAGTTATATAGTTGATYATAAATATTTTATGTAAAGTTTTAAGTTT";
$library2[4] = "ATACTTAATTAATCTTAACTTTACTTCTATCTAAATACTTTCTTAA";
$library1[5] = "AAGYTGTATTTTTGTGGAAGATAGTATTATTTAAAAATTA";
$library2[5] = "CAAACAATTTTAATCATCAAAAAAAAACTRAATTCCT";
@library1_len=(length($library1[0]),length($library1[1]),length($library1[2]),length($library1[3]),length($library1[4]),length($library1[5]));
@library2_len=(length($library2[0]),length($library2[1]),length($library2[2]),length($library2[3]),length($library2[4]),length($library1[5]));

for (my $i = 0; $i <= $#library1; $i++) {
	$library1[$i] =~ s/Y/(C)|(T)/g;
	$library2[$i] =~ s/Y/(C)|(T)/g;
	$library1[$i] =~ s/R/(A)|(G)/g;
	$library2[$i] =~ s/R/(A)|(G)/g;
} 

open(IN1, $ARGV[0]) or die "can't open file $ARGV[0]";
open(IN2, $ARGV[1]) or die "can't open file $ARGV[1]";


my @output_read1;
my @output_read2;
for (my $i = 0; $i <=5; $i++) {
	$file1 = ">Region" . $i ."_". $ARGV[0];
	$file2 = ">Region" . $i ."_". $ARGV[1];
	local *FILE1;
	open(FILE1, $file1) || die "can't open output file";
	push (@output_read1, *FILE1) ;
	local *FILE2;
	open(FILE2, $file2) || die "can't open output file";
	push (@output_read2, *FILE2);	
}

while (<IN1>) {
	$line11 = $_;
	$line12 = <IN1>;
	$line13 = <IN1>;
	$line14 = <IN1>;
	$line21 = <IN2>;
	$line22 = <IN2>;
	$line23 = <IN2>;
	$line24 = <IN2>;
	for (my $i = 0; $i <= $#library1; $i++) {
		$toMatch1 = $library1[$i];
		$toMatch2 = $library2[$i];
		local *OUTPUT1 = $output_read1[$i];
		local *OUTPUT2 = $output_read2[$i];
		if (($line12 =~ m/^$toMatch1/) && ($line22 =~ m/^$toMatch2/)) {
			$line12 = substr $line12, $library1_len[$i];
			$line14 = substr $line14, $library1_len[$i];
			$line22 = substr $line22, $library2_len[$i];
			$line24 = substr $line24, $library2_len[$i];
			print OUTPUT1 "$line11";
			print OUTPUT1 "$line12";
			print OUTPUT1 "$line13";
			print OUTPUT1 "$line14";
			
			print OUTPUT2 "$line21";
			print OUTPUT2 "$line22";
			print OUTPUT2 "$line23";
			print OUTPUT2 "$line24";
		} elsif (($line12 =~ m/^$toMatch2/) && ($line22 =~ m/^$toMatch1/)) {
			$line12 = substr $line12, $library2_len[$i];
			$line14 = substr $line14, $library2_len[$i];
			$line22 = substr $line22, $library1_len[$i];
			$line24 = substr $line24, $library1_len[$i];

			print OUTPUT1 "$line11";
			print OUTPUT1 "$line12";
			print OUTPUT1 "$line13";
			print OUTPUT1 "$line14";
			
			print OUTPUT2 "$line21";
			print OUTPUT2 "$line22";
			print OUTPUT2 "$line23";
			print OUTPUT2 "$line24";
		}
	}
}
