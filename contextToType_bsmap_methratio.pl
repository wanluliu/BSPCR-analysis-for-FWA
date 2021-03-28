#!/usr/bin/perl

open(INPUT, $ARGV[0]) or die "can't open file";
$file=$ARGV[0];

if ($file=~ /(\S+)\.txt/){
    $file=$1;
    open(OUTPUT,">$file\_type.txt");
}

my $chr;
my $pos;
my $strand;
my $context;
my $ratio,$eff_ct_count,$c_count,$ct_count,$rev_g_count,$rev_ga_count,$ci_lower,$ci_higher;
while (<INPUT>) {
	chomp;
	#print "$_";
	($chr,$pos,$strand,$context,$ratio,$eff_ct_count,$c_count,$ct_count,$rev_g_count,$rev_ga_count,$ci_lower,$ci_higher) = split(/\s+/);
   	#print "$chr\n";
	if ($strand eq "+") {
        	if ($context =~ /[ATCG][ATCG]CG[ATCG]/){
            		print OUTPUT "$chr\t$pos\t$strand\tCG\t$ratio\t$eff_ct_count\t$c_count\t$ct_count\t$rev_g_count\t$rev_ga_count\t$ci_lower\t$ci_higher\n";}
        	if ($context =~ /[ATCG][ATCG]C[ATC]G/) {
            		print OUTPUT "$chr\t$pos\t$strand\tCHG\t$ratio\t$eff_ct_count\t$c_count\t$ct_count\t$rev_g_count\t$rev_ga_count\t$ci_lower\t$ci_higher\n";}
        	if ($context =~ /[ATCG][ATCG]C[ATC][ATC]/) {
            		print OUTPUT "$chr\t$pos\t$strand\tCHH\t$ratio\t$eff_ct_count\t$c_count\t$ct_count\t$rev_g_count\t$rev_ga_count\t$ci_lower\t$ci_higher\n";}
    }
    if ($strand eq "-") {
        if ($context =~ /[ATCG]CG[ATCG][ATCG]/){
            print OUTPUT "$chr\t$pos\t$strand\tCG\t$ratio\t$eff_ct_count\t$c_count\t$ct_count\t$rev_g_count\t$rev_ga_count\t$ci_lower\t$ci_higher\n";}
        if ($context =~ /C[ATG]G[ATCG][ATCG]/) {
            print OUTPUT "$chr\t$pos\t$strand\tCHG\t$ratio\t$eff_ct_count\t$c_count\t$ct_count\t$rev_g_count\t$rev_ga_count\t$ci_lower\t$ci_higher\n";}
        if ($context =~ /[ATG][ATG]G[ATCG][ATCG]/) {
            print OUTPUT "$chr\t$pos\t$strand\tCHH\t$ratio\t$eff_ct_count\t$c_count\t$ct_count\t$rev_g_count\t$rev_ga_count\t$ci_lower\t$ci_higher\n";}
    }
}
close(INPUT);
close(OUTPUT);
