#!/usr/bin/perl


# Some useful color codes.
#
$col_black =        "\033[30m";
$col_red =          "\033[31m";
$col_green =        "\033[32m";
$col_brown =        "\033[33m";
$col_blue =         "\033[34m";
$col_purple =       "\033[35m";
$col_cyan =         "\033[36m";
$col_ltgray =       "\033[37m";

$col_norm =	    "\033[00m";
$col_background =   "\033[07m";
$col_brighten =     "\033[01m";
$col_underline =    "\033[04m";
$col_blink = 	    "\033[05m";
$col_reverse =      "\033[07m";

$col_yellow =       $col_brown . $col_brighten;
$col_white =        $col_ltgray . $col_brighten;

# Customize colors here...
#
$col_default =      $col_ltgray;
$col_modified =     $col_green . $col_brighten;
$col_conflict =     $col_cyan . $col_brighten;
$col_unknown =      $col_yellow;

while (<>)
{
	$thisline = $_;

	$thisline =~ s/^([MARD] )/$col_modified$1/;
	$thisline =~ s/^([CG] )/$col_conflict$1/;
	$thisline =~ s/^(\? )/$col_unknown$1/;
	$thisline =~ s/^/$col_norm/;
	print $thisline;	
}

print $col_norm;


