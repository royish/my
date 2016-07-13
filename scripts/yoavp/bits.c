#include <stdio.h>

int usage(void)
{
    printf("usage: bits <hex-val> [+bit|-bit ...]\n");
    return -1;
}

int main(int argc, char **argv)
{
    unsigned int val;
    int i;

    if (argc < 2)
	return usage();

    sscanf(argv[1], "%x", &val);
    for (i = 31; i >= 0; i--)
    {
	printf("%02d ", i);
	if (!(i % 8))
	    printf("  ");
    }
    printf("\n");
    for (i = 31; i >= 0; i--)
    {
	printf("%2s ", (val & (1 << i)) ? "*" : "");
	if (!(i % 8))
	    printf("  ");
    }
    printf("\n");

    for (i = 2; i < argc; i++)
    {
	unsigned long bit;

	if (!argv[i][0])
	    return usage();
	bit = strtoul(argv[i]+1, NULL, 10);

	if (argv[i][0] == '+')
	    val |= (1 << bit);
	else if (argv[i][0] == '-')
	    val &= ~(1 << bit);
	else
	    return usage();
    }
    printf("%#010x\n", val);
    return 0;
}
