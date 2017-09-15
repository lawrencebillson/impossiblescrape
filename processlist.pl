#!/usr/bin/perl

open(IN,"list.txt");
while ($line = <IN>) {
	chomp($line);
	if ($line =~ /public_report/) {

		@indexvals = split(/[\[\]\{\}]/, $line); # This splits it into 'index' values - quite useful


		foreach $index (@indexvals) {
			# Grab the ABN and reporting period out of each of those values

			if ($index =~ /^\"index\"/) {
				@iparts = split(',\"',$index);

				# Pass one - grab the ABN and Reporting period
				foreach $part (@iparts) {
					($key,$val) = split('\":\"',$part);
					$val =~ s/\"//g; # Remove the quotes

					if ($key =~ "abn") {
						$abn = $val;
						}
					if ($key =~ "reporting_period") {
						$period = $val;	
						}
					}				
				$uid = "$abn:$period";

				# Is it really unique? 
				if ($db{$uid}) {
					$ruid++;
					$uid = "$uid-$ruid";
					}

				# Second run through the deck!
				foreach $part (@iparts) {
					($key,$val) = split('\":\"',$part);
					$key =~ s/\"//g; # Remove the quotes
					$val =~ s/\"//g; # Remove the quotes
	
					# Put it into a big hash	
					$db{$uid}{$key} = $val;
					}


				} # Yep, was in index
			} # Cycled through the indexvals



		} # Done with the line


	} #Done with the file


# Print out our database 
# CSV header
#
# Work out all of the possible keys
foreach $huid (sort keys %db) {
	foreach $possible (sort keys %{ $db{$huid} }) {
		$stored{$possible} = 1;
		}
	}
print "UID,";
foreach $possible (sort keys %stored) {
	print "$possible,";
	}
print "\n";

# Ace, dump the database
foreach $huid (sort keys %db) { 
	print "$huid,";
	foreach $possible (sort keys %stored) {
		print "$db{$huid}{$possible},";	
		}
	print "\n"; 
	}

