#!/usr/bin/perl

open(IN,"list.txt");
while ($line = <IN>) {
	chomp($line);
	if ($line =~ /public_report/) {

		@indexvals = split(",",$line);
		

		foreach $entry (@indexvals) {
			chop($entry);
			$entry =~ s/^"//;
			($key,$value) = split("\":\"",$entry);
			print "$key $value\n";


			if ($key eq "abn") { $abn = $value; }
			if ($key eq "reporting_period") { $period = $value; }
			chop($period);
	
			#print "ABN is $abn period is $period -                   $key - $value\n";
		
			}



		} # Done with the line


	} #Done with the file
