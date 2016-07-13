#ifndef _yuval_tt_h
#define _yuval_tt_h
//#define YNDBG
#ifdef __cplusplus
extern "C" {
#endif
#ifdef __KERNEL__
#define YPRINTF printk

extern int ydb, d_profile;
extern int printk(const char * fmt, ...);
void console_print(const char *s);

void current_debug(const char *func, int line);
//int yuval_get_pid(void);
#define G_PID -1
#else
extern int ydb;
#define G_PID getpid()
#include <errno.h>
#include <strings.h>
#include <stdio.h>
#include <sys/types.h>
#include <unistd.h>
#ifndef YCONSOLE
  #ifdef CC_FOR_BUILD
    #define YCONSOLE "/proc/self/fd/3"
  #else
    #define YCONSOLE "/dev/console"
  #endif
#endif

#define __TT(pid)
#ifdef __SUPPORT_LD_DEBUG__
#define YPRINTF(x...) ( { _dl_debug_early(x); } )
#endif

#ifndef YPRINTF
#ifndef CC_FOR_BUILD
#define YPRINTF(x...) if (1) { FILE *tt_fp = fopen(YCONSOLE, "a+"); \
    fprintf(tt_fp, x); fclose(tt_fp); }
#else
#define YPRINTF(x...) ( { printf(x); } )
#endif
#endif
#endif
#ifndef YNDBG
#define TT YPRINTF("%d:%s:%s:%d\n", G_PID, __FILE__, __FUNCTION__, __LINE__)
#define TF(fmt, args...) YPRINTF("%d:%s:%s:%d " fmt "\n", G_PID, __FILE__, __FUNCTION__, __LINE__ , ## args)
#define PIP(addr) \
	((unsigned char *)&addr)[0], \
	((unsigned char *)&addr)[1], \
	((unsigned char *)&addr)[2], \
	((unsigned char *)&addr)[3]
#else
#define TT
#define TF(x...)
#endif

#ifdef __KERNEL__
#define DTT
#define DTV(a)
//#include "/home/yuval/dev/infineon/danube/ctt.h"
#if 0
#define _DCP ( { struct task_struct *tsk = current; \
    if (tsk) TF("current: %p, pid: %d, vfork_done: %x name: %s " \
    "sizeof task_struct=%d pid_offset=%d", tsk, tsk->pid, \
    tsk->vfork_done, tsk->comm, sizeof(*tsk), (unsigned char *)&tsk->pid - (unsigned char *)tsk); \
    else TF("current=NULL"); } )
#endif
#define _DCP ( { current_debug(__FUNCTION__, __LINE__); } )
#define DCP(x...) ( { _DCP; TF(x); } )
#endif

#define PIP_P "%u.%u.%u.%u"
#define PMAC_P "%02x:%02x:%02x:%02x:%02x:%02x"
#define C(x) ((unsigned char *)x)
#define PMAC_A(mac) C(mac)[0],C(mac)[1],C(mac)[2],C(mac)[3],C(mac)[4],C(mac)[5]
#define _PMAC(mac) { if (mac) YPRINTF(PMAC_P, PMAC_A(mac)); else TF("NULL"); }
#define PMAC(mac) { if (mac) TF("%s: %02x:%02x:%02x:%02x:%02x:%02x", #mac, mac[0],mac[1],mac[2],mac[3],mac[4],mac[5]); else TF("NULL"); }

#define PV(v) TF("%s: %lx", #v, (unsigned long)(v))


#if 0
static unsigned char __MM[] = { 0, 0x1f, 0x3a , 0x7, 0x9f, 0xfa };
#define MM(mac) (!memcmp(mac, __MM, sizeof(__MM))) 
#define MTT(mac) { if (MM(mac)) TT; }
#define MTF(mac, s...) { if (MM(mac)) TF(s); }
#endif




static inline void TF_80211(unsigned char *p)
{
    unsigned short *usp = (unsigned short *)p;
    YPRINTF("80211:\n");
    YPRINTF("\tFrame Control: %04x Duration ID: %04x\n", usp[0], usp[1]);
    YPRINTF("\tMAC1: %02x:%02x:%02x:%02x:%02x:%02x\n", p[4], p[5], p[6], p[7],
	p[8], p[9]);
    YPRINTF("\tMAC2: %02x:%02x:%02x:%02x:%02x:%02x\n", p[10], p[11], p[12],
	p[13], p[14], p[15]);
    YPRINTF("\tMAC3: %02x:%02x:%02x:%02x:%02x:%02x\n", p[16], p[17], p[18],
	p[19], p[20], p[21]);
}

#if 0
static inline void y_print_stack(unsigned long *p, int len)
{
    int i;
    YPRINTF("Printing stack from %p!", p);

    for (i=0; i <= len; i++)
    {
	if (!(i%16))
	   YPRINTF("\n%p: ", &p[i]);
	YPRINTF("%x ", (unsigned int)p[i]);
    }
}

static inline void y_print_char(unsigned char *p, int len, int mod)
{
    int i;
    YPRINTF("Printing from %p %d bytes", p, len);

    for (i=0; i <= len; i++)
    {
	if (!(i%mod))
	   YPRINTF("\n%p: ", &p[i]);
	YPRINTF("%x ", p[i]);
    }
    YPRINTF("\n");
}
#endif

#ifdef __cplusplus
}
#endif
#endif
