#! /usr/bin/perl -w

use Getopt::Std;

# Symbol table
my @syms;
my @load_map;
my %cmd_line;

# Extracted from the crash dump.
my ($pc, $lr, @stack);

main();
exit(0);

sub main
{
    getopts('hdam', \%cmd_line) || do {
        help();
	exit(1);
    };

    if (defined($cmd_line{'h'}))
    {
        help();
	exit(0);
    }

    # The kernel is not remappable
    dynamic_map_add('vmlinux', 0x0);

    parse_input();

    # Build symbol post dynamic linkage symbol table
    symbol_table_create();

    if (defined($cmd_line{'d'}))
    {
        dump_syms();
	return;
    }

    do_stack_trace();
}

sub help
{
    print "\n";
    print "Usage: $0 -[hdam] < kernel_crash_dump.txt\n";
    print "  -h : help\n";
    print "  -d : dump symbol table. Do not print the stack trace.\n";
    print "  -a : print all symbols, even ones that are outside the objects\n";
    print "  -m : ignore missing modules\n";
    print "@@@ real usage:\n";
    print "  crash_analyze_k serial_dump.txt\n";
    print "\n";
}

# load_symbols($name, $base, $module_ref);
sub load_symbols
{
    my ($name, $base, $module) = @_;

    printf("Loading %s .text=0x%x", $name, $base);

    -r $name || do {
        defined($cmd_line{'m'}) && do {
	    print " NOT FOUND\n";
	    return;
	};
	print "\n";
	die "module $name not found.";
    };
    print "\n";

    # Load symbols
    open(MOD, "nm -n $name|")  || die "Error running nm";

    while (<MOD>)
    {
        chomp;
	/\w+ [Tt] / || next;
	/^(\w+) [Tt] (.*)$/ || die "$name: Bad symbol '$_'";
	my ($addr, $sym) = ($1, $2);
	$addr = hex($addr) + $base;
	push(@syms, {addr => $addr, sym => $sym, module => $module});
    }

    close(MOD);

    # Find the size of the text area, and enter a 'hole' symbol after it.
    open(MOD, "objdump -h $name|")  || die "Error running objdump";

    my $found = 0;
    while (<MOD>)
    {
        chomp;
	/.text\s+(\S+)\s+(\S+)\s/ && do
	{
	    my ($size, $load_addr) = ($1, $2);
	    $end = hex($size) + $base + hex($load_addr);
	    push(@syms, {addr => $end, sym => "End_of_$name",
	        module => $module});
	    $found = 1;
	    last;
	}
    }

    close(MOD);
    $found || die "No .text area found in objdump";
}

sub symbol_table_create
{
    # Go over the dynamic_map, find the files, 'nm' them, move to abs address,
    # add to @syms.
    foreach $module (@load_map)
    {
	load_symbols($module->{'name'}, $module->{'base'}, $module);
    }

    # Sort the sucker.
    @syms = sort {$a->{'addr'} <=> $b->{'addr'}} @syms;
}

sub dynamic_map_add
{
    my ($name, $base) = @_;

    push(@load_map, {base => hex($base), name => $name});
}

sub parse_input
{
    while (<STDIN>)
    {
        /insmod: add-symbol-file PATH\/(\S+)\s(\S+)/ && do
	{
	    dynamic_map_add($1, $2);
	};

	/pc : \[<(\w+)>\]\s+lr : \[<(\w+)>\]/ && do
	{
	    ($pc, $lr) = (hex($1), hex($2));
	};

	/[\da-f]{4}:\s([\da-f\s]+)$/ && do
	{
	    my @words = split(/\s+/, $1);
	    foreach $word (@words)
	    {
	        push(@stack, hex($word));
	    }
	};

	# linux-2.6's format
	/[\da-f]{8}:\s+\[<([\da-f]+)>\]$/ && do
	{
	    push(@stack, hex($1));
	};
    }
}

sub gen_addr_line
{
    my ($addr, $sym) = @_;

    return sprintf("%-25s     (0x%x: %s + 0x%x)\n", $sym->{'sym'}, $addr,
        $sym->{'module'}->{'name'}, $addr - $sym->{'module'}->{'base'});
}

sub do_stack_trace
{
    print "\n";
    # pc
    $sym = find_addr($pc);
    if (defined($sym))
    {
        print "pc: " . gen_addr_line($pc, $sym);
    }
    else
    {
       #printf("pc: 0x%x undefined\n", $pc);
       printf("pc undefined\n");
    }

    # lr
    $sym = find_addr($lr);
    if (defined($sym))
    {
        print "lr: " . gen_addr_line($lr, $sym);
    }
    else
    {
       #printf("lr 0x%x undefined\n", $lr);
       printf("lr undefined\n");
    }

    # stack
    foreach $addr (@stack)
    {
        $sym = find_addr($addr);
        defined($sym) || next;
	print "    " . gen_addr_line($addr, $sym);
    }

    print "\n";
}

sub find_addr
{
    my ($addr) = @_;

    my $first = $syms[0]->{'addr'};
    my $last = $syms[$#syms]->{'addr'};

    if ($addr < $first || $addr > $last)
    {
        return undef;
    }

    for ($i = $#syms; $i; $i--)
    {
	if ($syms[$i]->{'addr'} <= $addr)
	{
	    if (($syms[$i]->{'sym'} !~ /^End_of_/) || defined($cmd_line{'a'}))
	    {
	        return $syms[$i];
	    }
	    else
	    {
	        return undef;
	    }
	}
    }
    return undef;
}

sub dump_syms
{
    foreach $sym (@syms)
    {
        printf("0x%x %s\n", $sym->{'addr'}, $sym->{'sym'});
    }
}
