#include <stdio.h>
#include <stdlib.h>

int main(int argc, char **argv)
{
    int c, i = 0;

    printf("{\n");
    while ((c = getchar()) != EOF)
    {
	printf("0x%02x, ", c);
	if (++i % 8 == 0)
	    printf("\n");
    }
    printf("\n};\n");
    return 0;
}

