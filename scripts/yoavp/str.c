#include <stdio.h>

int main(void)
{
    unsigned int val;
    unsigned char *pval = (void *)&val;

    while (1)
    {
	fscanf(stdin, "%02x", &val);
	printf("%c", *pval);
	fflush(stdout);
    }
    return 0;
}
