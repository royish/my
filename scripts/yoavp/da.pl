#!/usr/bin/perl -w

use strict;
use Switch;

sub file_read_lines
{
    my $fname = shift;

    open FILE, "$fname";
    my @res = <FILE>;
    close FILE;

    chomp @res;

    return @res;
}


sub read_sub {
	my $dir = shift;
	return () if not -r "$dir/.reps";

	my @reps = file_read_lines "$dir/.reps";
	

	print "Reps: [@reps]";

}

sub do_status {
	read_sub "."
}






if (not @ARGV)
{
	system "darcs"
}
else
{
	switch ($ARGV[0]) {
		case /^(s|st|sta|status)$/ {shift @ARGV; do_status}
		else {print "Unknown command"}
	}
}
