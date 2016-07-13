#include <stdio.h>
#include <stdlib.h>
#include <set.h>
#include <rg_set_utils.h>

static char buf[1024*1024];

int main(int argc, char **argv)
{
    set_t *buf_set = NULL;
    char *p = buf;
    int c, ret = -2;

    if (argc != 2)
	return -1;

    while ((c = getchar()) != EOF)
	*p++ = c;
    *p = 0;

    buf_set = set_read(buf);
    if (!buf_set)
	goto Exit;

#if 0
    printf("%s\n", set_get_path_unobscured(&buf_set,
	"rg_conf/admin/user/0/password"));

    printf("%s\n", set_get_path_unobscured(&buf_set,
	"rg_conf/Fast34xx/ft_ppp_login/unlock_login/user"));
    printf("%s\n", set_get_path_unobscured(&buf_set,
	"rg_conf/Fast34xx/ft_ppp_login/unlock_login/password"));
#endif
    printf("%s\n", set_get_path_unobscured(&buf_set, argv[1]));
    ret = 0;

Exit:
    set_free(&buf_set);
    return ret;
}
