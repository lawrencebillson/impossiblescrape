#!/usr/bin/perl

$count = 1094;
$resultsperpage = 8;

# How many pages do we need to get?
$pcount = int $count / $resultsperpage;
$pcount++;

print "We need to collect $pcount pages\n";

open (OUTPUT, ">list.txt");
for ($count = 1; $count <= $pcount ; $count++) {
	$output = `curl -i -H "Accept: application/json" -X POST -d "term_id=1644&search=public_report&reporting_period=all&industry=62&legal_name=&abn=&state=all&emps=0&pageNum=$count" https://www.wgea.gov.au/public/reports`;

	print OUTPUT "$output\n";
	}

close(OUTPUT);
