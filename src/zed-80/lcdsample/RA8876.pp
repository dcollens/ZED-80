# 1 "RA8876.c"
# 1 "<built-in>" 1
# 1 "<built-in>" 3
# 361 "<built-in>" 3
# 1 "<command line>" 1
# 1 "<built-in>" 2
# 1 "RA8876.c" 2
# 15 "RA8876.c"
# 1 "./STC12C5A.h" 1
# 22 "./STC12C5A.h"
sfr PSW = 0xd0;



sbit CY = PSW^7;
sbit AC = PSW^6;
sbit F0 = PSW^5;
sbit RS1 = PSW^4;
sbit RS0 = PSW^3;
sbit OV = PSW^2;
sbit P = PSW^0;



sfr ACC = 0xe0;


sbit ACC7 = ACC^7;
sbit ACC6 = ACC^6;
sbit ACC5 = ACC^5;
sbit ACC4 = ACC^4;
sbit ACC3 = ACC^3;
sbit ACC2 = ACC^2;
sbit ACC1 = ACC^1;
sbit ACC0 = ACC^0;



sfr B = 0xf0;




sfr SP = 0x81;




sfr DPL = 0x82;




sfr DPH = 0x83;




sfr PCON = 0x87;
# 85 "./STC12C5A.h"
sfr WAKE_CLKO = 0x8f;
# 100 "./STC12C5A.h"
sfr CLK_DIV = 0x97;
# 115 "./STC12C5A.h"
sfr BUS_SPEED = 0xa1;
# 128 "./STC12C5A.h"
sfr WDT_CONTR = 0xc1;
# 139 "./STC12C5A.h"
sfr AUXR = 0x8e;
# 154 "./STC12C5A.h"
sfr AUXR1 = 0xa2;
# 167 "./STC12C5A.h"
sfr P0 = 0x80;



sbit P07 = P0^7;
sbit P06 = P0^6;
sbit P05 = P0^5;
sbit P04 = P0^4;
sbit P03 = P0^3;
sbit P02 = P0^2;
sbit P01 = P0^1;
sbit P00 = P0^0;



sfr P1 = 0x90;



sbit P17 = P1^7;
sbit P16 = P1^6;
sbit P15 = P1^5;
sbit P14 = P1^4;
sbit P13 = P1^3;
sbit P12 = P1^2;
sbit P11 = P1^1;
sbit P10 = P1^0;

sbit ADCIN7 = P1^7;
sbit ADCIN6 = P1^6;
sbit ADCIN5 = P1^5;
sbit ADCIN4 = P1^4;
sbit ADCIN3 = P1^3;
sbit ADCIN2 = P1^2;
sbit ADCIN1 = P1^1;
sbit ADCIN0 = P1^0;

sbit SPISCLK = P1^7;
sbit SPIMISO = P1^6;
sbit SPIMOSI = P1^5;
sbit SPISS = P1^4;

sbit CEX1 = P1^4;
sbit CEX0 = P1^3;
sbit ECI = P1^2;

sbit TXD2 = P1^3;
sbit RXD2 = P1^2;

sbit BRTCLKO = P1^0;



sfr P2 = 0xa0;



sbit P27 = P2^7;
sbit P26 = P2^6;
sbit P25 = P2^5;
sbit P24 = P2^4;
sbit P23 = P2^3;
sbit P22 = P2^2;
sbit P21 = P2^1;
sbit P20 = P2^0;



sfr P3 = 0xb0;



sbit P37 = P3^7;
sbit P36 = P3^6;
sbit P35 = P3^5;
sbit P34 = P3^4;
sbit P33 = P3^3;
sbit P32 = P3^2;
sbit P31 = P3^1;
sbit P30 = P3^0;

sbit RXD = P3^0;
sbit TXD = P3^1;
sbit INT0 = P3^2;
sbit INT1 = P3^3;
sbit T0 = P3^4;
sbit T1 = P3^5;
sbit WR = P3^6;
sbit RD = P3^7;

sbit T0CLKO = P3^4;
sbit T1CLKO = P3^5;



sfr P4 = 0xc0;



sbit P47 = P4^7;
sbit P46 = P4^6;
sbit P45 = P4^5;
sbit P44 = P4^4;
sbit P43 = P4^3;
sbit P42 = P4^2;
sbit P41 = P4^1;
sbit P40 = P4^0;

sbit RST = P4^7;
sbit EX_LVD = P4^6;

sbit P4SPISCLK = P4^3;
sbit P4SPIMISO = P4^2;
sbit P4SPIMOSI = P4^1;
sbit P4SPISS = P4^0;

sbit P4CEX1 = P4^3;
sbit P4CEX0 = P4^2;
sbit P4ECI = P4^1;

sbit P4TXD2 = P4^3;
sbit P4RXD2 = P4^2;



sfr P5 = 0xc8;



sbit P53 = P5^3;
sbit P52 = P5^2;
sbit P51 = P5^1;
sbit P50 = P5^0;



sfr P1M1 = 0x91;




sfr P1M0 = 0x92;




sfr P0M1 = 0x93;




sfr P0M0 = 0x94;




sfr P2M1 = 0x95;




sfr P2M0 = 0x96;




sfr P3M1 = 0xb1;




sfr P3M0 = 0xb2;




sfr P4M1 = 0xb3;




sfr P4M0 = 0xb4;




sfr P5M1 = 0xc9;




sfr P5M0 = 0xca;
# 371 "./STC12C5A.h"
sfr P1ASF = 0x9d;
# 386 "./STC12C5A.h"
sfr P4SW = 0xbb;
# 396 "./STC12C5A.h"
sfr IE = 0xa8;



sbit EA = IE^7;
sbit ELVD = IE^6;
sbit EADC = IE^5;
sbit ES = IE^4;
sbit ET1 = IE^3;
sbit EX1 = IE^2;
sbit ET0 = IE^1;
sbit EX0 = IE^0;



sfr IE2 = 0xaf;
# 432 "./STC12C5A.h"
sfr IP2 = 0xb5;
# 441 "./STC12C5A.h"
sfr IP2H = 0xb6;
# 450 "./STC12C5A.h"
sfr IPH = 0xb7;
# 465 "./STC12C5A.h"
sfr IP = 0xb8;



sbit PPCA = IP^7;
sbit PLVD = IP^6;
sbit PADC = IP^5;
sbit PS = IP^4;
sbit PT1 = IP^3;
sbit PX1 = IP^2;
sbit PT0 = IP^1;
sbit PX0 = IP^0;



sfr TCON = 0x88;



sbit TF1 = TCON^7;
sbit TR1 = TCON^6;
sbit TF0 = TCON^5;
sbit TR0 = TCON^4;
sbit IE1 = TCON^3;
sbit IT1 = TCON^2;
sbit IE0 = TCON^1;
sbit IT0 = TCON^0;



sfr TMOD = 0x89;
# 514 "./STC12C5A.h"
sfr TL0 = 0x8a;




sfr TL1 = 0x8b;




sfr TH0 = 0x8c;




sfr TH1 = 0x8d;




sfr SCON = 0x98;



sbit FE = SCON^7;
sbit SM0 = SCON^7;
sbit SM1 = SCON^6;
sbit SM2 = SCON^5;
sbit REN = SCON^4;
sbit TB8 = SCON^3;
sbit RB8 = SCON^2;
sbit TI = SCON^1;
sbit RI = SCON^0;



sfr SBUF = 0x99;




sfr S2CON = 0x9a;
# 570 "./STC12C5A.h"
sfr S2BUF = 0x9b;




sfr SADDR = 0xa9;




sfr SADEN = 0xb9;




sfr BRT = 0x9c;




sfr ADC_CONTR = 0xbc;
# 607 "./STC12C5A.h"
sfr ADC_RES = 0xbd;




sfr ADC_RESL = 0xbe;




sfr IAP_DATA = 0xc2;




sfr IAP_ADDRH = 0xc3;




sfr IAP_ADDRL = 0xc4;




sfr IAP_CMD = 0xc5;
# 642 "./STC12C5A.h"
sfr IAP_TRIG = 0xc6;







sfr IAP_CONTR = 0xc7;
# 661 "./STC12C5A.h"
sfr SPSTAT = 0xcd;
# 670 "./STC12C5A.h"
sfr SPCTL = 0xce;
# 687 "./STC12C5A.h"
sfr SPDAT = 0xcf;




sfr CCON = 0xd8;



sbit CF = CCON^7;
sbit CR = CCON^6;
sbit CCF1 = CCON^1;
sbit CCF0 = CCON^0;



sfr CMOD = 0xd9;
# 720 "./STC12C5A.h"
sfr CCAPM0 = 0xda;
# 734 "./STC12C5A.h"
sfr CCAPM1 = 0xdb;
# 762 "./STC12C5A.h"
sfr CL = 0xe9;




sfr CH = 0xf9;




sfr CCAP0L = 0xea;




sfr CCAP1L = 0xeb;




sfr CCAP0H = 0xfa;




sfr CCAP1H = 0xfb;




sfr PCA_PWM0 = 0xf2;





sfr PCA_PWM1 = 0xf3;
# 16 "RA8876.c" 2
# 1 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/math.h" 1 3 4
# 30 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/math.h" 3 4
# 1 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/sys/cdefs.h" 1 3 4
# 608 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/sys/cdefs.h" 3 4
# 1 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/sys/_symbol_aliasing.h" 1 3 4
# 609 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/sys/cdefs.h" 2 3 4
# 674 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/sys/cdefs.h" 3 4
# 1 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/sys/_posix_availability.h" 1 3 4
# 675 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/sys/cdefs.h" 2 3 4
# 31 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/math.h" 2 3 4
# 1 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/Availability.h" 1 3 4
# 236 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/Availability.h" 3 4
# 1 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/AvailabilityInternal.h" 1 3 4
# 237 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/Availability.h" 2 3 4
# 32 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/math.h" 2 3 4
# 44 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/math.h" 3 4
    typedef float float_t;
    typedef double double_t;
# 111 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/math.h" 3 4
extern int __math_errhandling(void);
# 131 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/math.h" 3 4
extern int __fpclassifyf(float);
extern int __fpclassifyd(double);
extern int __fpclassifyl(long double);
# 174 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/math.h" 3 4
inline __attribute__ ((__always_inline__)) int __inline_isfinitef(float);
inline __attribute__ ((__always_inline__)) int __inline_isfinited(double);
inline __attribute__ ((__always_inline__)) int __inline_isfinitel(long double);
inline __attribute__ ((__always_inline__)) int __inline_isinff(float);
inline __attribute__ ((__always_inline__)) int __inline_isinfd(double);
inline __attribute__ ((__always_inline__)) int __inline_isinfl(long double);
inline __attribute__ ((__always_inline__)) int __inline_isnanf(float);
inline __attribute__ ((__always_inline__)) int __inline_isnand(double);
inline __attribute__ ((__always_inline__)) int __inline_isnanl(long double);
inline __attribute__ ((__always_inline__)) int __inline_isnormalf(float);
inline __attribute__ ((__always_inline__)) int __inline_isnormald(double);
inline __attribute__ ((__always_inline__)) int __inline_isnormall(long double);
inline __attribute__ ((__always_inline__)) int __inline_signbitf(float);
inline __attribute__ ((__always_inline__)) int __inline_signbitd(double);
inline __attribute__ ((__always_inline__)) int __inline_signbitl(long double);

inline __attribute__ ((__always_inline__)) int __inline_isfinitef(float __x) {
    return __x == __x && __builtin_fabsf(__x) != __builtin_inff();
}
inline __attribute__ ((__always_inline__)) int __inline_isfinited(double __x) {
    return __x == __x && __builtin_fabs(__x) != __builtin_inf();
}
inline __attribute__ ((__always_inline__)) int __inline_isfinitel(long double __x) {
    return __x == __x && __builtin_fabsl(__x) != __builtin_infl();
}
inline __attribute__ ((__always_inline__)) int __inline_isinff(float __x) {
    return __builtin_fabsf(__x) == __builtin_inff();
}
inline __attribute__ ((__always_inline__)) int __inline_isinfd(double __x) {
    return __builtin_fabs(__x) == __builtin_inf();
}
inline __attribute__ ((__always_inline__)) int __inline_isinfl(long double __x) {
    return __builtin_fabsl(__x) == __builtin_infl();
}
inline __attribute__ ((__always_inline__)) int __inline_isnanf(float __x) {
    return __x != __x;
}
inline __attribute__ ((__always_inline__)) int __inline_isnand(double __x) {
    return __x != __x;
}
inline __attribute__ ((__always_inline__)) int __inline_isnanl(long double __x) {
    return __x != __x;
}
inline __attribute__ ((__always_inline__)) int __inline_signbitf(float __x) {
    union { float __f; unsigned int __u; } __u;
    __u.__f = __x;
    return (int)(__u.__u >> 31);
}
inline __attribute__ ((__always_inline__)) int __inline_signbitd(double __x) {
    union { double __f; unsigned long long __u; } __u;
    __u.__f = __x;
    return (int)(__u.__u >> 63);
}

inline __attribute__ ((__always_inline__)) int __inline_signbitl(long double __x) {
    union {
        long double __ld;
        struct{ unsigned long long __m; unsigned short __sexp; } __p;
    } __u;
    __u.__ld = __x;
    return (int)(__u.__p.__sexp >> 15);
}







inline __attribute__ ((__always_inline__)) int __inline_isnormalf(float __x) {
    return __inline_isfinitef(__x) && __builtin_fabsf(__x) >= 1.17549435e-38F;
}
inline __attribute__ ((__always_inline__)) int __inline_isnormald(double __x) {
    return __inline_isfinited(__x) && __builtin_fabs(__x) >= 2.2250738585072014e-308;
}
inline __attribute__ ((__always_inline__)) int __inline_isnormall(long double __x) {
    return __inline_isfinitel(__x) && __builtin_fabsl(__x) >= 3.36210314311209350626e-4932L;
}
# 308 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/math.h" 3 4
extern float acosf(float);
extern double acos(double);
extern long double acosl(long double);

extern float asinf(float);
extern double asin(double);
extern long double asinl(long double);

extern float atanf(float);
extern double atan(double);
extern long double atanl(long double);

extern float atan2f(float, float);
extern double atan2(double, double);
extern long double atan2l(long double, long double);

extern float cosf(float);
extern double cos(double);
extern long double cosl(long double);

extern float sinf(float);
extern double sin(double);
extern long double sinl(long double);

extern float tanf(float);
extern double tan(double);
extern long double tanl(long double);

extern float acoshf(float);
extern double acosh(double);
extern long double acoshl(long double);

extern float asinhf(float);
extern double asinh(double);
extern long double asinhl(long double);

extern float atanhf(float);
extern double atanh(double);
extern long double atanhl(long double);

extern float coshf(float);
extern double cosh(double);
extern long double coshl(long double);

extern float sinhf(float);
extern double sinh(double);
extern long double sinhl(long double);

extern float tanhf(float);
extern double tanh(double);
extern long double tanhl(long double);

extern float expf(float);
extern double exp(double);
extern long double expl(long double);

extern float exp2f(float);
extern double exp2(double);
extern long double exp2l(long double);

extern float expm1f(float);
extern double expm1(double);
extern long double expm1l(long double);

extern float logf(float);
extern double log(double);
extern long double logl(long double);

extern float log10f(float);
extern double log10(double);
extern long double log10l(long double);

extern float log2f(float);
extern double log2(double);
extern long double log2l(long double);

extern float log1pf(float);
extern double log1p(double);
extern long double log1pl(long double);

extern float logbf(float);
extern double logb(double);
extern long double logbl(long double);

extern float modff(float, float *);
extern double modf(double, double *);
extern long double modfl(long double, long double *);

extern float ldexpf(float, int);
extern double ldexp(double, int);
extern long double ldexpl(long double, int);

extern float frexpf(float, int *);
extern double frexp(double, int *);
extern long double frexpl(long double, int *);

extern int ilogbf(float);
extern int ilogb(double);
extern int ilogbl(long double);

extern float scalbnf(float, int);
extern double scalbn(double, int);
extern long double scalbnl(long double, int);

extern float scalblnf(float, long int);
extern double scalbln(double, long int);
extern long double scalblnl(long double, long int);

extern float fabsf(float);
extern double fabs(double);
extern long double fabsl(long double);

extern float cbrtf(float);
extern double cbrt(double);
extern long double cbrtl(long double);

extern float hypotf(float, float);
extern double hypot(double, double);
extern long double hypotl(long double, long double);

extern float powf(float, float);
extern double pow(double, double);
extern long double powl(long double, long double);

extern float sqrtf(float);
extern double sqrt(double);
extern long double sqrtl(long double);

extern float erff(float);
extern double erf(double);
extern long double erfl(long double);

extern float erfcf(float);
extern double erfc(double);
extern long double erfcl(long double);




extern float lgammaf(float);
extern double lgamma(double);
extern long double lgammal(long double);

extern float tgammaf(float);
extern double tgamma(double);
extern long double tgammal(long double);

extern float ceilf(float);
extern double ceil(double);
extern long double ceill(long double);

extern float floorf(float);
extern double floor(double);
extern long double floorl(long double);

extern float nearbyintf(float);
extern double nearbyint(double);
extern long double nearbyintl(long double);

extern float rintf(float);
extern double rint(double);
extern long double rintl(long double);

extern long int lrintf(float);
extern long int lrint(double);
extern long int lrintl(long double);

extern float roundf(float);
extern double round(double);
extern long double roundl(long double);

extern long int lroundf(float);
extern long int lround(double);
extern long int lroundl(long double);




extern long long int llrintf(float);
extern long long int llrint(double);
extern long long int llrintl(long double);

extern long long int llroundf(float);
extern long long int llround(double);
extern long long int llroundl(long double);


extern float truncf(float);
extern double trunc(double);
extern long double truncl(long double);

extern float fmodf(float, float);
extern double fmod(double, double);
extern long double fmodl(long double, long double);

extern float remainderf(float, float);
extern double remainder(double, double);
extern long double remainderl(long double, long double);

extern float remquof(float, float, int *);
extern double remquo(double, double, int *);
extern long double remquol(long double, long double, int *);

extern float copysignf(float, float);
extern double copysign(double, double);
extern long double copysignl(long double, long double);

extern float nanf(const char *);
extern double nan(const char *);
extern long double nanl(const char *);

extern float nextafterf(float, float);
extern double nextafter(double, double);
extern long double nextafterl(long double, long double);

extern double nexttoward(double, long double);
extern float nexttowardf(float, long double);
extern long double nexttowardl(long double, long double);

extern float fdimf(float, float);
extern double fdim(double, double);
extern long double fdiml(long double, long double);

extern float fmaxf(float, float);
extern double fmax(double, double);
extern long double fmaxl(long double, long double);

extern float fminf(float, float);
extern double fmin(double, double);
extern long double fminl(long double, long double);

extern float fmaf(float, float, float);
extern double fma(double, double, double);
extern long double fmal(long double, long double, long double);
# 551 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/math.h" 3 4
extern float __inff(void)
__attribute__((availability(macos,introduced=10.0,deprecated=10.9,message="use `(float)INFINITY` instead"))) __attribute__((availability(ios,unavailable))) __attribute__((availability(watchos,unavailable))) __attribute__((availability(tvos,unavailable)));
extern double __inf(void)
__attribute__((availability(macos,introduced=10.0,deprecated=10.9,message="use `INFINITY` instead"))) __attribute__((availability(ios,unavailable))) __attribute__((availability(watchos,unavailable))) __attribute__((availability(tvos,unavailable)));
extern long double __infl(void)
__attribute__((availability(macos,introduced=10.0,deprecated=10.9,message="use `(long double)INFINITY` instead"))) __attribute__((availability(ios,unavailable))) __attribute__((availability(watchos,unavailable))) __attribute__((availability(tvos,unavailable)));
extern float __nan(void)
__attribute__((availability(macos,introduced=10.0,deprecated=10.14,message="use `NAN` instead"))) __attribute__((availability(ios,unavailable))) __attribute__((availability(watchos,unavailable))) __attribute__((availability(tvos,unavailable)));
# 586 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/math.h" 3 4
extern float __exp10f(float) __attribute__((availability(macos,introduced=10.9))) __attribute__((availability(ios,introduced=7.0)));
extern double __exp10(double) __attribute__((availability(macos,introduced=10.9))) __attribute__((availability(ios,introduced=7.0)));





inline __attribute__ ((__always_inline__)) void __sincosf(float __x, float *__sinp, float *__cosp);
inline __attribute__ ((__always_inline__)) void __sincos(double __x, double *__sinp, double *__cosp);
# 603 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/math.h" 3 4
extern float __cospif(float) __attribute__((availability(macos,introduced=10.9))) __attribute__((availability(ios,introduced=7.0)));
extern double __cospi(double) __attribute__((availability(macos,introduced=10.9))) __attribute__((availability(ios,introduced=7.0)));
extern float __sinpif(float) __attribute__((availability(macos,introduced=10.9))) __attribute__((availability(ios,introduced=7.0)));
extern double __sinpi(double) __attribute__((availability(macos,introduced=10.9))) __attribute__((availability(ios,introduced=7.0)));
extern float __tanpif(float) __attribute__((availability(macos,introduced=10.9))) __attribute__((availability(ios,introduced=7.0)));
extern double __tanpi(double) __attribute__((availability(macos,introduced=10.9))) __attribute__((availability(ios,introduced=7.0)));
# 634 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/math.h" 3 4
inline __attribute__ ((__always_inline__)) void __sincospif(float __x, float *__sinp, float *__cosp);
inline __attribute__ ((__always_inline__)) void __sincospi(double __x, double *__sinp, double *__cosp);






struct __float2 { float __sinval; float __cosval; };
struct __double2 { double __sinval; double __cosval; };

extern struct __float2 __sincosf_stret(float);
extern struct __double2 __sincos_stret(double);
extern struct __float2 __sincospif_stret(float);
extern struct __double2 __sincospi_stret(double);

inline __attribute__ ((__always_inline__)) void __sincosf(float __x, float *__sinp, float *__cosp) {
    const struct __float2 __stret = __sincosf_stret(__x);
    *__sinp = __stret.__sinval; *__cosp = __stret.__cosval;
}

inline __attribute__ ((__always_inline__)) void __sincos(double __x, double *__sinp, double *__cosp) {
    const struct __double2 __stret = __sincos_stret(__x);
    *__sinp = __stret.__sinval; *__cosp = __stret.__cosval;
}

inline __attribute__ ((__always_inline__)) void __sincospif(float __x, float *__sinp, float *__cosp) {
    const struct __float2 __stret = __sincospif_stret(__x);
    *__sinp = __stret.__sinval; *__cosp = __stret.__cosval;
}

inline __attribute__ ((__always_inline__)) void __sincospi(double __x, double *__sinp, double *__cosp) {
    const struct __double2 __stret = __sincospi_stret(__x);
    *__sinp = __stret.__sinval; *__cosp = __stret.__cosval;
}







extern double j0(double) __attribute__((availability(macos,introduced=10.0))) __attribute__((availability(ios,introduced=3.2)));
extern double j1(double) __attribute__((availability(macos,introduced=10.0))) __attribute__((availability(ios,introduced=3.2)));
extern double jn(int, double) __attribute__((availability(macos,introduced=10.0))) __attribute__((availability(ios,introduced=3.2)));
extern double y0(double) __attribute__((availability(macos,introduced=10.0))) __attribute__((availability(ios,introduced=3.2)));
extern double y1(double) __attribute__((availability(macos,introduced=10.0))) __attribute__((availability(ios,introduced=3.2)));
extern double yn(int, double) __attribute__((availability(macos,introduced=10.0))) __attribute__((availability(ios,introduced=3.2)));
extern double scalb(double, double);
extern int signgam;
# 740 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/math.h" 3 4
extern long int rinttol(double)
__attribute__((availability(macos,introduced=10.0,deprecated=10.9,replacement="lrint"))) __attribute__((availability(ios,unavailable))) __attribute__((availability(watchos,unavailable))) __attribute__((availability(tvos,unavailable)));

extern long int roundtol(double)
__attribute__((availability(macos,introduced=10.0,deprecated=10.9,replacement="lround"))) __attribute__((availability(ios,unavailable))) __attribute__((availability(watchos,unavailable))) __attribute__((availability(tvos,unavailable)));

extern double drem(double, double)
__attribute__((availability(macos,introduced=10.0,deprecated=10.9,replacement="remainder"))) __attribute__((availability(ios,unavailable))) __attribute__((availability(watchos,unavailable))) __attribute__((availability(tvos,unavailable)));

extern int finite(double)
__attribute__((availability(macos,introduced=10.0,deprecated=10.9,message="Use `isfinite((double)x)` instead."))) __attribute__((availability(ios,unavailable))) __attribute__((availability(watchos,unavailable))) __attribute__((availability(tvos,unavailable)));

extern double gamma(double)
__attribute__((availability(macos,introduced=10.0,deprecated=10.9,replacement="tgamma"))) __attribute__((availability(ios,unavailable))) __attribute__((availability(watchos,unavailable))) __attribute__((availability(tvos,unavailable)));

extern double significand(double)
__attribute__((availability(macos,introduced=10.0,deprecated=10.9,message="Use `2*frexp( )` or `scalbn(x, -ilogb(x))` instead."))) __attribute__((availability(ios,unavailable))) __attribute__((availability(watchos,unavailable))) __attribute__((availability(tvos,unavailable)));


struct exception {
    int type;
    char *name;
    double arg1;
    double arg2;
    double retval;
};
# 17 "RA8876.c" 2
# 1 "./stdio.h" 1
# 22 "./stdio.h"
 typedef unsigned int size_t;


#pragma SAVE
#pragma REGPARMS
extern char _getkey (void);
extern char getchar (void);
extern char ungetchar (char);
extern char putchar (char);
extern int printf (const char *, ...);
extern int sprintf (char *, const char *, ...);
extern int vprintf (const char *, char *);
extern int vsprintf (char *, const char *, char *);
extern char *gets (char *, int n);
extern int scanf (const char *, ...);
extern int sscanf (char *, const char *, ...);
extern int puts (const char *);

#pragma RESTORE
# 18 "RA8876.c" 2
# 1 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/stdlib.h" 1 3 4
# 64 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/stdlib.h" 3 4
# 1 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/_types.h" 1 3 4
# 27 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/_types.h" 3 4
# 1 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/sys/_types.h" 1 3 4
# 33 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/sys/_types.h" 3 4
# 1 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/machine/_types.h" 1 3 4
# 32 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/machine/_types.h" 3 4
# 1 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/i386/_types.h" 1 3 4
# 37 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/i386/_types.h" 3 4
typedef signed char __int8_t;



typedef unsigned char __uint8_t;
typedef short __int16_t;
typedef unsigned short __uint16_t;
typedef int __int32_t;
typedef unsigned int __uint32_t;
typedef long long __int64_t;
typedef unsigned long long __uint64_t;

typedef long __darwin_intptr_t;
typedef unsigned int __darwin_natural_t;
# 70 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/i386/_types.h" 3 4
typedef int __darwin_ct_rune_t;





typedef union {
 char __mbstate8[128];
 long long _mbstateL;
} __mbstate_t;

typedef __mbstate_t __darwin_mbstate_t;


typedef long int __darwin_ptrdiff_t;







typedef long unsigned int __darwin_size_t;





typedef __builtin_va_list __darwin_va_list;





typedef int __darwin_wchar_t;




typedef __darwin_wchar_t __darwin_rune_t;


typedef int __darwin_wint_t;




typedef unsigned long __darwin_clock_t;
typedef __uint32_t __darwin_socklen_t;
typedef long __darwin_ssize_t;
typedef long __darwin_time_t;
# 33 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/machine/_types.h" 2 3 4
# 34 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/sys/_types.h" 2 3 4
# 55 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/sys/_types.h" 3 4
typedef __int64_t __darwin_blkcnt_t;
typedef __int32_t __darwin_blksize_t;
typedef __int32_t __darwin_dev_t;
typedef unsigned int __darwin_fsblkcnt_t;
typedef unsigned int __darwin_fsfilcnt_t;
typedef __uint32_t __darwin_gid_t;
typedef __uint32_t __darwin_id_t;
typedef __uint64_t __darwin_ino64_t;

typedef __darwin_ino64_t __darwin_ino_t;



typedef __darwin_natural_t __darwin_mach_port_name_t;
typedef __darwin_mach_port_name_t __darwin_mach_port_t;
typedef __uint16_t __darwin_mode_t;
typedef __int64_t __darwin_off_t;
typedef __int32_t __darwin_pid_t;
typedef __uint32_t __darwin_sigset_t;
typedef __int32_t __darwin_suseconds_t;
typedef __uint32_t __darwin_uid_t;
typedef __uint32_t __darwin_useconds_t;
typedef unsigned char __darwin_uuid_t[16];
typedef char __darwin_uuid_string_t[37];


# 1 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/sys/_pthread/_pthread_types.h" 1 3 4
# 57 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/sys/_pthread/_pthread_types.h" 3 4
struct __darwin_pthread_handler_rec {
 void (*__routine)(void *);
 void *__arg;
 struct __darwin_pthread_handler_rec *__next;
};

struct _opaque_pthread_attr_t {
 long __sig;
 char __opaque[56];
};

struct _opaque_pthread_cond_t {
 long __sig;
 char __opaque[40];
};

struct _opaque_pthread_condattr_t {
 long __sig;
 char __opaque[8];
};

struct _opaque_pthread_mutex_t {
 long __sig;
 char __opaque[56];
};

struct _opaque_pthread_mutexattr_t {
 long __sig;
 char __opaque[8];
};

struct _opaque_pthread_once_t {
 long __sig;
 char __opaque[8];
};

struct _opaque_pthread_rwlock_t {
 long __sig;
 char __opaque[192];
};

struct _opaque_pthread_rwlockattr_t {
 long __sig;
 char __opaque[16];
};

struct _opaque_pthread_t {
 long __sig;
 struct __darwin_pthread_handler_rec *__cleanup_stack;
 char __opaque[8176];
};

typedef struct _opaque_pthread_attr_t __darwin_pthread_attr_t;
typedef struct _opaque_pthread_cond_t __darwin_pthread_cond_t;
typedef struct _opaque_pthread_condattr_t __darwin_pthread_condattr_t;
typedef unsigned long __darwin_pthread_key_t;
typedef struct _opaque_pthread_mutex_t __darwin_pthread_mutex_t;
typedef struct _opaque_pthread_mutexattr_t __darwin_pthread_mutexattr_t;
typedef struct _opaque_pthread_once_t __darwin_pthread_once_t;
typedef struct _opaque_pthread_rwlock_t __darwin_pthread_rwlock_t;
typedef struct _opaque_pthread_rwlockattr_t __darwin_pthread_rwlockattr_t;
typedef struct _opaque_pthread_t *__darwin_pthread_t;
# 81 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/sys/_types.h" 2 3 4
# 28 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/_types.h" 2 3 4
# 40 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/_types.h" 3 4
typedef int __darwin_nl_item;
typedef int __darwin_wctrans_t;

typedef __uint32_t __darwin_wctype_t;
# 65 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/stdlib.h" 2 3 4

# 1 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/sys/wait.h" 1 3 4
# 79 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/sys/wait.h" 3 4
typedef enum {
 P_ALL,
 P_PID,
 P_PGID
} idtype_t;






# 1 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_pid_t.h" 1 3 4
# 31 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_pid_t.h" 3 4
typedef __darwin_pid_t pid_t;
# 90 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/sys/wait.h" 2 3 4
# 1 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_id_t.h" 1 3 4
# 31 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_id_t.h" 3 4
typedef __darwin_id_t id_t;
# 91 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/sys/wait.h" 2 3 4
# 109 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/sys/wait.h" 3 4
# 1 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/sys/signal.h" 1 3 4
# 73 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/sys/signal.h" 3 4
# 1 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/sys/appleapiopts.h" 1 3 4
# 74 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/sys/signal.h" 2 3 4








# 1 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/machine/signal.h" 1 3 4
# 32 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/machine/signal.h" 3 4
# 1 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/i386/signal.h" 1 3 4
# 39 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/i386/signal.h" 3 4
typedef int sig_atomic_t;
# 33 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/machine/signal.h" 2 3 4
# 83 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/sys/signal.h" 2 3 4
# 146 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/sys/signal.h" 3 4
# 1 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/machine/_mcontext.h" 1 3 4
# 29 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/machine/_mcontext.h" 3 4
# 1 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/i386/_mcontext.h" 1 3 4
# 34 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/i386/_mcontext.h" 3 4
# 1 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/mach/machine/_structs.h" 1 3 4
# 33 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/mach/machine/_structs.h" 3 4
# 1 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/mach/i386/_structs.h" 1 3 4
# 36 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/mach/i386/_structs.h" 3 4
# 1 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/machine/types.h" 1 3 4
# 35 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/machine/types.h" 3 4
# 1 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/i386/types.h" 1 3 4
# 76 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/i386/types.h" 3 4
# 1 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_int8_t.h" 1 3 4
# 30 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_int8_t.h" 3 4
typedef signed char int8_t;
# 77 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/i386/types.h" 2 3 4
# 1 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_int16_t.h" 1 3 4
# 30 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_int16_t.h" 3 4
typedef short int16_t;
# 78 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/i386/types.h" 2 3 4
# 1 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_int32_t.h" 1 3 4
# 30 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_int32_t.h" 3 4
typedef int int32_t;
# 79 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/i386/types.h" 2 3 4
# 1 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_int64_t.h" 1 3 4
# 30 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_int64_t.h" 3 4
typedef long long int64_t;
# 80 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/i386/types.h" 2 3 4

# 1 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_u_int8_t.h" 1 3 4
# 30 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_u_int8_t.h" 3 4
typedef unsigned char u_int8_t;
# 82 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/i386/types.h" 2 3 4
# 1 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_u_int16_t.h" 1 3 4
# 30 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_u_int16_t.h" 3 4
typedef unsigned short u_int16_t;
# 83 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/i386/types.h" 2 3 4
# 1 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_u_int32_t.h" 1 3 4
# 30 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_u_int32_t.h" 3 4
typedef unsigned int u_int32_t;
# 84 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/i386/types.h" 2 3 4
# 1 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_u_int64_t.h" 1 3 4
# 30 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_u_int64_t.h" 3 4
typedef unsigned long long u_int64_t;
# 85 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/i386/types.h" 2 3 4


typedef int64_t register_t;





# 1 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_intptr_t.h" 1 3 4
# 30 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_intptr_t.h" 3 4
# 1 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/machine/types.h" 1 3 4
# 31 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_intptr_t.h" 2 3 4

typedef __darwin_intptr_t intptr_t;
# 93 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/i386/types.h" 2 3 4
# 1 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_uintptr_t.h" 1 3 4
# 30 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_uintptr_t.h" 3 4
typedef unsigned long uintptr_t;
# 94 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/i386/types.h" 2 3 4



typedef u_int64_t user_addr_t;
typedef u_int64_t user_size_t;
typedef int64_t user_ssize_t;
typedef int64_t user_long_t;
typedef u_int64_t user_ulong_t;
typedef int64_t user_time_t;
typedef int64_t user_off_t;







typedef u_int64_t syscall_arg_t;
# 36 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/machine/types.h" 2 3 4
# 37 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/mach/i386/_structs.h" 2 3 4
# 46 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/mach/i386/_structs.h" 3 4
struct __darwin_i386_thread_state
{
    unsigned int __eax;
    unsigned int __ebx;
    unsigned int __ecx;
    unsigned int __edx;
    unsigned int __edi;
    unsigned int __esi;
    unsigned int __ebp;
    unsigned int __esp;
    unsigned int __ss;
    unsigned int __eflags;
    unsigned int __eip;
    unsigned int __cs;
    unsigned int __ds;
    unsigned int __es;
    unsigned int __fs;
    unsigned int __gs;
};
# 92 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/mach/i386/_structs.h" 3 4
struct __darwin_fp_control
{
    unsigned short __invalid :1,
        __denorm :1,
    __zdiv :1,
    __ovrfl :1,
    __undfl :1,
    __precis :1,
      :2,
    __pc :2,





    __rc :2,






             :1,
      :3;
};
typedef struct __darwin_fp_control __darwin_fp_control_t;
# 150 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/mach/i386/_structs.h" 3 4
struct __darwin_fp_status
{
    unsigned short __invalid :1,
        __denorm :1,
    __zdiv :1,
    __ovrfl :1,
    __undfl :1,
    __precis :1,
    __stkflt :1,
    __errsumm :1,
    __c0 :1,
    __c1 :1,
    __c2 :1,
    __tos :3,
    __c3 :1,
    __busy :1;
};
typedef struct __darwin_fp_status __darwin_fp_status_t;
# 194 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/mach/i386/_structs.h" 3 4
struct __darwin_mmst_reg
{
 char __mmst_reg[10];
 char __mmst_rsrv[6];
};
# 213 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/mach/i386/_structs.h" 3 4
struct __darwin_xmm_reg
{
 char __xmm_reg[16];
};
# 229 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/mach/i386/_structs.h" 3 4
struct __darwin_ymm_reg
{
 char __ymm_reg[32];
};
# 245 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/mach/i386/_structs.h" 3 4
struct __darwin_zmm_reg
{
 char __zmm_reg[64];
};
# 259 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/mach/i386/_structs.h" 3 4
struct __darwin_opmask_reg
{
 char __opmask_reg[8];
};
# 281 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/mach/i386/_structs.h" 3 4
struct __darwin_i386_float_state
{
 int __fpu_reserved[2];
 struct __darwin_fp_control __fpu_fcw;
 struct __darwin_fp_status __fpu_fsw;
 __uint8_t __fpu_ftw;
 __uint8_t __fpu_rsrv1;
 __uint16_t __fpu_fop;
 __uint32_t __fpu_ip;
 __uint16_t __fpu_cs;
 __uint16_t __fpu_rsrv2;
 __uint32_t __fpu_dp;
 __uint16_t __fpu_ds;
 __uint16_t __fpu_rsrv3;
 __uint32_t __fpu_mxcsr;
 __uint32_t __fpu_mxcsrmask;
 struct __darwin_mmst_reg __fpu_stmm0;
 struct __darwin_mmst_reg __fpu_stmm1;
 struct __darwin_mmst_reg __fpu_stmm2;
 struct __darwin_mmst_reg __fpu_stmm3;
 struct __darwin_mmst_reg __fpu_stmm4;
 struct __darwin_mmst_reg __fpu_stmm5;
 struct __darwin_mmst_reg __fpu_stmm6;
 struct __darwin_mmst_reg __fpu_stmm7;
 struct __darwin_xmm_reg __fpu_xmm0;
 struct __darwin_xmm_reg __fpu_xmm1;
 struct __darwin_xmm_reg __fpu_xmm2;
 struct __darwin_xmm_reg __fpu_xmm3;
 struct __darwin_xmm_reg __fpu_xmm4;
 struct __darwin_xmm_reg __fpu_xmm5;
 struct __darwin_xmm_reg __fpu_xmm6;
 struct __darwin_xmm_reg __fpu_xmm7;
 char __fpu_rsrv4[14*16];
 int __fpu_reserved1;
};


struct __darwin_i386_avx_state
{
 int __fpu_reserved[2];
 struct __darwin_fp_control __fpu_fcw;
 struct __darwin_fp_status __fpu_fsw;
 __uint8_t __fpu_ftw;
 __uint8_t __fpu_rsrv1;
 __uint16_t __fpu_fop;
 __uint32_t __fpu_ip;
 __uint16_t __fpu_cs;
 __uint16_t __fpu_rsrv2;
 __uint32_t __fpu_dp;
 __uint16_t __fpu_ds;
 __uint16_t __fpu_rsrv3;
 __uint32_t __fpu_mxcsr;
 __uint32_t __fpu_mxcsrmask;
 struct __darwin_mmst_reg __fpu_stmm0;
 struct __darwin_mmst_reg __fpu_stmm1;
 struct __darwin_mmst_reg __fpu_stmm2;
 struct __darwin_mmst_reg __fpu_stmm3;
 struct __darwin_mmst_reg __fpu_stmm4;
 struct __darwin_mmst_reg __fpu_stmm5;
 struct __darwin_mmst_reg __fpu_stmm6;
 struct __darwin_mmst_reg __fpu_stmm7;
 struct __darwin_xmm_reg __fpu_xmm0;
 struct __darwin_xmm_reg __fpu_xmm1;
 struct __darwin_xmm_reg __fpu_xmm2;
 struct __darwin_xmm_reg __fpu_xmm3;
 struct __darwin_xmm_reg __fpu_xmm4;
 struct __darwin_xmm_reg __fpu_xmm5;
 struct __darwin_xmm_reg __fpu_xmm6;
 struct __darwin_xmm_reg __fpu_xmm7;
 char __fpu_rsrv4[14*16];
 int __fpu_reserved1;
 char __avx_reserved1[64];
 struct __darwin_xmm_reg __fpu_ymmh0;
 struct __darwin_xmm_reg __fpu_ymmh1;
 struct __darwin_xmm_reg __fpu_ymmh2;
 struct __darwin_xmm_reg __fpu_ymmh3;
 struct __darwin_xmm_reg __fpu_ymmh4;
 struct __darwin_xmm_reg __fpu_ymmh5;
 struct __darwin_xmm_reg __fpu_ymmh6;
 struct __darwin_xmm_reg __fpu_ymmh7;
};


struct __darwin_i386_avx512_state
{
 int __fpu_reserved[2];
 struct __darwin_fp_control __fpu_fcw;
 struct __darwin_fp_status __fpu_fsw;
 __uint8_t __fpu_ftw;
 __uint8_t __fpu_rsrv1;
 __uint16_t __fpu_fop;
 __uint32_t __fpu_ip;
 __uint16_t __fpu_cs;
 __uint16_t __fpu_rsrv2;
 __uint32_t __fpu_dp;
 __uint16_t __fpu_ds;
 __uint16_t __fpu_rsrv3;
 __uint32_t __fpu_mxcsr;
 __uint32_t __fpu_mxcsrmask;
 struct __darwin_mmst_reg __fpu_stmm0;
 struct __darwin_mmst_reg __fpu_stmm1;
 struct __darwin_mmst_reg __fpu_stmm2;
 struct __darwin_mmst_reg __fpu_stmm3;
 struct __darwin_mmst_reg __fpu_stmm4;
 struct __darwin_mmst_reg __fpu_stmm5;
 struct __darwin_mmst_reg __fpu_stmm6;
 struct __darwin_mmst_reg __fpu_stmm7;
 struct __darwin_xmm_reg __fpu_xmm0;
 struct __darwin_xmm_reg __fpu_xmm1;
 struct __darwin_xmm_reg __fpu_xmm2;
 struct __darwin_xmm_reg __fpu_xmm3;
 struct __darwin_xmm_reg __fpu_xmm4;
 struct __darwin_xmm_reg __fpu_xmm5;
 struct __darwin_xmm_reg __fpu_xmm6;
 struct __darwin_xmm_reg __fpu_xmm7;
 char __fpu_rsrv4[14*16];
 int __fpu_reserved1;
 char __avx_reserved1[64];
 struct __darwin_xmm_reg __fpu_ymmh0;
 struct __darwin_xmm_reg __fpu_ymmh1;
 struct __darwin_xmm_reg __fpu_ymmh2;
 struct __darwin_xmm_reg __fpu_ymmh3;
 struct __darwin_xmm_reg __fpu_ymmh4;
 struct __darwin_xmm_reg __fpu_ymmh5;
 struct __darwin_xmm_reg __fpu_ymmh6;
 struct __darwin_xmm_reg __fpu_ymmh7;
 struct __darwin_opmask_reg __fpu_k0;
 struct __darwin_opmask_reg __fpu_k1;
 struct __darwin_opmask_reg __fpu_k2;
 struct __darwin_opmask_reg __fpu_k3;
 struct __darwin_opmask_reg __fpu_k4;
 struct __darwin_opmask_reg __fpu_k5;
 struct __darwin_opmask_reg __fpu_k6;
 struct __darwin_opmask_reg __fpu_k7;
 struct __darwin_ymm_reg __fpu_zmmh0;
 struct __darwin_ymm_reg __fpu_zmmh1;
 struct __darwin_ymm_reg __fpu_zmmh2;
 struct __darwin_ymm_reg __fpu_zmmh3;
 struct __darwin_ymm_reg __fpu_zmmh4;
 struct __darwin_ymm_reg __fpu_zmmh5;
 struct __darwin_ymm_reg __fpu_zmmh6;
 struct __darwin_ymm_reg __fpu_zmmh7;
};
# 575 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/mach/i386/_structs.h" 3 4
struct __darwin_i386_exception_state
{
 __uint16_t __trapno;
 __uint16_t __cpu;
 __uint32_t __err;
 __uint32_t __faultvaddr;
};
# 595 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/mach/i386/_structs.h" 3 4
struct __darwin_x86_debug_state32
{
 unsigned int __dr0;
 unsigned int __dr1;
 unsigned int __dr2;
 unsigned int __dr3;
 unsigned int __dr4;
 unsigned int __dr5;
 unsigned int __dr6;
 unsigned int __dr7;
};
# 627 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/mach/i386/_structs.h" 3 4
struct __darwin_x86_thread_state64
{
 __uint64_t __rax;
 __uint64_t __rbx;
 __uint64_t __rcx;
 __uint64_t __rdx;
 __uint64_t __rdi;
 __uint64_t __rsi;
 __uint64_t __rbp;
 __uint64_t __rsp;
 __uint64_t __r8;
 __uint64_t __r9;
 __uint64_t __r10;
 __uint64_t __r11;
 __uint64_t __r12;
 __uint64_t __r13;
 __uint64_t __r14;
 __uint64_t __r15;
 __uint64_t __rip;
 __uint64_t __rflags;
 __uint64_t __cs;
 __uint64_t __fs;
 __uint64_t __gs;
};
# 685 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/mach/i386/_structs.h" 3 4
struct __darwin_x86_thread_full_state64
{
 struct __darwin_x86_thread_state64 ss64;
 __uint64_t __ds;
 __uint64_t __es;
 __uint64_t __ss;
};
# 706 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/mach/i386/_structs.h" 3 4
struct __darwin_x86_float_state64
{
 int __fpu_reserved[2];
 struct __darwin_fp_control __fpu_fcw;
 struct __darwin_fp_status __fpu_fsw;
 __uint8_t __fpu_ftw;
 __uint8_t __fpu_rsrv1;
 __uint16_t __fpu_fop;


 __uint32_t __fpu_ip;
 __uint16_t __fpu_cs;

 __uint16_t __fpu_rsrv2;


 __uint32_t __fpu_dp;
 __uint16_t __fpu_ds;

 __uint16_t __fpu_rsrv3;
 __uint32_t __fpu_mxcsr;
 __uint32_t __fpu_mxcsrmask;
 struct __darwin_mmst_reg __fpu_stmm0;
 struct __darwin_mmst_reg __fpu_stmm1;
 struct __darwin_mmst_reg __fpu_stmm2;
 struct __darwin_mmst_reg __fpu_stmm3;
 struct __darwin_mmst_reg __fpu_stmm4;
 struct __darwin_mmst_reg __fpu_stmm5;
 struct __darwin_mmst_reg __fpu_stmm6;
 struct __darwin_mmst_reg __fpu_stmm7;
 struct __darwin_xmm_reg __fpu_xmm0;
 struct __darwin_xmm_reg __fpu_xmm1;
 struct __darwin_xmm_reg __fpu_xmm2;
 struct __darwin_xmm_reg __fpu_xmm3;
 struct __darwin_xmm_reg __fpu_xmm4;
 struct __darwin_xmm_reg __fpu_xmm5;
 struct __darwin_xmm_reg __fpu_xmm6;
 struct __darwin_xmm_reg __fpu_xmm7;
 struct __darwin_xmm_reg __fpu_xmm8;
 struct __darwin_xmm_reg __fpu_xmm9;
 struct __darwin_xmm_reg __fpu_xmm10;
 struct __darwin_xmm_reg __fpu_xmm11;
 struct __darwin_xmm_reg __fpu_xmm12;
 struct __darwin_xmm_reg __fpu_xmm13;
 struct __darwin_xmm_reg __fpu_xmm14;
 struct __darwin_xmm_reg __fpu_xmm15;
 char __fpu_rsrv4[6*16];
 int __fpu_reserved1;
};


struct __darwin_x86_avx_state64
{
 int __fpu_reserved[2];
 struct __darwin_fp_control __fpu_fcw;
 struct __darwin_fp_status __fpu_fsw;
 __uint8_t __fpu_ftw;
 __uint8_t __fpu_rsrv1;
 __uint16_t __fpu_fop;


 __uint32_t __fpu_ip;
 __uint16_t __fpu_cs;

 __uint16_t __fpu_rsrv2;


 __uint32_t __fpu_dp;
 __uint16_t __fpu_ds;

 __uint16_t __fpu_rsrv3;
 __uint32_t __fpu_mxcsr;
 __uint32_t __fpu_mxcsrmask;
 struct __darwin_mmst_reg __fpu_stmm0;
 struct __darwin_mmst_reg __fpu_stmm1;
 struct __darwin_mmst_reg __fpu_stmm2;
 struct __darwin_mmst_reg __fpu_stmm3;
 struct __darwin_mmst_reg __fpu_stmm4;
 struct __darwin_mmst_reg __fpu_stmm5;
 struct __darwin_mmst_reg __fpu_stmm6;
 struct __darwin_mmst_reg __fpu_stmm7;
 struct __darwin_xmm_reg __fpu_xmm0;
 struct __darwin_xmm_reg __fpu_xmm1;
 struct __darwin_xmm_reg __fpu_xmm2;
 struct __darwin_xmm_reg __fpu_xmm3;
 struct __darwin_xmm_reg __fpu_xmm4;
 struct __darwin_xmm_reg __fpu_xmm5;
 struct __darwin_xmm_reg __fpu_xmm6;
 struct __darwin_xmm_reg __fpu_xmm7;
 struct __darwin_xmm_reg __fpu_xmm8;
 struct __darwin_xmm_reg __fpu_xmm9;
 struct __darwin_xmm_reg __fpu_xmm10;
 struct __darwin_xmm_reg __fpu_xmm11;
 struct __darwin_xmm_reg __fpu_xmm12;
 struct __darwin_xmm_reg __fpu_xmm13;
 struct __darwin_xmm_reg __fpu_xmm14;
 struct __darwin_xmm_reg __fpu_xmm15;
 char __fpu_rsrv4[6*16];
 int __fpu_reserved1;
 char __avx_reserved1[64];
 struct __darwin_xmm_reg __fpu_ymmh0;
 struct __darwin_xmm_reg __fpu_ymmh1;
 struct __darwin_xmm_reg __fpu_ymmh2;
 struct __darwin_xmm_reg __fpu_ymmh3;
 struct __darwin_xmm_reg __fpu_ymmh4;
 struct __darwin_xmm_reg __fpu_ymmh5;
 struct __darwin_xmm_reg __fpu_ymmh6;
 struct __darwin_xmm_reg __fpu_ymmh7;
 struct __darwin_xmm_reg __fpu_ymmh8;
 struct __darwin_xmm_reg __fpu_ymmh9;
 struct __darwin_xmm_reg __fpu_ymmh10;
 struct __darwin_xmm_reg __fpu_ymmh11;
 struct __darwin_xmm_reg __fpu_ymmh12;
 struct __darwin_xmm_reg __fpu_ymmh13;
 struct __darwin_xmm_reg __fpu_ymmh14;
 struct __darwin_xmm_reg __fpu_ymmh15;
};


struct __darwin_x86_avx512_state64
{
 int __fpu_reserved[2];
 struct __darwin_fp_control __fpu_fcw;
 struct __darwin_fp_status __fpu_fsw;
 __uint8_t __fpu_ftw;
 __uint8_t __fpu_rsrv1;
 __uint16_t __fpu_fop;


 __uint32_t __fpu_ip;
 __uint16_t __fpu_cs;

 __uint16_t __fpu_rsrv2;


 __uint32_t __fpu_dp;
 __uint16_t __fpu_ds;

 __uint16_t __fpu_rsrv3;
 __uint32_t __fpu_mxcsr;
 __uint32_t __fpu_mxcsrmask;
 struct __darwin_mmst_reg __fpu_stmm0;
 struct __darwin_mmst_reg __fpu_stmm1;
 struct __darwin_mmst_reg __fpu_stmm2;
 struct __darwin_mmst_reg __fpu_stmm3;
 struct __darwin_mmst_reg __fpu_stmm4;
 struct __darwin_mmst_reg __fpu_stmm5;
 struct __darwin_mmst_reg __fpu_stmm6;
 struct __darwin_mmst_reg __fpu_stmm7;
 struct __darwin_xmm_reg __fpu_xmm0;
 struct __darwin_xmm_reg __fpu_xmm1;
 struct __darwin_xmm_reg __fpu_xmm2;
 struct __darwin_xmm_reg __fpu_xmm3;
 struct __darwin_xmm_reg __fpu_xmm4;
 struct __darwin_xmm_reg __fpu_xmm5;
 struct __darwin_xmm_reg __fpu_xmm6;
 struct __darwin_xmm_reg __fpu_xmm7;
 struct __darwin_xmm_reg __fpu_xmm8;
 struct __darwin_xmm_reg __fpu_xmm9;
 struct __darwin_xmm_reg __fpu_xmm10;
 struct __darwin_xmm_reg __fpu_xmm11;
 struct __darwin_xmm_reg __fpu_xmm12;
 struct __darwin_xmm_reg __fpu_xmm13;
 struct __darwin_xmm_reg __fpu_xmm14;
 struct __darwin_xmm_reg __fpu_xmm15;
 char __fpu_rsrv4[6*16];
 int __fpu_reserved1;
 char __avx_reserved1[64];
 struct __darwin_xmm_reg __fpu_ymmh0;
 struct __darwin_xmm_reg __fpu_ymmh1;
 struct __darwin_xmm_reg __fpu_ymmh2;
 struct __darwin_xmm_reg __fpu_ymmh3;
 struct __darwin_xmm_reg __fpu_ymmh4;
 struct __darwin_xmm_reg __fpu_ymmh5;
 struct __darwin_xmm_reg __fpu_ymmh6;
 struct __darwin_xmm_reg __fpu_ymmh7;
 struct __darwin_xmm_reg __fpu_ymmh8;
 struct __darwin_xmm_reg __fpu_ymmh9;
 struct __darwin_xmm_reg __fpu_ymmh10;
 struct __darwin_xmm_reg __fpu_ymmh11;
 struct __darwin_xmm_reg __fpu_ymmh12;
 struct __darwin_xmm_reg __fpu_ymmh13;
 struct __darwin_xmm_reg __fpu_ymmh14;
 struct __darwin_xmm_reg __fpu_ymmh15;
 struct __darwin_opmask_reg __fpu_k0;
 struct __darwin_opmask_reg __fpu_k1;
 struct __darwin_opmask_reg __fpu_k2;
 struct __darwin_opmask_reg __fpu_k3;
 struct __darwin_opmask_reg __fpu_k4;
 struct __darwin_opmask_reg __fpu_k5;
 struct __darwin_opmask_reg __fpu_k6;
 struct __darwin_opmask_reg __fpu_k7;
 struct __darwin_ymm_reg __fpu_zmmh0;
 struct __darwin_ymm_reg __fpu_zmmh1;
 struct __darwin_ymm_reg __fpu_zmmh2;
 struct __darwin_ymm_reg __fpu_zmmh3;
 struct __darwin_ymm_reg __fpu_zmmh4;
 struct __darwin_ymm_reg __fpu_zmmh5;
 struct __darwin_ymm_reg __fpu_zmmh6;
 struct __darwin_ymm_reg __fpu_zmmh7;
 struct __darwin_ymm_reg __fpu_zmmh8;
 struct __darwin_ymm_reg __fpu_zmmh9;
 struct __darwin_ymm_reg __fpu_zmmh10;
 struct __darwin_ymm_reg __fpu_zmmh11;
 struct __darwin_ymm_reg __fpu_zmmh12;
 struct __darwin_ymm_reg __fpu_zmmh13;
 struct __darwin_ymm_reg __fpu_zmmh14;
 struct __darwin_ymm_reg __fpu_zmmh15;
 struct __darwin_zmm_reg __fpu_zmm16;
 struct __darwin_zmm_reg __fpu_zmm17;
 struct __darwin_zmm_reg __fpu_zmm18;
 struct __darwin_zmm_reg __fpu_zmm19;
 struct __darwin_zmm_reg __fpu_zmm20;
 struct __darwin_zmm_reg __fpu_zmm21;
 struct __darwin_zmm_reg __fpu_zmm22;
 struct __darwin_zmm_reg __fpu_zmm23;
 struct __darwin_zmm_reg __fpu_zmm24;
 struct __darwin_zmm_reg __fpu_zmm25;
 struct __darwin_zmm_reg __fpu_zmm26;
 struct __darwin_zmm_reg __fpu_zmm27;
 struct __darwin_zmm_reg __fpu_zmm28;
 struct __darwin_zmm_reg __fpu_zmm29;
 struct __darwin_zmm_reg __fpu_zmm30;
 struct __darwin_zmm_reg __fpu_zmm31;
};
# 1164 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/mach/i386/_structs.h" 3 4
struct __darwin_x86_exception_state64
{
    __uint16_t __trapno;
    __uint16_t __cpu;
    __uint32_t __err;
    __uint64_t __faultvaddr;
};
# 1184 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/mach/i386/_structs.h" 3 4
struct __darwin_x86_debug_state64
{
 __uint64_t __dr0;
 __uint64_t __dr1;
 __uint64_t __dr2;
 __uint64_t __dr3;
 __uint64_t __dr4;
 __uint64_t __dr5;
 __uint64_t __dr6;
 __uint64_t __dr7;
};
# 1212 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/mach/i386/_structs.h" 3 4
struct __darwin_x86_cpmu_state64
{
 __uint64_t __ctrs[16];
};
# 34 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/mach/machine/_structs.h" 2 3 4
# 35 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/i386/_mcontext.h" 2 3 4




struct __darwin_mcontext32
{
 struct __darwin_i386_exception_state __es;
 struct __darwin_i386_thread_state __ss;
 struct __darwin_i386_float_state __fs;
};


struct __darwin_mcontext_avx32
{
 struct __darwin_i386_exception_state __es;
 struct __darwin_i386_thread_state __ss;
 struct __darwin_i386_avx_state __fs;
};



struct __darwin_mcontext_avx512_32
{
 struct __darwin_i386_exception_state __es;
 struct __darwin_i386_thread_state __ss;
 struct __darwin_i386_avx512_state __fs;
};
# 97 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/i386/_mcontext.h" 3 4
struct __darwin_mcontext64
{
 struct __darwin_x86_exception_state64 __es;
 struct __darwin_x86_thread_state64 __ss;
 struct __darwin_x86_float_state64 __fs;
};


struct __darwin_mcontext_avx64
{
 struct __darwin_x86_exception_state64 __es;
 struct __darwin_x86_thread_state64 __ss;
 struct __darwin_x86_avx_state64 __fs;
};



struct __darwin_mcontext_avx512_64
{
 struct __darwin_x86_exception_state64 __es;
 struct __darwin_x86_thread_state64 __ss;
 struct __darwin_x86_avx512_state64 __fs;
};
# 156 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/i386/_mcontext.h" 3 4
typedef struct __darwin_mcontext64 *mcontext_t;
# 30 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/machine/_mcontext.h" 2 3 4
# 147 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/sys/signal.h" 2 3 4

# 1 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/sys/_pthread/_pthread_attr_t.h" 1 3 4
# 31 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/sys/_pthread/_pthread_attr_t.h" 3 4
typedef __darwin_pthread_attr_t pthread_attr_t;
# 149 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/sys/signal.h" 2 3 4

# 1 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_sigaltstack.h" 1 3 4
# 42 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_sigaltstack.h" 3 4
struct __darwin_sigaltstack
{
 void *ss_sp;
 __darwin_size_t ss_size;
 int ss_flags;
};
typedef struct __darwin_sigaltstack stack_t;
# 151 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/sys/signal.h" 2 3 4
# 1 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_ucontext.h" 1 3 4
# 39 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_ucontext.h" 3 4
# 1 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/machine/_mcontext.h" 1 3 4
# 40 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_ucontext.h" 2 3 4


struct __darwin_ucontext
{
 int uc_onstack;
 __darwin_sigset_t uc_sigmask;
 struct __darwin_sigaltstack uc_stack;
 struct __darwin_ucontext *uc_link;
 __darwin_size_t uc_mcsize;
 struct __darwin_mcontext64 *uc_mcontext;



};


typedef struct __darwin_ucontext ucontext_t;
# 152 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/sys/signal.h" 2 3 4


# 1 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_sigset_t.h" 1 3 4
# 31 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_sigset_t.h" 3 4
typedef __darwin_sigset_t sigset_t;
# 155 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/sys/signal.h" 2 3 4
# 1 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_size_t.h" 1 3 4
# 156 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/sys/signal.h" 2 3 4
# 1 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_uid_t.h" 1 3 4
# 31 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_uid_t.h" 3 4
typedef __darwin_uid_t uid_t;
# 157 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/sys/signal.h" 2 3 4

union sigval {

 int sival_int;
 void *sival_ptr;
};





struct sigevent {
 int sigev_notify;
 int sigev_signo;
 union sigval sigev_value;
 void (*sigev_notify_function)(union sigval);
 pthread_attr_t *sigev_notify_attributes;
};


typedef struct __siginfo {
 int si_signo;
 int si_errno;
 int si_code;
 pid_t si_pid;
 uid_t si_uid;
 int si_status;
 void *si_addr;
 union sigval si_value;
 long si_band;
 unsigned long __pad[7];
} siginfo_t;
# 269 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/sys/signal.h" 3 4
union __sigaction_u {
 void (*__sa_handler)(int);
 void (*__sa_sigaction)(int, struct __siginfo *,
     void *);
};


struct __sigaction {
 union __sigaction_u __sigaction_u;
 void (*sa_tramp)(void *, int, int, siginfo_t *, void *);
 sigset_t sa_mask;
 int sa_flags;
};




struct sigaction {
 union __sigaction_u __sigaction_u;
 sigset_t sa_mask;
 int sa_flags;
};
# 331 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/sys/signal.h" 3 4
typedef void (*sig_t)(int);
# 348 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/sys/signal.h" 3 4
struct sigvec {
 void (*sv_handler)(int);
 int sv_mask;
 int sv_flags;
};
# 367 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/sys/signal.h" 3 4
struct sigstack {
 char *ss_sp;
 int ss_onstack;
};
# 390 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/sys/signal.h" 3 4
    void(*signal(int, void (*)(int)))(int);
# 110 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/sys/wait.h" 2 3 4
# 1 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/sys/resource.h" 1 3 4
# 72 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/sys/resource.h" 3 4
# 1 "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/clang/10.0.1/include/stdint.h" 1 3 4
# 63 "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/clang/10.0.1/include/stdint.h" 3 4
# 1 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/stdint.h" 1 3 4
# 23 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/stdint.h" 3 4
# 1 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/_types/_uint8_t.h" 1 3 4
# 31 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/_types/_uint8_t.h" 3 4
typedef unsigned char uint8_t;
# 24 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/stdint.h" 2 3 4
# 1 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/_types/_uint16_t.h" 1 3 4
# 31 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/_types/_uint16_t.h" 3 4
typedef unsigned short uint16_t;
# 25 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/stdint.h" 2 3 4
# 1 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/_types/_uint32_t.h" 1 3 4
# 31 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/_types/_uint32_t.h" 3 4
typedef unsigned int uint32_t;
# 26 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/stdint.h" 2 3 4
# 1 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/_types/_uint64_t.h" 1 3 4
# 31 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/_types/_uint64_t.h" 3 4
typedef unsigned long long uint64_t;
# 27 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/stdint.h" 2 3 4


typedef int8_t int_least8_t;
typedef int16_t int_least16_t;
typedef int32_t int_least32_t;
typedef int64_t int_least64_t;
typedef uint8_t uint_least8_t;
typedef uint16_t uint_least16_t;
typedef uint32_t uint_least32_t;
typedef uint64_t uint_least64_t;



typedef int8_t int_fast8_t;
typedef int16_t int_fast16_t;
typedef int32_t int_fast32_t;
typedef int64_t int_fast64_t;
typedef uint8_t uint_fast8_t;
typedef uint16_t uint_fast16_t;
typedef uint32_t uint_fast32_t;
typedef uint64_t uint_fast64_t;
# 58 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/stdint.h" 3 4
# 1 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/_types/_intmax_t.h" 1 3 4
# 32 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/_types/_intmax_t.h" 3 4
typedef long int intmax_t;
# 59 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/stdint.h" 2 3 4
# 1 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/_types/_uintmax_t.h" 1 3 4
# 32 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/_types/_uintmax_t.h" 3 4
typedef long unsigned int uintmax_t;
# 60 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/stdint.h" 2 3 4
# 64 "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/clang/10.0.1/include/stdint.h" 2 3 4
# 73 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/sys/resource.h" 2 3 4







# 1 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_timeval.h" 1 3 4
# 34 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_timeval.h" 3 4
struct timeval
{
 __darwin_time_t tv_sec;
 __darwin_suseconds_t tv_usec;
};
# 81 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/sys/resource.h" 2 3 4








typedef __uint64_t rlim_t;
# 152 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/sys/resource.h" 3 4
struct rusage {
 struct timeval ru_utime;
 struct timeval ru_stime;
# 163 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/sys/resource.h" 3 4
 long ru_maxrss;

 long ru_ixrss;
 long ru_idrss;
 long ru_isrss;
 long ru_minflt;
 long ru_majflt;
 long ru_nswap;
 long ru_inblock;
 long ru_oublock;
 long ru_msgsnd;
 long ru_msgrcv;
 long ru_nsignals;
 long ru_nvcsw;
 long ru_nivcsw;


};
# 193 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/sys/resource.h" 3 4
typedef void *rusage_info_t;

struct rusage_info_v0 {
 uint8_t ri_uuid[16];
 uint64_t ri_user_time;
 uint64_t ri_system_time;
 uint64_t ri_pkg_idle_wkups;
 uint64_t ri_interrupt_wkups;
 uint64_t ri_pageins;
 uint64_t ri_wired_size;
 uint64_t ri_resident_size;
 uint64_t ri_phys_footprint;
 uint64_t ri_proc_start_abstime;
 uint64_t ri_proc_exit_abstime;
};

struct rusage_info_v1 {
 uint8_t ri_uuid[16];
 uint64_t ri_user_time;
 uint64_t ri_system_time;
 uint64_t ri_pkg_idle_wkups;
 uint64_t ri_interrupt_wkups;
 uint64_t ri_pageins;
 uint64_t ri_wired_size;
 uint64_t ri_resident_size;
 uint64_t ri_phys_footprint;
 uint64_t ri_proc_start_abstime;
 uint64_t ri_proc_exit_abstime;
 uint64_t ri_child_user_time;
 uint64_t ri_child_system_time;
 uint64_t ri_child_pkg_idle_wkups;
 uint64_t ri_child_interrupt_wkups;
 uint64_t ri_child_pageins;
 uint64_t ri_child_elapsed_abstime;
};

struct rusage_info_v2 {
 uint8_t ri_uuid[16];
 uint64_t ri_user_time;
 uint64_t ri_system_time;
 uint64_t ri_pkg_idle_wkups;
 uint64_t ri_interrupt_wkups;
 uint64_t ri_pageins;
 uint64_t ri_wired_size;
 uint64_t ri_resident_size;
 uint64_t ri_phys_footprint;
 uint64_t ri_proc_start_abstime;
 uint64_t ri_proc_exit_abstime;
 uint64_t ri_child_user_time;
 uint64_t ri_child_system_time;
 uint64_t ri_child_pkg_idle_wkups;
 uint64_t ri_child_interrupt_wkups;
 uint64_t ri_child_pageins;
 uint64_t ri_child_elapsed_abstime;
 uint64_t ri_diskio_bytesread;
 uint64_t ri_diskio_byteswritten;
};

struct rusage_info_v3 {
 uint8_t ri_uuid[16];
 uint64_t ri_user_time;
 uint64_t ri_system_time;
 uint64_t ri_pkg_idle_wkups;
 uint64_t ri_interrupt_wkups;
 uint64_t ri_pageins;
 uint64_t ri_wired_size;
 uint64_t ri_resident_size;
 uint64_t ri_phys_footprint;
 uint64_t ri_proc_start_abstime;
 uint64_t ri_proc_exit_abstime;
 uint64_t ri_child_user_time;
 uint64_t ri_child_system_time;
 uint64_t ri_child_pkg_idle_wkups;
 uint64_t ri_child_interrupt_wkups;
 uint64_t ri_child_pageins;
 uint64_t ri_child_elapsed_abstime;
 uint64_t ri_diskio_bytesread;
 uint64_t ri_diskio_byteswritten;
 uint64_t ri_cpu_time_qos_default;
 uint64_t ri_cpu_time_qos_maintenance;
 uint64_t ri_cpu_time_qos_background;
 uint64_t ri_cpu_time_qos_utility;
 uint64_t ri_cpu_time_qos_legacy;
 uint64_t ri_cpu_time_qos_user_initiated;
 uint64_t ri_cpu_time_qos_user_interactive;
 uint64_t ri_billed_system_time;
 uint64_t ri_serviced_system_time;
};

struct rusage_info_v4 {
 uint8_t ri_uuid[16];
 uint64_t ri_user_time;
 uint64_t ri_system_time;
 uint64_t ri_pkg_idle_wkups;
 uint64_t ri_interrupt_wkups;
 uint64_t ri_pageins;
 uint64_t ri_wired_size;
 uint64_t ri_resident_size;
 uint64_t ri_phys_footprint;
 uint64_t ri_proc_start_abstime;
 uint64_t ri_proc_exit_abstime;
 uint64_t ri_child_user_time;
 uint64_t ri_child_system_time;
 uint64_t ri_child_pkg_idle_wkups;
 uint64_t ri_child_interrupt_wkups;
 uint64_t ri_child_pageins;
 uint64_t ri_child_elapsed_abstime;
 uint64_t ri_diskio_bytesread;
 uint64_t ri_diskio_byteswritten;
 uint64_t ri_cpu_time_qos_default;
 uint64_t ri_cpu_time_qos_maintenance;
 uint64_t ri_cpu_time_qos_background;
 uint64_t ri_cpu_time_qos_utility;
 uint64_t ri_cpu_time_qos_legacy;
 uint64_t ri_cpu_time_qos_user_initiated;
 uint64_t ri_cpu_time_qos_user_interactive;
 uint64_t ri_billed_system_time;
 uint64_t ri_serviced_system_time;
 uint64_t ri_logical_writes;
 uint64_t ri_lifetime_max_phys_footprint;
 uint64_t ri_instructions;
 uint64_t ri_cycles;
 uint64_t ri_billed_energy;
 uint64_t ri_serviced_energy;
 uint64_t ri_interval_max_phys_footprint;

 uint64_t ri_unused[1];
};

typedef struct rusage_info_v4 rusage_info_current;
# 366 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/sys/resource.h" 3 4
struct rlimit {
 rlim_t rlim_cur;
 rlim_t rlim_max;
};
# 401 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/sys/resource.h" 3 4
struct proc_rlimit_control_wakeupmon {
 uint32_t wm_flags;
 int32_t wm_rate;
};
# 437 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/sys/resource.h" 3 4
int getpriority(int, id_t);

int getiopolicy_np(int, int) __attribute__((availability(macosx,introduced=10.5)));

int getrlimit(int, struct rlimit *) __asm("_" "getrlimit" );
int getrusage(int, struct rusage *);
int setpriority(int, id_t, int);

int setiopolicy_np(int, int, int) __attribute__((availability(macosx,introduced=10.5)));

int setrlimit(int, const struct rlimit *) __asm("_" "setrlimit" );
# 111 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/sys/wait.h" 2 3 4
# 186 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/sys/wait.h" 3 4
# 1 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/machine/endian.h" 1 3 4
# 35 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/machine/endian.h" 3 4
# 1 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/i386/endian.h" 1 3 4
# 99 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/i386/endian.h" 3 4
# 1 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/sys/_endian.h" 1 3 4
# 130 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/sys/_endian.h" 3 4
# 1 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/libkern/_OSByteOrder.h" 1 3 4
# 66 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/libkern/_OSByteOrder.h" 3 4
# 1 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/libkern/i386/_OSByteOrder.h" 1 3 4
# 44 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/libkern/i386/_OSByteOrder.h" 3 4
static inline
__uint16_t
_OSSwapInt16(
 __uint16_t _data
 )
{
 return (__uint16_t)((_data << 8) | (_data >> 8));
}

static inline
__uint32_t
_OSSwapInt32(
 __uint32_t _data
 )
{

 return __builtin_bswap32(_data);




}


static inline
__uint64_t
_OSSwapInt64(
 __uint64_t _data
 )
{
 return __builtin_bswap64(_data);
}
# 67 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/libkern/_OSByteOrder.h" 2 3 4
# 131 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/sys/_endian.h" 2 3 4
# 100 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/i386/endian.h" 2 3 4
# 36 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/machine/endian.h" 2 3 4
# 187 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/sys/wait.h" 2 3 4







union wait {
 int w_status;



 struct {

  unsigned int w_Termsig:7,
      w_Coredump:1,
      w_Retcode:8,
      w_Filler:16;







 } w_T;





 struct {

  unsigned int w_Stopval:8,
      w_Stopsig:8,
      w_Filler:16;






 } w_S;
};
# 248 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/sys/wait.h" 3 4
pid_t wait(int *) __asm("_" "wait" );
pid_t waitpid(pid_t, int *, int) __asm("_" "waitpid" );

int waitid(idtype_t, id_t, siginfo_t *, int) __asm("_" "waitid" );


pid_t wait3(int *, int, struct rusage *);
pid_t wait4(pid_t, int *, int, struct rusage *);
# 67 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/stdlib.h" 2 3 4

# 1 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/alloca.h" 1 3 4
# 29 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/alloca.h" 3 4
# 1 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_size_t.h" 1 3 4
# 30 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/alloca.h" 2 3 4


void *alloca(size_t);
# 69 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/stdlib.h" 2 3 4





# 1 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_size_t.h" 1 3 4
# 75 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/stdlib.h" 2 3 4


# 1 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_ct_rune_t.h" 1 3 4
# 32 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_ct_rune_t.h" 3 4
typedef __darwin_ct_rune_t ct_rune_t;
# 78 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/stdlib.h" 2 3 4
# 1 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_rune_t.h" 1 3 4
# 31 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_rune_t.h" 3 4
typedef __darwin_rune_t rune_t;
# 79 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/stdlib.h" 2 3 4


# 1 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_wchar_t.h" 1 3 4
# 34 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_wchar_t.h" 3 4
typedef __darwin_wchar_t wchar_t;
# 82 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/stdlib.h" 2 3 4

typedef struct {
 int quot;
 int rem;
} div_t;

typedef struct {
 long quot;
 long rem;
} ldiv_t;


typedef struct {
 long long quot;
 long long rem;
} lldiv_t;



# 1 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_null.h" 1 3 4
# 101 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/stdlib.h" 2 3 4
# 118 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/stdlib.h" 3 4
extern int __mb_cur_max;
# 128 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/stdlib.h" 3 4
# 1 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/malloc/_malloc.h" 1 3 4
# 36 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/malloc/_malloc.h" 3 4
# 1 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_size_t.h" 1 3 4
# 37 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/malloc/_malloc.h" 2 3 4



void *malloc(size_t __size) __attribute__((__warn_unused_result__)) __attribute__((alloc_size(1)));
void *calloc(size_t __count, size_t __size) __attribute__((__warn_unused_result__)) __attribute__((alloc_size(1,2)));
void free(void *);
void *realloc(void *__ptr, size_t __size) __attribute__((__warn_unused_result__)) __attribute__((alloc_size(2)));

void *valloc(size_t) __attribute__((alloc_size(1)));

int posix_memalign(void **__memptr, size_t __alignment, size_t __size) __attribute__((availability(macosx,introduced=10.6)));
# 129 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/stdlib.h" 2 3 4


void abort(void) __attribute__((noreturn));
int abs(int) __attribute__((const));
int atexit(void (* _Nonnull)(void));
double atof(const char *);
int atoi(const char *);
long atol(const char *);

long long
  atoll(const char *);

void *bsearch(const void *__key, const void *__base, size_t __nel,
     size_t __width, int (* _Nonnull __compar)(const void *, const void *));

div_t div(int, int) __attribute__((const));
void exit(int) __attribute__((noreturn));

char *getenv(const char *);
long labs(long) __attribute__((const));
ldiv_t ldiv(long, long) __attribute__((const));

long long
  llabs(long long);
lldiv_t lldiv(long long, long long);


int mblen(const char *__s, size_t __n);
size_t mbstowcs(wchar_t * restrict , const char * restrict, size_t);
int mbtowc(wchar_t * restrict, const char * restrict, size_t);

void qsort(void *__base, size_t __nel, size_t __width,
     int (* _Nonnull __compar)(const void *, const void *));
int rand(void) __attribute__((__availability__(swift, unavailable, message="Use arc4random instead.")));

void srand(unsigned) __attribute__((__availability__(swift, unavailable, message="Use arc4random instead.")));
double strtod(const char *, char **) __asm("_" "strtod" );
float strtof(const char *, char **) __asm("_" "strtof" );
long strtol(const char *__str, char **__endptr, int __base);
long double
  strtold(const char *, char **);

long long
  strtoll(const char *__str, char **__endptr, int __base);

unsigned long
  strtoul(const char *__str, char **__endptr, int __base);

unsigned long long
  strtoull(const char *__str, char **__endptr, int __base);
# 187 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/stdlib.h" 3 4
__attribute__((__availability__(swift, unavailable, message="Use posix_spawn APIs or NSTask instead.")))
__attribute__((availability(macos,introduced=10.0))) __attribute__((availability(ios,unavailable)))
__attribute__((availability(watchos,unavailable))) __attribute__((availability(tvos,unavailable)))
int system(const char *) __asm("_" "system" );



size_t wcstombs(char * restrict, const wchar_t * restrict, size_t);
int wctomb(char *, wchar_t);


void _Exit(int) __attribute__((noreturn));
long a64l(const char *);
double drand48(void);
char *ecvt(double, int, int *restrict, int *restrict);
double erand48(unsigned short[3]);
char *fcvt(double, int, int *restrict, int *restrict);
char *gcvt(double, int, char *);
int getsubopt(char **, char * const *, char **);
int grantpt(int);

char *initstate(unsigned, char *, size_t);



long jrand48(unsigned short[3]) __attribute__((__availability__(swift, unavailable, message="Use arc4random instead.")));
char *l64a(long);
void lcong48(unsigned short[7]);
long lrand48(void) __attribute__((__availability__(swift, unavailable, message="Use arc4random instead.")));
char *mktemp(char *);
int mkstemp(char *);
long mrand48(void) __attribute__((__availability__(swift, unavailable, message="Use arc4random instead.")));
long nrand48(unsigned short[3]) __attribute__((__availability__(swift, unavailable, message="Use arc4random instead.")));
int posix_openpt(int);
char *ptsname(int);


int ptsname_r(int fildes, char *buffer, size_t buflen) __attribute__((availability(macos,introduced=10.13.4))) __attribute__((availability(ios,introduced=11.3))) __attribute__((availability(tvos,introduced=11.3))) __attribute__((availability(watchos,introduced=4.3)));


int putenv(char *) __asm("_" "putenv" );
long random(void) __attribute__((__availability__(swift, unavailable, message="Use arc4random instead.")));
int rand_r(unsigned *) __attribute__((__availability__(swift, unavailable, message="Use arc4random instead.")));

char *realpath(const char * restrict, char * restrict) __asm("_" "realpath" "$DARWIN_EXTSN");



unsigned short
 *seed48(unsigned short[3]);
int setenv(const char * __name, const char * __value, int __overwrite) __asm("_" "setenv" );

void setkey(const char *) __asm("_" "setkey" );



char *setstate(const char *);
void srand48(long);

void srandom(unsigned);



int unlockpt(int);

int unsetenv(const char *) __asm("_" "unsetenv" );
# 261 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/stdlib.h" 3 4
# 1 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_dev_t.h" 1 3 4
# 31 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_dev_t.h" 3 4
typedef __darwin_dev_t dev_t;
# 262 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/stdlib.h" 2 3 4
# 1 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_mode_t.h" 1 3 4
# 31 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/sys/_types/_mode_t.h" 3 4
typedef __darwin_mode_t mode_t;
# 263 "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include/stdlib.h" 2 3 4


uint32_t arc4random(void);
void arc4random_addrandom(unsigned char * , int )
    __attribute__((availability(macosx,introduced=10.0))) __attribute__((availability(macosx,deprecated=10.12,message="use arc4random_stir")))
    __attribute__((availability(ios,introduced=2.0))) __attribute__((availability(ios,deprecated=10.0,message="use arc4random_stir")))
    __attribute__((availability(tvos,introduced=2.0))) __attribute__((availability(tvos,deprecated=10.0,message="use arc4random_stir")))
    __attribute__((availability(watchos,introduced=1.0))) __attribute__((availability(watchos,deprecated=3.0,message="use arc4random_stir")));
void arc4random_buf(void * __buf, size_t __nbytes) __attribute__((availability(macosx,introduced=10.7)));
void arc4random_stir(void);
uint32_t
  arc4random_uniform(uint32_t __upper_bound) __attribute__((availability(macosx,introduced=10.7)));

int atexit_b(void (^ _Nonnull)(void)) __attribute__((availability(macosx,introduced=10.6)));
void *bsearch_b(const void *__key, const void *__base, size_t __nel,
     size_t __width, int (^ _Nonnull __compar)(const void *, const void *)) __attribute__((availability(macosx,introduced=10.6)));



char *cgetcap(char *, const char *, int);
int cgetclose(void);
int cgetent(char **, char **, const char *);
int cgetfirst(char **, char **);
int cgetmatch(const char *, const char *);
int cgetnext(char **, char **);
int cgetnum(char *, const char *, long *);
int cgetset(const char *);
int cgetstr(char *, const char *, char **);
int cgetustr(char *, const char *, char **);

int daemon(int, int) __asm("_" "daemon" "$1050") __attribute__((availability(macosx,introduced=10.0,deprecated=10.5,message="Use posix_spawn APIs instead."))) __attribute__((availability(watchos,unavailable))) __attribute__((availability(tvos,unavailable)));
char *devname(dev_t, mode_t);
char *devname_r(dev_t, mode_t, char *buf, int len);
char *getbsize(int *, long *);
int getloadavg(double [], int);
const char
 *getprogname(void);

int heapsort(void *__base, size_t __nel, size_t __width,
     int (* _Nonnull __compar)(const void *, const void *));

int heapsort_b(void *__base, size_t __nel, size_t __width,
     int (^ _Nonnull __compar)(const void *, const void *)) __attribute__((availability(macosx,introduced=10.6)));

int mergesort(void *__base, size_t __nel, size_t __width,
     int (* _Nonnull __compar)(const void *, const void *));

int mergesort_b(void *__base, size_t __nel, size_t __width,
     int (^ _Nonnull __compar)(const void *, const void *)) __attribute__((availability(macosx,introduced=10.6)));

void psort(void *__base, size_t __nel, size_t __width,
     int (* _Nonnull __compar)(const void *, const void *)) __attribute__((availability(macosx,introduced=10.6)));

void psort_b(void *__base, size_t __nel, size_t __width,
     int (^ _Nonnull __compar)(const void *, const void *)) __attribute__((availability(macosx,introduced=10.6)));

void psort_r(void *__base, size_t __nel, size_t __width, void *,
     int (* _Nonnull __compar)(void *, const void *, const void *)) __attribute__((availability(macosx,introduced=10.6)));

void qsort_b(void *__base, size_t __nel, size_t __width,
     int (^ _Nonnull __compar)(const void *, const void *)) __attribute__((availability(macosx,introduced=10.6)));

void qsort_r(void *__base, size_t __nel, size_t __width, void *,
     int (* _Nonnull __compar)(void *, const void *, const void *));
int radixsort(const unsigned char **__base, int __nel, const unsigned char *__table,
     unsigned __endbyte);
void setprogname(const char *);
int sradixsort(const unsigned char **__base, int __nel, const unsigned char *__table,
     unsigned __endbyte);
void sranddev(void);
void srandomdev(void);
void *reallocf(void *__ptr, size_t __size) __attribute__((alloc_size(2)));

long long
  strtoq(const char *__str, char **__endptr, int __base);
unsigned long long
  strtouq(const char *__str, char **__endptr, int __base);

extern char *suboptarg;
# 19 "RA8876.c" 2
# 1 "./intrins.h" 1
# 12 "./intrins.h"
extern void _nop_ (void);
extern bit _testbit_ (bit);
extern unsigned char _cror_ (unsigned char, unsigned char);
extern unsigned int _iror_ (unsigned int, unsigned char);
extern unsigned long _lror_ (unsigned long, unsigned char);
extern unsigned char _crol_ (unsigned char, unsigned char);
extern unsigned int _irol_ (unsigned int, unsigned char);
extern unsigned long _lrol_ (unsigned long, unsigned char);
extern unsigned char _chkfloat_(float);
# 20 "RA8876.c" 2
# 1 "./RA8876.h" 1




sbit rs=P1^1;
sbit cs=P1^0;
sbit wr=P1^2;
sbit rd=P1^3;
sbit next =P3^5;
sbit c86 = P3^6;
sbit rst =P3^7;
# 196 "./RA8876.h"
  unsigned int code f3[1600];
 unsigned int code f2[1600];
 unsigned int code f1[1600];
 unsigned int code pattern16x16_16bpp[256];
unsigned int code ASCII_Table[];
 unsigned int code pic_80x80[];
unsigned char code gImage_no_im[256];
unsigned char code gImage_busy_im[256];
unsigned char code gImage_pen_il[256];
unsigned char code gImage_arrow_il[256];

void LCD_RegisterWrite(unsigned char Cmd,unsigned char Data);
unsigned char LCD_RegisterRead(unsigned char Cmd);


void RA8876_initial(void);

void RA8876_PLL_Initial(void);

void RA8876_SDRAM_initail(void);





void Check_Mem_WR_FIFO_not_Full(void);
void Check_Mem_WR_FIFO_Empty(void);
void Check_Mem_RD_FIFO_not_Full(void);
void Check_Mem_RD_FIFO_not_Empty(void);
void Check_2D_Busy(void);
void Check_SDRAM_Ready(void);
unsigned char Power_Saving_Status(void);
void Check_Power_is_Normal(void);
void Check_Power_is_Saving(void);
void Check_NO_Interrupt(void);
void Check_Interrupt_Occur(void);

void Check_Busy_Draw(void);
void Check_Busy_SFI_DMA(void);


void RA8876_SW_Reset(void);

void Enable_PLL(void);
void RA8876_Sleep(void);
void RA8876_WakeUp(void);
void TFT_24bit(void);
void TFT_18bit(void);
void TFT_16bit(void);
void TFT_LVDS(void);
void Key_Scan_Enable(void);
void Key_Scan_Disable(void);
void RA8876_I2CM_Enable(void);
void RA8876_I2CM_Disable(void);
void Enable_SFlash_SPI(void);
void Disable_SFlash_SPI(void);
void Host_Bus_8bit(void);
void Host_Bus_16bit(void);


void RGB_8b_8bpp(void);
void RGB_8b_16bpp(void);
void RGB_8b_24bpp(void);

void RGB_16b_8bpp(void);
void RGB_16b_16bpp(void);
void RGB_16b_24bpp_mode1(void);
void RGB_16b_24bpp_mode2(void);

void MemRead_Left_Right_Top_Down(void);
void MemRead_Right_Left_Top_Down(void);
void MemRead_Top_Down_Left_Right(void);
void MemRead_Down_Top_Left_Right(void);

void MemWrite_Left_Right_Top_Down(void);
void MemWrite_Right_Left_Top_Down(void);
void MemWrite_Top_Down_Left_Right(void);
void MemWrite_Down_Top_Left_Right(void);

void Interrupt_Active_Low(void);
void Interrupt_Active_High(void);
void ExtInterrupt_Debounce(void);
void ExtInterrupt_Nodebounce(void);
void ExtInterrupt_Input_Low_Level_Trigger(void);
void ExtInterrupt_Input_High_Level_Trigger(void);
void ExtInterrupt_Input_Falling_Edge_Trigger(void);
void ExtInterrupt_Input_Rising_Edge_Trigger(void);
void LVDS_Format1(void);
void LVDS_Format2(void);
void Graphic_Mode(void);
void Text_Mode(void);
void Memory_Select_SDRAM(void);
void Memory_Select_Graphic_Cursor_RAM(void);
void Memory_Select_Color_Palette_RAM(void);






void Enable_Resume_Interrupt(void);
void Disable_Resume_Interrupt(void);
void Enable_ExtInterrupt_Input(void);
void Disable_ExtInterrupt_Input(void);
void Enable_I2CM_Interrupt(void);
void Disable_I2CM_Interrupt(void);
void Enable_Vsync_Interrupt(void);
void Disable_Vsync_Interrupt(void);
void Enable_KeyScan_Interrupt(void);
void Disable_KeyScan_Interrupt(void);
void Enable_DMA_Draw_BTE_Interrupt(void);
void Disable_DMA_Draw_BTE_Interrupt(void);
void Enable_PWM1_Interrupt(void);
void Disable_PWM1_Interrupt(void);
void Enable_PWM0_Interrupt(void);
void Disable_PWM0_Interrupt(void);

unsigned char Read_Interrupt_status(void);
void Clear_Resume_Interrupt_Flag(void);
void Clear_ExtInterrupt_Input_Flag(void);
void Clear_I2CM_Interrupt_Flag(void);
void Clear_Vsync_Interrupt_Flag(void);
void Clear_KeyScan_Interrupt_Flag(void);
void Clear_DMA_Draw_BTE_Interrupt_Flag(void);
void Clear_PWM1_Interrupt_Flag(void);
void Clear_PWM0_Interrupt_Flag(void);

void Mask_Resume_Interrupt_Flag(void);
void Mask_ExtInterrupt_Input_Flag(void);
void Mask_I2CM_Interrupt_Flag(void);
void Mask_Vsync_Interrupt_Flag(void);
void Mask_KeyScan_Interrupt_Flag(void);
void Mask_DMA_Draw_BTE_Interrupt_Flag(void);
void Mask_PWM1_Interrupt_Flag(void);
void Mask_PWM0_Interrupt_Flag(void);

void Enable_Resume_Interrupt_Flag(void);
void Enable_ExtInterrupt_Input_Flag(void);
void Enable_I2CM_Interrupt_Flag(void);
void Enable_Vsync_Interrupt_Flag(void);
void Enable_KeyScan_Interrupt_Flag(void);
void Enable_DMA_Draw_BTE_Interrupt_Flag(void);
void Enable_PWM1_Interrupt_Flag(void);
void Enable_PWM0_Interrupt_Flag(void);

void Enable_GPIOF_PullUp(void);
void Enable_GPIOE_PullUp(void);
void Enable_GPIOD_PullUp(void);
void Enable_GPIOC_PullUp(void);
void Enable_XDB15_8_PullUp(void);
void Enable_XDB7_0_PullUp(void);
void Disable_GPIOF_PullUp(void);
void Disable_GPIOE_PullUp(void);
void Disable_GPIOD_PullUp(void);
void Disable_GPIOC_PullUp(void);
void Disable_XDB15_8_PullUp(void);
void Disable_XDB7_0_PullUp(void);


void XPDAT18_Set_GPIO_D7(void);
void XPDAT18_Set_KOUT4(void);
void XPDAT17_Set_GPIO_D5(void);
void XPDAT17_Set_KOUT2(void);
void XPDAT16_Set_GPIO_D4(void);
void XPDAT16_Set_KOUT1(void);
void XPDAT9_Set_GPIO_D3(void);
void XPDAT9_Set_KOUT3(void);
void XPDAT8_Set_GPIO_D2(void);
void XPDAT8_Set_KIN3(void);
void XPDAT2_Set_GPIO_D6(void);
void XPDAT2_Set_KIN4(void);
void XPDAT1_Set_GPIO_D1(void);
void XPDAT1_Set_KIN2(void);
void XPDAT0_Set_GPIO_D0(void);
void XPDAT0_Set_KIN1(void);


void Enable_PIP1(void);
void Disable_PIP1(void);
void Enable_PIP2(void);
void Disable_PIP2(void);
void Select_PIP1_Parameter(void);
void Select_PIP2_Parameter(void);
void Select_Main_Window_8bpp(void);
void Select_Main_Window_16bpp(void);
void Select_Main_Window_24bpp(void);

void Select_PIP1_Window_8bpp(void);
void Select_PIP1_Window_16bpp(void);
void Select_PIP1_Window_24bpp(void);
void Select_PIP2_Window_8bpp(void);
void Select_PIP2_Window_16bpp(void);
void Select_PIP2_Window_24bpp(void);

void PCLK_Rising(void);
void PCLK_Falling(void);
void Display_ON(void);
void Display_OFF(void);
void Color_Bar_ON(void);
void Color_Bar_OFF(void);
void HSCAN_L_to_R(void);
void HSCAN_R_to_L(void);
void VSCAN_T_to_B(void);
void VSCAN_B_to_T(void);
void PDATA_Set_RGB(void);
void PDATA_Set_RBG(void);
void PDATA_Set_GRB(void);
void PDATA_Set_GBR(void);
void PDATA_Set_BRG(void);
void PDATA_Set_BGR(void);
void PDATA_IDLE_STATE(void);


void HSYNC_Low_Active(void);
void HSYNC_High_Active(void);
void VSYNC_Low_Active(void);
void VSYNC_High_Active(void);
void DE_Low_Active(void);
void DE_High_Active(void);
void Idle_DE_Low(void);
void Idle_DE_High(void);
void Idle_PCLK_Low(void);
void Idle_PCLK_High(void);
void Idle_PDAT_Low(void);
void Idle_PDAT_High(void);
void Idle_HSYNC_Low(void);
void Idle_HSYNC_High(void);
void Idle_VSYNC_Low(void);
void Idle_VSYNC_High(void);

void LCD_HorizontalWidth_VerticalHeight(unsigned short WX,unsigned short HY);

void LCD_Horizontal_Non_Display(unsigned short WX);

void LCD_HSYNC_Start_Position(unsigned short WX);

void LCD_HSYNC_Pulse_Width(unsigned short WX);

void LCD_Vertical_Non_Display(unsigned short HY);

void LCD_VSYNC_Start_Position(unsigned short HY);

void LCD_VSYNC_Pulse_Width(unsigned short HY);

void Main_Image_Start_Address(unsigned long Addr);

void Main_Image_Width(unsigned short WX);

void Main_Window_Start_XY(unsigned short WX,unsigned short HY);

void PIP_Display_Start_XY(unsigned short WX,unsigned short HY);

void PIP_Image_Start_Address(unsigned long Addr);

void PIP_Image_Width(unsigned short WX);

void PIP_Window_Image_Start_XY(unsigned short WX,unsigned short HY);

void PIP_Window_Width_Height(unsigned short WX,unsigned short HY);

void Enable_Graphic_Cursor(void);
void Disable_Graphic_Cursor(void);
void Select_Graphic_Cursor_1(void);
void Select_Graphic_Cursor_2(void);
void Select_Graphic_Cursor_3(void);
void Select_Graphic_Cursor_4(void);
void Enable_Text_Cursor(void);
void Disable_Text_Cursor(void);
void Enable_Text_Cursor_Blinking(void);
void Disable_Text_Cursor_Blinking(void);

void Blinking_Time_Frames(unsigned char temp);

void Text_Cursor_H_V(unsigned short WX,unsigned short HY);

void Graphic_Cursor_XY(unsigned short WX,unsigned short HY);

void Set_Graphic_Cursor_Color_1(unsigned char temp);

void Set_Graphic_Cursor_Color_2(unsigned char temp);

void Canvas_Image_Start_address(unsigned long Addr);

void Canvas_image_width(unsigned short WX);

void Active_Window_XY(unsigned short WX,unsigned short HY);

void Active_Window_WH(unsigned short WX,unsigned short HY);

void Select_Write_Data_Position(void);
void Select_Read_Data_Position(void);
void Memory_XY_Mode(void);
void Memory_Linear_Mode(void);
void Memory_8bpp_Mode(void);
void Memory_16bpp_Mode(void);
void Memory_24bpp_Mode(void);

void Goto_Pixel_XY(unsigned short WX,unsigned short HY);
void Goto_Linear_Addr(unsigned long Addr);

void Goto_Text_XY(unsigned short WX,unsigned short HY);




void Start_Line(void);
void Start_Triangle(void);
void Start_Triangle_Fill(void);

void Line_Start_XY(unsigned short WX,unsigned short HY);
void Line_End_XY(unsigned short WX,unsigned short HY);
void Triangle_Point1_XY(unsigned short WX,unsigned short HY);
void Triangle_Point2_XY(unsigned short WX,unsigned short HY);
void Triangle_Point3_XY (unsigned short WX,unsigned short HY);
void Square_Start_XY(unsigned short WX,unsigned short HY);
void Square_End_XY(unsigned short WX,unsigned short HY);

void Start_Circle_or_Ellipse(void);
void Start_Circle_or_Ellipse_Fill(void);
void Start_Left_Down_Curve(void);
void Start_Left_Up_Curve(void);
void Start_Right_Up_Curve(void);
void Start_Right_Down_Curve(void);
void Start_Left_Down_Curve_Fill(void);
void Start_Left_Up_Curve_Fill(void);
void Start_Right_Up_Curve_Fill(void);
void Start_Right_Down_Curve_Fill(void);
void Start_Square(void);
void Start_Square_Fill(void);
void Start_Circle_Square(void);
void Start_Circle_Square_Fill(void);

void Circle_Center_XY(unsigned short WX,unsigned short HY);
void Ellipse_Center_XY(unsigned short WX,unsigned short HY);
void Circle_Radius_R(unsigned short WX);
void Ellipse_Radius_RxRy(unsigned short WX,unsigned short HY);
void Circle_Square_Radius_RxRy(unsigned short WX,unsigned short HY);




void Set_PWM_Prescaler_1_to_256(unsigned short WX);

void Select_PWM1_Clock_Divided_By_1(void);
void Select_PWM1_Clock_Divided_By_2(void);
void Select_PWM1_Clock_Divided_By_4(void);
void Select_PWM1_Clock_Divided_By_8(void);
void Select_PWM0_Clock_Divided_By_1(void);
void Select_PWM0_Clock_Divided_By_2(void);
void Select_PWM0_Clock_Divided_By_4(void);
void Select_PWM0_Clock_Divided_By_8(void);

void Select_PWM1_is_ErrorFlag(void);
void Select_PWM1(void);
void Select_PWM1_is_Osc_Clock(void);

void Select_PWM0_is_GPIO_C7(void);
void Select_PWM0(void);
void Select_PWM0_is_Core_Clock(void);


void Enable_PWM1_Inverter(void);
void Disable_PWM1_Inverter(void);
void Auto_Reload_PWM1(void);
void One_Shot_PWM1(void);
void Start_PWM1(void);
void Stop_PWM1(void);

void Enable_PWM0_Dead_Zone(void);
void Disable_PWM0_Dead_Zone(void);
void Enable_PWM0_Inverter(void);
void Disable_PWM0_Inverter(void);
void Auto_Reload_PWM0(void);
void One_Shot_PWM0(void);
void Start_PWM0(void);
void Stop_PWM0(void);

void Set_Timer0_Dead_Zone_Length(unsigned char temp);

void Set_Timer0_Compare_Buffer(unsigned short WX);

void Set_Timer0_Count_Buffer(unsigned short WX);

void Set_Timer1_Compare_Buffer(unsigned short WX);

void Set_Timer1_Count_Buffer(unsigned short WX);






void BTE_Enable(void);
void BTE_Disable(void);

void Check_BTE_Busy(void);

void Pattern_Format_8X8(void);
void Pattern_Format_16X16(void);


void BTE_ROP_Code(unsigned char setx);
void BTE_Operation_Code(unsigned char setx);


void BTE_S0_Color_8bpp(void);
void BTE_S0_Color_16bpp(void);
void BTE_S0_Color_24bpp(void);

void BTE_S1_Color_8bpp(void);
void BTE_S1_Color_16bpp(void);
void BTE_S1_Color_24bpp(void);
void BTE_S1_Color_Constant(void);
void BTE_S1_Color_8bit_Alpha(void);
void BTE_S1_Color_16bit_Alpha(void);

void BTE_Destination_Color_8bpp(void);
void BTE_Destination_Color_16bpp(void);
void BTE_Destination_Color_24bpp(void);


void BTE_S0_Memory_Start_Address(unsigned long Addr);


void BTE_S0_Image_Width(unsigned short WX);


void BTE_S0_Window_Start_XY(unsigned short WX,unsigned short HY);


void BTE_S1_Memory_Start_Address(unsigned long Addr);
void S1_Constant_color_256(unsigned char temp);
void S1_Constant_color_65k(unsigned short temp);
void S1_Constant_color_16M(unsigned long temp);


void BTE_S1_Image_Width(unsigned short WX);


void BTE_S1_Window_Start_XY(unsigned short WX,unsigned short HY);


void BTE_Destination_Memory_Start_Address(unsigned long Addr);


void BTE_Destination_Image_Width(unsigned short WX);


void BTE_Destination_Window_Start_XY(unsigned short WX,unsigned short HY);


void BTE_Window_Size(unsigned short WX, unsigned short WY);


void BTE_Alpha_Blending_Effect(unsigned char temp);
# 660 "./RA8876.h"
void Start_SFI_DMA(void);
void Check_Busy_SFI_DMA(void);


void Select_SFI_0(void);
void Select_SFI_1(void);
void Select_SFI_Font_Mode(void);
void Select_SFI_DMA_Mode(void);
void Select_SFI_24bit_Address(void);
void Select_SFI_32bit_Address(void);
void Select_SFI_Waveform_Mode_0(void);
void Select_SFI_Waveform_Mode_3(void);
void Select_SFI_0_DummyRead(void);
void Select_SFI_8_DummyRead(void);
void Select_SFI_16_DummyRead(void);
void Select_SFI_24_DummyRead(void);
void Select_SFI_Single_Mode(void);
void Select_SFI_Dual_Mode0(void);
void Select_SFI_Dual_Mode1(void);


unsigned char SPI_Master_FIFO_Data_Put(unsigned char Data);
unsigned char SPI_Master_FIFO_Data_Get(void);


void Mask_SPI_Master_Interrupt_Flag(void);
void Select_nSS_drive_on_xnsfcs0(void);
void Select_nSS_drive_on_xnsfcs1(void);
void nSS_Inactive(void);
void nSS_Active(void);
void OVFIRQEN_Enable(void);
void EMTIRQEN_Enable(void);
void Reset_CPOL(void);
void Set_CPOL(void);
void Reset_CPHA(void);
void Set_CPHA(void);


unsigned char Tx_FIFO_Empty_Flag(void);
unsigned char Tx_FIFO_Full_Flag(void);
unsigned char Rx_FIFO_Empty_Flag(void);
unsigned char Rx_FIFO_full_flag(void);
unsigned char OVFI_Flag(void);
void Clear_OVFI_Flag(void);
unsigned char EMTI_Flag(void);
void Clear_EMTI_Flag(void);


void SPI_Clock_Period(unsigned char temp);



void SFI_DMA_Source_Start_Address(unsigned long Addr);

void SFI_DMA_Destination_Start_Address(unsigned long Addr);
void SFI_DMA_Destination_Upper_Left_Corner(unsigned short WX,unsigned short HY);

void SFI_DMA_Destination_Width(unsigned short WX);

void SFI_DMA_Transfer_Number(unsigned long Addr);
void SFI_DMA_Transfer_Width_Height(unsigned short WX,unsigned short HY);

void SFI_DMA_Source_Width(unsigned short WX);





void Font_Select_UserDefine_Mode(void);
void CGROM_Select_Internal_CGROM(void);
void CGROM_Select_Genitop_FontROM(void);
void Font_Select_8x16_16x16(void);
void Font_Select_12x24_24x24(void);
void Font_Select_16x32_32x32(void);
void Internal_CGROM_Select_ISOIEC8859_1(void);
void Internal_CGROM_Select_ISOIEC8859_2(void);
void Internal_CGROM_Select_ISOIEC8859_3(void);
void Internal_CGROM_Select_ISOIEC8859_4(void);

void Enable_Font_Alignment(void);
void Disable_Font_Alignment(void);
void Font_Background_select_Transparency(void);
void Font_Background_select_Color(void);
void Font_0_degree(void);
void Font_90_degree(void);
void Font_Width_X1(void);
void Font_Width_X2(void);
void Font_Width_X3(void);
void Font_Width_X4(void);
void Font_Height_X1(void);
void Font_Height_X2(void);
void Font_Height_X3(void);
void Font_Height_X4(void);

void GTFont_Select_GT21L16TW_GT21H16T1W(void);
void GTFont_Select_GT23L16U2W(void);
void GTFont_Select_GT23L24T3Y_GT23H24T3Y(void);
void GTFont_Select_GT23L24M1Z(void);
void GTFont_Select_GT23L32S4W_GT23H32S4W(void);
void GTFont_Select_GT20L24F6Y(void);
void GTFont_Select_GT21L24S1W(void);
void GTFont_Select_GT22L16A1Y(void);

void Set_GTFont_Decoder(unsigned char temp);

void Font_Line_Distance(unsigned char temp);

void Set_Font_to_Font_Width(unsigned char temp);

void Foreground_RGB(unsigned char RED,unsigned char GREEN,unsigned char BLUE);
void Foreground_color_256(unsigned char temp);
void Foreground_color_65k(unsigned short temp);
void Foreground_color_16M(unsigned long temp);

void Background_RGB(unsigned char RED,unsigned char GREEN,unsigned char BLUE);
void Background_color_256(unsigned char temp);
void Background_color_65k(unsigned short temp);
void Background_color_16M(unsigned long temp);

void CGRAM_Start_address(unsigned long Addr);

void Power_Normal_Mode(void);
void Power_Saving_Standby_Mode(void);
void Power_Saving_Suspend_Mode(void);
void Power_Saving_Sleep_Mode(void);
# 796 "./RA8876.h"
void RA8876_I2CM_Clock_Prescale(unsigned short WX);

void RA8876_I2CM_Transmit_Data(unsigned char temp);

unsigned char RA8876_I2CM_Receiver_Data(void);


void RA8876_I2CM_Read_With_Ack(void);
void RA8876_I2CM_Read_With_Nack(void);
void RA8876_I2CM_Write_With_Start(void);
void RA8876_I2CM_Write(void);
void RA8876_I2CM_Stop(void);



unsigned char RA8876_I2CM_Check_Slave_ACK(void);
unsigned char RA8876_I2CM_Bus_Busy(void);
unsigned char RA8876_I2CM_transmit_Progress(void);
unsigned char RA8876_I2CM_Arbitration(void);






void Set_GPIO_A_In_Out(unsigned char temp);
void Write_GPIO_A_7_0(unsigned char temp);
unsigned char Read_GPIO_A_7_0(void);

void Write_GPIO_B_7_4(unsigned char temp);
unsigned char Read_GPIO_B_7_0(void);

void Set_GPIO_C_In_Out(unsigned char temp);
void Write_GPIO_C_7_0(unsigned char temp);
unsigned char Read_GPIO_C_7_0(void);

void Set_GPIO_D_In_Out(unsigned char temp);
void Write_GPIO_D_7_0(unsigned char temp);
unsigned char Read_GPIO_D_7_0(void);

void Set_GPIO_E_In_Out(unsigned char temp);
void Write_GPIO_E_7_0(unsigned char temp);
unsigned char Read_GPIO_E_7_0(void);

void Set_GPIO_F_In_Out(unsigned char temp);
void Write_GPIO_F_7_0(unsigned char temp);
unsigned char Read_GPIO_F_7_0(void);






void Long_Key_enable(void);
void Key_Scan_Freg(unsigned char temp);


void Key_Scan_Wakeup_Function_Enable(void);
void Long_Key_Timing_Adjustment(unsigned char setx);
unsigned char Numbers_of_Key_Hit(void);


unsigned char Read_Key_Strobe_Data_0(void);
unsigned char Read_Key_Strobe_Data_1(void);
unsigned char Read_Key_Strobe_Data_2(void);

void Show_String(char *str);
void Show_picture(unsigned long numbers,const unsigned short *datap);
void Show_picture1(unsigned long numbers,const unsigned short *datap);

void delay_us(unsigned int i);
void delay_ms(unsigned int i);
void Delay10ms(unsigned int i);
void Delay100ms(unsigned int i);
void NextStep(void);
void LCD_Clear(unsigned int Color);
void LCD_SetCursor(unsigned int Xpos, unsigned int Ypos);
  void LCD_PutChar(unsigned int x,unsigned int y,unsigned char c,unsigned int charColor,unsigned int bkColor);
void LCD_DisplayString(unsigned int X,unsigned int Y, char *ptr, unsigned int charColor, unsigned int bkColor);
void LCD_SetPoint(unsigned int x,unsigned int y,unsigned int point);
 void LCD_WriteRAM_Prepare(void);
void RA8876_HW_Reset(void);
void NextStep(void);

 void Graphic_cursor_initial(void);
void Show_picture(unsigned long numbers,const unsigned short *datap);



void delay_us(unsigned int i)
{

    while(i--)
 {_nop_();
 }

}

void delay_ms(unsigned int i)
{unsigned char j;
 while(i--)
   for(j=0;j<125;j++);
}


void Delay10ms(unsigned int i)
{ while(i--)
 delay_ms(10);
}

void Delay100ms(unsigned int i)
{ while(i--)
 delay_ms(100);
}

void NextStep(void)
{
  while(next)
  {
   Delay100ms(1);
  }
 while(!next);
 Delay100ms(10);
 while(!next);
}


void LCD_CmdWrite(unsigned char Cmd)
{ if(c86)
   {
   rd = 1;
   cs = 0;
   rs = 0;

   P0 = Cmd;
   wr = 0;
   wr = 1;
   cs= 1;

   P0 = 0xff;
   rs = 1;
   }

 else
   {

   rd = 0;
   cs =0;
   wr = 0;
   rs = 0;
   P0 = Cmd;
   rd = 1;
   ;
   ;
   rd = 0;
   cs =1;
   }
}


void LCD_DataWrite(unsigned int Data)
{ if(c86)
   {
   rd = 1;
   cs = 0;
   rs = 1;

   P0 = Data;
   wr = 0;
   wr = 1;
   cs = 1;

   P0 = 0xff;
   rs = 0;
   }

 else
   {

   rd = 0;
   cs =0;
   wr = 0;
   rs = 1;

   P0 = Data;
   rd = 1;
   ;
   ;
   rd = 0;
   cs =1;
   }

}






unsigned char LCD_StatusRead(void)
{ if(c86)
   {
   unsigned char Data;

   P0 = 0xff;
   cs = 0;
   rs= 0;
   wr = 1;
   rd = 0;
   Data = P0;
   rd = 1;
   cs= 1;
   P0 = 0xff;
   rs = 1;
   return Data;
   }

 else
   {

   unsigned char reg_rddata;

   P0 = 0xff;
   rd = 0;
   cs =0;
   wr = 1;
   rs = 0;
   rd = 1;
   reg_rddata = P0;
   ;
   ;
   rd = 0;
   cs =1;
   return(reg_rddata);
   }
}


unsigned char LCD_DataRead(void)
{ if(c86)
   {
   unsigned char Data;
   wr = 1;
   cs = 0;
   rs = 1;
   rd = 0;
   Data = P0;
   rd = 1;
   cs = 1;
   rs = 0;

   return(Data);
   }

 else
   {

   unsigned char reg_rddata;
   P0 = 0xff;
   rd = 0;
   cs =0;
   wr = 1;
   rs = 1;
   rd = 1;
   reg_rddata = P0;
   ;
   ;
   rd = 0;



   cs =1;
   return(reg_rddata);
   }
}




void LCD_RegisterWrite(unsigned char Cmd,unsigned char Data)
{
 LCD_CmdWrite(Cmd);
 LCD_DataWrite(Data);
}

unsigned char LCD_RegisterRead(unsigned char Cmd)
{
 unsigned char temp;

 LCD_CmdWrite(Cmd);
 temp=LCD_DataRead();
 return temp;
}

 void LCD_WriteRAM_Prepare(void)
{
  LCD_CmdWrite(0x04);
}

void RA8876_HW_Reset(void)
{

 rst=0;
    delay_ms(2);
 rst=1;
    delay_ms(20);
}


 void LCD_SetPoint(unsigned int x,unsigned int y,unsigned int point)
{
  LCD_SetCursor(x,y);
  LCD_WriteRAM_Prepare();
  LCD_DataWrite(point);
  LCD_DataWrite(point>>8);
}


 void LCD_PutChar(unsigned int x,unsigned int y,unsigned char c,unsigned int charColor,unsigned int bkColor)
{
  unsigned int i=0;
  unsigned int j=0;

  unsigned int tmp_char=0;

  for (i=0;i<24;i++)
  {
    tmp_char=ASCII_Table[((c-0x20)*24)+i];
    for (j=0;j<16;j++)
    {

 if ( (tmp_char >> j) & 0x01 == 0x01)
      {
        LCD_SetPoint(x+j,y+i,charColor);
      }
      else
      {
        LCD_SetPoint(x+j,y+i,bkColor);
      }
    }
  }
}


void LCD_DisplayString(unsigned int X,unsigned int Y, char *ptr, unsigned int charColor, unsigned int bkColor)
{
  unsigned long i = 0;


  while ((*ptr != 0) & (i < 64))
  {

 LCD_PutChar(X, Y, *ptr, charColor, bkColor);

    X += 16;

    ptr++;

    i++;
  }
}






void LCD_SetCursor(unsigned int Xpos, unsigned int Ypos)
{
    LCD_CmdWrite(0x5F);
 LCD_DataWrite(Xpos);
    LCD_CmdWrite(0x60);
 LCD_DataWrite(Xpos>>8);
    LCD_CmdWrite(0x61);
 LCD_DataWrite(Ypos);
    LCD_CmdWrite(0x62);
 LCD_DataWrite(Ypos>>8);
}




 void LCD_Clear(unsigned int Color)
{
  unsigned long index = 0;

  LCD_SetCursor(0,0);

  LCD_WriteRAM_Prepare();

  for(index = 0; index < 614400; index++)
  {
    LCD_DataWrite(Color);
 LCD_DataWrite(Color>>8);
  }

}




void RA8876_initial(void)
{

  RA8876_SW_Reset();
  RA8876_PLL_Initial();
  RA8876_SDRAM_initail();


 TFT_24bit();
 Host_Bus_8bit();

 RGB_8b_16bpp();

 MemWrite_Left_Right_Top_Down();

 Graphic_Mode();
 Memory_Select_SDRAM();


 HSCAN_L_to_R();
 VSCAN_T_to_B();
 PDATA_Set_RGB();


 PCLK_Falling();
 DE_High_Active();

 HSYNC_High_Active();

 VSYNC_High_Active();
 LCD_HorizontalWidth_VerticalHeight(1024,600);

 LCD_Horizontal_Non_Display(160);
 LCD_HSYNC_Start_Position(160);
 LCD_HSYNC_Pulse_Width(70);
 LCD_Vertical_Non_Display(23);
 LCD_VSYNC_Start_Position(12);
 LCD_VSYNC_Pulse_Width(10);


 Select_Main_Window_16bpp();
 Main_Image_Start_Address(0);
 Main_Image_Width(1024);
 Main_Window_Start_XY(0,0);
 Canvas_Image_Start_address(0);
 Canvas_image_width(1024);
 Active_Window_XY(0,0);
 Active_Window_WH(1024,600);

 Memory_XY_Mode();
 Memory_16bpp_Mode();
 Select_Main_Window_16bpp();

}


 void RA8876_PLL_Initial(void)
{
unsigned short plldivm_sclk, plldivm_cclk, plldivm_mclk;
unsigned short plldivn_sclk, plldivn_cclk, plldivn_mclk;
unsigned short plldivk_sclk, plldivk_cclk, plldivk_mclk;
unsigned short plldivk_sclkpow, plldivk_cclkpow, plldivk_mclkpow;
unsigned short temp_sclk, temp_cclk, temp_mclk;







   plldivk_sclk = 1;
   plldivk_sclkpow = 2;
# 1296 "./RA8876.h"
   plldivm_sclk = 0;
# 1307 "./RA8876.h"
   plldivk_mclk = 1;
   plldivk_mclkpow = 2;
# 1331 "./RA8876.h"
   plldivk_cclk = 1;
   plldivk_cclkpow = 2;
# 1344 "./RA8876.h"
   plldivm_cclk = 0;

plldivn_sclk = ((40 * (plldivm_sclk + 1) * plldivk_sclkpow) / 10) - 1;
// 40 * 1 * 2 / 10 - 1 = 7
plldivn_mclk = ((100 * (plldivm_mclk + 1) * plldivk_mclkpow) / 10) - 1;
// 100 * 1 * 2 / 10 - 1 = 19
plldivn_cclk = ((100 * (plldivm_cclk + 1) * plldivk_cclkpow) / 10) - 1;
// 100 * 1 * 2 / 10 - 1 = 19

temp_sclk = (plldivk_sclk << 1) | plldivm_sclk;
// 1 << 1 | 0 = 2
temp_mclk = (plldivk_mclk << 1) | plldivm_mclk;
// 1 << 1 | 0 = 2
temp_cclk = (plldivk_cclk << 1) | plldivm_cclk;
// 1 << 1 | 0 = 2


 LCD_CmdWrite(0x05);
 LCD_DataWrite(temp_sclk); // 2
 LCD_CmdWrite(0x07);
 LCD_DataWrite(temp_mclk); // 2
 LCD_CmdWrite(0x09);
 LCD_DataWrite(temp_cclk); // 2

 LCD_CmdWrite(0x06);
 LCD_DataWrite(plldivn_sclk); // 7
 LCD_CmdWrite(0x08);
 LCD_DataWrite(plldivn_mclk); // 19
 LCD_CmdWrite(0x0a);
 LCD_DataWrite(plldivn_cclk); // 19

    LCD_CmdWrite(0x01);
 LCD_DataWrite(0x00);
 delay_us(1);
 LCD_DataWrite(0x80);


 delay_ms(1);
}





void RA8876_SDRAM_initail(void)
{

unsigned short sdram_itv;
# 1485 "./RA8876.h"
 LCD_RegisterWrite(0xe0,0x29);
 LCD_RegisterWrite(0xe1,0x03);

    sdram_itv = (64000000 / 8192) / (1000/100) ; // 781

    sdram_itv-=2;   // 779 == 0x30B

 LCD_RegisterWrite(0xe2,sdram_itv);	// 0x0B
 LCD_RegisterWrite(0xe3,sdram_itv >>8); // 0x03

 LCD_RegisterWrite(0xe4,0x01);
# 1540 "./RA8876.h"
 Check_SDRAM_Ready();

delay_ms(1);

}





void Check_Mem_WR_FIFO_not_Full(void)
{


 do
 {

 }while( LCD_StatusRead()&0x80 );
}
void Check_Mem_WR_FIFO_Empty(void)
{


 do
 {

 }while( (LCD_StatusRead()&0x40) == 0x00 );
}
void Check_Mem_RD_FIFO_not_Full(void)
{


 do
 {

 }while( LCD_StatusRead()&0x20 );
}
void Check_Mem_RD_FIFO_not_Empty(void)
{



 do
 {

 }while( LCD_StatusRead()&0x10 );
}
void Check_2D_Busy(void)
{
  do
 {
 }while( LCD_StatusRead()&0x08 );

}
void Check_SDRAM_Ready(void)
{


 unsigned char temp;
 do
 {
  temp=LCD_StatusRead();
 }while( (temp&0x04) == 0x00 );
}


unsigned char Power_Saving_Status(void)
{
     unsigned char temp;

   if((LCD_StatusRead()&0x02)==0x02)
     temp = 1;
   else
     temp = 0;

   return temp;
}


void Check_Power_is_Normal(void)
{


 do
 {

 }while( LCD_StatusRead()&0x02 );
}
void Check_Power_is_Saving(void)
{


 do
 {

 }while( (LCD_StatusRead()&0x02) == 0x00 );
}
void Check_NO_Interrupt(void)
{



 do
 {

 }while( LCD_StatusRead()&0x01 );
}
void Check_Interrupt_Occur(void)
{



 do
 {

 }while( (LCD_StatusRead()&0x01) == 0x00 );
}

void Check_Busy_Draw(void)
{
unsigned char temp;






 do
 {
  temp=LCD_StatusRead();
 } while(temp&0x08);
# 1691 "./RA8876.h"
}



void RA8876_SW_Reset(void)
{
 unsigned char temp;

 LCD_CmdWrite(0x00);
 temp = LCD_DataRead();
 temp |= 0x01;
 LCD_DataWrite(temp);

    do
    {
     temp = LCD_DataRead();
    }
    while( temp&0x01 );
}


void Enable_PLL(void)
{


 unsigned char temp;
 LCD_CmdWrite(0x01);
 temp = LCD_DataRead();
 temp |= 0x80;
 LCD_DataWrite(temp);

    delay_us(1);
}
void RA8876_Sleep(void)
{


 unsigned char temp;
 LCD_CmdWrite(0x01);
 temp = LCD_DataRead();
 temp |= 0x40;
 LCD_DataWrite(temp);
}
void RA8876_WakeUp(void)
{


 unsigned char temp;
 LCD_CmdWrite(0x01);
 temp = LCD_DataRead();
 temp &= 0xbf;
 LCD_DataWrite(temp);
}
void Key_Scan_Enable(void)
{


 unsigned char temp;
 LCD_CmdWrite(0x01);
 temp = LCD_DataRead();
 temp |= 0x20;
 LCD_DataWrite(temp);
}
void Key_Scan_Disable(void)
{


 unsigned char temp;
 LCD_CmdWrite(0x01);
 temp = LCD_DataRead();
 temp &= 0xdf;
 LCD_DataWrite(temp);
}
void TFT_24bit(void)
{




 unsigned char temp;
 LCD_CmdWrite(0x01);
 temp = LCD_DataRead();
 temp &= 0xef;
    temp &= 0xf7;
 LCD_DataWrite(temp);
}
void TFT_18bit(void)
{




 unsigned char temp;
 LCD_CmdWrite(0x01);
 temp = LCD_DataRead();
 temp &= 0xef;
    temp |= 0x08;
 LCD_DataWrite(temp);
}
void TFT_16bit(void)
{




 unsigned char temp;
 LCD_CmdWrite(0x01);
 temp = LCD_DataRead();
 temp |= 0x10;
    temp &= 0xf7;
 LCD_DataWrite(temp);
}
void TFT_LVDS(void)
{




 unsigned char temp;
 LCD_CmdWrite(0x01);
 temp = LCD_DataRead();
 temp |= 0x10;
    temp |= 0x08;
 LCD_DataWrite(temp);
}

void RA8876_I2CM_Enable(void)
{



 unsigned char temp;
 LCD_CmdWrite(0x01);
 temp = LCD_DataRead();
 temp |= 0x04;
 LCD_DataWrite(temp);
}

void RA8876_I2CM_Disable(void)
{



 unsigned char temp;
 LCD_CmdWrite(0x01);
 temp = LCD_DataRead();
 temp &= 0xfb;
 LCD_DataWrite(temp);
}

void Enable_SFlash_SPI(void)
{



 unsigned char temp;
 LCD_CmdWrite(0x01);
 temp = LCD_DataRead();
 temp |= 0x02;
 LCD_DataWrite(temp);
}

void Disable_SFlash_SPI(void)
{



 unsigned char temp;
 LCD_CmdWrite(0x01);
 temp = LCD_DataRead();
 temp &= 0xfd;
 LCD_DataWrite(temp);
}
void Host_Bus_8bit(void)
{



 unsigned char temp;
 LCD_CmdWrite(0x01);
 temp = LCD_DataRead();
 temp &= 0xfe;
 LCD_DataWrite(temp);
}
void Host_Bus_16bit(void)
{



 unsigned char temp;
 LCD_CmdWrite(0x01);
 temp = LCD_DataRead();
 temp |= 0x01;
 LCD_DataWrite(temp);
}



void RGB_8b_8bpp(void)
{
 unsigned char temp;
 LCD_CmdWrite(0x02);
 temp = LCD_DataRead();
 temp &= 0x7f;
 temp &= 0xbf;
 LCD_DataWrite(temp);
}
void RGB_8b_16bpp(void)
{
 unsigned char temp;
 LCD_CmdWrite(0x02);
 temp = LCD_DataRead();
 temp &= 0x7f;
 temp |= 0x40;
 LCD_DataWrite(temp);
}
void RGB_8b_24bpp(void)
{
 unsigned char temp;
 LCD_CmdWrite(0x02);
 temp = LCD_DataRead();
 temp &= 0x7f;
 temp &= 0xbf;
 LCD_DataWrite(temp);
}

void RGB_16b_8bpp(void)
{
 unsigned char temp;
 LCD_CmdWrite(0x02);
 temp = LCD_DataRead();
 temp |= 0x80;
    temp &= 0xbf;
 LCD_DataWrite(temp);
}
void RGB_16b_16bpp(void)
{
 unsigned char temp;
 LCD_CmdWrite(0x02);
 temp = LCD_DataRead();
 temp &= 0x7f;
 temp |= 0x40;
 LCD_DataWrite(temp);
}
void RGB_16b_24bpp_mode1(void)
{
 unsigned char temp;
 LCD_CmdWrite(0x02);
 temp = LCD_DataRead();
 temp &= 0x7f;
 temp &= 0xbf;
 LCD_DataWrite(temp);
}
void RGB_16b_24bpp_mode2(void)
{
 unsigned char temp;
 LCD_CmdWrite(0x02);
 temp = LCD_DataRead();
 temp |= 0x80;
 temp |= 0x40;
 LCD_DataWrite(temp);
}

void MemRead_Left_Right_Top_Down(void)
{
 unsigned char temp;
 LCD_CmdWrite(0x02);
 temp = LCD_DataRead();
 temp &= 0xdf;
 temp &= 0xef;
 LCD_DataWrite(temp);
}
void MemRead_Right_Left_Top_Down(void)
{
 unsigned char temp;
 LCD_CmdWrite(0x02);
 temp = LCD_DataRead();
 temp &= 0xdf;
 temp |= 0x10;
 LCD_DataWrite(temp);
}
void MemRead_Top_Down_Left_Right(void)
{
 unsigned char temp;
 LCD_CmdWrite(0x02);
 temp = LCD_DataRead();
 temp |= 0x20;
    temp &= 0xef;
 LCD_DataWrite(temp);
}
void MemRead_Down_Top_Left_Right(void)
{
 unsigned char temp;
 LCD_CmdWrite(0x02);
 temp = LCD_DataRead();
 temp |= 0x20;
 temp |= 0x10;
 LCD_DataWrite(temp);
}
void MemWrite_Left_Right_Top_Down(void)
{
 unsigned char temp;
 LCD_CmdWrite(0x02);
 temp = LCD_DataRead();
 temp &= 0xfb;
 temp &= 0xfd;
 LCD_DataWrite(temp);
}
void MemWrite_Right_Left_Top_Down(void)
{
 unsigned char temp;
 LCD_CmdWrite(0x02);
 temp = LCD_DataRead();
 temp &= 0xfb;
 temp |= 0x02;
 LCD_DataWrite(temp);
}
void MemWrite_Top_Down_Left_Right(void)
{
 unsigned char temp;
 LCD_CmdWrite(0x02);
 temp = LCD_DataRead();
 temp |= 0x04;
    temp &= 0xfd;
 LCD_DataWrite(temp);
}
void MemWrite_Down_Top_Left_Right(void)
{
 unsigned char temp;
 LCD_CmdWrite(0x02);
 temp = LCD_DataRead();
 temp |= 0x04;
 temp |= 0x02;
 LCD_DataWrite(temp);
}

void Interrupt_Active_Low(void)
{



 unsigned char temp;
 LCD_CmdWrite(0x03);
 temp = LCD_DataRead();
 temp &= 0x7f;
 LCD_DataWrite(temp);
}
void Interrupt_Active_High(void)
{



 unsigned char temp;
 LCD_CmdWrite(0x03);
 temp = LCD_DataRead();
 temp |= 0x80;
 LCD_DataWrite(temp);
}
void ExtInterrupt_Debounce(void)
{



 unsigned char temp;
 LCD_CmdWrite(0x03);
 temp = LCD_DataRead();
 temp |= 0x40;
 LCD_DataWrite(temp);
}
void ExtInterrupt_Nodebounce(void)
{



 unsigned char temp;
 LCD_CmdWrite(0x03);
 temp = LCD_DataRead();
 temp &= 0xbf;
 LCD_DataWrite(temp);
}
void ExtInterrupt_Input_Low_Level_Trigger(void)
{
 unsigned char temp;
 LCD_CmdWrite(0x03);
 temp = LCD_DataRead();
 temp &= 0xdf;
    temp &= 0xef;
 LCD_DataWrite(temp);
}
void ExtInterrupt_Input_High_Level_Trigger(void)
{
 unsigned char temp;
 LCD_CmdWrite(0x03);
 temp = LCD_DataRead();
 temp |= 0x20;
    temp &= 0xef;
 LCD_DataWrite(temp);
}
void ExtInterrupt_Input_Falling_Edge_Trigger(void)
{
 unsigned char temp;
 LCD_CmdWrite(0x03);
 temp = LCD_DataRead();
    temp &= 0xdf;
    temp |= 0x10;
 LCD_DataWrite(temp);
}
void ExtInterrupt_Input_Rising_Edge_Trigger(void)
{
 unsigned char temp;
 LCD_CmdWrite(0x03);
 temp = LCD_DataRead();
 temp |= 0x20;
    temp |= 0x10;
 LCD_DataWrite(temp);
}
void LVDS_Format1(void)
{
 unsigned char temp;
 LCD_CmdWrite(0x03);
 temp = LCD_DataRead();
    temp &= 0xf7;
 LCD_DataWrite(temp);
}
void LVDS_Format2(void)
{
 unsigned char temp;
 LCD_CmdWrite(0x03);
 temp = LCD_DataRead();
    temp |= 0x08;
 LCD_DataWrite(temp);
}
void Graphic_Mode(void)
{
 unsigned char temp;
 LCD_CmdWrite(0x03);
 temp = LCD_DataRead();
    temp &= 0xfb;
 LCD_DataWrite(temp);
}
void Text_Mode(void)
{
 unsigned char temp;
 LCD_CmdWrite(0x03);
 temp = LCD_DataRead();
    temp |= 0x04;
 LCD_DataWrite(temp);
}
void Memory_Select_SDRAM(void)
{
 unsigned char temp;
 LCD_CmdWrite(0x03);
 temp = LCD_DataRead();
    temp &= 0xfd;
    temp &= 0xfe;
 LCD_DataWrite(temp);
}
void Memory_Select_Graphic_Cursor_RAM(void)
{
 unsigned char temp;
 LCD_CmdWrite(0x03);
 temp = LCD_DataRead();
    temp |= 0x02;
    temp &= 0xfe;
 LCD_DataWrite(temp);
}
void Memory_Select_Color_Palette_RAM(void)
{
 unsigned char temp;
 LCD_CmdWrite(0x03);
 temp = LCD_DataRead();
    temp |= 0x02;
    temp |= 0x01;
 LCD_DataWrite(temp);
}
# 2175 "./RA8876.h"
void Enable_Resume_Interrupt(void)
{





 unsigned char temp;
 LCD_CmdWrite(0x0B);
 temp = LCD_DataRead();
    temp |= 0x80;
 LCD_DataWrite(temp);
}
void Disable_Resume_Interrupt(void)
{





 unsigned char temp;
 LCD_CmdWrite(0x0B);
 temp = LCD_DataRead();
    temp &= 0x7f;
 LCD_DataWrite(temp);
}
void Enable_ExtInterrupt_Input(void)
{





 unsigned char temp;
 LCD_CmdWrite(0x0B);
 temp = LCD_DataRead();
    temp |= 0x40;
 LCD_DataWrite(temp);
}
void Disable_ExtInterrupt_Input(void)
{





 unsigned char temp;
 LCD_CmdWrite(0x0B);
 temp = LCD_DataRead();
    temp &= 0xbf;
 LCD_DataWrite(temp);
}
void Enable_I2CM_Interrupt(void)
{





 unsigned char temp;
 LCD_CmdWrite(0x0B);
 temp = LCD_DataRead();
    temp |= 0x20;
 LCD_DataWrite(temp);
}
void Disable_I2CM_Interrupt(void)
{





 unsigned char temp;
 LCD_CmdWrite(0x0B);
 temp = LCD_DataRead();
    temp &= 0xdf;
 LCD_DataWrite(temp);
}
void Enable_Vsync_Interrupt(void)
{





 unsigned char temp;
 LCD_CmdWrite(0x0B);
 temp = LCD_DataRead();
    temp |= 0x10;
 LCD_DataWrite(temp);
}
void Disable_Vsync_Interrupt(void)
{





 unsigned char temp;
 LCD_CmdWrite(0x0B);
 temp = LCD_DataRead();
    temp &= 0xef;
 LCD_DataWrite(temp);
}
void Enable_KeyScan_Interrupt(void)
{





 unsigned char temp;
 LCD_CmdWrite(0x0B);
 temp = LCD_DataRead();
    temp |= 0x08;
 LCD_DataWrite(temp);
}
void Disable_KeyScan_Interrupt(void)
{





 unsigned char temp;
 LCD_CmdWrite(0x0B);
 temp = LCD_DataRead();
    temp &= 0xf7;
 LCD_DataWrite(temp);
}
void Enable_DMA_Draw_BTE_Interrupt(void)
{






 unsigned char temp;
 LCD_CmdWrite(0x0B);
 temp = LCD_DataRead();
    temp |= 0x04;
 LCD_DataWrite(temp);
}
void Disable_DMA_Draw_BTE_Interrupt(void)
{






 unsigned char temp;
 LCD_CmdWrite(0x0B);
 temp = LCD_DataRead();
    temp &= 0xfb;
 LCD_DataWrite(temp);
}
void Enable_PWM1_Interrupt(void)
{





 unsigned char temp;
 LCD_CmdWrite(0x0B);
 temp = LCD_DataRead();
    temp |= 0x02;
 LCD_DataWrite(temp);
}
void Disable_PWM1_Interrupt(void)
{





 unsigned char temp;
 LCD_CmdWrite(0x0B);
 temp = LCD_DataRead();
    temp &= 0xfd;
 LCD_DataWrite(temp);
}
void Enable_PWM0_Interrupt(void)
{





 unsigned char temp;
 LCD_CmdWrite(0x0B);
 temp = LCD_DataRead();
    temp |= 0x01;
 LCD_DataWrite(temp);
}
void Disable_PWM0_Interrupt(void)
{





 unsigned char temp;
 LCD_CmdWrite(0x0B);
 temp = LCD_DataRead();
    temp &= 0xfe;
 LCD_DataWrite(temp);
}


unsigned char Read_Interrupt_status(void)
{
# 2415 "./RA8876.h"
 unsigned char temp;
 LCD_CmdWrite(0x0C);
 temp = LCD_DataRead();
    return temp;
}
void Clear_Resume_Interrupt_Flag(void)
{






 unsigned char temp;
 LCD_CmdWrite(0x0C);
 temp = LCD_DataRead();
    temp |= 0x80;
 LCD_DataWrite(temp);
}
void Clear_ExtInterrupt_Input_Flag(void)
{






 unsigned char temp;
 LCD_CmdWrite(0x0C);
 temp = LCD_DataRead();
    temp |= 0x40;
 LCD_DataWrite(temp);
}
void Clear_I2CM_Interrupt_Flag(void)
{






 unsigned char temp;
 LCD_CmdWrite(0x0C);
 temp = LCD_DataRead();
    temp |= 0x20;
 LCD_DataWrite(temp);
}
void Clear_Vsync_Interrupt_Flag(void)
{






 unsigned char temp;
 LCD_CmdWrite(0x0C);
 temp = LCD_DataRead();
    temp |= 0x10;
 LCD_DataWrite(temp);
}
void Clear_KeyScan_Interrupt_Flag(void)
{






 unsigned char temp;
 LCD_CmdWrite(0x0C);
 temp = LCD_DataRead();
    temp |= 0x08;
 LCD_DataWrite(temp);
}
void Clear_DMA_Draw_BTE_Interrupt_Flag(void)
{







 unsigned char temp;
 LCD_CmdWrite(0x0C);
 temp = LCD_DataRead();
    temp |= 0x04;
 LCD_DataWrite(temp);
}
void Clear_PWM1_Interrupt_Flag(void)
{






 unsigned char temp;
 LCD_CmdWrite(0x0C);
 temp = LCD_DataRead();
    temp |= 0x02;
 LCD_DataWrite(temp);
}
void Clear_PWM0_Interrupt_Flag(void)
{






 unsigned char temp;
 LCD_CmdWrite(0x0C);
 temp = LCD_DataRead();
    temp |= 0x01;
 LCD_DataWrite(temp);
}

void Mask_Resume_Interrupt_Flag(void)
{





 unsigned char temp;
 LCD_CmdWrite(0x0D);
 temp = LCD_DataRead();
    temp |= 0x80;
 LCD_DataWrite(temp);
}
void Mask_ExtInterrupt_Input_Flag(void)
{





 unsigned char temp;
 LCD_CmdWrite(0x0D);
 temp = LCD_DataRead();
    temp |= 0x40;
 LCD_DataWrite(temp);
}
void Mask_I2CM_Interrupt_Flag(void)
{





 unsigned char temp;
 LCD_CmdWrite(0x0D);
 temp = LCD_DataRead();
    temp |= 0x20;
 LCD_DataWrite(temp);
}
void Mask_Vsync_Interrupt_Flag(void)
{





 unsigned char temp;
 LCD_CmdWrite(0x0D);
 temp = LCD_DataRead();
    temp |= 0x10;
 LCD_DataWrite(temp);
}
void Mask_KeyScan_Interrupt_Flag(void)
{





 unsigned char temp;
 LCD_CmdWrite(0x0D);
 temp = LCD_DataRead();
    temp |= 0x08;
 LCD_DataWrite(temp);
}
void Mask_DMA_Draw_BTE_Interrupt_Flag(void)
{






 unsigned char temp;
 LCD_CmdWrite(0x0D);
 temp = LCD_DataRead();
    temp |= 0x04;
 LCD_DataWrite(temp);
}
void Mask_PWM1_Interrupt_Flag(void)
{





 unsigned char temp;
 LCD_CmdWrite(0x0D);
 temp = LCD_DataRead();
    temp |= 0x02;
 LCD_DataWrite(temp);
}
void Mask_PWM0_Interrupt_Flag(void)
{





 unsigned char temp;
 LCD_CmdWrite(0x0D);
 temp = LCD_DataRead();
    temp |= 0x01;
 LCD_DataWrite(temp);
}

void Enable_Resume_Interrupt_Flag(void)
{





 unsigned char temp;
 LCD_CmdWrite(0x0D);
 temp = LCD_DataRead();
    temp &= 0x7f;
 LCD_DataWrite(temp);
}
void Enable_ExtInterrupt_Inpur_Flag(void)
{





 unsigned char temp;
 LCD_CmdWrite(0x0D);
 temp = LCD_DataRead();
    temp &= 0xbf;
 LCD_DataWrite(temp);
}
void Enable_I2CM_Interrupt_Flag(void)
{





 unsigned char temp;
 LCD_CmdWrite(0x0D);
 temp = LCD_DataRead();
    temp &= 0xdf;
 LCD_DataWrite(temp);
}
void Enable_Vsync_Interrupt_Flag(void)
{





 unsigned char temp;
 LCD_CmdWrite(0x0D);
 temp = LCD_DataRead();
    temp &= 0xef;
 LCD_DataWrite(temp);
}
void Enable_KeyScan_Interrupt_Flag(void)
{





 unsigned char temp;
 LCD_CmdWrite(0x0D);
 temp = LCD_DataRead();
    temp &= 0xf7;
 LCD_DataWrite(temp);
}
void Enable_DMA_Draw_BTE_Interrupt_Flag(void)
{






 unsigned char temp;
 LCD_CmdWrite(0x0D);
 temp = LCD_DataRead();
    temp &= 0xfb;
 LCD_DataWrite(temp);
}
void Enable_PWM1_Interrupt_Flag(void)
{





 unsigned char temp;
 LCD_CmdWrite(0x0D);
 temp = LCD_DataRead();
    temp &= 0xfd;
 LCD_DataWrite(temp);
}
void Enable_PWM0_Interrupt_Flag(void)
{





 unsigned char temp;
 LCD_CmdWrite(0x0D);
 temp = LCD_DataRead();
    temp &= 0xfe;
 LCD_DataWrite(temp);
}


void Enable_GPIOF_PullUp(void)
{





 unsigned char temp;
 LCD_CmdWrite(0x0E);
 temp = LCD_DataRead();
    temp |= 0x20;
 LCD_DataWrite(temp);
}
void Enable_GPIOE_PullUp(void)
{





 unsigned char temp;
 LCD_CmdWrite(0x0E);
 temp = LCD_DataRead();
    temp |= 0x10;
 LCD_DataWrite(temp);
}
void Enable_GPIOD_PullUp(void)
{





 unsigned char temp;
 LCD_CmdWrite(0x0E);
 temp = LCD_DataRead();
    temp |= 0x08;
 LCD_DataWrite(temp);
}
void Enable_GPIOC_PullUp(void)
{






 unsigned char temp;
 LCD_CmdWrite(0x0E);
 temp = LCD_DataRead();
    temp |= 0x04;
 LCD_DataWrite(temp);
}
void Enable_XDB15_8_PullUp(void)
{





 unsigned char temp;
 LCD_CmdWrite(0x0E);
 temp = LCD_DataRead();
    temp |= 0x02;
 LCD_DataWrite(temp);
}
void Enable_XDB7_0_PullUp(void)
{





 unsigned char temp;
 LCD_CmdWrite(0x0E);
 temp = LCD_DataRead();
    temp |= 0x01;
 LCD_DataWrite(temp);
}
void Disable_GPIOF_PullUp(void)
{





 unsigned char temp;
 LCD_CmdWrite(0x0E);
 temp = LCD_DataRead();
    temp &= 0xdf;
 LCD_DataWrite(temp);
}
void Disable_GPIOE_PullUp(void)
{





 unsigned char temp;
 LCD_CmdWrite(0x0E);
 temp = LCD_DataRead();
    temp &= 0xef;
 LCD_DataWrite(temp);
}
void Disable_GPIOD_PullUp(void)
{





 unsigned char temp;
 LCD_CmdWrite(0x0E);
 temp = LCD_DataRead();
    temp &= 0xf7;
 LCD_DataWrite(temp);
}
void Disable_GPIOC_PullUp(void)
{






 unsigned char temp;
 LCD_CmdWrite(0x0E);
 temp = LCD_DataRead();
    temp &= 0xfb;
 LCD_DataWrite(temp);
}
void Disable_XDB15_8_PullUp(void)
{





 unsigned char temp;
 LCD_CmdWrite(0x0E);
 temp = LCD_DataRead();
    temp &= 0xfd;
 LCD_DataWrite(temp);
}
void Disable_XDB7_0_PullUp(void)
{





 unsigned char temp;
 LCD_CmdWrite(0x0E);
 temp = LCD_DataRead();
    temp &= 0xfe;
 LCD_DataWrite(temp);
}

void XPDAT18_Set_GPIO_D7(void)
{





 unsigned char temp;
 LCD_CmdWrite(0x0F);
 temp = LCD_DataRead();
    temp &= 0x7f;
 LCD_DataWrite(temp);
}
void XPDAT18_Set_KOUT4(void)
{





 unsigned char temp;
 LCD_CmdWrite(0x0F);
 temp = LCD_DataRead();
    temp |= 0x80;
 LCD_DataWrite(temp);
}
void XPDAT17_Set_GPIO_D5(void)
{





 unsigned char temp;
 LCD_CmdWrite(0x0F);
 temp = LCD_DataRead();
    temp &= 0xbf;
 LCD_DataWrite(temp);
}
void XPDAT17_Set_KOUT2(void)
{





 unsigned char temp;
 LCD_CmdWrite(0x0F);
 temp = LCD_DataRead();
    temp |= 0x40;
 LCD_DataWrite(temp);
}
void XPDAT16_Set_GPIO_D4(void)
{





 unsigned char temp;
 LCD_CmdWrite(0x0F);
 temp = LCD_DataRead();
    temp &= 0xdf;
 LCD_DataWrite(temp);
}
void XPDAT16_Set_KOUT1(void)
{





 unsigned char temp;
 LCD_CmdWrite(0x0F);
 temp = LCD_DataRead();
    temp |= 0x20;
 LCD_DataWrite(temp);
}
void XPDAT9_Set_GPIO_D3(void)
{





 unsigned char temp;
 LCD_CmdWrite(0x0F);
 temp = LCD_DataRead();
    temp &= 0xef;
 LCD_DataWrite(temp);
}
void XPDAT9_Set_KOUT3(void)
{





 unsigned char temp;
 LCD_CmdWrite(0x0F);
 temp = LCD_DataRead();
    temp |= 0x10;
 LCD_DataWrite(temp);
}
void XPDAT8_Set_GPIO_D2(void)
{





 unsigned char temp;
 LCD_CmdWrite(0x0F);
 temp = LCD_DataRead();
    temp &= 0xf7;
 LCD_DataWrite(temp);
}
void XPDAT8_Set_KIN3(void)
{





 unsigned char temp;
 LCD_CmdWrite(0x0F);
 temp = LCD_DataRead();
    temp |= 0x08;
 LCD_DataWrite(temp);
}
void XPDAT2_Set_GPIO_D6(void)
{





 unsigned char temp;
 LCD_CmdWrite(0x0F);
 temp = LCD_DataRead();
    temp &= 0xfb;
 LCD_DataWrite(temp);
}
void XPDAT2_Set_KIN4(void)
{





 unsigned char temp;
 LCD_CmdWrite(0x0F);
 temp = LCD_DataRead();
    temp |= 0x04;
 LCD_DataWrite(temp);
}
void XPDAT1_Set_GPIO_D1(void)
{





 unsigned char temp;
 LCD_CmdWrite(0x0F);
 temp = LCD_DataRead();
    temp &= 0xfd;
 LCD_DataWrite(temp);
}
void XPDAT1_Set_KIN2(void)
{





 unsigned char temp;
 LCD_CmdWrite(0x0F);
 temp = LCD_DataRead();
    temp |= 0x02;
 LCD_DataWrite(temp);
}
void XPDAT0_Set_GPIO_D0(void)
{





 unsigned char temp;
 LCD_CmdWrite(0x0F);
 temp = LCD_DataRead();
    temp &= 0xfe;
 LCD_DataWrite(temp);
}
void XPDAT0_Set_KIN1(void)
{





 unsigned char temp;
 LCD_CmdWrite(0x0F);
 temp = LCD_DataRead();
    temp |= 0x01;
 LCD_DataWrite(temp);
}


void Enable_PIP1(void)
{






 unsigned char temp;
 LCD_CmdWrite(0x10);
 temp = LCD_DataRead();
    temp |= 0x80;
 LCD_DataWrite(temp);
}
void Disable_PIP1(void)
{






 unsigned char temp;
 LCD_CmdWrite(0x10);
 temp = LCD_DataRead();
    temp &= 0x7f;
 LCD_DataWrite(temp);
}
void Enable_PIP2(void)
{






 unsigned char temp;
 LCD_CmdWrite(0x10);
 temp = LCD_DataRead();
    temp |= 0x40;
 LCD_DataWrite(temp);
}
void Disable_PIP2(void)
{






 unsigned char temp;
 LCD_CmdWrite(0x10);
 temp = LCD_DataRead();
    temp &= 0xbf;
 LCD_DataWrite(temp);
}
void Select_PIP1_Parameter(void)
{




 unsigned char temp;
 LCD_CmdWrite(0x10);
 temp = LCD_DataRead();
    temp &= 0xef;
 LCD_DataWrite(temp);
}
void Select_PIP2_Parameter(void)
{




 unsigned char temp;
 LCD_CmdWrite(0x10);
 temp = LCD_DataRead();
    temp |= 0x10;
 LCD_DataWrite(temp);
}
void Select_Main_Window_8bpp(void)
{






 unsigned char temp;
 LCD_CmdWrite(0x10);
 temp = LCD_DataRead();
    temp &= 0xf7;
    temp &= 0xfb;
 LCD_DataWrite(temp);
}
void Select_Main_Window_16bpp(void)
{






 unsigned char temp;
 LCD_CmdWrite(0x10);
 temp = LCD_DataRead();
    temp &= 0xf7;
    temp |= 0x04;
 LCD_DataWrite(temp);
}
void Select_Main_Window_24bpp(void)
{






 unsigned char temp;
 LCD_CmdWrite(0x10);
 temp = LCD_DataRead();
    temp |= 0x08;

 LCD_DataWrite(temp);
}

void Select_PIP2_Window_8bpp(void)
{






 unsigned char temp;
 LCD_CmdWrite(0x11);
 temp = LCD_DataRead();
    temp &= 0xfd;
    temp &= 0xfe;
 LCD_DataWrite(temp);
}
void Select_PIP2_Window_16bpp(void)
{






 unsigned char temp;
 LCD_CmdWrite(0x11);
 temp = LCD_DataRead();
    temp &= 0xfd;
    temp |= 0x01;
 LCD_DataWrite(temp);
}
void Select_PIP2_Window_24bpp(void)
{






 unsigned char temp;
 LCD_CmdWrite(0x11);
 temp = LCD_DataRead();
    temp |= 0x02;
    temp &= 0xfe;
 LCD_DataWrite(temp);
}
void Select_PIP1_Window_8bpp(void)
{






 unsigned char temp;
 LCD_CmdWrite(0x11);
 temp = LCD_DataRead();
    temp &= 0xf7;
    temp &= 0xfb;
 LCD_DataWrite(temp);
}
void Select_PIP1_Window_16bpp(void)
{






 unsigned char temp;
 LCD_CmdWrite(0x11);
 temp = LCD_DataRead();
    temp &= 0xf7;
    temp |= 0x04;
 LCD_DataWrite(temp);
}
void Select_PIP1_Window_24bpp(void)
{






 unsigned char temp;
 LCD_CmdWrite(0x11);
 temp = LCD_DataRead();
    temp |= 0x08;
    temp &= 0xfb;
 LCD_DataWrite(temp);
}


void PCLK_Rising(void)
{





 unsigned char temp;
 LCD_CmdWrite(0x12);
 temp = LCD_DataRead();
    temp &= 0x7f;
 LCD_DataWrite(temp);
}
void PCLK_Falling(void)
{





 unsigned char temp;
 LCD_CmdWrite(0x12);
 temp = LCD_DataRead();
    temp |= 0x80;
 LCD_DataWrite(temp);
}
void Display_ON(void)
{





 unsigned char temp;

 LCD_CmdWrite(0x12);
 temp = LCD_DataRead();
 temp |= 0x40;
 LCD_DataWrite(temp);
}

void Display_OFF(void)
{





 unsigned char temp;

 LCD_CmdWrite(0x12);
 temp = LCD_DataRead();
 temp &= 0xbf;
 LCD_DataWrite(temp);
}
void Color_Bar_ON(void)
{





 unsigned char temp;

 LCD_CmdWrite(0x12);
 temp = LCD_DataRead();
 temp |= 0x20;
 LCD_DataWrite(temp);
}
void Color_Bar_OFF(void)
{





 unsigned char temp;

 LCD_CmdWrite(0x12);
 temp = LCD_DataRead();
 temp &= 0xdf;
 LCD_DataWrite(temp);
}
void HSCAN_L_to_R(void)
{






 unsigned char temp;

 LCD_CmdWrite(0x12);
 temp = LCD_DataRead();
 temp &= 0xef;
 LCD_DataWrite(temp);
}
void HSCAN_R_to_L(void)
{






 unsigned char temp;

 LCD_CmdWrite(0x12);
 temp = LCD_DataRead();
 temp |= 0x10;
 LCD_DataWrite(temp);
}
void VSCAN_T_to_B(void)
{






 unsigned char temp;

 LCD_CmdWrite(0x12);
 temp = LCD_DataRead();
 temp &= 0xf7;
 LCD_DataWrite(temp);
}
void VSCAN_B_to_T(void)
{






 unsigned char temp;

 LCD_CmdWrite(0x12);
 temp = LCD_DataRead();
 temp |= 0x08;
 LCD_DataWrite(temp);
}
void PDATA_Set_RGB(void)
{
# 3488 "./RA8876.h"
 unsigned char temp;

 LCD_CmdWrite(0x12);
 temp = LCD_DataRead();
    temp &=0xf8;
 LCD_DataWrite(temp);
}
void PDATA_Set_RBG(void)
{
# 3506 "./RA8876.h"
 unsigned char temp;

 LCD_CmdWrite(0x12);
 temp = LCD_DataRead();
 temp &=0xf8;
    temp |= 0x01;
 LCD_DataWrite(temp);
}
void PDATA_Set_GRB(void)
{
# 3525 "./RA8876.h"
 unsigned char temp;

 LCD_CmdWrite(0x12);
 temp = LCD_DataRead();
 temp &=0xf8;
    temp |= 0x02;
 LCD_DataWrite(temp);
}
void PDATA_Set_GBR(void)
{
# 3544 "./RA8876.h"
 unsigned char temp;

 LCD_CmdWrite(0x12);
 temp = LCD_DataRead();
 temp &=0xf8;
    temp |= 0x02;
    temp |= 0x01;
 LCD_DataWrite(temp);
}
void PDATA_Set_BRG(void)
{
# 3564 "./RA8876.h"
 unsigned char temp;

 LCD_CmdWrite(0x12);
 temp = LCD_DataRead();
 temp &=0xf8;
 temp |= 0x04;
 LCD_DataWrite(temp);
}
void PDATA_Set_BGR(void)
{
# 3583 "./RA8876.h"
 unsigned char temp;

 LCD_CmdWrite(0x12);
 temp = LCD_DataRead();
 temp &=0xf8;
 temp |= 0x04;
    temp |= 0x01;
 LCD_DataWrite(temp);
}

void PDATA_IDLE_STATE(void)
{
 unsigned char temp;

 LCD_CmdWrite(0x12);
 temp = LCD_DataRead();
 temp |=0x07;
 LCD_DataWrite(temp);

}



void HSYNC_Low_Active(void)
{





 unsigned char temp;

 LCD_CmdWrite(0x13);
 temp = LCD_DataRead();
 temp &= 0x7f;
 LCD_DataWrite(temp);
}
void HSYNC_High_Active(void)
{





 unsigned char temp;

 LCD_CmdWrite(0x13);
 temp = LCD_DataRead();
 temp |= 0x80;
 LCD_DataWrite(temp);
}
void VSYNC_Low_Active(void)
{





 unsigned char temp;

 LCD_CmdWrite(0x13);
 temp = LCD_DataRead();
 temp &= 0xbf;
 LCD_DataWrite(temp);
}
void VSYNC_High_Active(void)
{





 unsigned char temp;

 LCD_CmdWrite(0x13);
 temp = LCD_DataRead();
 temp |= 0x40;
 LCD_DataWrite(temp);
}
void DE_Low_Active(void)
{





 unsigned char temp;

 LCD_CmdWrite(0x13);
 temp = LCD_DataRead();
    temp |= 0x20;
 LCD_DataWrite(temp);
}
void DE_High_Active(void)
{





 unsigned char temp;

 LCD_CmdWrite(0x13);
 temp = LCD_DataRead();
 temp &= 0xdf;
 LCD_DataWrite(temp);
}
void Idle_DE_Low(void)
{





 unsigned char temp;

 LCD_CmdWrite(0x13);
 temp = LCD_DataRead();
    temp &= 0xef;
 LCD_DataWrite(temp);
}
void Idle_DE_High(void)
{





 unsigned char temp;

 LCD_CmdWrite(0x13);
 temp = LCD_DataRead();
 temp |= 0x10;
 LCD_DataWrite(temp);
}
void Idle_PCLK_Low(void)
{





 unsigned char temp;

 LCD_CmdWrite(0x13);
 temp = LCD_DataRead();
    temp &= 0xf7;
 LCD_DataWrite(temp);
}
void Idle_PCLK_High(void)
{





 unsigned char temp;

 LCD_CmdWrite(0x13);
 temp = LCD_DataRead();
 temp |= 0x08;
 LCD_DataWrite(temp);
}
void Idle_PDAT_Low(void)
{





 unsigned char temp;

 LCD_CmdWrite(0x13);
 temp = LCD_DataRead();
    temp &= 0xfb;
 LCD_DataWrite(temp);
}
void Idle_PDAT_High(void)
{





 unsigned char temp;

 LCD_CmdWrite(0x13);
 temp = LCD_DataRead();
 temp |= 0x04;
 LCD_DataWrite(temp);
}
void Idle_HSYNC_Low(void)
{





 unsigned char temp;

 LCD_CmdWrite(0x13);
 temp = LCD_DataRead();
    temp &= 0xfd;
 LCD_DataWrite(temp);
}
void Idle_HSYNC_High(void)
{





 unsigned char temp;

 LCD_CmdWrite(0x13);
 temp = LCD_DataRead();
 temp |= 0x02;
 LCD_DataWrite(temp);
}
void Idle_VSYNC_Low(void)
{





 unsigned char temp;

 LCD_CmdWrite(0x13);
 temp = LCD_DataRead();
    temp &= 0xfe;
 LCD_DataWrite(temp);
}
void Idle_VSYNC_High(void)
{





 unsigned char temp;

 LCD_CmdWrite(0x13);
 temp = LCD_DataRead();
 temp |= 0x01;
 LCD_DataWrite(temp);
}


void LCD_HorizontalWidth_VerticalHeight(unsigned short WX,unsigned short HY)
{
# 3846 "./RA8876.h"
 unsigned char temp;
 if(WX<8)
    {
 LCD_CmdWrite(0x14);
 LCD_DataWrite(0x00);

 LCD_CmdWrite(0x15);
 LCD_DataWrite(WX);

    temp=HY-1;
 LCD_CmdWrite(0x1A);
 LCD_DataWrite(temp);

 temp=(HY-1)>>8;
 LCD_CmdWrite(0x1B);
 LCD_DataWrite(temp);
 }
 else
 {
    temp=(WX/8)-1;
 LCD_CmdWrite(0x14);
 LCD_DataWrite(temp);

    temp=WX%8;
 LCD_CmdWrite(0x15);
 LCD_DataWrite(temp);

    temp=HY-1;
 LCD_CmdWrite(0x1A);
 LCD_DataWrite(temp);

 temp=(HY-1)>>8;
 LCD_CmdWrite(0x1B);
 LCD_DataWrite(temp);
 }
}

void LCD_Horizontal_Non_Display(unsigned short WX)
{
# 3897 "./RA8876.h"
 unsigned char temp;
 if(WX<8)
 {
 LCD_CmdWrite(0x16);
 LCD_DataWrite(0x00);

 LCD_CmdWrite(0x17);
 LCD_DataWrite(WX);
 }
 else
 {
    temp=(WX/8)-1;
 LCD_CmdWrite(0x16);
 LCD_DataWrite(temp);

    temp=WX%8;
 LCD_CmdWrite(0x17);
 LCD_DataWrite(temp);
 }
}

void LCD_HSYNC_Start_Position(unsigned short WX)
{







 unsigned char temp;
 if(WX<8)
 {
 LCD_CmdWrite(0x18);
 LCD_DataWrite(0x00);
 }
 else
 {
    temp=(WX/8)-1;
 LCD_CmdWrite(0x18);
 LCD_DataWrite(temp);
 }
}

void LCD_HSYNC_Pulse_Width(unsigned short WX)
{





 unsigned char temp;
 if(WX<8)
 {
 LCD_CmdWrite(0x19);
 LCD_DataWrite(0x00);
 }
 else
 {
    temp=(WX/8)-1;
 LCD_CmdWrite(0x19);
 LCD_DataWrite(temp);
 }
}

void LCD_Vertical_Non_Display(unsigned short HY)
{







 unsigned char temp;
    temp=HY-1;
 LCD_CmdWrite(0x1C);
 LCD_DataWrite(temp);

 LCD_CmdWrite(0x1D);
 LCD_DataWrite(temp>>8);
}

void LCD_VSYNC_Start_Position(unsigned short HY)
{





 unsigned char temp;
    temp=HY-1;
 LCD_CmdWrite(0x1E);
 LCD_DataWrite(temp);
}

void LCD_VSYNC_Pulse_Width(unsigned short HY)
{





 unsigned char temp;
    temp=HY-1;
 LCD_CmdWrite(0x1F);
 LCD_DataWrite(temp);
}

void Main_Image_Start_Address(unsigned long Addr)
{






 LCD_RegisterWrite(0x20,Addr);
 LCD_RegisterWrite(0x21,Addr>>8);
 LCD_RegisterWrite(0x22,Addr>>16);
 LCD_RegisterWrite(0x23,Addr>>24);
}

void Main_Image_Width(unsigned short WX)
{







 LCD_RegisterWrite(0x24,WX);
 LCD_RegisterWrite(0x25,WX>>8);
}

void Main_Window_Start_XY(unsigned short WX,unsigned short HY)
{
# 4049 "./RA8876.h"
 LCD_RegisterWrite(0x26,WX);
 LCD_RegisterWrite(0x27,WX>>8);

 LCD_RegisterWrite(0x28,HY);
 LCD_RegisterWrite(0x29,HY>>8);
}

void PIP_Display_Start_XY(unsigned short WX,unsigned short HY)
{
# 4076 "./RA8876.h"
 LCD_RegisterWrite(0x2A,WX);
 LCD_RegisterWrite(0x2B,WX>>8);

 LCD_RegisterWrite(0x2C,HY);
 LCD_RegisterWrite(0x2D,HY>>8);
}

void PIP_Image_Start_Address(unsigned long Addr)
{






 LCD_RegisterWrite(0x2E,Addr);
 LCD_RegisterWrite(0x2F,Addr>>8);
 LCD_RegisterWrite(0x30,Addr>>16);
 LCD_RegisterWrite(0x31,Addr>>24);
}

void PIP_Image_Width(unsigned short WX)
{
# 4109 "./RA8876.h"
 LCD_RegisterWrite(0x32,WX);
 LCD_RegisterWrite(0x33,WX>>8);
}

void PIP_Window_Image_Start_XY(unsigned short WX,unsigned short HY)
{
# 4133 "./RA8876.h"
 LCD_RegisterWrite(0x34,WX);
 LCD_RegisterWrite(0x35,WX>>8);

 LCD_RegisterWrite(0x36,HY);
 LCD_RegisterWrite(0x37,HY>>8);
}

void PIP_Window_Width_Height(unsigned short WX,unsigned short HY)
{
# 4158 "./RA8876.h"
 LCD_RegisterWrite(0x38,WX);
 LCD_RegisterWrite(0x39,WX>>8);

 LCD_RegisterWrite(0x3A,HY);
 LCD_RegisterWrite(0x3B,HY>>8);
}


void Enable_Graphic_Cursor(void)
{





 unsigned char temp;

 LCD_CmdWrite(0x3C);
 temp = LCD_DataRead();
 temp |= 0x10;
 LCD_DataWrite(temp);
}
void Disable_Graphic_Cursor(void)
{





 unsigned char temp;

 LCD_CmdWrite(0x3C);
 temp = LCD_DataRead();
 temp &= 0xef;
 LCD_DataWrite(temp);
}

void Select_Graphic_Cursor_1(void)
{
# 4205 "./RA8876.h"
 unsigned char temp;

 LCD_CmdWrite(0x3C);
 temp = LCD_DataRead();
 temp &= 0xf7;
 temp &= 0xfb;
 LCD_DataWrite(temp);
}
void Select_Graphic_Cursor_2(void)
{
# 4223 "./RA8876.h"
 unsigned char temp;

 LCD_CmdWrite(0x3C);
 temp = LCD_DataRead();
 temp &= 0xf7;
 temp |= 0x04;
 LCD_DataWrite(temp);
}
void Select_Graphic_Cursor_3(void)
{
# 4241 "./RA8876.h"
 unsigned char temp;

 LCD_CmdWrite(0x3C);
 temp = LCD_DataRead();
 temp |= 0x08;
 temp &= 0xfb;
 LCD_DataWrite(temp);
}
void Select_Graphic_Cursor_4(void)
{
# 4259 "./RA8876.h"
 unsigned char temp;

 LCD_CmdWrite(0x3C);
 temp = LCD_DataRead();
 temp |= 0x08;
 temp |= 0x04;
 LCD_DataWrite(temp);
}

void Enable_Text_Cursor(void)
{







 unsigned char temp;

 LCD_CmdWrite(0x3C);
 temp = LCD_DataRead();
 temp |= 0x02;
 LCD_DataWrite(temp);
}
void Disable_Text_Cursor(void)
{







 unsigned char temp;

 LCD_CmdWrite(0x3C);
 temp = LCD_DataRead();
 temp &= 0xfd;
 LCD_DataWrite(temp);
}

void Enable_Text_Cursor_Blinking(void)
{





 unsigned char temp;

 LCD_CmdWrite(0x3C);
 temp = LCD_DataRead();
 temp |= 0x01;
 LCD_DataWrite(temp);
}
void Disable_Text_Cursor_Blinking(void)
{





 unsigned char temp;

 LCD_CmdWrite(0x3C);
 temp = LCD_DataRead();
 temp &= 0xfe;
 LCD_DataWrite(temp);
}

void Blinking_Time_Frames(unsigned char temp)
{
# 4340 "./RA8876.h"
 LCD_CmdWrite(0x3D);
 LCD_DataWrite(temp);
}

void Text_Cursor_H_V(unsigned short WX,unsigned short HY)
{
# 4360 "./RA8876.h"
 LCD_CmdWrite(0x3E);
 LCD_DataWrite(WX);
 LCD_CmdWrite(0x3F);
 LCD_DataWrite(HY);
}

void Graphic_Cursor_XY(unsigned short WX,unsigned short HY)
{







 LCD_RegisterWrite(0x40,WX);
 LCD_RegisterWrite(0x41,WX>>8);

 LCD_RegisterWrite(0x42,HY);
 LCD_RegisterWrite(0x43,HY>>8);
}

void Set_Graphic_Cursor_Color_1(unsigned char temp)
{




 LCD_RegisterWrite(0x44,temp);
}

void Set_Graphic_Cursor_Color_2(unsigned char temp)
{




 LCD_RegisterWrite(0x45,temp);
}

void Canvas_Image_Start_address(unsigned long Addr)
{






 LCD_RegisterWrite(0x50,Addr);
 LCD_RegisterWrite(0x51,Addr>>8);
 LCD_RegisterWrite(0x52,Addr>>16);
 LCD_RegisterWrite(0x53,Addr>>24);
}

void Canvas_image_width(unsigned short WX)
{




 LCD_RegisterWrite(0x54,WX);
 LCD_RegisterWrite(0x55,WX>>8);
}

void Active_Window_XY(unsigned short WX,unsigned short HY)
{






 LCD_RegisterWrite(0x56,WX);
 LCD_RegisterWrite(0x57,WX>>8);

 LCD_RegisterWrite(0x58,HY);
 LCD_RegisterWrite(0x59,HY>>8);
}

void Active_Window_WH(unsigned short WX,unsigned short HY)
{






 LCD_RegisterWrite(0x5A,WX);
 LCD_RegisterWrite(0x5B,WX>>8);

  LCD_RegisterWrite(0x5C,HY);
 LCD_RegisterWrite(0x5D,HY>>8);
}

void Select_Write_Data_Position(void)
{





 unsigned char temp;

 LCD_CmdWrite(0x5E);
 temp = LCD_DataRead();
 temp &= 0xf7;
 LCD_DataWrite(temp);
}
void Select_Read_Data_Position(void)
{





 unsigned char temp;

 LCD_CmdWrite(0x5E);
 temp = LCD_DataRead();
 temp |= 0x08;
 LCD_DataWrite(temp);
}
void Memory_XY_Mode(void)
{





 unsigned char temp;

 LCD_CmdWrite(0x5E);
 temp = LCD_DataRead();
 temp &= 0xfb;
 LCD_DataWrite(temp);
}
void Memory_Linear_Mode(void)
{





 unsigned char temp;

 LCD_CmdWrite(0x5E);
 temp = LCD_DataRead();
 temp |= 0x04;
 LCD_DataWrite(temp);
}
void Memory_8bpp_Mode(void)
{
# 4522 "./RA8876.h"
 unsigned char temp;

 LCD_CmdWrite(0x5E);
 temp = LCD_DataRead();
 temp &= 0xfd;
 temp &= 0xfe;
 LCD_DataWrite(temp);
}
void Memory_16bpp_Mode(void)
{
# 4542 "./RA8876.h"
 unsigned char temp;

 LCD_CmdWrite(0x5E);
 temp = LCD_DataRead();
 temp &= 0xfd;
 temp |= 0x01;
 LCD_DataWrite(temp);
}
void Memory_24bpp_Mode(void)
{
# 4562 "./RA8876.h"
 unsigned char temp;

 LCD_CmdWrite(0x5E);
 temp = LCD_DataRead();
 temp |= 0x02;
 temp |= 0x01;
 LCD_DataWrite(temp);
}


void Goto_Pixel_XY(unsigned short WX,unsigned short HY)
{
# 4585 "./RA8876.h"
 LCD_RegisterWrite(0x5F,WX);
 LCD_RegisterWrite(0x60,WX>>8);

 LCD_RegisterWrite(0x61,HY);
 LCD_RegisterWrite(0x62,HY>>8);
}
void Goto_Linear_Addr(unsigned long Addr)
{
 LCD_RegisterWrite(0x5F,Addr);
 LCD_RegisterWrite(0x60,Addr>>8);
 LCD_RegisterWrite(0x61,Addr>>16);
 LCD_RegisterWrite(0x62,Addr>>24);
}



void Goto_Text_XY(unsigned short WX,unsigned short HY)
{
# 4611 "./RA8876.h"
 LCD_RegisterWrite(0x63,WX);
 LCD_RegisterWrite(0x64,WX>>8);

 LCD_RegisterWrite(0x65,HY);
 LCD_RegisterWrite(0x66,HY>>8);
}
# 4633 "./RA8876.h"
void Start_Line(void)
{
 LCD_CmdWrite(0x67);
 LCD_DataWrite(0x80);
 Check_Busy_Draw();
}
void Start_Triangle(void)
{
 LCD_CmdWrite(0x67);
 LCD_DataWrite(0x82);
 Check_Busy_Draw();
}
void Start_Triangle_Fill(void)
{

 LCD_CmdWrite(0x67);
 LCD_DataWrite(0xA2);
 Check_Busy_Draw();
}


void Line_Start_XY(unsigned short WX,unsigned short HY)
{






 LCD_CmdWrite(0x68);
 LCD_DataWrite(WX);

 LCD_CmdWrite(0x69);
 LCD_DataWrite(WX>>8);

 LCD_CmdWrite(0x6A);
 LCD_DataWrite(HY);

 LCD_CmdWrite(0x6B);
 LCD_DataWrite(HY>>8);
}


void Line_End_XY(unsigned short WX,unsigned short HY)
{






 LCD_CmdWrite(0x6C);
 LCD_DataWrite(WX);

 LCD_CmdWrite(0x6D);
 LCD_DataWrite(WX>>8);

 LCD_CmdWrite(0x6E);
 LCD_DataWrite(HY);

 LCD_CmdWrite(0x6F);
 LCD_DataWrite(HY>>8);
}


void Triangle_Point1_XY(unsigned short WX,unsigned short HY)
{






 LCD_CmdWrite(0x68);
 LCD_DataWrite(WX);

 LCD_CmdWrite(0x69);
 LCD_DataWrite(WX>>8);

 LCD_CmdWrite(0x6A);
 LCD_DataWrite(HY);

 LCD_CmdWrite(0x6B);
 LCD_DataWrite(HY>>8);
}

void Triangle_Point2_XY(unsigned short WX,unsigned short HY)
{






 LCD_CmdWrite(0x6C);
 LCD_DataWrite(WX);

 LCD_CmdWrite(0x6D);
 LCD_DataWrite(WX>>8);

 LCD_CmdWrite(0x6E);
 LCD_DataWrite(HY);

 LCD_CmdWrite(0x6F);
 LCD_DataWrite(HY>>8);
}

void Triangle_Point3_XY (unsigned short WX,unsigned short HY)
{






 LCD_CmdWrite(0x70);
 LCD_DataWrite(WX);

 LCD_CmdWrite(0x71);
 LCD_DataWrite(WX>>8);

 LCD_CmdWrite(0x72);
 LCD_DataWrite(HY);

 LCD_CmdWrite(0x73);
 LCD_DataWrite(HY>>8);
}

void Square_Start_XY(unsigned short WX,unsigned short HY)
{






 LCD_CmdWrite(0x68);
 LCD_DataWrite(WX);

 LCD_CmdWrite(0x69);
 LCD_DataWrite(WX>>8);

 LCD_CmdWrite(0x6A);
 LCD_DataWrite(HY);

 LCD_CmdWrite(0x6B);
 LCD_DataWrite(HY>>8);
}

void Square_End_XY(unsigned short WX,unsigned short HY)
{






 LCD_CmdWrite(0x6C);
 LCD_DataWrite(WX);

 LCD_CmdWrite(0x6D);
 LCD_DataWrite(WX>>8);

 LCD_CmdWrite(0x6E);
 LCD_DataWrite(HY);

 LCD_CmdWrite(0x6F);
 LCD_DataWrite(HY>>8);
}
# 4829 "./RA8876.h"
void Start_Circle_or_Ellipse(void)
{
 LCD_CmdWrite(0x76);
 LCD_DataWrite(0x80);
 Check_Busy_Draw();
}
void Start_Circle_or_Ellipse_Fill(void)
{
 LCD_CmdWrite(0x76);
 LCD_DataWrite(0xC0);
 Check_Busy_Draw();
}

void Start_Left_Down_Curve(void)
{
 LCD_CmdWrite(0x76);
 LCD_DataWrite(0x90);
 Check_Busy_Draw();
}
void Start_Left_Up_Curve(void)
{
 LCD_CmdWrite(0x76);
 LCD_DataWrite(0x91);
 Check_Busy_Draw();
}
void Start_Right_Up_Curve(void)
{
 LCD_CmdWrite(0x76);
 LCD_DataWrite(0x92);
 Check_Busy_Draw();
}
void Start_Right_Down_Curve(void)
{
 LCD_CmdWrite(0x76);
 LCD_DataWrite(0x93);
 Check_Busy_Draw();
}

void Start_Left_Down_Curve_Fill(void)
{
 LCD_CmdWrite(0x76);
 LCD_DataWrite(0xD0);
 Check_Busy_Draw();
}
void Start_Left_Up_Curve_Fill(void)
{
 LCD_CmdWrite(0x76);
 LCD_DataWrite(0xD1);
 Check_Busy_Draw();
}
void Start_Right_Up_Curve_Fill(void)
{
 LCD_CmdWrite(0x76);
 LCD_DataWrite(0xD2);
 Check_Busy_Draw();
}
void Start_Right_Down_Curve_Fill(void)
{
 LCD_CmdWrite(0x76);
 LCD_DataWrite(0xD3);
 Check_Busy_Draw();
}

void Start_Square(void)
{
 LCD_CmdWrite(0x76);
 LCD_DataWrite(0xA0);
 Check_Busy_Draw();
}
void Start_Square_Fill(void)
{
 LCD_CmdWrite(0x76);
 LCD_DataWrite(0xE0);
 Check_Busy_Draw();
}
void Start_Circle_Square(void)
{
 LCD_CmdWrite(0x76);
 LCD_DataWrite(0xB0);
 Check_Busy_Draw();
}
void Start_Circle_Square_Fill(void)
{
 LCD_CmdWrite(0x76);
 LCD_DataWrite(0xF0);
 Check_Busy_Draw();
}


void Circle_Center_XY(unsigned short WX,unsigned short HY)
{






 LCD_CmdWrite(0x7B);
 LCD_DataWrite(WX);

 LCD_CmdWrite(0x7C);
 LCD_DataWrite(WX>>8);

 LCD_CmdWrite(0x7D);
 LCD_DataWrite(HY);

 LCD_CmdWrite(0x7E);
 LCD_DataWrite(HY>>8);
}

void Ellipse_Center_XY(unsigned short WX,unsigned short HY)
{






 LCD_CmdWrite(0x7B);
 LCD_DataWrite(WX);

 LCD_CmdWrite(0x7C);
 LCD_DataWrite(WX>>8);

 LCD_CmdWrite(0x7D);
 LCD_DataWrite(HY);

 LCD_CmdWrite(0x7E);
 LCD_DataWrite(HY>>8);
}

void Circle_Radius_R(unsigned short WX)
{






 LCD_CmdWrite(0x77);
 LCD_DataWrite(WX);

 LCD_CmdWrite(0x78);
 LCD_DataWrite(WX>>8);

 LCD_CmdWrite(0x79);
 LCD_DataWrite(WX);

 LCD_CmdWrite(0x7A);
 LCD_DataWrite(WX>>8);
}


void Ellipse_Radius_RxRy(unsigned short WX,unsigned short HY)
{






 LCD_CmdWrite(0x77);
 LCD_DataWrite(WX);

 LCD_CmdWrite(0x78);
 LCD_DataWrite(WX>>8);

 LCD_CmdWrite(0x79);
 LCD_DataWrite(HY);

 LCD_CmdWrite(0x7A);
 LCD_DataWrite(HY>>8);
}


void Circle_Square_Radius_RxRy(unsigned short WX,unsigned short HY)
{






 LCD_CmdWrite(0x77);
 LCD_DataWrite(WX);

 LCD_CmdWrite(0x78);
 LCD_DataWrite(WX>>8);

 LCD_CmdWrite(0x79);
 LCD_DataWrite(HY);

 LCD_CmdWrite(0x7A);
 LCD_DataWrite(HY>>8);
}


void Set_PWM_Prescaler_1_to_256(unsigned short WX)
{





 WX=WX-1;
 LCD_CmdWrite(0x84);
 LCD_DataWrite(WX);
}

void Select_PWM1_Clock_Divided_By_1(void)
{




 unsigned char temp;

 LCD_CmdWrite(0x85);
 temp = LCD_DataRead();
 temp &= 0x7f;
 temp &= 0xbf;
 LCD_DataWrite(temp);
}
void Select_PWM1_Clock_Divided_By_2(void)
{




 unsigned char temp;

 LCD_CmdWrite(0x85);
 temp = LCD_DataRead();
 temp &= 0x7f;
 temp |= 0x40;
 LCD_DataWrite(temp);
}
void Select_PWM1_Clock_Divided_By_4(void)
{




 unsigned char temp;

 LCD_CmdWrite(0x85);
 temp = LCD_DataRead();
 temp |= 0x80;
 temp &= 0xbf;
 LCD_DataWrite(temp);
}
void Select_PWM1_Clock_Divided_By_8(void)
{




 unsigned char temp;

 LCD_CmdWrite(0x85);
 temp = LCD_DataRead();
 temp |= 0x80;
 temp |= 0x40;
 LCD_DataWrite(temp);
}
void Select_PWM0_Clock_Divided_By_1(void)
{




 unsigned char temp;

 LCD_CmdWrite(0x85);
 temp = LCD_DataRead();
 temp &= 0xdf;
 temp &= 0xef;
 LCD_DataWrite(temp);
}
void Select_PWM0_Clock_Divided_By_2(void)
{




 unsigned char temp;

 LCD_CmdWrite(0x85);
 temp = LCD_DataRead();
 temp &= 0xdf;
 temp |= 0x10;
 LCD_DataWrite(temp);
}
void Select_PWM0_Clock_Divided_By_4(void)
{




 unsigned char temp;

 LCD_CmdWrite(0x85);
 temp = LCD_DataRead();
 temp |= 0x20;
 temp &= 0xef;
 LCD_DataWrite(temp);
}
void Select_PWM0_Clock_Divided_By_8(void)
{




 unsigned char temp;

 LCD_CmdWrite(0x85);
 temp = LCD_DataRead();
 temp |= 0x20;
 temp |= 0x10;
 LCD_DataWrite(temp);
}
# 5158 "./RA8876.h"
void Select_PWM1_is_ErrorFlag(void)
{
 unsigned char temp;

 LCD_CmdWrite(0x85);
 temp = LCD_DataRead();
 temp &= 0xf7;
 LCD_DataWrite(temp);
}
void Select_PWM1(void)
{
 unsigned char temp;

 LCD_CmdWrite(0x85);
 temp = LCD_DataRead();
 temp |= 0x08;
 temp &= 0xfb;
 LCD_DataWrite(temp);
}
void Select_PWM1_is_Osc_Clock(void)
{
 unsigned char temp;

 LCD_CmdWrite(0x85);
 temp = LCD_DataRead();
 temp |= 0x08;
 temp |= 0x04;
 LCD_DataWrite(temp);
}







void Select_PWM0_is_GPIO_C7(void)
{
 unsigned char temp;

 LCD_CmdWrite(0x85);
 temp = LCD_DataRead();
 temp &= 0xfd;
 LCD_DataWrite(temp);
}
void Select_PWM0(void)
{
 unsigned char temp;

 LCD_CmdWrite(0x85);
 temp = LCD_DataRead();
 temp |= 0x02;
 temp &= 0xfe;
 LCD_DataWrite(temp);
}
void Select_PWM0_is_Core_Clock(void)
{
 unsigned char temp;

 LCD_CmdWrite(0x85);
 temp = LCD_DataRead();
 temp |= 0x02;
 temp |= 0x01;
 LCD_DataWrite(temp);
}


void Enable_PWM1_Inverter(void)
{






 unsigned char temp;
 LCD_CmdWrite(0x86);
 temp = LCD_DataRead();
 temp |= 0x40;
 LCD_DataWrite(temp);
}
void Disable_PWM1_Inverter(void)
{






 unsigned char temp;
 LCD_CmdWrite(0x86);
 temp = LCD_DataRead();
 temp &= 0xbf;
 LCD_DataWrite(temp);
}
void Auto_Reload_PWM1(void)
{






 unsigned char temp;
 LCD_CmdWrite(0x86);
 temp = LCD_DataRead();
 temp |= 0x20;
 LCD_DataWrite(temp);
}
void One_Shot_PWM1(void)
{






 unsigned char temp;
 LCD_CmdWrite(0x86);
 temp = LCD_DataRead();
 temp &= 0xdf;
 LCD_DataWrite(temp);
}
void Start_PWM1(void)
{






 unsigned char temp;
 LCD_CmdWrite(0x86);
 temp = LCD_DataRead();
 temp |= 0x10;
 LCD_DataWrite(temp);
}
void Stop_PWM1(void)
{






 unsigned char temp;
 LCD_CmdWrite(0x86);
 temp = LCD_DataRead();
 temp &= 0xef;
 LCD_DataWrite(temp);
}

void Enable_PWM0_Dead_Zone(void)
{




 unsigned char temp;
 LCD_CmdWrite(0x86);
 temp = LCD_DataRead();
 temp |= 0x08;
 LCD_DataWrite(temp);
}
void Disable_PWM0_Dead_Zone(void)
{




 unsigned char temp;
 LCD_CmdWrite(0x86);
 temp = LCD_DataRead();
 temp &= 0xf7;
 LCD_DataWrite(temp);
}
void Enable_PWM0_Inverter(void)
{






 unsigned char temp;
 LCD_CmdWrite(0x86);
 temp = LCD_DataRead();
 temp |= 0x04;
 LCD_DataWrite(temp);
}
void Disable_PWM0_Inverter(void)
{






 unsigned char temp;
 LCD_CmdWrite(0x86);
 temp = LCD_DataRead();
 temp &= 0xfb;
 LCD_DataWrite(temp);
}
void Auto_Reload_PWM0(void)
{






 unsigned char temp;
 LCD_CmdWrite(0x86);
 temp = LCD_DataRead();
 temp |= 0x02;
 LCD_DataWrite(temp);
}
void One_Shot_PWM0(void)
{






 unsigned char temp;
 LCD_CmdWrite(0x86);
 temp = LCD_DataRead();
 temp &= 0xfd;
 LCD_DataWrite(temp);
}
void Start_PWM0(void)
{






 unsigned char temp;
 LCD_CmdWrite(0x86);
 temp = LCD_DataRead();
 temp |= 0x01;
 LCD_DataWrite(temp);
}
void Stop_PWM0(void)
{






 unsigned char temp;
 LCD_CmdWrite(0x86);
 temp = LCD_DataRead();
 temp &= 0xfe;
 LCD_DataWrite(temp);
}

void Set_Timer0_Dead_Zone_Length(unsigned char temp)
{





 LCD_CmdWrite(0x87);
 LCD_DataWrite(temp);
}

void Set_Timer0_Compare_Buffer(unsigned short WX)
{






 LCD_CmdWrite(0x88);
 LCD_DataWrite(WX);
 LCD_CmdWrite(0x89);
 LCD_DataWrite(WX>>8);
}

void Set_Timer0_Count_Buffer(unsigned short WX)
{






 LCD_CmdWrite(0x8A);
 LCD_DataWrite(WX);
 LCD_CmdWrite(0x8B);
 LCD_DataWrite(WX>>8);
}

void Set_Timer1_Compare_Buffer(unsigned short WX)
{






 LCD_CmdWrite(0x8C);
 LCD_DataWrite(WX);
 LCD_CmdWrite(0x8D);
 LCD_DataWrite(WX>>8);
}

void Set_Timer1_Count_Buffer(unsigned short WX)
{






 LCD_CmdWrite(0x8E);
 LCD_DataWrite(WX);
 LCD_CmdWrite(0x8F);
 LCD_DataWrite(WX>>8);
}





void BTE_Enable(void)
{





    unsigned char temp;
    LCD_CmdWrite(0x90);
    temp = LCD_DataRead();
    temp |= 0x10 ;
 LCD_DataWrite(temp);
}


void BTE_Disable(void)
{





    unsigned char temp;
    LCD_CmdWrite(0x90);
    temp = LCD_DataRead();
    temp &= 0xef ;
 LCD_DataWrite(temp);
}


void Check_BTE_Busy(void)
{





 unsigned char temp;
 do
 {
  temp=LCD_StatusRead();
 }while(temp&0x08);

}

void Pattern_Format_8X8(void)
{





    unsigned char temp;
    LCD_CmdWrite(0x90);
    temp = LCD_DataRead();
    temp &= 0xfe ;
 LCD_DataWrite(temp);
}

void Pattern_Format_16X16(void)
{





    unsigned char temp;
    LCD_CmdWrite(0x90);
    temp = LCD_DataRead();
    temp |= 0x01 ;
   LCD_DataWrite(temp);
}


void BTE_ROP_Code(unsigned char setx)
{
# 5586 "./RA8876.h"
    unsigned char temp;
    LCD_CmdWrite(0x91);
    temp = LCD_DataRead();
    temp &= 0x0f ;
  temp |= (setx<<4);
   LCD_DataWrite(temp);
}


void BTE_Operation_Code(unsigned char setx)
{
# 5617 "./RA8876.h"
    unsigned char temp;
    LCD_CmdWrite(0x91);
    temp = LCD_DataRead();
    temp &= 0xf0 ;
  temp |= setx ;
   LCD_DataWrite(temp);

}

void BTE_S0_Color_8bpp(void)
{






    unsigned char temp;
    LCD_CmdWrite(0x92);
    temp = LCD_DataRead();
    temp &= 0xbf ;
  temp &= 0xdf ;
   LCD_DataWrite(temp);
}

void BTE_S0_Color_16bpp(void)
{






    unsigned char temp;
    LCD_CmdWrite(0x92);
    temp = LCD_DataRead();
    temp &= 0xbf ;
  temp |= 0x20 ;
   LCD_DataWrite(temp);

}

void BTE_S0_Color_24bpp(void)
{






    unsigned char temp;
    LCD_CmdWrite(0x92);
    temp = LCD_DataRead();
    temp |= 0x40 ;

   LCD_DataWrite(temp);
}

void BTE_S1_Color_8bpp(void)
{
# 5686 "./RA8876.h"
    unsigned char temp;
    LCD_CmdWrite(0x92);
    temp = LCD_DataRead();
    temp &= 0xef ;
  temp &= 0xf7 ;
   temp &= 0xfb ;
   LCD_DataWrite(temp);
}

void BTE_S1_Color_16bpp(void)
{
# 5706 "./RA8876.h"
    unsigned char temp;
    LCD_CmdWrite(0x92);
    temp = LCD_DataRead();
    temp &= 0xef ;
  temp &= 0xf7 ;
   temp |= 0x04 ;
   LCD_DataWrite(temp);

}

void BTE_S1_Color_24bpp(void)
{
# 5727 "./RA8876.h"
    unsigned char temp;
    LCD_CmdWrite(0x92);
    temp = LCD_DataRead();
    temp &= 0xef ;
  temp |= 0x08 ;
   temp &= 0xfb ;
   LCD_DataWrite(temp);
}


void BTE_S1_Color_Constant(void)
{
# 5748 "./RA8876.h"
    unsigned char temp;
    LCD_CmdWrite(0x92);
    temp = LCD_DataRead();
    temp &= 0xef ;
  temp |= 0x08 ;
   temp |= 0x04 ;
   LCD_DataWrite(temp);
}




void BTE_S1_Color_8bit_Alpha(void)
{
# 5771 "./RA8876.h"
    unsigned char temp;
    LCD_CmdWrite(0x92);
    temp = LCD_DataRead();
    temp |= 0x10 ;
  temp &= 0xf7 ;
   temp &= 0xfb ;
   LCD_DataWrite(temp);
}


void BTE_S1_Color_16bit_Alpha(void)
{
# 5792 "./RA8876.h"
    unsigned char temp;
    LCD_CmdWrite(0x92);
    temp = LCD_DataRead();
    temp |= 0x10 ;
  temp &= 0xf7 ;
   temp |= 0x04 ;
   LCD_DataWrite(temp);
}


void BTE_Destination_Color_8bpp(void)
{






    unsigned char temp;
    LCD_CmdWrite(0x92);
    temp = LCD_DataRead();
    temp &= 0xfd ;
  temp &= 0xfe ;
   LCD_DataWrite(temp);
}

void BTE_Destination_Color_16bpp(void)
{






    unsigned char temp;
    LCD_CmdWrite(0x92);
    temp = LCD_DataRead();
    temp &= 0xfd ;
  temp |= 0x01 ;
   LCD_DataWrite(temp);

}

void BTE_Destination_Color_24bpp(void)
{






    unsigned char temp;
    LCD_CmdWrite(0x92);
    temp = LCD_DataRead();
    temp |= 0x02 ;

   LCD_DataWrite(temp);
}



void BTE_S0_Memory_Start_Address(unsigned long Addr)
{







 LCD_RegisterWrite(0x93,Addr);
 LCD_RegisterWrite(0x94,Addr>>8);
 LCD_RegisterWrite(0x95,Addr>>16);
 LCD_RegisterWrite(0x96,Addr>>24);
}



void BTE_S0_Image_Width(unsigned short WX)
{






 LCD_RegisterWrite(0x97,WX);
 LCD_RegisterWrite(0x98,WX>>8);
}



void BTE_S0_Window_Start_XY(unsigned short WX,unsigned short HY)
{






 LCD_RegisterWrite(0x99,WX);
 LCD_RegisterWrite(0x9A,WX>>8);

 LCD_RegisterWrite(0x9B,HY);
 LCD_RegisterWrite(0x9C,HY>>8);
}





void BTE_S1_Memory_Start_Address(unsigned long Addr)
{







 LCD_RegisterWrite(0x9D,Addr);
 LCD_RegisterWrite(0x9E,Addr>>8);
 LCD_RegisterWrite(0x9F,Addr>>16);
 LCD_RegisterWrite(0xA0,Addr>>24);
}



void S1_Constant_color_256(unsigned char temp)
{
    LCD_CmdWrite(0x9D);
    LCD_DataWrite(temp);

    LCD_CmdWrite(0x9E);
    LCD_DataWrite(temp<<3);

    LCD_CmdWrite(0x9F);
    LCD_DataWrite(temp<<6);
}


void S1_Constant_color_65k(unsigned short temp)
{
    LCD_CmdWrite(0x9D);
    LCD_DataWrite(temp>>8);

    LCD_CmdWrite(0x9E);
    LCD_DataWrite(temp>>3);

    LCD_CmdWrite(0x9F);
    LCD_DataWrite(temp<<3);
}


void S1_Constant_color_16M(unsigned long temp)
{
    LCD_CmdWrite(0x9D);
    LCD_DataWrite(temp>>16);

    LCD_CmdWrite(0x9E);
    LCD_DataWrite(temp>>8);

    LCD_CmdWrite(0x9F);
    LCD_DataWrite(temp);
}





void BTE_S1_Image_Width(unsigned short WX)
{






 LCD_RegisterWrite(0xA1,WX);
 LCD_RegisterWrite(0xA2,WX>>8);
}



void BTE_S1_Window_Start_XY(unsigned short WX,unsigned short HY)
{






 LCD_RegisterWrite(0xA3,WX);
 LCD_RegisterWrite(0xA4,WX>>8);

 LCD_RegisterWrite(0xA5,HY);
 LCD_RegisterWrite(0xA6,HY>>8);
}





void BTE_Destination_Memory_Start_Address(unsigned long Addr)
{







 LCD_RegisterWrite(0xA7,Addr);
 LCD_RegisterWrite(0xA8,Addr>>8);
 LCD_RegisterWrite(0xA9,Addr>>16);
 LCD_RegisterWrite(0xAA,Addr>>24);
}



void BTE_Destination_Image_Width(unsigned short WX)
{






 LCD_RegisterWrite(0xAB,WX);
 LCD_RegisterWrite(0xAC,WX>>8);
}



void BTE_Destination_Window_Start_XY(unsigned short WX,unsigned short HY)
{






 LCD_RegisterWrite(0xAD,WX);
 LCD_RegisterWrite(0xAE,WX>>8);

 LCD_RegisterWrite(0xAF,HY);
 LCD_RegisterWrite(0xB0,HY>>8);
}




void BTE_Window_Size(unsigned short WX, unsigned short WY)

{







        LCD_RegisterWrite(0xB1,WX);
        LCD_RegisterWrite(0xB2,WX>>8);

     LCD_RegisterWrite(0xB3,WY);
        LCD_RegisterWrite(0xB4,WY>>8);
}


void BTE_Alpha_Blending_Effect(unsigned char temp)
{
# 6078 "./RA8876.h"
    LCD_CmdWrite(0xB5);
 LCD_DataWrite(temp);
}



void Start_SFI_DMA(void)
{
 unsigned char temp;
 LCD_CmdWrite(0xB6);
 temp = LCD_DataRead();
    temp |= 0x01;
 LCD_DataWrite(temp);
}

void Check_Busy_SFI_DMA(void)
{
 LCD_CmdWrite(0xB6);
 do
 {
 }while((LCD_DataRead()&0x01)==0x01);
}



void Select_SFI_0(void)
{





 unsigned char temp;
 LCD_CmdWrite(0xB7);
 temp = LCD_DataRead();
    temp &= 0x7f;
 LCD_DataWrite(temp);
}
void Select_SFI_1(void)
{





 unsigned char temp;
 LCD_CmdWrite(0xB7);
 temp = LCD_DataRead();
    temp |= 0x80;
 LCD_DataWrite(temp);
}
void Select_SFI_Font_Mode(void)
{





 unsigned char temp;
 LCD_CmdWrite(0xB7);
 temp = LCD_DataRead();
    temp &= 0xbf;
 LCD_DataWrite(temp);
}
void Select_SFI_DMA_Mode(void)
{





 unsigned char temp;
 LCD_CmdWrite(0xB7);
 temp = LCD_DataRead();
    temp |= 0x40;
 LCD_DataWrite(temp);
}
void Select_SFI_24bit_Address(void)
{





 unsigned char temp;
 LCD_CmdWrite(0xB7);
 temp = LCD_DataRead();
    temp &= 0xdf;
 LCD_DataWrite(temp);
}
void Select_SFI_32bit_Address(void)
{





 unsigned char temp;
 LCD_CmdWrite(0xB7);
 temp = LCD_DataRead();
    temp |= 0x20;
 LCD_DataWrite(temp);
}
void Select_SFI_Waveform_Mode_0(void)
{





 unsigned char temp;
 LCD_CmdWrite(0xB7);
 temp = LCD_DataRead();
    temp &= 0xef;
 LCD_DataWrite(temp);
}
void Select_SFI_Waveform_Mode_3(void)
{





 unsigned char temp;
 LCD_CmdWrite(0xB7);
 temp = LCD_DataRead();
    temp |= 0x10;
 LCD_DataWrite(temp);
}
void Select_SFI_0_DummyRead(void)
{







 unsigned char temp;
 LCD_CmdWrite(0xB7);
 temp = LCD_DataRead();
 temp &= 0xF3;
 LCD_DataWrite(temp);
}
void Select_SFI_8_DummyRead(void)
{
 unsigned char temp;
 LCD_CmdWrite(0xB7);
 temp = LCD_DataRead();
 temp &= 0xF3;
    temp |= 0x04;
 LCD_DataWrite(temp);
}
void Select_SFI_16_DummyRead(void)
{

 unsigned char temp;
 LCD_CmdWrite(0xB7);
 temp = LCD_DataRead();
 temp &= 0xF3;
    temp |= 0x08;
 LCD_DataWrite(temp);
}
void Select_SFI_24_DummyRead(void)
{
 unsigned char temp;
 LCD_CmdWrite(0xB7);
 temp = LCD_DataRead();
    temp |= 0x0c;
 LCD_DataWrite(temp);
}
void Select_SFI_Single_Mode(void)
{






 unsigned char temp;
 LCD_CmdWrite(0xB7);
 temp = LCD_DataRead();
 temp &= 0xFC;
 LCD_DataWrite(temp);
}
void Select_SFI_Dual_Mode0(void)
{
 unsigned char temp;
 LCD_CmdWrite(0xB7);
 temp = LCD_DataRead();
 temp &= 0xFC;
    temp |= 0x02;
 LCD_DataWrite(temp);
}
void Select_SFI_Dual_Mode1(void)
{
 unsigned char temp;
 LCD_CmdWrite(0xB7);
 temp = LCD_DataRead();
    temp |= 0x03;
 LCD_DataWrite(temp);
}


unsigned char SPI_Master_FIFO_Data_Put(unsigned char Data)
{
    unsigned char temp;
 LCD_CmdWrite(0xB8);
 LCD_DataWrite(Data);
 while(Tx_FIFO_Empty_Flag()==0);
 temp = SPI_Master_FIFO_Data_Get();
 return temp;
}

unsigned char SPI_Master_FIFO_Data_Get(void)
{
   unsigned char temp;

 while(Rx_FIFO_Empty_Flag()==1);
 LCD_CmdWrite(0xB8);
 temp=LCD_DataRead();

   return temp;
}


void Mask_SPI_Master_Interrupt_Flag(void)
{
  unsigned char temp;
  LCD_CmdWrite(0xB9);
  temp = LCD_DataRead();
  temp |= 0x40;
  LCD_DataWrite(temp);

}

void Select_nSS_drive_on_xnsfcs0(void)
{
  unsigned char temp;
  LCD_CmdWrite(0xB9);
  temp = LCD_DataRead();
  temp &= 0xdf;
  LCD_DataWrite(temp);

}

void Select_nSS_drive_on_xnsfcs1(void)
{
  unsigned char temp;
  LCD_CmdWrite(0xB9);
  temp = LCD_DataRead();
  temp |= 0x20;
  LCD_DataWrite(temp);

}


void nSS_Inactive(void)
{
  unsigned char temp;
  LCD_CmdWrite(0xB9);
  temp = LCD_DataRead();
  temp &= 0xef;
  LCD_DataWrite(temp);
}

void nSS_Active(void)
{
  unsigned char temp;
  LCD_CmdWrite(0xB9);
  temp = LCD_DataRead();
  temp |= 0x10;
  LCD_DataWrite(temp);
}


void OVFIRQEN_Enable(void)
{
  unsigned char temp;
  LCD_CmdWrite(0xB9);
  temp = LCD_DataRead();
  temp |= 0x08;
  LCD_DataWrite(temp);

}

void EMTIRQEN_Enable(void)
{
  unsigned char temp;
  LCD_CmdWrite(0xB9);
  temp = LCD_DataRead();
  temp |= 0x04;
  LCD_DataWrite(temp);
}
# 6386 "./RA8876.h"
void Reset_CPOL(void)
{
  unsigned char temp;
  LCD_CmdWrite(0xB9);
  temp = LCD_DataRead();
  temp &= 0xfd;
  LCD_DataWrite(temp);
}

void Set_CPOL(void)
{
  unsigned char temp;
  LCD_CmdWrite(0xB9);
  temp = LCD_DataRead();
  temp |= 0x02;
  LCD_DataWrite(temp);
}


void Reset_CPHA(void)
{
  unsigned char temp;
  LCD_CmdWrite(0xB9);
  temp = LCD_DataRead();
  temp &= 0xfe;
  LCD_DataWrite(temp);
}

void Set_CPHA(void)
{
  unsigned char temp;
  LCD_CmdWrite(0xB9);
  temp = LCD_DataRead();
  temp |= 0x01;
  LCD_DataWrite(temp);
}



unsigned char Tx_FIFO_Empty_Flag(void)
{
  LCD_CmdWrite(0xBA);
  if((LCD_DataRead()&0x80)==0x80)
  return 1;
  else
  return 0;
}

unsigned char Tx_FIFO_Full_Flag(void)
{
  LCD_CmdWrite(0xBA);
  if((LCD_DataRead()&0x40)==0x40)
  return 1;
  else
  return 0;
}

unsigned char Rx_FIFO_Empty_Flag(void)
{
  LCD_CmdWrite(0xBA);
  if((LCD_DataRead()&0x20)==0x20)
  return 1;
  else
  return 0;
}

unsigned char Rx_FIFO_full_flag(void)
{
   LCD_CmdWrite(0xBA);
   if((LCD_DataRead()&0x10)==0x10)
   return 1;
   else
   return 0;
}

unsigned char OVFI_Flag(void)
{
   LCD_CmdWrite(0xBA);
   if((LCD_DataRead()&0x08)==0x08)
   return 1;
   else
   return 0;
}

void Clear_OVFI_Flag(void)
{
   unsigned char temp;
   LCD_CmdWrite(0xBA);
   temp = LCD_DataRead();
   temp |= 0x08;
   LCD_DataWrite(temp);
}

unsigned char EMTI_Flag(void)
{
   LCD_CmdWrite(0xBA);
   if((LCD_DataRead()&0x04)==0x04)
   return 1;
   else
   return 0;
}

void Clear_EMTI_Flag(void)
{
   unsigned char temp;
   LCD_CmdWrite(0xBA);
   temp = LCD_DataRead();
   temp |= 0x04;
   LCD_DataWrite(temp);
}



void SPI_Clock_Period(unsigned char temp)
{
   LCD_CmdWrite(0xBB);
   LCD_DataWrite(temp);
}


void SFI_DMA_Source_Start_Address(unsigned long Addr)
{




 LCD_CmdWrite(0xBC);
 LCD_DataWrite(Addr);
 LCD_CmdWrite(0xBD);
 LCD_DataWrite(Addr>>8);
 LCD_CmdWrite(0xBE);
 LCD_DataWrite(Addr>>16);
 LCD_CmdWrite(0xBF);
 LCD_DataWrite(Addr>>24);
}

void SFI_DMA_Destination_Start_Address(unsigned long Addr)
{





 LCD_CmdWrite(0xC0);
 LCD_DataWrite(Addr);
 LCD_CmdWrite(0xC1);
 LCD_DataWrite(Addr>>8);
 LCD_CmdWrite(0xC2);
 LCD_DataWrite(Addr>>16);
 LCD_CmdWrite(0xC3);
 LCD_DataWrite(Addr>>24);
}

void SFI_DMA_Destination_Upper_Left_Corner(unsigned short WX,unsigned short HY)
{
# 6567 "./RA8876.h"
 LCD_CmdWrite(0xC0);
 LCD_DataWrite(WX);
 LCD_CmdWrite(0xC1);
 LCD_DataWrite(WX>>8);

 LCD_CmdWrite(0xC2);
 LCD_DataWrite(HY);
 LCD_CmdWrite(0xC3);
 LCD_DataWrite(HY>>8);
}




void SFI_DMA_Transfer_Number(unsigned long Addr)
{
# 6592 "./RA8876.h"
 LCD_CmdWrite(0xC6);
 LCD_DataWrite(Addr);
 LCD_CmdWrite(0xC7);
 LCD_DataWrite(Addr>>8);
 LCD_CmdWrite(0xC8);
 LCD_DataWrite(Addr>>16);
 LCD_CmdWrite(0xC9);
 LCD_DataWrite(Addr>>24);
}
void SFI_DMA_Transfer_Width_Height(unsigned short WX,unsigned short HY)
{
# 6611 "./RA8876.h"
 LCD_CmdWrite(0xC6);
 LCD_DataWrite(WX);
 LCD_CmdWrite(0xC7);
 LCD_DataWrite(WX>>8);

 LCD_CmdWrite(0xC8);
 LCD_DataWrite(HY);
 LCD_CmdWrite(0xC9);
 LCD_DataWrite(HY>>8);
}

void SFI_DMA_Source_Width(unsigned short WX)
{




 LCD_CmdWrite(0xCA);
 LCD_DataWrite(WX);
 LCD_CmdWrite(0xCB);
 LCD_DataWrite(WX>>8);
}



void Font_Select_UserDefine_Mode(void)
{






 unsigned char temp;
 LCD_CmdWrite(0xCC);
 temp = LCD_DataRead();
    temp |= 0x80;
 temp &= 0xbf;
 LCD_DataWrite(temp);
}
void CGROM_Select_Internal_CGROM(void)
{






 unsigned char temp;
 LCD_CmdWrite(0xCC);
 temp = LCD_DataRead();
 temp &= 0x7f;
    temp &= 0xbf;
 LCD_DataWrite(temp);
}
void CGROM_Select_Genitop_FontROM(void)
{






 unsigned char temp;
 LCD_CmdWrite(0xCC);
 temp = LCD_DataRead();
 temp &= 0x7f;
    temp |= 0x40;
 LCD_DataWrite(temp);
}
void Font_Select_8x16_16x16(void)
{
# 6692 "./RA8876.h"
 unsigned char temp;
 LCD_CmdWrite(0xCC);
 temp = LCD_DataRead();
    temp &= 0xdf;
    temp &= 0xef;
 LCD_DataWrite(temp);
}
void Font_Select_12x24_24x24(void)
{
# 6710 "./RA8876.h"
 unsigned char temp;
 LCD_CmdWrite(0xCC);
 temp = LCD_DataRead();
    temp &= 0xdf;
    temp |= 0x10;
 LCD_DataWrite(temp);
}
void Font_Select_16x32_32x32(void)
{
# 6728 "./RA8876.h"
 unsigned char temp;
 LCD_CmdWrite(0xCC);
 temp = LCD_DataRead();
    temp |= 0x20;
    temp &= 0xef;
 LCD_DataWrite(temp);
}
void Internal_CGROM_Select_ISOIEC8859_1(void)
{
# 6747 "./RA8876.h"
 unsigned char temp;
 LCD_CmdWrite(0xCC);
 temp = LCD_DataRead();
    temp &= 0xfd;
    temp &= 0xfe;
 LCD_DataWrite(temp);
}
void Internal_CGROM_Select_ISOIEC8859_2(void)
{
# 6766 "./RA8876.h"
 unsigned char temp;
 LCD_CmdWrite(0xCC);
 temp = LCD_DataRead();
    temp &= 0xfd;
    temp |= 0x01;
 LCD_DataWrite(temp);
}
void Internal_CGROM_Select_ISOIEC8859_3(void)
{
# 6785 "./RA8876.h"
 unsigned char temp;
 LCD_CmdWrite(0xCC);
 temp = LCD_DataRead();
    temp |= 0x02;
    temp &= 0xfe;
 LCD_DataWrite(temp);
}
void Internal_CGROM_Select_ISOIEC8859_4(void)
{
# 6804 "./RA8876.h"
 unsigned char temp;
 LCD_CmdWrite(0xCC);
 temp = LCD_DataRead();
    temp |= 0x02;
    temp |= 0x01;
 LCD_DataWrite(temp);
}

void Enable_Font_Alignment(void)
{





 unsigned char temp;
 LCD_CmdWrite(0xCD);
 temp = LCD_DataRead();
    temp |= 0x80;
 LCD_DataWrite(temp);
}
void Disable_Font_Alignment(void)
{





 unsigned char temp;
 LCD_CmdWrite(0xCD);
 temp = LCD_DataRead();
    temp &= 0x7f;
 LCD_DataWrite(temp);
}
void Font_Background_select_Transparency(void)
{





 unsigned char temp;
 LCD_CmdWrite(0xCD);
 temp = LCD_DataRead();
    temp |= 0x40;
 LCD_DataWrite(temp);
}
void Font_Background_select_Color(void)
{





 unsigned char temp;
 LCD_CmdWrite(0xCD);
 temp = LCD_DataRead();
    temp &= 0xbf;
 LCD_DataWrite(temp);
}
void Font_0_degree(void)
{
# 6876 "./RA8876.h"
 unsigned char temp;
 LCD_CmdWrite(0xCD);
 temp = LCD_DataRead();
    temp &= 0xef;
 LCD_DataWrite(temp);
}
void Font_90_degree(void)
{
# 6894 "./RA8876.h"
 unsigned char temp;
 LCD_CmdWrite(0xCD);
 temp = LCD_DataRead();
    temp |= 0x10;
 LCD_DataWrite(temp);
}
void Font_Width_X1(void)
{







 unsigned char temp;
 LCD_CmdWrite(0xCD);
 temp = LCD_DataRead();
    temp &= 0xf7;
    temp &= 0xfb;
 LCD_DataWrite(temp);
}
void Font_Width_X2(void)
{







 unsigned char temp;
 LCD_CmdWrite(0xCD);
 temp = LCD_DataRead();
    temp &= 0xf7;
    temp |= 0x04;
 LCD_DataWrite(temp);
}
void Font_Width_X3(void)
{







 unsigned char temp;
 LCD_CmdWrite(0xCD);
 temp = LCD_DataRead();
    temp |= 0x08;
    temp &= 0xfb;
 LCD_DataWrite(temp);
}
void Font_Width_X4(void)
{







 unsigned char temp;
 LCD_CmdWrite(0xCD);
 temp = LCD_DataRead();
    temp |= 0x08;
    temp |= 0x04;
 LCD_DataWrite(temp);
}
void Font_Height_X1(void)
{







 unsigned char temp;
 LCD_CmdWrite(0xCD);
 temp = LCD_DataRead();
    temp &= 0xfd;
    temp &= 0xfe;
 LCD_DataWrite(temp);
}
void Font_Height_X2(void)
{







 unsigned char temp;
 LCD_CmdWrite(0xCD);
 temp = LCD_DataRead();
    temp &= 0xfd;
    temp |= 0x01;
 LCD_DataWrite(temp);
}
void Font_Height_X3(void)
{







 unsigned char temp;
 LCD_CmdWrite(0xCD);
 temp = LCD_DataRead();
    temp |= 0x02;
    temp &= 0xfe;
 LCD_DataWrite(temp);
}
void Font_Height_X4(void)
{







 unsigned char temp;
 LCD_CmdWrite(0xCD);
 temp = LCD_DataRead();
    temp |= 0x02;
    temp |= 0x01;
 LCD_DataWrite(temp);
}


void GTFont_Select_GT21L16TW_GT21H16T1W(void)
{
# 7043 "./RA8876.h"
 unsigned char temp;
 LCD_CmdWrite(0xCE);
 temp = LCD_DataRead();
    temp &= 0x7f;
    temp &= 0xbf;
    temp &= 0xdf;
 LCD_DataWrite(temp);
}
void GTFont_Select_GT23L16U2W(void)
{
# 7064 "./RA8876.h"
 unsigned char temp;
 LCD_CmdWrite(0xCE);
 temp = LCD_DataRead();
    temp &= 0x7f;
    temp &= 0xbf;
    temp |= 0x20;
 LCD_DataWrite(temp);
}
void GTFont_Select_GT23L24T3Y_GT23H24T3Y(void)
{
# 7085 "./RA8876.h"
 unsigned char temp;
 LCD_CmdWrite(0xCE);
 temp = LCD_DataRead();
    temp &= 0x7f;
    temp |= 0x40;
    temp &= 0xdf;
 LCD_DataWrite(temp);
}
void GTFont_Select_GT23L24M1Z(void)
{
# 7106 "./RA8876.h"
 unsigned char temp;
 LCD_CmdWrite(0xCE);
 temp = LCD_DataRead();
    temp &= 0x7f;
    temp |= 0x40;
    temp |= 0x20;
 LCD_DataWrite(temp);
}
void GTFont_Select_GT23L32S4W_GT23H32S4W(void)
{
# 7127 "./RA8876.h"
 unsigned char temp;
 LCD_CmdWrite(0xCE);
 temp = LCD_DataRead();
    temp |= 0x80;
    temp &= 0xbf;
    temp &= 0xdf;
 LCD_DataWrite(temp);
}
void GTFont_Select_GT20L24F6Y(void)
{
# 7148 "./RA8876.h"
 unsigned char temp;
 LCD_CmdWrite(0xCE);
 temp = LCD_DataRead();
    temp |= 0x80;
    temp &= 0xbf;
    temp |= 0x20;
 LCD_DataWrite(temp);
}
void GTFont_Select_GT21L24S1W(void)
{
# 7169 "./RA8876.h"
 unsigned char temp;
 LCD_CmdWrite(0xCE);
 temp = LCD_DataRead();
    temp |= 0x80;
    temp |= 0x40;
    temp &= 0xdf;
 LCD_DataWrite(temp);
}
void GTFont_Select_GT22L16A1Y(void)
{
# 7190 "./RA8876.h"
 unsigned char temp;
 LCD_CmdWrite(0xCE);
 temp = LCD_DataRead();
    temp |= 0x80;
    temp |= 0x40;
    temp |= 0x20;
 LCD_DataWrite(temp);
}


void Set_GTFont_Decoder(unsigned char temp)
{
# 7239 "./RA8876.h"
 LCD_CmdWrite(0xCF);
 LCD_DataWrite(temp);
}

void Font_Line_Distance(unsigned char temp)
{





 LCD_CmdWrite(0xD0);
 LCD_DataWrite(temp);
}

void Set_Font_to_Font_Width(unsigned char temp)
{



 LCD_CmdWrite(0xD1);
 LCD_DataWrite(temp);
}

void Foreground_RGB(unsigned char RED,unsigned char GREEN,unsigned char BLUE)
{





    LCD_CmdWrite(0xD2);
 LCD_DataWrite(RED);

    LCD_CmdWrite(0xD3);
 LCD_DataWrite(GREEN);

    LCD_CmdWrite(0xD4);
 LCD_DataWrite(BLUE);
}


void Foreground_color_256(unsigned char temp)
{
    LCD_CmdWrite(0xD2);
 LCD_DataWrite(temp);

    LCD_CmdWrite(0xD3);
 LCD_DataWrite(temp<<3);

    LCD_CmdWrite(0xD4);
 LCD_DataWrite(temp<<6);
}


void Foreground_color_65k(unsigned short temp)
{
    LCD_CmdWrite(0xD2);
 LCD_DataWrite(temp>>8);

    LCD_CmdWrite(0xD3);
 LCD_DataWrite(temp>>3);

    LCD_CmdWrite(0xD4);
 LCD_DataWrite(temp<<3);
}


void Foreground_color_16M(unsigned long temp)
{
    LCD_CmdWrite(0xD2);
 LCD_DataWrite(temp>>16);

    LCD_CmdWrite(0xD3);
 LCD_DataWrite(temp>>8);

    LCD_CmdWrite(0xD4);
 LCD_DataWrite(temp);
}
# 7327 "./RA8876.h"
void Background_RGB(unsigned char RED,unsigned char GREEN,unsigned char BLUE)
{

    LCD_CmdWrite(0xD5);
 LCD_DataWrite(RED);

    LCD_CmdWrite(0xD6);
 LCD_DataWrite(GREEN);

    LCD_CmdWrite(0xD7);
 LCD_DataWrite(BLUE);
}


void Background_color_256(unsigned char temp)
{
    LCD_CmdWrite(0xD5);
 LCD_DataWrite(temp);

    LCD_CmdWrite(0xD6);
 LCD_DataWrite(temp<<3);

    LCD_CmdWrite(0xD7);
 LCD_DataWrite(temp<<6);
}


void Background_color_65k(unsigned short temp)
{
    LCD_CmdWrite(0xD5);
 LCD_DataWrite(temp>>8);

    LCD_CmdWrite(0xD6);
 LCD_DataWrite(temp>>3);

    LCD_CmdWrite(0xD7);
 LCD_DataWrite(temp<<3);
}


void Background_color_16M(unsigned long temp)
{
    LCD_CmdWrite(0xD5);
 LCD_DataWrite(temp>>16);

    LCD_CmdWrite(0xD6);
 LCD_DataWrite(temp>>8);

    LCD_CmdWrite(0xD7);
 LCD_DataWrite(temp);
}


void CGRAM_Start_address(unsigned long Addr)
{



    LCD_CmdWrite(0xDB);
 LCD_DataWrite(Addr);
    LCD_CmdWrite(0xDC);
 LCD_DataWrite(Addr>>8);
    LCD_CmdWrite(0xDD);
 LCD_DataWrite(Addr>>16);
    LCD_CmdWrite(0xDE);
 LCD_DataWrite(Addr>>24);
}
# 7406 "./RA8876.h"
void Power_Normal_Mode(void)
{
 LCD_CmdWrite(0xDF);
 LCD_DataWrite(0x00);
}
void Power_Saving_Standby_Mode(void)
{
 LCD_CmdWrite(0xDF);
 LCD_DataWrite(0x01);
 LCD_CmdWrite(0xDF);
 LCD_DataWrite(0x81);
}
void Power_Saving_Suspend_Mode(void)
{
 LCD_CmdWrite(0xDF);


 LCD_DataWrite(0x82);
}
void Power_Saving_Sleep_Mode(void)
{
 LCD_CmdWrite(0xDF);


 LCD_DataWrite(0x83);
}



void RA8876_I2CM_Clock_Prescale(unsigned short WX)
{




    LCD_CmdWrite(0xE5);
 LCD_DataWrite(WX);
    LCD_CmdWrite(0xE6);
 LCD_DataWrite(WX>>8);
}

void RA8876_I2CM_Transmit_Data(unsigned char temp)
{



    LCD_CmdWrite(0xE7);
 LCD_DataWrite(temp);
}

unsigned char RA8876_I2CM_Receiver_Data(void)
{



 unsigned char temp;
    LCD_CmdWrite(0xE8);
 temp=LCD_DataRead();
 return temp;
}
# 7492 "./RA8876.h"
void RA8876_I2CM_Stop(void)
{
 LCD_CmdWrite(0xE9);







}
void RA8876_I2CM_Read_With_Ack(void)
{

 LCD_CmdWrite(0xE9);






}

void RA8876_I2CM_Read_With_Nack(void)
{

 LCD_CmdWrite(0xE9);






}

void RA8876_I2CM_Write_With_Start(void)
{
 LCD_CmdWrite(0xE9);
# 7538 "./RA8876.h"
}

void RA8876_I2CM_Write(void)
{
 LCD_CmdWrite(0xE9);






}
# 7558 "./RA8876.h"
unsigned char RA8876_I2CM_Check_Slave_ACK(void)
{
unsigned char temp;





 LCD_CmdWrite(0xEA);
 temp=LCD_DataRead();
 if((temp&0x80)==0x80)
  return 1;
 else
  return 0;
}






unsigned char RA8876_I2CM_Bus_Busy(void)
{
 unsigned char temp;






 LCD_CmdWrite(0xEA);
 temp=LCD_DataRead();
 if((temp&0x40)==0x40)
  return 1;
 else
  return 0;
}





unsigned char RA8876_I2CM_transmit_Progress(void)
{
 unsigned char temp;




 LCD_CmdWrite(0xEA);
 temp=LCD_DataRead();
 if((temp&0x02)==0x02)
 return 1;
 else
 return 0;
}





unsigned char RA8876_I2CM_Arbitration(void)
{
 unsigned char temp;





 LCD_CmdWrite(0xEA);
 temp=LCD_DataRead();
 temp&=0x01;
 return temp;
}



void Set_GPIO_A_In_Out(unsigned char temp)
{





 LCD_CmdWrite(0xF0);
 LCD_DataWrite(temp);
}

void Write_GPIO_A_7_0(unsigned char temp)
{




 LCD_CmdWrite(0xF1);
 LCD_DataWrite(temp);
}
unsigned char Read_GPIO_A_7_0(void)
{




 unsigned char temp;
 LCD_CmdWrite(0xF1);
 temp=LCD_DataRead();
 return temp;
}

void Write_GPIO_B_7_4(unsigned char temp)
{




 LCD_CmdWrite(0xF2);
 LCD_DataWrite(temp);
}
unsigned char Read_GPIO_B_7_0(void)
{




 unsigned char temp;
 LCD_CmdWrite(0xF2);
 temp=LCD_DataRead();
 return temp;
}


void Set_GPIO_C_In_Out(unsigned char temp)
{





 LCD_CmdWrite(0xF3);
 LCD_DataWrite(temp);
}

void Write_GPIO_C_7_0(unsigned char temp)
{




 LCD_CmdWrite(0xF4);
 LCD_DataWrite(temp);
}
unsigned char Read_GPIO_C_7_0(void)
{




 unsigned char temp;
 LCD_CmdWrite(0xF4);
 temp=LCD_DataRead();
 return temp;
}

void Set_GPIO_D_In_Out(unsigned char temp)
{





 LCD_CmdWrite(0xF5);
 LCD_DataWrite(temp);
}

void Write_GPIO_D_7_0(unsigned char temp)
{



 LCD_CmdWrite(0xF6);
 LCD_DataWrite(temp);
}
unsigned char Read_GPIO_D_7_0(void)
{



 unsigned char temp;
 LCD_CmdWrite(0xF6);
 temp=LCD_DataRead();
 return temp;
}

void Set_GPIO_E_In_Out(unsigned char temp)
{





 LCD_CmdWrite(0xF7);
 LCD_DataWrite(temp);
}

void Write_GPIO_E_7_0(unsigned char temp)
{




 LCD_CmdWrite(0xF8);
 LCD_DataWrite(temp);
}
unsigned char Read_GPIO_E_7_0(void)
{




 unsigned char temp;
 LCD_CmdWrite(0xF8);
 temp=LCD_DataRead();
 return temp;
}

void Set_GPIO_F_In_Out(unsigned char temp)
{





 LCD_CmdWrite(0xF9);
 LCD_DataWrite(temp);
}

void Write_GPIO_F_7_0(unsigned char temp)
{




 LCD_CmdWrite(0xFA);
 LCD_DataWrite(temp);
}
unsigned char Read_GPIO_F_7_0(void)
{




 unsigned char temp;
 LCD_CmdWrite(0xFA);
 temp=LCD_DataRead();
 return temp;
}




void Long_Key_enable(void)
{






 unsigned char temp;
 LCD_CmdWrite(0xFB);
 temp=LCD_DataRead();
 temp |= 0x40;
 LCD_DataWrite(temp);
}


void Key_Scan_Freg(unsigned char setx)
{

  unsigned char temp;
  LCD_CmdWrite(0xFB);
  temp = LCD_DataRead();
  temp &= 0xf0;
  temp|= (setx&0x07);
  LCD_DataWrite(temp);
}




void Key_Scan_Wakeup_Function_Enable(void)
{







 unsigned char temp;
 LCD_CmdWrite(0xFC);
 temp=LCD_DataRead();
 temp |= 0x80;
 LCD_DataWrite(temp);
}


void Long_Key_Timing_Adjustment(unsigned char setx)
{

  unsigned char temp,temp1;
  temp = setx & 0x1c;
  LCD_CmdWrite(0xFC);
  temp1 = LCD_DataRead();
  temp1|=temp;
  LCD_DataWrite(temp1);

}

unsigned char Numbers_of_Key_Hit(void)
{
   unsigned char temp;
   LCD_CmdWrite(0xFC);
   temp = LCD_DataRead();
   temp = temp & 0x03;
   return temp;
}


unsigned char Read_Key_Strobe_Data_0(void)
{




 unsigned char temp;
 LCD_CmdWrite(0xFD);
 temp=LCD_DataRead();
 return temp;
}
unsigned char Read_Key_Strobe_Data_1(void)
{




 unsigned char temp;
 LCD_CmdWrite(0xFE);
 temp=LCD_DataRead();
 return temp;
}
unsigned char Read_Key_Strobe_Data_2(void)
{




 unsigned char temp;
 LCD_CmdWrite(0xFF);
 temp=LCD_DataRead();
 return temp;
}



void Show_String(char *str)
{
  Text_Mode();
  LCD_CmdWrite(0x04);
  while(*str != '\0')
  {
   LCD_DataWrite(*str);
   Check_Mem_WR_FIFO_not_Full();
  ++str;
  }
   Check_2D_Busy();

   Graphic_Mode();
}


void Show_picture(unsigned long numbers,const unsigned short *datap)
{
  unsigned long i;

  LCD_CmdWrite(0x04);
  for(i=0;i<numbers;i++)
   {
   LCD_DataWrite(datap[i]);
   LCD_DataWrite(datap[i]>>8);
   Check_Mem_WR_FIFO_not_Full();
   }

}

void Show_picture1(unsigned long numbers,const unsigned short *datap)
{
  unsigned long i;

  LCD_CmdWrite(0x04);
  for(i=0;i<numbers;i++)
   {
   LCD_DataWrite(datap[i]>>8);
   LCD_DataWrite(datap[i]);
   Check_Mem_WR_FIFO_not_Full();
   }

}

void Graphic_cursor_initial(void)
{
  unsigned int i ;


  Memory_Select_Graphic_Cursor_RAM();
  Graphic_Mode();

    Select_Graphic_Cursor_1();
    LCD_CmdWrite(0x04);
    for(i=0;i<256;i++)
    {
     LCD_DataWrite(gImage_pen_il[i]);
    }

    Select_Graphic_Cursor_2();
    LCD_CmdWrite(0x04);
    for(i=0;i<256;i++)
    {
     LCD_DataWrite(gImage_arrow_il[i]);
    }

     Select_Graphic_Cursor_3();
     LCD_CmdWrite(0x04);
     for(i=0;i<256;i++)
     {
      LCD_DataWrite(gImage_busy_im[i]);

     }

     Select_Graphic_Cursor_4();
     LCD_CmdWrite(0x04);
     for(i=0;i<256;i++)
     {
      LCD_DataWrite(gImage_no_im[i]);

     }

    Memory_Select_SDRAM();

    Set_Graphic_Cursor_Color_1(0xff);
    Set_Graphic_Cursor_Color_2(0x00);
    Graphic_Cursor_XY(0,0);
    Enable_Graphic_Cursor();
}


void Text_cursor_initial(void)
{


    Enable_Text_Cursor_Blinking();

    Blinking_Time_Frames(10);

    Text_Cursor_H_V(1,15);
 Enable_Text_Cursor();

}



unsigned int code ASCII_Table[] =
       {

         0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
         0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
         0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,

         0x0000, 0x0180, 0x0180, 0x0180, 0x0180, 0x0180, 0x0180, 0x0180,
         0x0180, 0x0180, 0x0180, 0x0180, 0x0180, 0x0180, 0x0000, 0x0000,
         0x0180, 0x0180, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,

         0x0000, 0x0000, 0x00CC, 0x00CC, 0x00CC, 0x00CC, 0x00CC, 0x00CC,
         0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
         0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,

         0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0C60, 0x0C60,
         0x0C60, 0x0630, 0x0630, 0x1FFE, 0x1FFE, 0x0630, 0x0738, 0x0318,
         0x1FFE, 0x1FFE, 0x0318, 0x0318, 0x018C, 0x018C, 0x018C, 0x0000,

         0x0000, 0x0080, 0x03E0, 0x0FF8, 0x0E9C, 0x1C8C, 0x188C, 0x008C,
         0x0098, 0x01F8, 0x07E0, 0x0E80, 0x1C80, 0x188C, 0x188C, 0x189C,
         0x0CB8, 0x0FF0, 0x03E0, 0x0080, 0x0080, 0x0000, 0x0000, 0x0000,

         0x0000, 0x0000, 0x0000, 0x180E, 0x0C1B, 0x0C11, 0x0611, 0x0611,
         0x0311, 0x0311, 0x019B, 0x018E, 0x38C0, 0x6CC0, 0x4460, 0x4460,
         0x4430, 0x4430, 0x4418, 0x6C18, 0x380C, 0x0000, 0x0000, 0x0000,

         0x0000, 0x01E0, 0x03F0, 0x0738, 0x0618, 0x0618, 0x0330, 0x01F0,
         0x00F0, 0x00F8, 0x319C, 0x330E, 0x1E06, 0x1C06, 0x1C06, 0x3F06,
         0x73FC, 0x21F0, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,

         0x0000, 0x0000, 0x000C, 0x000C, 0x000C, 0x000C, 0x000C, 0x000C,
         0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
         0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,

         0x0000, 0x0200, 0x0300, 0x0180, 0x00C0, 0x00C0, 0x0060, 0x0060,
         0x0030, 0x0030, 0x0030, 0x0030, 0x0030, 0x0030, 0x0030, 0x0030,
         0x0060, 0x0060, 0x00C0, 0x00C0, 0x0180, 0x0300, 0x0200, 0x0000,

         0x0000, 0x0020, 0x0060, 0x00C0, 0x0180, 0x0180, 0x0300, 0x0300,
         0x0600, 0x0600, 0x0600, 0x0600, 0x0600, 0x0600, 0x0600, 0x0600,
         0x0300, 0x0300, 0x0180, 0x0180, 0x00C0, 0x0060, 0x0020, 0x0000,

         0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x00C0, 0x00C0,
         0x06D8, 0x07F8, 0x01E0, 0x0330, 0x0738, 0x0000, 0x0000, 0x0000,
         0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,

         0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0180, 0x0180,
         0x0180, 0x0180, 0x0180, 0x3FFC, 0x3FFC, 0x0180, 0x0180, 0x0180,
         0x0180, 0x0180, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,

         0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
         0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
         0x0000, 0x0180, 0x0180, 0x0100, 0x0100, 0x0080, 0x0000, 0x0000,

         0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
         0x0000, 0x0000, 0x0000, 0x0000, 0x07E0, 0x07E0, 0x0000, 0x0000,
         0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,

         0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
         0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
         0x0000, 0x00C0, 0x00C0, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,

         0x0000, 0x0C00, 0x0C00, 0x0600, 0x0600, 0x0600, 0x0300, 0x0300,
         0x0300, 0x0380, 0x0180, 0x0180, 0x0180, 0x00C0, 0x00C0, 0x00C0,
         0x0060, 0x0060, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,

         0x0000, 0x03E0, 0x07F0, 0x0E38, 0x0C18, 0x180C, 0x180C, 0x180C,
         0x180C, 0x180C, 0x180C, 0x180C, 0x180C, 0x180C, 0x0C18, 0x0E38,
         0x07F0, 0x03E0, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,

         0x0000, 0x0100, 0x0180, 0x01C0, 0x01F0, 0x0198, 0x0188, 0x0180,
         0x0180, 0x0180, 0x0180, 0x0180, 0x0180, 0x0180, 0x0180, 0x0180,
         0x0180, 0x0180, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,

         0x0000, 0x03E0, 0x0FF8, 0x0C18, 0x180C, 0x180C, 0x1800, 0x1800,
         0x0C00, 0x0600, 0x0300, 0x0180, 0x00C0, 0x0060, 0x0030, 0x0018,
         0x1FFC, 0x1FFC, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,

         0x0000, 0x01E0, 0x07F8, 0x0E18, 0x0C0C, 0x0C0C, 0x0C00, 0x0600,
         0x03C0, 0x07C0, 0x0C00, 0x1800, 0x1800, 0x180C, 0x180C, 0x0C18,
         0x07F8, 0x03E0, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,

         0x0000, 0x0C00, 0x0E00, 0x0F00, 0x0F00, 0x0D80, 0x0CC0, 0x0C60,
         0x0C60, 0x0C30, 0x0C18, 0x0C0C, 0x3FFC, 0x3FFC, 0x0C00, 0x0C00,
         0x0C00, 0x0C00, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,

         0x0000, 0x0FF8, 0x0FF8, 0x0018, 0x0018, 0x000C, 0x03EC, 0x07FC,
         0x0E1C, 0x1C00, 0x1800, 0x1800, 0x1800, 0x180C, 0x0C1C, 0x0E18,
         0x07F8, 0x03E0, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,

         0x0000, 0x07C0, 0x0FF0, 0x1C38, 0x1818, 0x0018, 0x000C, 0x03CC,
         0x0FEC, 0x0E3C, 0x1C1C, 0x180C, 0x180C, 0x180C, 0x1C18, 0x0E38,
         0x07F0, 0x03E0, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,

         0x0000, 0x1FFC, 0x1FFC, 0x0C00, 0x0600, 0x0600, 0x0300, 0x0380,
         0x0180, 0x01C0, 0x00C0, 0x00E0, 0x0060, 0x0060, 0x0070, 0x0030,
         0x0030, 0x0030, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,

         0x0000, 0x03E0, 0x07F0, 0x0E38, 0x0C18, 0x0C18, 0x0C18, 0x0638,
         0x07F0, 0x07F0, 0x0C18, 0x180C, 0x180C, 0x180C, 0x180C, 0x0C38,
         0x0FF8, 0x03E0, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,

         0x0000, 0x03E0, 0x07F0, 0x0E38, 0x0C1C, 0x180C, 0x180C, 0x180C,
         0x1C1C, 0x1E38, 0x1BF8, 0x19E0, 0x1800, 0x0C00, 0x0C00, 0x0E1C,
         0x07F8, 0x01F0, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,

         0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0180, 0x0180,
         0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
         0x0180, 0x0180, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,

         0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0180, 0x0180,
         0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
         0x0180, 0x0180, 0x0100, 0x0100, 0x0080, 0x0000, 0x0000, 0x0000,

         0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
         0x1000, 0x1C00, 0x0F80, 0x03E0, 0x00F8, 0x0018, 0x00F8, 0x03E0,
         0x0F80, 0x1C00, 0x1000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,

         0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
         0x1FF8, 0x0000, 0x0000, 0x0000, 0x1FF8, 0x0000, 0x0000, 0x0000,
         0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,

         0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
         0x0008, 0x0038, 0x01F0, 0x07C0, 0x1F00, 0x1800, 0x1F00, 0x07C0,
         0x01F0, 0x0038, 0x0008, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,

         0x0000, 0x03E0, 0x0FF8, 0x0C18, 0x180C, 0x180C, 0x1800, 0x0C00,
         0x0600, 0x0300, 0x0180, 0x00C0, 0x00C0, 0x00C0, 0x0000, 0x0000,
         0x00C0, 0x00C0, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,

         0x0000, 0x0000, 0x07E0, 0x1818, 0x2004, 0x29C2, 0x4A22, 0x4411,
         0x4409, 0x4409, 0x4409, 0x2209, 0x1311, 0x0CE2, 0x4002, 0x2004,
         0x1818, 0x07E0, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,

         0x0000, 0x0380, 0x0380, 0x06C0, 0x06C0, 0x06C0, 0x0C60, 0x0C60,
         0x1830, 0x1830, 0x1830, 0x3FF8, 0x3FF8, 0x701C, 0x600C, 0x600C,
         0xC006, 0xC006, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,

         0x0000, 0x03FC, 0x0FFC, 0x0C0C, 0x180C, 0x180C, 0x180C, 0x0C0C,
         0x07FC, 0x0FFC, 0x180C, 0x300C, 0x300C, 0x300C, 0x300C, 0x180C,
         0x1FFC, 0x07FC, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,

         0x0000, 0x07C0, 0x1FF0, 0x3838, 0x301C, 0x700C, 0x6006, 0x0006,
         0x0006, 0x0006, 0x0006, 0x0006, 0x0006, 0x6006, 0x700C, 0x301C,
         0x1FF0, 0x07E0, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,

         0x0000, 0x03FE, 0x0FFE, 0x0E06, 0x1806, 0x1806, 0x3006, 0x3006,
         0x3006, 0x3006, 0x3006, 0x3006, 0x3006, 0x1806, 0x1806, 0x0E06,
         0x0FFE, 0x03FE, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,

         0x0000, 0x3FFC, 0x3FFC, 0x000C, 0x000C, 0x000C, 0x000C, 0x000C,
         0x1FFC, 0x1FFC, 0x000C, 0x000C, 0x000C, 0x000C, 0x000C, 0x000C,
         0x3FFC, 0x3FFC, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,

         0x0000, 0x3FF8, 0x3FF8, 0x0018, 0x0018, 0x0018, 0x0018, 0x0018,
         0x1FF8, 0x1FF8, 0x0018, 0x0018, 0x0018, 0x0018, 0x0018, 0x0018,
         0x0018, 0x0018, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,

         0x0000, 0x0FE0, 0x3FF8, 0x783C, 0x600E, 0xE006, 0xC007, 0x0003,
         0x0003, 0xFE03, 0xFE03, 0xC003, 0xC007, 0xC006, 0xC00E, 0xF03C,
         0x3FF8, 0x0FE0, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,

         0x0000, 0x300C, 0x300C, 0x300C, 0x300C, 0x300C, 0x300C, 0x300C,
         0x3FFC, 0x3FFC, 0x300C, 0x300C, 0x300C, 0x300C, 0x300C, 0x300C,
         0x300C, 0x300C, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,

         0x0000, 0x0180, 0x0180, 0x0180, 0x0180, 0x0180, 0x0180, 0x0180,
         0x0180, 0x0180, 0x0180, 0x0180, 0x0180, 0x0180, 0x0180, 0x0180,
         0x0180, 0x0180, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,

         0x0000, 0x0600, 0x0600, 0x0600, 0x0600, 0x0600, 0x0600, 0x0600,
         0x0600, 0x0600, 0x0600, 0x0600, 0x0600, 0x0618, 0x0618, 0x0738,
         0x03F0, 0x01E0, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,

         0x0000, 0x3006, 0x1806, 0x0C06, 0x0606, 0x0306, 0x0186, 0x00C6,
         0x0066, 0x0076, 0x00DE, 0x018E, 0x0306, 0x0606, 0x0C06, 0x1806,
         0x3006, 0x6006, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,

         0x0000, 0x0018, 0x0018, 0x0018, 0x0018, 0x0018, 0x0018, 0x0018,
         0x0018, 0x0018, 0x0018, 0x0018, 0x0018, 0x0018, 0x0018, 0x0018,
         0x1FF8, 0x1FF8, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,

         0x0000, 0xE00E, 0xF01E, 0xF01E, 0xF01E, 0xD836, 0xD836, 0xD836,
         0xD836, 0xCC66, 0xCC66, 0xCC66, 0xC6C6, 0xC6C6, 0xC6C6, 0xC6C6,
         0xC386, 0xC386, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,

         0x0000, 0x300C, 0x301C, 0x303C, 0x303C, 0x306C, 0x306C, 0x30CC,
         0x30CC, 0x318C, 0x330C, 0x330C, 0x360C, 0x360C, 0x3C0C, 0x3C0C,
         0x380C, 0x300C, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,

         0x0000, 0x07E0, 0x1FF8, 0x381C, 0x700E, 0x6006, 0xC003, 0xC003,
         0xC003, 0xC003, 0xC003, 0xC003, 0xC003, 0x6006, 0x700E, 0x381C,
         0x1FF8, 0x07E0, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,

         0x0000, 0x0FFC, 0x1FFC, 0x380C, 0x300C, 0x300C, 0x300C, 0x300C,
         0x180C, 0x1FFC, 0x07FC, 0x000C, 0x000C, 0x000C, 0x000C, 0x000C,
         0x000C, 0x000C, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,

         0x0000, 0x07E0, 0x1FF8, 0x381C, 0x700E, 0x6006, 0xE003, 0xC003,
         0xC003, 0xC003, 0xC003, 0xC003, 0xE007, 0x6306, 0x3F0E, 0x3C1C,
         0x3FF8, 0xF7E0, 0xC000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,

         0x0000, 0x0FFE, 0x1FFE, 0x3806, 0x3006, 0x3006, 0x3006, 0x3806,
         0x1FFE, 0x07FE, 0x0306, 0x0606, 0x0C06, 0x1806, 0x1806, 0x3006,
         0x3006, 0x6006, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,

         0x0000, 0x03E0, 0x0FF8, 0x0C1C, 0x180C, 0x180C, 0x000C, 0x001C,
         0x03F8, 0x0FE0, 0x1E00, 0x3800, 0x3006, 0x3006, 0x300E, 0x1C1C,
         0x0FF8, 0x07E0, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,

         0x0000, 0x7FFE, 0x7FFE, 0x0180, 0x0180, 0x0180, 0x0180, 0x0180,
         0x0180, 0x0180, 0x0180, 0x0180, 0x0180, 0x0180, 0x0180, 0x0180,
         0x0180, 0x0180, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,

         0x0000, 0x300C, 0x300C, 0x300C, 0x300C, 0x300C, 0x300C, 0x300C,
         0x300C, 0x300C, 0x300C, 0x300C, 0x300C, 0x300C, 0x300C, 0x1818,
         0x1FF8, 0x07E0, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,

         0x0000, 0x6003, 0x3006, 0x3006, 0x3006, 0x180C, 0x180C, 0x180C,
         0x0C18, 0x0C18, 0x0E38, 0x0630, 0x0630, 0x0770, 0x0360, 0x0360,
         0x01C0, 0x01C0, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,

         0x0000, 0x6003, 0x61C3, 0x61C3, 0x61C3, 0x3366, 0x3366, 0x3366,
         0x3366, 0x3366, 0x3366, 0x1B6C, 0x1B6C, 0x1B6C, 0x1A2C, 0x1E3C,
         0x0E38, 0x0E38, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,

         0x0000, 0xE00F, 0x700C, 0x3018, 0x1830, 0x0C70, 0x0E60, 0x07C0,
         0x0380, 0x0380, 0x03C0, 0x06E0, 0x0C70, 0x1C30, 0x1818, 0x300C,
         0x600E, 0xE007, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,

         0x0000, 0xC003, 0x6006, 0x300C, 0x381C, 0x1838, 0x0C30, 0x0660,
         0x07E0, 0x03C0, 0x0180, 0x0180, 0x0180, 0x0180, 0x0180, 0x0180,
         0x0180, 0x0180, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,

         0x0000, 0x7FFC, 0x7FFC, 0x6000, 0x3000, 0x1800, 0x0C00, 0x0600,
         0x0300, 0x0180, 0x00C0, 0x0060, 0x0030, 0x0018, 0x000C, 0x0006,
         0x7FFE, 0x7FFE, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,

         0x0000, 0x03E0, 0x03E0, 0x0060, 0x0060, 0x0060, 0x0060, 0x0060,
         0x0060, 0x0060, 0x0060, 0x0060, 0x0060, 0x0060, 0x0060, 0x0060,
         0x0060, 0x0060, 0x0060, 0x0060, 0x0060, 0x03E0, 0x03E0, 0x0000,

         0x0000, 0x0030, 0x0030, 0x0060, 0x0060, 0x0060, 0x00C0, 0x00C0,
         0x00C0, 0x01C0, 0x0180, 0x0180, 0x0180, 0x0300, 0x0300, 0x0300,
         0x0600, 0x0600, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,

         0x0000, 0x03E0, 0x03E0, 0x0300, 0x0300, 0x0300, 0x0300, 0x0300,
         0x0300, 0x0300, 0x0300, 0x0300, 0x0300, 0x0300, 0x0300, 0x0300,
         0x0300, 0x0300, 0x0300, 0x0300, 0x0300, 0x03E0, 0x03E0, 0x0000,

         0x0000, 0x0000, 0x01C0, 0x01C0, 0x0360, 0x0360, 0x0360, 0x0630,
         0x0630, 0x0C18, 0x0C18, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
         0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,

         0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
         0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
         0x0000, 0xFFFF, 0xFFFF, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,

         0x0000, 0x000C, 0x000C, 0x000C, 0x000C, 0x000C, 0x000C, 0x0000,
         0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
         0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,

         0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x03F0, 0x07F8,
         0x0C1C, 0x0C0C, 0x0F00, 0x0FF0, 0x0CF8, 0x0C0C, 0x0C0C, 0x0F1C,
         0x0FF8, 0x18F0, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,

         0x0000, 0x0018, 0x0018, 0x0018, 0x0018, 0x0018, 0x03D8, 0x0FF8,
         0x0C38, 0x1818, 0x1818, 0x1818, 0x1818, 0x1818, 0x1818, 0x0C38,
         0x0FF8, 0x03D8, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,

         0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x03C0, 0x07F0,
         0x0E30, 0x0C18, 0x0018, 0x0018, 0x0018, 0x0018, 0x0C18, 0x0E30,
         0x07F0, 0x03C0, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,

         0x0000, 0x1800, 0x1800, 0x1800, 0x1800, 0x1800, 0x1BC0, 0x1FF0,
         0x1C30, 0x1818, 0x1818, 0x1818, 0x1818, 0x1818, 0x1818, 0x1C30,
         0x1FF0, 0x1BC0, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,

         0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x03C0, 0x0FF0,
         0x0C30, 0x1818, 0x1FF8, 0x1FF8, 0x0018, 0x0018, 0x1838, 0x1C30,
         0x0FF0, 0x07C0, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,

         0x0000, 0x0F80, 0x0FC0, 0x00C0, 0x00C0, 0x00C0, 0x07F0, 0x07F0,
         0x00C0, 0x00C0, 0x00C0, 0x00C0, 0x00C0, 0x00C0, 0x00C0, 0x00C0,
         0x00C0, 0x00C0, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,

         0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0DE0, 0x0FF8,
         0x0E18, 0x0C0C, 0x0C0C, 0x0C0C, 0x0C0C, 0x0C0C, 0x0C0C, 0x0E18,
         0x0FF8, 0x0DE0, 0x0C00, 0x0C0C, 0x061C, 0x07F8, 0x01F0, 0x0000,

         0x0000, 0x0018, 0x0018, 0x0018, 0x0018, 0x0018, 0x07D8, 0x0FF8,
         0x1C38, 0x1818, 0x1818, 0x1818, 0x1818, 0x1818, 0x1818, 0x1818,
         0x1818, 0x1818, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,

         0x0000, 0x00C0, 0x00C0, 0x0000, 0x0000, 0x0000, 0x00C0, 0x00C0,
         0x00C0, 0x00C0, 0x00C0, 0x00C0, 0x00C0, 0x00C0, 0x00C0, 0x00C0,
         0x00C0, 0x00C0, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,

         0x0000, 0x00C0, 0x00C0, 0x0000, 0x0000, 0x0000, 0x00C0, 0x00C0,
         0x00C0, 0x00C0, 0x00C0, 0x00C0, 0x00C0, 0x00C0, 0x00C0, 0x00C0,
         0x00C0, 0x00C0, 0x00C0, 0x00C0, 0x00C0, 0x00F8, 0x0078, 0x0000,

         0x0000, 0x000C, 0x000C, 0x000C, 0x000C, 0x000C, 0x0C0C, 0x060C,
         0x030C, 0x018C, 0x00CC, 0x006C, 0x00FC, 0x019C, 0x038C, 0x030C,
         0x060C, 0x0C0C, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,

         0x0000, 0x00C0, 0x00C0, 0x00C0, 0x00C0, 0x00C0, 0x00C0, 0x00C0,
         0x00C0, 0x00C0, 0x00C0, 0x00C0, 0x00C0, 0x00C0, 0x00C0, 0x00C0,
         0x00C0, 0x00C0, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,

         0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x3C7C, 0x7EFF,
         0xE3C7, 0xC183, 0xC183, 0xC183, 0xC183, 0xC183, 0xC183, 0xC183,
         0xC183, 0xC183, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,

         0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0798, 0x0FF8,
         0x1C38, 0x1818, 0x1818, 0x1818, 0x1818, 0x1818, 0x1818, 0x1818,
         0x1818, 0x1818, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,

         0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x03C0, 0x0FF0,
         0x0C30, 0x1818, 0x1818, 0x1818, 0x1818, 0x1818, 0x1818, 0x0C30,
         0x0FF0, 0x03C0, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,

         0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x03D8, 0x0FF8,
         0x0C38, 0x1818, 0x1818, 0x1818, 0x1818, 0x1818, 0x1818, 0x0C38,
         0x0FF8, 0x03D8, 0x0018, 0x0018, 0x0018, 0x0018, 0x0018, 0x0000,

         0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x1BC0, 0x1FF0,
         0x1C30, 0x1818, 0x1818, 0x1818, 0x1818, 0x1818, 0x1818, 0x1C30,
         0x1FF0, 0x1BC0, 0x1800, 0x1800, 0x1800, 0x1800, 0x1800, 0x0000,

         0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x07B0, 0x03F0,
         0x0070, 0x0030, 0x0030, 0x0030, 0x0030, 0x0030, 0x0030, 0x0030,
         0x0030, 0x0030, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,

         0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x03E0, 0x03F0,
         0x0E38, 0x0C18, 0x0038, 0x03F0, 0x07C0, 0x0C00, 0x0C18, 0x0E38,
         0x07F0, 0x03E0, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,

         0x0000, 0x0000, 0x0080, 0x00C0, 0x00C0, 0x00C0, 0x07F0, 0x07F0,
         0x00C0, 0x00C0, 0x00C0, 0x00C0, 0x00C0, 0x00C0, 0x00C0, 0x00C0,
         0x07C0, 0x0780, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,

         0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x1818, 0x1818,
         0x1818, 0x1818, 0x1818, 0x1818, 0x1818, 0x1818, 0x1818, 0x1C38,
         0x1FF0, 0x19E0, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,

         0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x180C, 0x0C18,
         0x0C18, 0x0C18, 0x0630, 0x0630, 0x0630, 0x0360, 0x0360, 0x0360,
         0x01C0, 0x01C0, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,

         0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x41C1, 0x41C1,
         0x61C3, 0x6363, 0x6363, 0x6363, 0x3636, 0x3636, 0x3636, 0x1C1C,
         0x1C1C, 0x1C1C, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,

         0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x381C, 0x1C38,
         0x0C30, 0x0660, 0x0360, 0x0360, 0x0360, 0x0360, 0x0660, 0x0C30,
         0x1C38, 0x381C, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,

         0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x3018, 0x1830,
         0x1830, 0x1870, 0x0C60, 0x0C60, 0x0CE0, 0x06C0, 0x06C0, 0x0380,
         0x0380, 0x0380, 0x0180, 0x0180, 0x01C0, 0x00F0, 0x0070, 0x0000,

         0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x1FFC, 0x1FFC,
         0x0C00, 0x0600, 0x0300, 0x0180, 0x00C0, 0x0060, 0x0030, 0x0018,
         0x1FFC, 0x1FFC, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,

         0x0000, 0x0300, 0x0180, 0x00C0, 0x00C0, 0x00C0, 0x00C0, 0x00C0,
         0x00C0, 0x0060, 0x0060, 0x0030, 0x0060, 0x0040, 0x00C0, 0x00C0,
         0x00C0, 0x00C0, 0x00C0, 0x00C0, 0x0180, 0x0300, 0x0000, 0x0000,

         0x0000, 0x0180, 0x0180, 0x0180, 0x0180, 0x0180, 0x0180, 0x0180,
         0x0180, 0x0180, 0x0180, 0x0180, 0x0180, 0x0180, 0x0180, 0x0180,
         0x0180, 0x0180, 0x0180, 0x0180, 0x0180, 0x0180, 0x0180, 0x0000,

         0x0000, 0x0060, 0x00C0, 0x01C0, 0x0180, 0x0180, 0x0180, 0x0180,
         0x0180, 0x0300, 0x0300, 0x0600, 0x0300, 0x0100, 0x0180, 0x0180,
         0x0180, 0x0180, 0x0180, 0x0180, 0x00C0, 0x0060, 0x0000, 0x0000,

         0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
         0x10F0, 0x1FF8, 0x0F08, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
         0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
      };


 unsigned int code pattern16x16_16bpp[256] = {
0XF800,0XF800,0XF800,0XF800,0XF800,0XF800,0XF800,0X9248,
0X89E6,0XF800,0XF800,0X8349,0X5B29,0XF800,0XF800,0XF800,
0XF800,0XF800,0XF800,0XF800,0XF800,0XF800,0X89E6,0XFDD6,
0XFE37,0X9247,0XF800,0X72C7,0XEFDC,0X636B,0XF800,0XF800,
0XF800,0XF800,0XF800,0XF800,0XF800,0X8948,0XFD93,0XFAA8,
0XD983,0XFDB3,0X9168,0XAA2B,0XF71F,0X72F0,0XF800,0XF800,
0XF800,0XF800,0XF800,0XF800,0XAA2B,0XFDFA,0XE1C4,0XD121,
0XD983,0XE1C4,0XFE3B,0X99CA,0XD5FC,0X8393,0XF800,0XF800,
0XF800,0XF800,0XF800,0XC1E7,0XFD56,0XEA29,0XAA88,0X6880,
0X7902,0XA247,0XC925,0XFDF8,0XC207,0XB9C7,0XF800,0XF800,
0XF800,0XF800,0XA104,0XFDD6,0XE208,0XD9C7,0X5800,0XFD33,
0XF4B1,0X70A0,0XD9C7,0XC966,0XFE17,0X98E3,0XF800,0XF800,
0XF800,0X8203,0XFD31,0XE205,0XC207,0X7800,0XB637,0XF7FF,
0XF7FF,0XB637,0X8000,0XB1A5,0XD9C4,0XFE15,0X6960,0XF800,
0X9264,0XFDB1,0XEA66,0XD9A4,0X7800,0XFCD1,0XEFDE,0XF7FF,
0XF7FF,0XE7BD,0XFCF2,0X8880,0XD9C4,0XD9C4,0XFEB5,0X8A23,
0X48E4,0X5105,0X4066,0X4066,0XCD58,0XFF5F,0XFFFE,0XFF9C,
0XFFFE,0XFF7C,0XFF7F,0XDDDA,0X3825,0X4887,0X5125,0X48E4,
0XA3AF,0XE5B7,0XEDBB,0XFE5E,0XFF3F,0X6A4D,0X62C9,0X62CA,
0X62EA,0X62EA,0X728D,0XFEFF,0XFE3D,0XEDBB,0XE597,0XABF0,
0X73CC,0XFFFD,0XEFDE,0XE79D,0XFFFF,0X94D4,0XFFFF,0XEF9F,
0XB597,0XFFFF,0X94D4,0XFFFF,0XF7FF,0XF7FE,0XFFFD,0X6BAC,
0X6B8B,0XFFFD,0XF7FE,0XFFFF,0XFFFF,0X4A6A,0XB5B8,0XC65A,
0XC63A,0XEF9F,0X5B0D,0XF7BF,0XFFFF,0XF7DE,0XFFFD,0X73CC,
0X6BE7,0XFFF9,0XFFF7,0XFF95,0XFFFB,0XAD50,0XDFFF,0XDFFF,
0XA69B,0XCFBF,0X9CAE,0XFFFB,0XFFF6,0XFFF7,0XFFF9,0X6BE7,
0X63A6,0XA5AE,0XCDEE,0XCDEE,0XCE34,0X6307,0X330D,0X32CC,
0X4B8F,0X434E,0X6307,0XCE54,0XC5AD,0XBD8D,0XADEF,0X6BE7,
0X7328,0XD614,0XFF5C,0XEEB9,0XEED9,0XF71A,0XFFDA,0XEF58,
0XE6F7,0XEF58,0XF73B,0XEF1A,0XEED9,0XFF7C,0XCDF3,0X7308,
0X5A65,0X49C3,0X3103,0X49C6,0X49C6,0X3964,0X3981,0X4203,
0X41E2,0X39A2,0X49C6,0X41A5,0X49C6,0X4164,0X4181,0X6AC7,
};

 unsigned int code f1[1600] = {
0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,
0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,
0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,
0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,
0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,
0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,
0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,
0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,
0X000C,0X1800,0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,
0X0000,0X0000,0X09FF,0X7FC0,0X0000,0X0000,0X0000,0X0000,
0X0000,0X0000,0X0000,0X0000,0X1FFF,0X7FFC,0X0000,0X0000,
0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,0X7FFE,0X3FFF,
0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,0X0003,
0XFFFC,0X1FFF,0XE000,0X0000,0X0000,0X0000,0X0000,0X0000,
0X0000,0X000F,0XFFF8,0X0FFF,0XF800,0X0000,0X0000,0X0000,
0X0000,0X0000,0X0000,0X003F,0XFF87,0XF1FF,0XFC00,0X0000,
0X0000,0X0000,0X0000,0X0000,0X0000,0X0067,0XC807,0XF009,
0XF700,0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,
0X0007,0XF000,0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,
0X0000,0X0000,0X0007,0XF000,0X0000,0X0000,0X0000,0X0000,
0X0000,0X0000,0X0000,0XF000,0X000F,0XF000,0X0007,0X0000,
0X0000,0X0000,0X0000,0X0000,0X000F,0X8000,0X000F,0XF000,
0X0003,0XF800,0X0000,0X0000,0X0000,0X0000,0X003F,0X0000,
0X000F,0XF800,0X0000,0X7E00,0X0000,0X0000,0X0000,0X0000,
0X01FE,0X0000,0X000F,0XF800,0X0000,0X3FC0,0X0000,0X0000,
0X0000,0X0000,0X07FC,0X0000,0X000F,0XF800,0X0000,0X1FF0,
0X0000,0X0000,0X0000,0X0000,0X3FF8,0X0000,0X000F,0XF800,
0X0000,0X0FF8,0X0000,0X0000,0X0000,0X0000,0X7FE0,0X0000,
0X000F,0XF000,0X0000,0X07FF,0X0000,0X0000,0X0000,0X0000,
0XFFC0,0X0000,0X0007,0XF000,0X0000,0X01FF,0X8000,0X0000,
0X0000,0X0001,0XFF80,0X0000,0X0007,0XF000,0X0000,0X00FF,
0XC000,0X0000,0X0000,0X0003,0XFF00,0X0000,0X0007,0XF000,
0X0000,0X007F,0XC000,0X0000,0X0000,0X0003,0XFE00,0X0000,
0X0007,0XF000,0X0000,0X003F,0XC000,0X0000,0X0000,0X0003,
0XFC00,0X0000,0X0007,0XF000,0X0000,0X001F,0XE000,0X0000,
0X0000,0X0004,0XF800,0X0000,0X0003,0XE000,0X0000,0X000F,
0XC000,0X0000,0X0000,0X0028,0X3000,0X0000,0X0007,0XF000,
0X0000,0X0004,0X0800,0X0000,0X0000,0X0078,0X1800,0X0000,
0X0003,0XE000,0X0000,0X0000,0X0F00,0X0000,0X0000,0X00F8,
0X3C00,0X0000,0X0001,0XC000,0X0000,0X001E,0X0F80,0X0000,
0X0000,0X01FC,0X7E00,0X0000,0X0001,0XC000,0X0000,0X003F,
0X1FC0,0X0000,0X0000,0X03FC,0XFF00,0X0000,0X0001,0XC000,
0X0000,0X007F,0X9FE0,0X0000,0X0000,0X03FF,0XFF80,0X0000,
0X0001,0XC000,0X0000,0X00FF,0XFFE0,0X0000,0X0000,0X03FD,
0XFFC0,0X0000,0X0001,0XC000,0X0000,0X01FF,0XDFE0,0X0000,
0X0000,0X07F8,0XFFE0,0X0000,0X0000,0X8000,0X0000,0X03FF,
0X8FF0,0X0000,0X0000,0X0FF0,0X7FF0,0X0000,0X0000,0X8000,
0X0000,0X07FF,0X07F0,0X0000,0X0000,0X0FE0,0X3FF8,0X0000,
0X0000,0X8000,0X0000,0X0FFE,0X03F8,0X0000,0X0000,0X1FC0,
0X1FF8,0X0000,0X0000,0X8000,0X0000,0X0FFC,0X01FC,0X0000,
0X0000,0X0F80,0X0FF8,0X0000,0X0000,0X0000,0X0000,0X0FF8,
0X00F8,0X0000,0X0000,0X1F00,0X07FC,0X0000,0X0000,0X0000,
0X0000,0X1FF0,0X007C,0X0000,0X0000,0X1E00,0X03FE,0X0000,
0X0000,0X8000,0X0000,0X3FE0,0X007C,0X0000,0X0000,0X3C00,
0X01FF,0X0000,0X0000,0X8000,0X0000,0X7FC0,0X003E,0X0000,
0X0000,0X3C00,0X00FF,0X0000,0X0000,0X8000,0X0000,0X7F80,
0X001E,0X0000,0X0000,0X7800,0X003F,0X8000,0X0000,0X8000,
0X0000,0XFE00,0X000F,0X0000,0X0000,0X3000,0X001F,0XC000,
0X0001,0XC000,0X0001,0XFC00,0X0006,0X0000,0X0000,0X6000,
0X000F,0XC000,0X0001,0XC000,0X0001,0XF800,0X0003,0X0000,
0X0000,0X4000,0X0001,0XC000,0X0003,0XE000,0X0001,0XC000,
0X0001,0X0000,0X0000,0XC000,0X0000,0XE000,0X0003,0XE000,
0X0003,0X8000,0X0001,0X0000,0X0000,0XC000,0X0000,0X3000,
0X0003,0XE000,0X0006,0X0000,0X0001,0X0000,0X0000,0X8000,
0X0000,0X1000,0X0003,0XE000,0X0004,0X0000,0X0000,0X8000,
0X0000,0X0000,0X0000,0X0000,0X0007,0XF000,0X0000,0X0000,
0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,0X000F,0XF000,
0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,0X0300,
0X000F,0XF800,0X0060,0X0000,0X0000,0X0000,0X0000,0X0000,
0X0000,0X0180,0X001F,0XFC00,0X00C0,0X0000,0X0000,0X0000,
0X0002,0X0000,0X0000,0X00F8,0X001F,0XFC00,0X0F80,0X0000,
0X0000,0X2000,0X0006,0X0000,0X0000,0X00FC,0X001F,0XFC00,
0X1F80,0X0000,0X0000,0X3000,0X0004,0X0000,0X0000,0X00FF,
0XC01F,0XFC01,0XFF80,0X0000,0X0000,0X1000,0X000E,0X0000,
0X0000,0X00FF,0XE01F,0XFC03,0XFF80,0X0000,0X0000,0X3800,
0X001E,0X0000,0X0000,0X007F,0XFA1F,0XFC2F,0XFF00,0X0000,
0X0000,0X3800,0X001E,0X0000,0X0000,0X003F,0XFF3F,0XFE7F,
0XFE00,0X0000,0X0000,0X3C00,0X003C,0X0000,0X0000,0X003F,
0XFFFF,0XFFFF,0XFE00,0X0000,0X0000,0X3E00,0X003C,0X0000,
0X0000,0X001F,0XFFFF,0XFFFF,0XFC00,0X0000,0X0000,0X1E00,
0X003C,0X0000,0X0000,0X001F,0XFFFF,0XFFFF,0XFC00,0X0000,
0X0000,0X1E00,0X007C,0X0000,0X0000,0X001F,0XFFFF,0XFFFF,
0XFC00,0X0000,0X0000,0X1E00,0X007C,0X0000,0X0000,0X000F,
0XFFFF,0XFFFF,0XF800,0X0000,0X0000,0X1F00,0X00FC,0X0000,
0X0000,0X000F,0XFFFF,0XFFFF,0XF800,0X0000,0X0000,0X1F80,
0X00FC,0X0000,0X0000,0X0007,0XFFFF,0XFFFF,0XF000,0X0000,
0X0000,0X1F80,0X00F8,0X0000,0X0000,0X0007,0XFFFF,0XFFFF,
0XF000,0X0000,0X0000,0X0F80,0X00F8,0X0000,0X0000,0X0003,
0XFFFF,0XFFFF,0XE000,0X0000,0X0000,0X0F80,0X01F8,0X0000,
0X0000,0X0003,0XFFFF,0XFFFF,0XC000,0X0000,0X0000,0X1FC0,
0X01F8,0X0000,0X0000,0X0003,0XFFFF,0XFFFF,0XC000,0X0000,
0X0000,0X0FC0,0X00F8,0X0000,0X0000,0X0003,0XFFFF,0XFFFF,
0XE000,0X0000,0X0000,0X0F80,0X01F8,0X0000,0X0000,0X003F,
0XFFFF,0XFFFF,0XFE00,0X0000,0X0000,0X0F80,0X01F8,0X1C00,
0X0000,0X03FF,0XFFFF,0XFFFF,0XFFC0,0X0000,0X0000,0X0FC0,
0X01FF,0XFFF8,0X0000,0X07FF,0XFFFF,0XFFFF,0XFFF0,0X0000,
0X03FF,0XCFC0,0X01E7,0XFFFF,0X8000,0X5FFF,0XFFFF,0XFFFF,
0XFFFD,0X0000,0XBFFF,0XF3C0,0X01C7,0XFFFF,0XD001,0XFFFF,
0XFFFF,0XFFFF,0XFFFF,0XC005,0XFFFF,0XF1C0,0X0007,0XFFFF,
0XFE0F,0XFFFF,0XFFFF,0XFFFF,0XFFFF,0XF83F,0XFFFF,0XF000,
0X0087,0XFFFF,0XFC07,0XFFFF,0XFFFF,0XFFFF,0XFFFF,0XFC7F,
0XFFFF,0XF080,0X01C7,0XFFFF,0X0000,0X7FFF,0XFFFF,0XFFFF,
0XFFFF,0XC000,0XFFFF,0XF1C0,0X01E7,0XFFFE,0X0000,0X3FFF,
0XFFFF,0XFFFF,0XFFFE,0X0000,0X3FFF,0XF3C0,0X00F9,0X3E60,
0X0000,0X07FF,0XFFFF,0XFFFF,0XFFF0,0X0000,0X13FF,0XCF80,
0X01F8,0X0000,0X0000,0X00FF,0XFFFF,0XFFFF,0XFF80,0X0000,
0X0000,0X0F80,0X01F8,0X0000,0X0000,0X003F,0XFFFF,0XFFFF,
0XFE00,0X0000,0X0000,0X0FC0,0X00F8,0X0000,0X0000,0X0003,
0XFFFF,0XFFFF,0XE000,0X0000,0X0000,0X0F80,0X00F8,0X0000,
0X0000,0X0001,0XFFFF,0XFFFF,0XC000,0X0000,0X0000,0X0F80,
0X01F8,0X0000,0X0000,0X0003,0XFFFF,0XFFFF,0XE000,0X0000,
0X0000,0X0FC0,0X01FC,0X0000,0X0000,0X0007,0XFFFF,0XFFFF,
0XF000,0X0000,0X0000,0X1FC0,0X00FC,0X0000,0X0000,0X0007,
0XFFFF,0XFFFF,0XF000,0X0000,0X0000,0X1F80,0X00FC,0X0000,
0X0000,0X0007,0XFFFF,0XFFFF,0XF000,0X0000,0X0000,0X1F80,
0X007C,0X0000,0X0000,0X000F,0XFFFF,0XFFFF,0XF000,0X0000,
0X0000,0X1F00,0X007C,0X0000,0X0000,0X000F,0XFFFF,0XFFFF,
0XF800,0X0000,0X0000,0X1F00,0X007C,0X0000,0X0000,0X001F,
0XFFFF,0XFFFF,0XFC00,0X0000,0X0000,0X1F00,0X003C,0X0000,
0X0000,0X001F,0XFFFF,0XFFFF,0XFC00,0X0000,0X0000,0X1E00,
0X003C,0X0000,0X0000,0X003F,0XFFFF,0XFFFF,0XFE00,0X0000,
0X0000,0X1E00,0X001C,0X0000,0X0000,0X003F,0XFFFF,0XFFFF,
0XFC00,0X0000,0X0000,0X1C00,0X001E,0X0000,0X0000,0X003F,
0XFE3F,0XFE3F,0XFE00,0X0000,0X0000,0X3C00,0X001C,0X0000,
0X0000,0X007F,0XF83F,0XFC0F,0XFF00,0X0000,0X0000,0X1C00,
0X000C,0X0000,0X0000,0X00FF,0XE01F,0XFC03,0XFF00,0X0000,
0X0000,0X1800,0X000C,0X0000,0X0000,0X00FF,0X001F,0XFC01,
0XFF80,0X0000,0X0000,0X1800,0X0004,0X0000,0X0000,0X00FE,
0X001F,0XFC00,0X3F80,0X0000,0X0000,0X3000,0X0002,0X0000,
0X0000,0X00F8,0X001F,0XFC00,0X0F80,0X0000,0X0000,0X2000,
0X0000,0X0000,0X0000,0X01C0,0X000F,0XF800,0X01C0,0X0000,
0X0000,0X0000,0X0000,0X0000,0X0000,0X0300,0X000F,0XF800,
0X0040,0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,
0X000F,0XF800,0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,
0X0000,0X0000,0X0007,0XF000,0X0000,0X0000,0X0000,0X0000,
0X0000,0X8000,0X0000,0X1000,0X0007,0XE000,0X0008,0X0000,
0X0000,0X8000,0X0000,0X8000,0X0000,0X3000,0X0003,0XE000,
0X0006,0X0000,0X0000,0X0000,0X0000,0X4000,0X0001,0XE000,
0X0003,0XE000,0X0003,0XC000,0X0001,0X0000,0X0000,0X6000,
0X0003,0XC000,0X0003,0XC000,0X0003,0XE000,0X0003,0X0000,
0X0000,0X7000,0X000F,0XC000,0X0003,0XC000,0X0001,0XF800,
0X0007,0X0000,0X0000,0X7800,0X001F,0X8000,0X0001,0XC000,
0X0000,0XFC00,0X000F,0X0000,0X0000,0X3C00,0X00FF,0X0000,
0X0001,0X8000,0X0000,0XFE00,0X001E,0X0000,0X0000,0X7C00,
0X01FF,0X0000,0X0000,0X8000,0X0000,0XFF00,0X001E,0X0000,
0X0000,0X3C00,0X03FF,0X0000,0X0000,0X8000,0X0000,0X7FE0,
0X001E,0X0000,0X0000,0X3E00,0X07FE,0X0000,0X0000,0X0000,
0X0000,0X3FF0,0X003C,0X0000,0X0000,0X1F00,0X0FFC,0X0000,
0X0000,0X0000,0X0000,0X1FF8,0X007C,0X0000,0X0000,0X0F80,
0X1FF8,0X0000,0X0000,0X0000,0X0000,0X1FFC,0X00F8,0X0000,
0X0000,0X0FC0,0X3FF8,0X0000,0X0000,0X0000,0X0000,0X0FFE,
0X01F8,0X0000,0X0000,0X0FE0,0X7FF0,0X0000,0X0000,0X8000,
0X0000,0X07FF,0X03F8,0X0000,0X0000,0X0FF0,0XFFE0,0X0000,
0X0000,0X8000,0X0000,0X03FF,0X87F8,0X0000,0X0000,0X07F9,
0XFFC0,0X0000,0X0000,0X8000,0X0000,0X01FF,0XCFF0,0X0000,
0X0000,0X07FF,0XFF80,0X0000,0X0000,0X8000,0X0000,0X00FF,
0X9FF0,0X0000,0X0000,0X03FF,0XFF00,0X0000,0X0001,0X8000,
0X0000,0X007F,0X9FE0,0X0000,0X0000,0X01FC,0XFE00,0X0000,
0X0001,0XC000,0X0000,0X003F,0X1FC0,0X0000,0X0000,0X00FC,
0X7C00,0X0000,0X0003,0XE000,0X0000,0X001E,0X1F80,0X0000,
0X0000,0X0078,0X3800,0X0000,0X0007,0XF000,0X0000,0X000C,
0X0F00,0X0000,0X0000,0X0038,0X1000,0X0000,0X0003,0XE000,
0X0000,0X0004,0X0E00,0X0000,0X0000,0X0008,0X7000,0X0000,
0X0003,0XE000,0X0000,0X0006,0X0800,0X0000,0X0000,0X0007,
0XF800,0X0000,0X0007,0XF000,0X0000,0X000F,0XE000,0X0000,
0X0000,0X0003,0XFC00,0X0000,0X0007,0XE000,0X0000,0X001F,
0XE000,0X0000,0X0000,0X0003,0XFE00,0X0000,0X0007,0XF000,
0X0000,0X003F,0XE000,0X0000,0X0000,0X0001,0XFF00,0X0000,
0X0007,0XF000,0X0000,0X007F,0XC000,0X0000,0X0000,0X0000,
0XFF80,0X0000,0X0007,0XF000,0X0000,0X00FF,0X8000,0X0000,
0X0000,0X0000,0X7FC0,0X0000,0X000F,0XF000,0X0000,0X01FF,
0X0000,0X0000,0X0000,0X0000,0X3FE0,0X0000,0X000F,0XF000,
0X0000,0X03FE,0X0000,0X0000,0X0000,0X0000,0X1FFC,0X0000,
0X000F,0XF000,0X0000,0X1FFC,0X0000,0X0000,0X0000,0X0000,
0X07FE,0X0000,0X000F,0XF000,0X0000,0X3FF0,0X0000,0X0000,
0X0000,0X0000,0X00FF,0X0000,0X000F,0XF000,0X0000,0X7F80,
0X0000,0X0000,0X0000,0X0000,0X003F,0X8000,0X000F,0XF000,
0X0000,0XFE00,0X0000,0X0000,0X0000,0X0000,0X000F,0XC000,
0X000F,0XF000,0X0001,0XF800,0X0000,0X0000,0X0000,0X0000,
0X0000,0XF000,0X0007,0XF000,0X0007,0X8000,0X0000,0X0000,
0X0000,0X0000,0X0000,0X0000,0X0007,0XF000,0X0000,0X0000,
0X0000,0X0000,0X0000,0X0000,0X0000,0X008C,0X0007,0XF000,
0X0880,0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,0X007F,
0XF807,0XF00F,0XFF00,0X0000,0X0000,0X0000,0X0000,0X0000,
0X0000,0X001F,0XFF94,0X14FF,0XFC00,0X0000,0X0000,0X0000,
0X0000,0X0000,0X0000,0X000F,0XFFF8,0X0FFF,0XF800,0X0000,
0X0000,0X0000,0X0000,0X0000,0X0000,0X0001,0XFFFC,0X1FFF,
0XC000,0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,
0XFFFE,0X3FFF,0X8000,0X0000,0X0000,0X0000,0X0000,0X0000,
0X0000,0X0000,0X0FFF,0X7FF8,0X0000,0X0000,0X0000,0X0000,
0X0000,0X0000,0X0000,0X0000,0X03FF,0X7FE0,0X0000,0X0000,
0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,0X0012,0X2400,
0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,
0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,
0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,
0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,
0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,
0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,
0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,
0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,
};

 unsigned int code f2[1600] = {
0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,
0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,
0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,
0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,
0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,
0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,
0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,
0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,
0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,
0X0000,0X0000,0X0000,0X3FFE,0X0000,0X0000,0X0000,0X0000,
0X0000,0X0000,0X0000,0X0000,0X0003,0XFFFF,0X0000,0X0000,
0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,0X003F,0XFFFF,
0XE000,0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,0X0001,
0X3077,0XFFFF,0X8FC0,0X0000,0X0000,0X0000,0X0000,0X0000,
0X0000,0X017F,0XE000,0X7FFF,0X8FF0,0X0000,0X0000,0X0000,
0X0000,0X0000,0X0000,0X1FFF,0X4000,0X00FE,0X0FFC,0X0000,
0X0000,0X0000,0X0000,0X0000,0X0000,0X7FFF,0X0000,0X000E,
0X0FFC,0X0000,0X0000,0X0000,0X0000,0X0000,0X0003,0XFFFC,
0X0000,0X0000,0X07FF,0X8000,0X0000,0X0000,0X0000,0X0000,
0X0003,0XFFE0,0X0000,0X0003,0XC7FF,0X8000,0X0000,0X0000,
0X0000,0X0000,0X0007,0XFF00,0X0000,0X0007,0XF9FF,0XE000,
0X0000,0X0000,0X0000,0X0000,0X003F,0XFC00,0X0000,0X0007,
0XF81F,0XF000,0X0000,0X0000,0X0000,0X0000,0X00F0,0XE000,
0X0000,0X0007,0XF803,0XF800,0X0000,0X0000,0X0000,0X0000,
0X01F0,0X4000,0X0000,0X000F,0XF001,0XFC00,0X0000,0X0000,
0X0000,0X0000,0X07E0,0XC000,0X0000,0X000F,0XF000,0X3F00,
0X0000,0X0000,0X0000,0X0000,0X0FE3,0XE000,0X0000,0X000F,
0XF000,0X0300,0X0000,0X0000,0X0000,0X0000,0X1FF7,0XE000,
0X0000,0X000F,0XE000,0X0180,0X0000,0X0000,0X0000,0X0000,
0X7FDF,0XF000,0X0000,0X001F,0XE000,0X0000,0X0000,0X0000,
0X0000,0X0000,0X7F8F,0XF800,0X0000,0X001F,0XE000,0X0000,
0X0000,0X0000,0X0000,0X0000,0X7F0F,0XFC00,0X0000,0X001F,
0XE000,0X0000,0X0000,0X0000,0X0000,0X0000,0XFC07,0XFC00,
0X0000,0X001F,0XC000,0X0006,0X0000,0X0000,0X0000,0X0003,
0XF807,0XFE00,0X0000,0X003F,0XC000,0X0003,0X0000,0X0000,
0X0000,0X0003,0XF807,0XFE00,0X0000,0X001F,0XC000,0X0001,
0XC000,0X0000,0X0000,0X0003,0XE003,0XFE00,0X0000,0X001F,
0XC000,0X0001,0XE000,0X0000,0X0000,0X000F,0X8001,0XFF00,
0X0000,0X003F,0X8000,0X0001,0XF800,0X0000,0X0000,0X000F,
0X8001,0XFF80,0X0000,0X003F,0X0000,0X0000,0XFC00,0X0000,
0X0000,0X001C,0X0000,0XFF80,0X0000,0X003F,0X0000,0X0000,
0XFE00,0X0000,0X0000,0X0010,0X0000,0X7F80,0X0000,0X001E,
0X0000,0X0000,0X3F80,0X0000,0X0000,0X0030,0X0000,0X3F80,
0X0000,0X003E,0X0000,0X0000,0X1F80,0X0000,0X0000,0X0000,
0X0000,0X3FC0,0X0000,0X003C,0X0000,0X0000,0X1FC0,0X0000,
0X0000,0X0000,0X0000,0X1F80,0X0000,0X003C,0X0000,0X0000,
0X0FE0,0X0000,0X0000,0X0000,0X0000,0X0F80,0X0000,0X0018,
0X0000,0X0000,0X07F0,0X0000,0X0000,0X0100,0X0000,0X03C0,
0X0000,0X0038,0X0000,0X0000,0X03F8,0X0000,0X0000,0X0000,
0X0000,0X01E0,0X0000,0X0030,0X0000,0X0000,0X01F8,0X0000,
0X0000,0X0600,0X0000,0X00E0,0X0000,0X0030,0X0000,0X0000,
0X00FC,0X0000,0X0000,0X0C00,0X0000,0X00E0,0X0000,0X0000,
0X0000,0X0000,0X00FE,0X0000,0X0000,0X1C00,0X0000,0X0070,
0X0000,0X0000,0X0000,0X0000,0X007E,0X0000,0X0000,0X1800,
0X0000,0X0030,0X0000,0X0000,0X0000,0X0000,0X0044,0X0000,
0X0000,0X7800,0X0000,0X0010,0X0000,0X0000,0X0000,0X0000,
0X03C3,0X0000,0X0000,0XF800,0X0000,0X0000,0X0000,0X0040,
0X0000,0X0000,0X0FC3,0X8000,0X0000,0XF800,0X0000,0X0000,
0X0000,0X00C0,0X0000,0X0000,0X1FE3,0X8000,0X0003,0XF000,
0X0000,0X0004,0X0000,0X00C0,0X0000,0X0000,0X7FE3,0XC000,
0X0003,0XE000,0X0000,0X0002,0X0000,0X01C0,0X0000,0X0001,
0XFFFF,0XC000,0X0007,0XE000,0X0000,0X0002,0X0000,0X03C0,
0X0000,0X0003,0XFFF7,0XE000,0X0007,0XC000,0X0000,0X0003,
0X8000,0X07E0,0X0000,0X000F,0XFFE7,0XE000,0X001F,0XC000,
0X0000,0X0003,0XC000,0X07E0,0X0000,0X001F,0XFFC3,0XF000,
0X001F,0XC000,0X0000,0X0001,0XE000,0X0FE0,0X0000,0X003F,
0XFF01,0XF000,0X001F,0XC000,0X0000,0X0001,0XF000,0X1FE0,
0X0000,0X007F,0XFE01,0XF000,0X001F,0X8000,0X0000,0X0001,
0XFC00,0X3FE0,0X0000,0X00FF,0XF801,0XF800,0X003F,0X8000,
0X0000,0X0001,0XFC00,0X3FE0,0X0000,0X00FF,0XE001,0XF800,
0X003F,0X8000,0X0000,0X0001,0XFF80,0X7FE0,0X0000,0X03FF,
0X0001,0XF800,0X003F,0X8000,0X0000,0X0000,0XFF80,0XFFE0,
0X0000,0X07E4,0X0000,0XF800,0X003F,0X0000,0X0000,0X0001,
0XFFC1,0XFFF0,0X0000,0X0E00,0X0000,0XF800,0X003C,0XE000,
0X0000,0X0001,0XFFE1,0XFFF0,0X0000,0X1E00,0X0000,0X7800,
0X0020,0XFC00,0X0000,0X0000,0XFFFB,0XFFE0,0X0000,0X0000,
0X0000,0X3800,0X0020,0XFFC0,0X0000,0X0000,0XFFFF,0XFFF0,
0X0002,0X8000,0X0000,0X3C00,0X0061,0XFFFC,0X0000,0X0000,
0XFFFF,0XFFF0,0X003F,0X0000,0X0000,0X3C00,0X00E1,0XFFFC,
0X0000,0X0000,0XFFFF,0XFFF0,0X07FE,0X0000,0X0000,0X1C00,
0X00F9,0XFFFF,0XC000,0X0000,0X7FFF,0XFFF1,0XFFFC,0X0000,
0X0000,0X0C00,0X00FF,0XFFFF,0XC000,0X0000,0X7FFF,0XFFFF,
0XFFFC,0X0000,0X0000,0X0C00,0X01FC,0XFFFF,0XF800,0X0000,
0X7FFF,0XFFFF,0XFFF0,0X0000,0X0000,0X0C00,0X01FC,0X1FFF,
0XFC00,0X0000,0X7FFF,0XFFFF,0XFFE0,0X0000,0X0000,0X0400,
0X01FC,0X01FF,0XFF80,0X0003,0XFFFF,0XFFFF,0XFFE0,0X0000,
0X0000,0X0000,0X01F8,0X0019,0XFF80,0X13FF,0XFFFF,0XFFFF,
0XFFC0,0X0000,0X0000,0X0000,0X01F8,0X0000,0X0007,0XFFFF,
0XFFFF,0XFFFF,0XFF80,0X0000,0X0000,0X0000,0X01F8,0X0000,
0X0003,0XFFFF,0XFFFF,0XFFFF,0XFF00,0X0000,0X0000,0X0000,
0X01F8,0X0000,0X0001,0XFFFF,0XFFFF,0XFFFF,0XFE00,0X0000,
0X0000,0X0000,0X01F0,0X0000,0X0000,0X7FFF,0XFFFF,0XFFFF,
0XFC00,0X0000,0X0000,0X0000,0X01F0,0X0000,0X0000,0X7FFF,
0XFFFF,0XFFFF,0XF800,0X0000,0X0000,0X0200,0X01F0,0X0000,
0X0000,0X1FFF,0XFFFF,0XFFFF,0XF800,0X0000,0X0000,0X0200,
0X00E0,0X0000,0X0000,0X07FF,0XFFFF,0XFFFF,0XE000,0X0000,
0X0000,0X0200,0X01E0,0X0000,0X0000,0X03FF,0XFFFF,0XFFFF,
0XE000,0X0000,0X0000,0X0700,0X00F0,0X0000,0X0000,0X00FF,
0XFFFF,0XFFFF,0XF800,0X0000,0X0000,0X0700,0X00F0,0X0000,
0X0000,0X00FF,0XFFFF,0XFFFF,0XFC00,0X0000,0X0000,0X0700,
0X0060,0X0000,0X0000,0X003F,0XFFFF,0XFFFF,0XFF00,0X0000,
0X0000,0X0700,0X00E0,0X0000,0X0000,0X000F,0XFFFF,0XFFFF,
0XFF80,0X0000,0X0000,0X0700,0X0060,0X0000,0X0000,0X000F,
0XFFFF,0XFFFF,0XFFC0,0X0000,0X0000,0X0780,0X0060,0X0000,
0X0000,0X0007,0XFFFF,0XFFFF,0XFFF0,0X0000,0X0000,0X0780,
0X0040,0X0000,0X0000,0X000F,0XFFFF,0XFFFF,0XFFF0,0X0000,
0X0000,0X0F80,0X0060,0X0000,0X0000,0X001F,0XFFFF,0XFFFF,
0XFFFE,0X0000,0X0000,0X0F80,0X0060,0X0000,0X0000,0X003F,
0XFFFF,0XFFFF,0XFFFF,0X0000,0X0000,0X0FC0,0X0020,0X0000,
0X0000,0X007F,0XFFFF,0XFFFF,0XFFFF,0X0000,0X0000,0X0F80,
0X0000,0X0000,0X0000,0X00FF,0XFFFF,0XFFFF,0XFFFF,0XE000,
0X0000,0X1FC0,0X0000,0X0000,0X0000,0X01FF,0XFFFF,0XFFFF,
0XFFFF,0XE000,0X0000,0X1FC0,0X0020,0X0000,0X0000,0X01FF,
0XFFFF,0XFFFF,0XFFE4,0X02FF,0XE400,0X1FC0,0X0000,0X0000,
0X0000,0X03FF,0XFFFF,0XFFFF,0XE400,0X00FF,0XFFC0,0X1F80,
0X0010,0X0000,0X0000,0X07FF,0XFFFF,0XFFFE,0X0000,0X007F,
0XFFFC,0X3F80,0X0030,0X0000,0X0000,0X0FFF,0XFFFF,0XFFFE,
0X0000,0X000F,0XFFFF,0XBF80,0X0010,0X0000,0X0000,0X0FFF,
0XFFFF,0XFFFE,0X0000,0X0007,0XFFFF,0X9F80,0X0018,0X0000,
0X0000,0X3FFF,0X87FF,0XFFFF,0X0000,0X0000,0XFFFF,0X8F00,
0X001C,0X0000,0X0000,0X3FF0,0X07FF,0XFFFF,0X0000,0X0000,
0X3FFF,0X8700,0X003C,0X0000,0X0000,0X7B00,0X0FFF,0XFFFF,
0X0000,0X0000,0X1FFF,0X8200,0X001C,0X0000,0X0001,0X0000,
0X07FF,0XFFFF,0X8000,0X0000,0X01FF,0X0000,0X001E,0X0000,
0X0000,0X0000,0X07FF,0XEFFF,0X8000,0X0000,0X001F,0X0000,
0X001E,0X0000,0X0010,0X0000,0X07FF,0XCFFF,0X8000,0X0000,
0X0003,0X9C00,0X001F,0X0000,0X00F0,0X0000,0X07FF,0X83FF,
0X8000,0X0000,0X0000,0XFE00,0X001F,0X8000,0X1FE0,0X0000,
0X07FF,0X01FF,0X8000,0X0000,0X0000,0XFC00,0X001F,0X8000,
0XFFC0,0X0000,0X07FF,0X00FF,0X8000,0X0000,0X0001,0XFC00,
0X000F,0X0003,0XFF00,0X0000,0X03FE,0X007F,0X8000,0X0000,
0X0001,0XFC00,0X001F,0X8017,0XFE00,0X0000,0X07FC,0X001F,
0XC000,0X0000,0X0001,0XFC00,0X000F,0X807F,0XFE00,0X0000,
0X07F8,0X001F,0XC000,0X0000,0X0001,0XF800,0X000F,0XC0FF,
0XFC00,0X0000,0X03F8,0X0007,0XC000,0X0000,0X0003,0XF800,
0X000F,0XC1FF,0XF800,0X0000,0X03F0,0X0003,0XC000,0X0000,
0X0003,0XF000,0X0007,0XE3FF,0XF000,0X0000,0X07E0,0X0001,
0XC000,0X0000,0X0003,0XF000,0X0003,0XFFFF,0XE000,0X0000,
0X03E0,0X0000,0XE000,0X0000,0X0003,0XE000,0X0003,0XEFFF,
0X8000,0X0000,0X03C0,0X0000,0X2000,0X0000,0X0007,0XC000,
0X0003,0XE7FF,0X0000,0X0000,0X0380,0X0000,0X2000,0X0000,
0X0007,0XC000,0X0003,0XC3FE,0X0000,0X0000,0X0300,0X0000,
0X0000,0X0000,0X000F,0X8000,0X0001,0XC3E0,0X0000,0X0000,
0X0300,0X0000,0X0000,0X0000,0X001F,0X0000,0X0000,0X41C0,
0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,0X001E,0X0000,
0X0000,0X3100,0X0000,0X0000,0X0000,0X0000,0X0400,0X0000,
0X001E,0X0000,0X0000,0X7F00,0X0000,0X0000,0X0000,0X0000,
0X0600,0X0000,0X0018,0X0000,0X0000,0X7F00,0X0000,0X0000,
0X0000,0X0000,0X0700,0X0000,0X0030,0X0000,0X0000,0X1F80,
0X0000,0X0000,0X0400,0X0000,0X0300,0X0000,0X0020,0X0000,
0X0000,0X1F80,0X0000,0X0000,0X0C00,0X0000,0X03E0,0X0000,
0X0040,0X0000,0X0000,0X0FC0,0X0000,0X0000,0X0C00,0X0000,
0X03F0,0X0000,0X0000,0X0000,0X0000,0X0FF0,0X0000,0X0000,
0X1C00,0X0000,0X03F0,0X0000,0X0000,0X0000,0X0000,0X07F8,
0X0000,0X0000,0X1C00,0X0000,0X03F8,0X0000,0X0000,0X0000,
0X0000,0X03F8,0X0000,0X0000,0X3C00,0X0000,0X03FC,0X0000,
0X0000,0X0000,0X0000,0X01FC,0X0000,0X0000,0X3C00,0X0000,
0X01FE,0X0000,0X0400,0X0000,0X0000,0X00FC,0X0000,0X0000,
0X7C00,0X0000,0X01FE,0X0000,0X0C00,0X0000,0X0000,0X007E,
0X0000,0X0000,0XFC00,0X0000,0X01FF,0X0000,0X3000,0X0000,
0X0000,0X001F,0X8000,0X0000,0XFC00,0X0000,0X00FF,0X0000,
0XF000,0X0000,0X0000,0X000F,0X0000,0X0001,0XFC00,0X0000,
0X00FF,0X8001,0XF000,0X0000,0X0000,0X0007,0X8000,0X0001,
0XF800,0X0000,0X007F,0XC007,0XF000,0X0000,0X0000,0X0003,
0X8000,0X0003,0XF800,0X0000,0X007F,0XC01F,0XC000,0X0000,
0X0000,0X0000,0XC000,0X0003,0XFC00,0X0000,0X003F,0XE01F,
0XC000,0X0000,0X0000,0X0000,0X2000,0X0003,0XFC00,0X0000,
0X003F,0XE03F,0X8000,0X0000,0X0000,0X0000,0X0000,0X0003,
0XF800,0X0000,0X001F,0XF07F,0X0000,0X0000,0X0000,0X0000,
0X0000,0X0007,0XF800,0X0000,0X001F,0XF9FE,0X0000,0X0000,
0X0000,0X0000,0X0200,0X0007,0XF800,0X0000,0X000F,0XFBFE,
0X0000,0X0000,0X0000,0X0000,0X0100,0X0007,0XF800,0X0000,
0X0007,0XE7FC,0X0000,0X0000,0X0000,0X0000,0X00E0,0X0007,
0XF000,0X0000,0X0003,0XC7F0,0X0000,0X0000,0X0000,0X0000,
0X007E,0X000F,0XF000,0X0000,0X0003,0X07E0,0X0000,0X0000,
0X0000,0X0000,0X003E,0X000F,0XF000,0X0000,0X0001,0X07E0,
0X0000,0X0000,0X0000,0X0000,0X001F,0XC00F,0XF000,0X0000,
0X0007,0X8E00,0X0000,0X0000,0X0000,0X0000,0X000F,0XFC1F,
0XE000,0X0000,0X001F,0XF200,0X0000,0X0000,0X0000,0X0000,
0X0007,0XFFDF,0XE000,0X0000,0X01FF,0XF000,0X0000,0X0000,
0X0000,0X0000,0X0001,0XFFF3,0XE000,0X0000,0X07FF,0XE000,
0X0000,0X0000,0X0000,0X0000,0X0000,0XFFF0,0X6000,0X0000,
0X1FFF,0X8000,0X0000,0X0000,0X0000,0X0000,0X0000,0X7FF0,
0X7800,0X0000,0XFFFF,0X0000,0X0000,0X0000,0X0000,0X0000,
0X0000,0X1FF0,0XFF80,0X0001,0XFFF8,0X0000,0X0000,0X0000,
0X0000,0X0000,0X0000,0X1FF8,0XFFFB,0X0003,0XFF40,0X0000,
0X0000,0X0000,0X0000,0X0000,0X0000,0X01FF,0XFFFF,0XF104,
0X6000,0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,0X0003,
0XFFFF,0XFA00,0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,
0X0000,0X0001,0XFFFF,0XC000,0X0000,0X0000,0X0000,0X0000,
0X0000,0X0000,0X0000,0X0000,0X3FF2,0X0000,0X0000,0X0000,
0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,
0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,
0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,
0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,
0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,
0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,
0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,
0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,
0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,
};

 unsigned int code f3[1600] = {
0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,
0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,
0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,
0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,
0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,
0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,
0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,
0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,
0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,
0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,
0X0000,0X0000,0X0000,0X0000,0X07D4,0X0000,0X0000,0X0000,
0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,0X7FFF,0XA000,
0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,0X0001,
0XFFFF,0XFE00,0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,
0X0000,0X003D,0XFFFF,0XFE0A,0XFA80,0X0000,0X0000,0X0000,
0X0000,0X0000,0X0000,0X03FC,0X7FFF,0XC007,0XFFF8,0X0000,
0X0000,0X0000,0X0000,0X0000,0X0000,0X07F8,0X1FD0,0X0000,
0X7FFF,0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,0X1FF8,
0X2000,0X0000,0X1FFF,0XC000,0X0000,0X0000,0X0000,0X0000,
0X0000,0X3FF0,0XF000,0X0000,0X07FF,0XE000,0X0000,0X0000,
0X0000,0X0000,0X0000,0XFFEF,0XF000,0X0000,0X02FF,0XF000,
0X0000,0X0000,0X0000,0X0000,0X0001,0XFF0F,0XF000,0X0000,
0X003F,0XF800,0X0000,0X0000,0X0000,0X0000,0X0003,0XFE07,
0XF800,0X0000,0X000F,0XF000,0X0000,0X0000,0X0000,0X0000,
0X000F,0XF807,0XF800,0X0000,0X0003,0XC3E0,0X0000,0X0000,
0X0000,0X0000,0X000F,0XC007,0XFC00,0X0000,0X0001,0X01F0,
0X0000,0X0000,0X0000,0X0000,0X003F,0X0007,0XFC00,0X0000,
0X0000,0X03FC,0X0000,0X0000,0X0000,0X0000,0X0060,0X0007,
0XFC00,0X0000,0X0001,0XC3FC,0X0000,0X0000,0X0000,0X0000,
0X0040,0X0007,0XFC00,0X0000,0X0003,0XF3FF,0X0000,0X0000,
0X0000,0X0000,0X0000,0X0003,0XFC00,0X0000,0X0007,0XFFFF,
0X0000,0X0000,0X0000,0X0000,0X0000,0X0003,0XFC00,0X0000,
0X0007,0XFCFF,0X8000,0X0000,0X0000,0X0000,0X0000,0X0003,
0XFE00,0X0000,0X000F,0XF83F,0XC000,0X0000,0X0000,0X0000,
0X3800,0X0001,0XFE00,0X0000,0X000F,0XF01F,0XE000,0X0000,
0X0000,0X0000,0X6000,0X0001,0XFE00,0X0000,0X001F,0XF007,
0XE000,0X0000,0X0000,0X0000,0XC000,0X0000,0XFE00,0X0000,
0X001F,0XE003,0XF000,0X0000,0X0000,0X0003,0XC000,0X0000,
0XFE00,0X0000,0X003F,0XE001,0XF000,0X0000,0X0000,0X000F,
0X8000,0X0000,0XFE00,0X0000,0X007F,0XC000,0XF800,0X0000,
0X0000,0X003F,0X8000,0X0000,0X7E00,0X0000,0X007F,0XC000,
0X3C00,0X0000,0X0000,0X007F,0X0000,0X0000,0X3C00,0X0000,
0X007F,0X8000,0X0E00,0X0000,0X0000,0X00FE,0X0000,0X0000,
0X1E00,0X0000,0X007F,0X0000,0X0600,0X0000,0X0000,0X01FC,
0X0000,0X0000,0X1E00,0X0000,0X00FF,0X0000,0X0600,0X0000,
0X0000,0X03F8,0X0000,0X0000,0X0E00,0X0000,0X00FE,0X0000,
0X0100,0X0000,0X0000,0X07F8,0X0000,0X0000,0X0E00,0X0000,
0X01FC,0X0000,0X0000,0X0000,0X0000,0X07F0,0X0000,0X0000,
0X0E00,0X0000,0X00F8,0X0000,0X0000,0X0000,0X0000,0X0FF0,
0X0000,0X0000,0X0600,0X0000,0X01F0,0X0000,0X0000,0X0000,
0X0000,0X1FE0,0X0000,0X0000,0X0200,0X0000,0X01F0,0X0000,
0X0020,0X0000,0X0000,0X1FC0,0X0000,0X0000,0X0200,0X0000,
0X03C0,0X0000,0X0018,0X0000,0X0000,0X1FC0,0X0000,0X0000,
0X0000,0X0000,0X03C0,0X0000,0X0018,0X0000,0X0000,0X1F80,
0X0000,0X0000,0X0000,0X0000,0X0380,0X0000,0X000C,0X0000,
0X0000,0X20C0,0X0000,0X0000,0X0100,0X0000,0X0600,0X0000,
0X001E,0X0000,0X0000,0X20F0,0X0000,0X0000,0X0000,0X0000,
0X0600,0X0000,0X000F,0X0000,0X0000,0XE0F8,0X0000,0X0000,
0X0180,0X0000,0X0400,0X0000,0X000F,0X8000,0X0001,0XF1FE,
0X0000,0X0000,0X0080,0X0000,0X0000,0X0000,0X000F,0X8000,
0X0001,0XF1FF,0X8000,0X0000,0X01C0,0X0000,0X0000,0X0000,
0X0007,0XC000,0X0003,0XFBFF,0XE000,0X0000,0X01E0,0X0000,
0X1000,0X0000,0X0003,0XE000,0X0003,0XFFFF,0XF000,0X0000,
0X01F0,0X0000,0X3000,0X0000,0X0003,0XF000,0X0007,0XF9FF,
0XF800,0X0000,0X01F0,0X0000,0X6000,0X0000,0X0003,0XF000,
0X0007,0XF07F,0XFC00,0X0000,0X01F8,0X0000,0XF000,0X0000,
0X0001,0XF000,0X0007,0XE03F,0XFF00,0X0000,0X01FC,0X0003,
0XE000,0X0000,0X0001,0XFC00,0X000F,0XE00F,0XFF80,0X0000,
0X01FC,0X0007,0XE000,0X0000,0X0000,0XFC00,0X000F,0XC003,
0XFF80,0X0000,0X01FE,0X000F,0XE000,0X0000,0X0000,0XFC00,
0X000F,0XC000,0XFFE0,0X0000,0X03FF,0X003F,0XE000,0X0000,
0X0000,0X7C00,0X000F,0X8000,0X7FF0,0X0000,0X01FF,0X807F,
0XE000,0X0000,0X0000,0X7E00,0X000F,0X8000,0X07F0,0X0000,
0X03FF,0X80FF,0XE000,0X0000,0X0000,0X7F00,0X000F,0X0000,
0X007C,0X0000,0X03FF,0XC1FF,0XC000,0X0000,0X0000,0X3F00,
0X000E,0X0000,0X0006,0X0000,0X03FF,0XC7FF,0XC000,0X0000,
0X0001,0X6F00,0X000F,0X0000,0X0000,0X0000,0X03FF,0XE7FF,
0XC000,0X0000,0X001F,0XC200,0X000E,0X0000,0X0000,0X0000,
0X03FF,0XFFFF,0XC000,0X0000,0X00FF,0XC000,0X000E,0X0000,
0X0000,0X3E80,0X01FF,0XFFFF,0XC000,0X0000,0X0FFF,0XE300,
0X000C,0X0000,0X0000,0X1FFE,0X03FF,0XFFFF,0X8000,0X0000,
0X3FFF,0XE380,0X000C,0X0000,0X0000,0X1FFF,0XF3FF,0XFFFF,
0X8000,0X0000,0X7FFF,0XE780,0X0018,0X0000,0X0000,0X07FF,
0XFFFF,0XFFFF,0X8000,0X0001,0XFFFF,0XFF80,0X0008,0X0000,
0X0000,0X07FF,0XFFFF,0XFFFF,0X8000,0X0003,0XFFFF,0X8F80,
0X0018,0X0000,0X0000,0X03FF,0XFFFF,0XFFFF,0X0000,0X001F,
0XFFFF,0X8FC0,0X0008,0X0000,0X0000,0X01FF,0XFFFF,0XFFFF,
0X8000,0X003F,0XFFF8,0X0FC0,0X0000,0X0000,0X0000,0X00FF,
0XFFFF,0XFFFF,0XFFA8,0X00F0,0XBC80,0X07C0,0X0000,0X0000,
0X0000,0X007F,0XFFFF,0XFFFF,0XFFFF,0XFC00,0X0000,0X07C0,
0X0000,0X0000,0X0000,0X007F,0XFFFF,0XFFFF,0XFFFF,0XF000,
0X0000,0X07C0,0X0000,0X0000,0X0000,0X003F,0XFFFF,0XFFFF,
0XFFFF,0XC000,0X0000,0X0FC0,0X0010,0X0000,0X0000,0X001F,
0XFFFF,0XFFFF,0XFFFF,0XC000,0X0000,0X0FC0,0X0010,0X0000,
0X0000,0X000F,0XFFFF,0XFFFF,0XFFFF,0X0000,0X0000,0X07C0,
0X0030,0X0000,0X0000,0X000F,0XFFFF,0XFFFF,0XFFFC,0X0000,
0X0000,0X07C0,0X0010,0X0000,0X0000,0X0007,0XFFFF,0XFFFF,
0XFFF0,0X0000,0X0000,0X0780,0X0038,0X0000,0X0000,0X0003,
0XFFFF,0XFFFF,0XFFE0,0X0000,0X0000,0X0780,0X0038,0X0000,
0X0000,0X0003,0XFFFF,0XFFFF,0XFFC0,0X0000,0X0000,0X0380,
0X0078,0X0000,0X0000,0X000F,0XFFFF,0XFFFF,0XFF00,0X0000,
0X0000,0X0380,0X0038,0X0000,0X0000,0X003F,0XFFFF,0XFFFF,
0XFE00,0X0000,0X0000,0X0780,0X0078,0X0000,0X0000,0X00FF,
0XFFFF,0XFFFF,0XF800,0X0000,0X0000,0X0380,0X0078,0X0000,
0X0000,0X01FF,0XFFFF,0XFFFF,0XF000,0X0000,0X0000,0X0100,
0X007C,0X0000,0X0000,0X03FF,0XFFFF,0XFFFF,0XF800,0X0000,
0X0000,0X0180,0X00FC,0X0000,0X0000,0X0FFF,0XFFFF,0XFFFF,
0XFE00,0X0000,0X0000,0X0300,0X007C,0X0000,0X0000,0X0FFF,
0XFFFF,0XFFFF,0XFE00,0X0000,0X0000,0X0100,0X00FC,0X0000,
0X0000,0X3FFF,0XFFFF,0XFFFF,0XFF00,0X0000,0X0000,0X0000,
0X0078,0X0000,0X0000,0XFFFF,0XFFFF,0XFFFF,0XFF00,0X0000,
0X0000,0X0100,0X00FC,0X0000,0X0001,0XFFFF,0XFFFF,0XFFFF,
0XFFC0,0X0000,0X0000,0X0000,0X00FC,0X0000,0X4003,0XFFFF,
0XFFFF,0XFFFF,0XFFC0,0X0000,0X0000,0X0000,0X007C,0X001F,
0XE780,0X0AFF,0XFFFF,0XFFFF,0XFFE0,0X0000,0X0000,0X0200,
0X007C,0X07FF,0XFF80,0X0000,0X3FFF,0XFFFF,0XFFE0,0X0000,
0X0000,0X0200,0X007E,0X0FFF,0XFC00,0X0000,0X3FFF,0XFFFF,
0XFFF8,0X0000,0X0000,0X0000,0X007E,0XFFFF,0XF000,0X0000,
0X3FFF,0XFFFF,0XFFF8,0X0000,0X0000,0X0200,0X007D,0XFFFF,
0XC000,0X0000,0X7FFF,0XFFFF,0XFFFC,0X0000,0X0000,0X0600,
0X0078,0XFFFF,0XC000,0X0000,0X3FFF,0XFFFD,0XFFFC,0X0000,
0X0000,0X0600,0X0038,0XFFFF,0X0000,0X0000,0X7FFF,0XFFF0,
0X07FF,0X0000,0X0000,0X0E00,0X0030,0XFFF8,0X0000,0X0000,
0X7FFF,0XFFF0,0X003F,0X8000,0X0000,0X0E00,0X0000,0XFFC0,
0X0000,0X0000,0X7FFF,0XFFF0,0X0000,0X8000,0X0000,0X1E00,
0X0018,0X7F80,0X0000,0X0000,0XFFFE,0XFFF8,0X0000,0X0000,
0X0000,0X1E00,0X001E,0XC000,0X0000,0X0000,0X7FF8,0XFFF0,
0X0000,0X0E00,0X0000,0X1E00,0X001F,0X8000,0X0000,0X0000,
0XFFE0,0X7FF0,0X0000,0X07C0,0X0000,0X3E00,0X000F,0X8000,
0X0000,0X0000,0XFFE0,0X7FF0,0X0000,0X03FC,0X0000,0X3C00,
0X001F,0XC000,0X0000,0X0000,0XFF80,0X3FF0,0X0000,0X01FF,
0X0000,0X7E00,0X000F,0XC000,0X0000,0X0000,0XFF00,0X1FF0,
0X0000,0X00FF,0XF000,0X7C00,0X0007,0XC000,0X0000,0X0001,
0XFE00,0X0FF0,0X0000,0X007F,0XF800,0XFE00,0X0007,0XE000,
0X0000,0X0000,0XF800,0X0FE0,0X0000,0X003F,0XFE00,0XFC00,
0X0007,0XF000,0X0000,0X0001,0XF800,0X07F0,0X0000,0X000F,
0XFF81,0XFC00,0X0007,0XF000,0X0000,0X0001,0XF000,0X07E0,
0X0000,0X0007,0XFFE3,0XFC00,0X0001,0XF800,0X0000,0X0001,
0XC000,0X03F0,0X0000,0X0007,0XFFF3,0XF800,0X0001,0XF800,
0X0000,0X0001,0X8000,0X01E0,0X0000,0X0001,0XFFF7,0XF800,
0X0000,0XF800,0X0000,0X0001,0X0000,0X01F0,0X0000,0X0000,
0X7FF3,0XF000,0X0000,0XF800,0X0000,0X0000,0X0000,0X00E0,
0X0000,0X0000,0X3FF1,0XF000,0X0000,0X3C00,0X0000,0X0000,
0X0000,0X0060,0X0000,0X0000,0X0FE0,0XE000,0X0000,0X3E00,
0X0000,0X0008,0X0000,0X0020,0X0000,0X0000,0X03C0,0XE000,
0X0000,0X1C00,0X0000,0X000C,0X0000,0X0020,0X0000,0X0000,
0X00C0,0X8000,0X0000,0X1E00,0X0000,0X0018,0X0000,0X0000,
0X0000,0X0000,0X0040,0X0000,0X0000,0X0600,0X0000,0X0070,
0X0000,0X0000,0X0000,0X0000,0X007F,0X0000,0X0000,0X0600,
0X0000,0X0070,0X0000,0X0000,0X0000,0X0000,0X007F,0X0000,
0X0000,0X0300,0X0000,0X00F0,0X0000,0X0000,0X0000,0X0000,
0X00FF,0X0000,0X0000,0X0000,0X0000,0X01F0,0X0000,0X0008,
0X0000,0X0000,0X01FE,0X0000,0X0000,0X0080,0X0000,0X03E0,
0X0000,0X0008,0X0000,0X0000,0X01FC,0X0000,0X0000,0X0000,
0X0000,0X07E0,0X0000,0X000C,0X0000,0X0000,0X03FC,0X0000,
0X0000,0X0000,0X0000,0X0FE0,0X0000,0X000C,0X0000,0X0000,
0X03F8,0X0000,0X0000,0X0010,0X0000,0X1FE0,0X0000,0X000C,
0X0000,0X0000,0X07F8,0X0000,0X0000,0X0010,0X0000,0X1FC0,
0X0000,0X000F,0X0000,0X0000,0X07E0,0X0000,0X0000,0X000C,
0X0000,0X3FC0,0X0000,0X000F,0X8000,0X0000,0X0FC0,0X0000,
0X0000,0X000E,0X0000,0X7FC0,0X0000,0X001F,0X8000,0X0000,
0X3F80,0X0000,0X0000,0X0007,0X8000,0X7FC0,0X0000,0X001F,
0X8000,0X0000,0X3F00,0X0000,0X0000,0X0007,0XC000,0XFF80,
0X0000,0X000F,0XC000,0X0000,0X7C00,0X0000,0X0000,0X0003,
0XE000,0XFF00,0X0000,0X000F,0XE000,0X0000,0X7800,0X0000,
0X0000,0X0001,0XF001,0XFF00,0X0000,0X001F,0XE000,0X0000,
0XF000,0X0000,0X0000,0X0001,0XFC01,0XFE00,0X0000,0X000F,
0XE000,0X0001,0X8000,0X0000,0X0000,0X0000,0X7F03,0XFE00,
0X0000,0X000F,0XF000,0X0000,0X0000,0X0000,0X0000,0X0000,
0X7FC7,0XFC00,0X0000,0X000F,0XF000,0X0006,0X0000,0X0000,
0X0000,0X0000,0X3FE7,0XFC00,0X0000,0X000F,0XF000,0X0000,
0X0000,0X0000,0X0000,0X0000,0X3FFF,0XF800,0X0000,0X000F,
0XF000,0X0000,0X0000,0X0000,0X0000,0X0000,0X1FF9,0XF000,
0X0000,0X000F,0XF800,0X0040,0X0000,0X0000,0X0000,0X0000,
0X1FF8,0X7000,0X0000,0X0007,0XF800,0X0780,0X0000,0X0000,
0X0000,0X0000,0X07F8,0X2000,0X0000,0X0007,0XF800,0X1E00,
0X0000,0X0000,0X0000,0X0000,0X01F0,0X3000,0X0000,0X0007,
0XF801,0XFE00,0X0000,0X0000,0X0000,0X0000,0X0078,0XFC00,
0X0000,0X0007,0XFC07,0XFC00,0X0000,0X0000,0X0000,0X0000,
0X000F,0XFE00,0X0000,0X0003,0XFC0F,0XF000,0X0000,0X0000,
0X0000,0X0000,0X0003,0XFF80,0X0000,0X0003,0XFC3F,0XF000,
0X0000,0X0000,0X0000,0X0000,0X0003,0XFFE0,0X0000,0X0001,
0XFFFF,0XC000,0X0000,0X0000,0X0000,0X0000,0X0001,0XFFFA,
0X0000,0X0001,0X83FF,0X8000,0X0000,0X0000,0X0000,0X0000,
0X0000,0X7FFF,0X0000,0X0003,0X03FF,0X0000,0X0000,0X0000,
0X0000,0X0000,0X0000,0X1FFF,0XC000,0X07DF,0X87FC,0X0000,
0X0000,0X0000,0X0000,0X0000,0X0000,0X01FF,0XF001,0XFFFF,
0XC7E0,0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,0X000F,
0XBE17,0XFFFF,0XFEC0,0X0000,0X0000,0X0000,0X0000,0X0000,
0X0000,0X0000,0X000B,0XFFFF,0XE200,0X0000,0X0000,0X0000,
0X0000,0X0000,0X0000,0X0000,0X0000,0XFFFF,0X2000,0X0000,
0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,0X02B2,
0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,
0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,
0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,
0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,
0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,
0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,
0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,
0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,0X0000,
};



 unsigned char code gImage_busy_im[256] = {
0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,
0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,0X55,0X55,0X55,0X55,0X6A,0XAA,
0XAA,0XAA,0X54,0X00,0X00,0X05,0X6A,0XAA,0XAA,0XAA,0X55,0X55,0X55,0X55,0X6A,0XAA,
0XAA,0XAA,0X94,0X00,0X00,0X05,0XAA,0XAA,0XAA,0XAA,0X94,0X00,0X00,0X05,0XAA,0XAA,
0XAA,0XAA,0X94,0X44,0X44,0X45,0XAA,0XAA,0XAA,0XAA,0X94,0X11,0X11,0X05,0XAA,0XAA,
0XAA,0XAA,0X95,0X04,0X44,0X15,0XAA,0XAA,0XAA,0XAA,0XA5,0X41,0X10,0X56,0XAA,0XAA,
0XAA,0XAA,0XA9,0X50,0X41,0X5A,0XAA,0XAA,0XAA,0XAA,0XAA,0X54,0X05,0X6A,0XAA,0XAA,
0XAA,0XAA,0XAA,0X94,0X05,0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,0X94,0X05,0XAA,0XAA,0XAA,
0XAA,0XAA,0XAA,0X94,0X45,0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,0X94,0X05,0XAA,0XAA,0XAA,
0XAA,0XAA,0XAA,0X50,0X01,0X6A,0XAA,0XAA,0XAA,0XAA,0XA9,0X40,0X40,0X5A,0XAA,0XAA,
0XAA,0XAA,0XA5,0X00,0X10,0X16,0XAA,0XAA,0XAA,0XAA,0X94,0X00,0X00,0X05,0XAA,0XAA,
0XAA,0XAA,0X94,0X04,0X44,0X05,0XAA,0XAA,0XAA,0XAA,0X94,0X11,0X11,0X05,0XAA,0XAA,
0XAA,0XAA,0X94,0X44,0X44,0X45,0XAA,0XAA,0XAA,0XAA,0X95,0X11,0X11,0X15,0XAA,0XAA,
0XAA,0XAA,0X55,0X55,0X55,0X55,0X6A,0XAA,0XAA,0XAA,0X54,0X00,0X00,0X05,0X6A,0XAA,
0XAA,0XAA,0X55,0X55,0X55,0X55,0X6A,0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,
0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,
};


unsigned char code gImage_no_im[256] = {
0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,
0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,0X95,0X55,0XAA,0XAA,0XAA,
0XAA,0XAA,0XA9,0X40,0X00,0X5A,0XAA,0XAA,0XAA,0XAA,0X94,0X00,0X00,0X05,0XAA,0XAA,
0XAA,0XAA,0X40,0X00,0X00,0X00,0X6A,0XAA,0XAA,0XA9,0X00,0X15,0X55,0X00,0X1A,0XAA,
0XAA,0XA4,0X00,0X6A,0XAA,0X50,0X06,0XAA,0XAA,0XA4,0X00,0X6A,0XAA,0XA4,0X06,0XAA,
0XAA,0X90,0X00,0X1A,0XAA,0XA9,0X01,0XAA,0XAA,0X90,0X10,0X06,0XAA,0XA9,0X01,0XAA,
0XAA,0X40,0X64,0X01,0XAA,0XAA,0X40,0X6A,0XAA,0X40,0X69,0X00,0X6A,0XAA,0X40,0X6A,
0XAA,0X40,0X6A,0X40,0X1A,0XAA,0X40,0X6A,0XAA,0X40,0X6A,0X90,0X06,0XAA,0X40,0X6A,
0XAA,0X40,0X6A,0XA4,0X01,0XAA,0X40,0X6A,0XAA,0X40,0X6A,0XA9,0X00,0X6A,0X40,0X6A,
0XAA,0X40,0X6A,0XAA,0X40,0X1A,0X40,0X6A,0XAA,0X90,0X1A,0XAA,0X90,0X05,0X01,0XAA,
0XAA,0X90,0X1A,0XAA,0XA4,0X00,0X01,0XAA,0XAA,0XA4,0X06,0XAA,0XA9,0X00,0X06,0XAA,
0XAA,0XA4,0X01,0X6A,0XAA,0X40,0X06,0XAA,0XAA,0XA9,0X00,0X15,0X55,0X00,0X1A,0XAA,
0XAA,0XAA,0X40,0X00,0X00,0X00,0X6A,0XAA,0XAA,0XAA,0X94,0X00,0X00,0X05,0XAA,0XAA,
0XAA,0XAA,0XA9,0X40,0X00,0X5A,0XAA,0XAA,0XAA,0XAA,0XAA,0X95,0X55,0XAA,0XAA,0XAA,
0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,
0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,
};

unsigned char code gImage_arrow_il[256] = {
0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,0X6A,0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,
0X5A,0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,0X46,0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,
0X41,0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,0X40,0X6A,0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,
0X40,0X1A,0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,0X40,0X06,0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,
0X40,0X01,0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,0X40,0X00,0X6A,0XAA,0XAA,0XAA,0XAA,0XAA,
0X40,0X00,0X1A,0XAA,0XAA,0XAA,0XAA,0XAA,0X40,0X00,0X06,0XAA,0XAA,0XAA,0XAA,0XAA,
0X40,0X00,0X01,0XAA,0XAA,0XAA,0XAA,0XAA,0X40,0X00,0X00,0X6A,0XAA,0XAA,0XAA,0XAA,
0X40,0X00,0X00,0X1A,0XAA,0XAA,0XAA,0XAA,0X40,0X00,0X00,0X06,0XAA,0XAA,0XAA,0XAA,
0X40,0X00,0X00,0X01,0XAA,0XAA,0XAA,0XAA,0X40,0X00,0X00,0X00,0X6A,0XAA,0XAA,0XAA,
0X40,0X00,0X15,0X55,0X5A,0XAA,0XAA,0XAA,0X40,0X10,0X1A,0XAA,0XAA,0XAA,0XAA,0XAA,
0X40,0X64,0X06,0XAA,0XAA,0XAA,0XAA,0XAA,0X41,0XA4,0X06,0XAA,0XAA,0XAA,0XAA,0XAA,
0X46,0XA9,0X01,0XAA,0XAA,0XAA,0XAA,0XAA,0X5A,0XA9,0X01,0XAA,0XAA,0XAA,0XAA,0XAA,
0X6A,0XAA,0X40,0X6A,0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,0X40,0X6A,0XAA,0XAA,0XAA,0XAA,
0XAA,0XAA,0X90,0X1A,0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,0X90,0X1A,0XAA,0XAA,0XAA,0XAA,
0XAA,0XAA,0XA4,0X06,0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,0XA4,0X06,0XAA,0XAA,0XAA,0XAA,
0XAA,0XAA,0XA9,0X5A,0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,
};

unsigned char code gImage_pen_il[256] = {
0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,
0X96,0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,0X91,0X6A,0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,
0XA4,0X15,0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,0XA4,0X00,0X6A,0XAA,0XAA,0XAA,0XAA,0XAA,
0XA9,0X01,0X1A,0XAA,0XAA,0XAA,0XAA,0XAA,0XA9,0X00,0X46,0XAA,0XAA,0XAA,0XAA,0XAA,
0XAA,0X40,0X51,0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,0X90,0X14,0X6A,0XAA,0XAA,0XAA,0XAA,
0XAA,0XA4,0X05,0X1A,0XAA,0XAA,0XAA,0XAA,0XAA,0XA9,0X01,0X46,0XAA,0XAA,0XAA,0XAA,
0XAA,0XAA,0X40,0X51,0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,0X90,0X14,0X6A,0XAA,0XAA,0XAA,
0XAA,0XAA,0XA4,0X05,0X1A,0XAA,0XAA,0XAA,0XAA,0XAA,0XA9,0X01,0X46,0XAA,0XAA,0XAA,
0XAA,0XAA,0XAA,0X40,0X51,0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,0X90,0X14,0X69,0XAA,0XAA,
0XAA,0XAA,0XAA,0XA4,0X01,0X14,0X6A,0XAA,0XAA,0XAA,0XAA,0XA9,0X00,0X44,0X1A,0XAA,
0XAA,0XAA,0XAA,0XAA,0X40,0X11,0X06,0XAA,0XAA,0XAA,0XAA,0XAA,0X90,0X04,0X41,0XAA,
0XAA,0XAA,0XAA,0XAA,0XA4,0X01,0X10,0X6A,0XAA,0XAA,0XAA,0XAA,0XA9,0X00,0X44,0X1A,
0XAA,0XAA,0XAA,0XAA,0XAA,0X40,0X11,0X1A,0XAA,0XAA,0XAA,0XAA,0XAA,0X90,0X04,0X1A,
0XAA,0XAA,0XAA,0XAA,0XAA,0XA4,0X01,0X1A,0XAA,0XAA,0XAA,0XAA,0XAA,0XA9,0X00,0X1A,
0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,0X40,0X6A,0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,0X95,0XAA,
0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,0XAA,
};



  unsigned int code pic_80x80[]={




0x6c51,0x7472,0x7492,0x7472,0x7451,0x7451,0x7472,0x7c92,
0x6c31,0x63cf,0x534d,0x4b2d,0x5b8f,0x7c72,0x9535,0x9d75,
0x9d95,0x9d95,0x9d75,0x9d95,0xa5d7,0xae18,0xa5d7,0x9575,
0x7c92,0x430c,0x2a29,0x32aa,0x430c,0x42ec,0x326a,0x19e7,
0x2248,0x2a69,0x538f,0x6c33,0x536f,0x4b6e,0x2207,0x2206,
0x3289,0x3a8b,0x3a8d,0x2a2c,0x1169,0x21e9,0x2227,0x4b8c,
0x4b6d,0x3b0c,0x19e8,0x0145,0x11c7,0x226a,0x2a6a,0x224a,
0x19e9,0x11c8,0x2a6b,0x4b8f,0x6411,0x74b3,0x8d35,0x9576,
0x9577,0x9db8,0xa5d8,0x9577,0x84d4,0x63f1,0x430d,0x324a,
0x2a2a,0x3aac,0x536f,0x4b4f,0x430e,0x3acd,0x2a4b,0x3acd,
0x6c31,0x7472,0x7cb2,0x7cb2,0x7492,0x7472,0x7492,0x7c92,
0x6c10,0x63cf,0x536e,0x534d,0x63cf,0x7c92,0x8d35,0x9555,
0x9d96,0x9d95,0x9d75,0x9d95,0xadf7,0xb638,0xae17,0x9db6,
0x7471,0x4b2c,0x2a49,0x326a,0x32ab,0x3aab,0x326a,0x2208,
0x19e7,0x3aeb,0x5bd0,0x7473,0x63f1,0x3acc,0x19a6,0x2a27,
0x3aca,0x326a,0x3a8d,0x21cb,0x1169,0x1188,0x3aca,0x434b,
0x4b6d,0x3b0c,0x19e8,0x0965,0x19e8,0x2a8a,0x2a8b,0x226a,
0x11c8,0x11a8,0x2a6b,0x538f,0x6431,0x7cb3,0x8d35,0x9576,
0x9db8,0x9db8,0x9db8,0x9556,0x84d4,0x6c11,0x430d,0x2a2a,
0x2a4b,0x3acc,0x4b4f,0x430e,0x42ed,0x3aac,0x2a4b,0x3acd,
0x7472,0x7c92,0x7cb3,0x84f4,0x8d14,0x8d14,0x84f4,0x84f4,
0x7472,0x7451,0x6c31,0x6c11,0x7c72,0x8cf4,0x9555,0x9d76,
0x9d75,0x9d75,0x9d75,0x9d95,0xa5d7,0xae18,0xa5f7,0x9db6,
0x7492,0x538e,0x42ec,0x32ab,0x328b,0x3acb,0x3acc,0x2a69,
0x32ca,0x32aa,0x6c52,0x6c33,0x6c32,0x5b8f,0x21e7,0x2a07,
0x3a8a,0x324a,0x21ca,0x2a0c,0x1149,0x1188,0x4b4d,0x53ad,
0x5bce,0x4b4d,0x2228,0x1186,0x1a08,0x2a6a,0x224a,0x1a09,
0x19c8,0x19e8,0x32ac,0x5bd0,0x6c52,0x7cb4,0x8d35,0x8d56,
0x9577,0x9577,0x9556,0x8d36,0x84d5,0x6c32,0x4b2e,0x2a4a,
0x2209,0x324b,0x3acd,0x3aac,0x3aac,0x328c,0x220a,0x326c,
0x7cb3,0x7472,0x7472,0x84d3,0x9555,0x9d96,0x9d96,0x9576,
0x8d14,0x8d15,0x9535,0x9555,0x9576,0x9d96,0x9d96,0x9d55,
0x9534,0x9554,0x9d75,0x9d75,0x9d75,0x9d75,0x9555,0x8d34,
0x7cd3,0x6c31,0x5baf,0x4b4d,0x430d,0x4b6e,0x536e,0x430c,
0x538e,0x4b4c,0x7473,0x7474,0x7433,0x534e,0x42cb,0x21c6,
0x42ca,0x63af,0x21ca,0x5b71,0x2a2c,0x3aac,0x4b4d,0x5bce,
0x6410,0x538e,0x326a,0x2208,0x2a6a,0x32cb,0x2a8b,0x2a4a,
0x2229,0x224a,0x430d,0x63f1,0x6c52,0x7cb3,0x84f4,0x84d4,
0x84d4,0x84d4,0x84d4,0x84f5,0x8d15,0x7c93,0x536f,0x328b,
0x1988,0x21e9,0x3a8c,0x3aac,0x42ed,0x42cd,0x2a2b,0x326b,
0x84d3,0x6c30,0x63cf,0x7451,0x8d14,0x9d96,0x9d96,0x9d76,
0x9d96,0xa5d7,0xb618,0xb639,0xae18,0xadd7,0x9d76,0x9535,
0x8d14,0x9555,0x9d96,0x9d76,0x8d14,0x84b2,0x7c72,0x7c92,
0x7cb3,0x7472,0x6c31,0x63f0,0x5bd0,0x6c31,0x6c52,0x5baf,
0x3289,0x7471,0x63f1,0x6bf2,0x7453,0x3a4b,0x4aec,0x2a08,
0xcedb,0xe7df,0x5b70,0x5b50,0x4ace,0x6bd1,0x6bf0,0x5bae,
0x6c30,0x5bcf,0x430c,0x3acb,0x4b4e,0x53af,0x4b8f,0x4b6e,
0x32ac,0x32ac,0x4b4e,0x6411,0x6c52,0x7472,0x7472,0x6c31,
0x6c11,0x7452,0x7c93,0x8cf5,0x8d36,0x84d4,0x5bb0,0x3aac,
0x21c8,0x2a4a,0x4b0e,0x536f,0x5bd0,0x5b90,0x3acd,0x3acd,
0x8cf4,0x6c30,0x5b8e,0x6c10,0x84d3,0x9555,0x9d76,0x9d76,
0xadd7,0xb659,0xc6bb,0xc6bb,0xbe7a,0xae18,0xa576,0x9535,
0x9514,0x9d55,0x9d96,0x9d75,0x84d3,0x7410,0x63f0,0x6c10,
0x7451,0x6c31,0x7452,0x7472,0x7452,0x7cb3,0x7cd4,0x7452,
0x8d34,0x5baf,0x5bb0,0x9557,0xe7bf,0x7c93,0x3208,0xd73c,
0xe7be,0xf7ff,0x94f5,0x6bb1,0xa578,0xd71e,0xdf5e,0x9555,
0x7c92,0x7451,0x5baf,0x538e,0x6411,0x6c52,0x6c32,0x6c32,
0x5bb0,0x538f,0x63f1,0x7473,0x7cb3,0x7cb3,0x7492,0x6bf0,
0x6bf1,0x7452,0x84b4,0x8d36,0x9556,0x84d4,0x5bb0,0x3aac,
0x324b,0x42cd,0x63d1,0x6c12,0x7473,0x6c32,0x4b2e,0x4b2e,
0x9535,0x7c92,0x7410,0x7c72,0x8cf4,0x9535,0x9555,0x9d76,
0xadd7,0xb639,0xc69a,0xc69a,0xbe39,0xadd7,0x9d76,0x9535,
0x9555,0x9d55,0x9d55,0x9535,0x7c92,0x6bf0,0x63af,0x63af,
0x6c11,0x7431,0x7cb3,0x84d4,0x7c93,0x7cb3,0x84f4,0x84d4,
0x84d3,0x6c31,0x84d4,0x530e,0xadf9,0xf7ff,0x8493,0xefbf,
0xefbf,0xffff,0xdf3d,0xd71d,0xf7ff,0xf7ff,0xdf5e,0x7c51,
0x9555,0x9514,0x84b3,0x7c72,0x84d4,0x7cd4,0x7cb4,0x84f4,
0x7cb4,0x7473,0x7cb3,0x8515,0x8d36,0x9556,0x8cf4,0x7452,
0x6c11,0x7c93,0x8d15,0x9d77,0x9557,0x84d4,0x63d0,0x42ed,
0x4aed,0x536f,0x6c32,0x7453,0x7c94,0x7453,0x536f,0x538f,
0x9555,0x84d3,0x8492,0x84d3,0x8d14,0x8cf4,0x8d14,0x9535,
0x9d76,0xadd8,0xb639,0xb618,0xadb7,0xa576,0x9d35,0x9514,
0x9d76,0x9555,0x9514,0x8cf4,0x7c72,0x6bf0,0x5b8f,0x5b8e,
0x7431,0x7c72,0x8cf5,0x8d15,0x7cb3,0x7c93,0x84d4,0x8d15,
0x9576,0x9d97,0x8493,0x63b0,0x8cd5,0xf7df,0xefdf,0xf7bf,
0xffff,0xe75c,0xd6fb,0xffff,0xe75d,0xdf3d,0xe73e,0xadd8,
0xadb7,0xa5b7,0x9556,0x9555,0x9d96,0x9d97,0x9577,0x9dd8,
0x8d56,0x84f4,0x84f5,0x9556,0x9d97,0x9db7,0x9556,0x7c93,
0x7432,0x84d4,0x9d56,0x9d97,0x9d77,0x84d4,0x6bd1,0x4b2e,
0x534f,0x63b0,0x7473,0x7c73,0x7cb4,0x7c73,0x63b0,0x63f1,
0x94f4,0x9535,0x9d55,0x9d75,0xa576,0xa596,0x9d55,0x8cd3,
0x7c72,0x8cf4,0xa576,0xa596,0x9d55,0x9514,0x94f4,0x9514,
0xa576,0xadd7,0xa597,0x9514,0x8492,0x6bf0,0x63af,0x6bf0,
0x7c72,0x8cd4,0x9556,0x9535,0x7c72,0x6bf0,0x84b3,0xa5d7,
0xa5d7,0xa597,0x8cd4,0x73d0,0xbe19,0xffff,0xef7e,0xf7bf,
0xf7be,0xfffe,0xfffe,0xf7bd,0xf7be,0xf7df,0xf7bf,0xe75e,
0xf7ff,0xadd7,0xb618,0xb659,0x9d76,0xadf9,0xb65a,0x9577,
0x8d36,0x8d15,0x8d15,0x9556,0xa5d8,0xa5d8,0x9535,0x7c72,
0x7411,0x8cd4,0x9d97,0xa5b8,0x9d77,0x84d4,0x6c11,0x5b8f,
0x5b6f,0x63f1,0x7c93,0x84f5,0x84d4,0x7473,0x6c32,0x6c32,
0xa596,0x8cd3,0x8492,0x9514,0xa596,0xa576,0x9514,0x8cf3,
0x8cd3,0x8cb3,0x8cb3,0x8492,0x8492,0x8cb3,0x94f4,0x9d35,
0xadd7,0xb639,0xb619,0xa597,0x9515,0x8472,0x7411,0x7c51,
0x94f4,0x8cd4,0x8cf4,0x9515,0x8493,0x7411,0x7c92,0x9d76,
0xa596,0xa576,0x7c31,0xbe19,0xf7ff,0xef7f,0xffff,0xffff,
0xffde,0xf7bc,0xffdc,0xfffc,0xfffd,0xffdd,0xffbe,0xffdf,
0xf7df,0xb5f8,0x9d55,0xadb7,0xb619,0xadf8,0xa5b8,0xb65a,
0x9d77,0x9556,0x8cf5,0x84d4,0x8d15,0x9535,0x8cf4,0x7c72,
0x7c52,0x8cf5,0xa597,0xadd8,0xa5b8,0x9536,0x7c73,0x6bf1,
0x6bd1,0x7432,0x84b4,0x8d36,0x8d36,0x84d5,0x7cb4,0x7cb4,
0x9514,0x9514,0x9d55,0xa576,0xa596,0xa576,0xa576,0xa576,
0xa576,0x9d35,0x94f4,0x94f4,0x9d35,0xad96,0xb5d8,0xb618,
0xbe18,0xc67a,0xbe59,0xb5f8,0xa596,0x9514,0x94d4,0x9514,
0x9514,0xadb7,0xa576,0x7c31,0x6baf,0x8452,0x9d56,0xadb7,
0xadd8,0xa576,0x94d4,0xb5f8,0xe75d,0xffbf,0xffdf,0xef3d,
0xffdd,0xffbb,0xffda,0xffda,0xffda,0xffdc,0xffbe,0xffdf,
0xffff,0x9d35,0x9d15,0xbe59,0xbe39,0xb5f8,0xadd8,0xadd8,
0xa5b8,0x9d76,0x84d4,0x7c73,0x7452,0x7c72,0x7c72,0x7c52,
0x8493,0x9515,0xa597,0xadf8,0xadf9,0xa5b7,0x9515,0x8493,
0x7c73,0x8494,0x8cf5,0x9d57,0x9d77,0x9d57,0x9536,0x9536,
0x8cd3,0x8cb3,0x94d3,0x9d55,0xa576,0x9d55,0x9514,0x9d14,
0xa556,0xa596,0xb5f8,0xce9b,0xe75d,0xf7df,0xffff,0xffff,
0xf7df,0xf7df,0xdf3d,0xc65a,0xb5b7,0x9d35,0x94d4,0x9d14,
0x9d15,0xa576,0x94f4,0x6baf,0x632d,0x7c10,0x94d4,0x9d14,
0xadb7,0xb5d8,0xad96,0x9d14,0xad55,0xe71c,0xffff,0xffde,
0xffbc,0xffdb,0xffd9,0xf7b7,0xf798,0xffda,0xffbd,0xf77d,
0xdedb,0x8431,0x8452,0xa576,0xa576,0xb619,0xbe5a,0xa5b8,
0xa5b8,0x9556,0x84b4,0x7c52,0x7432,0x7c52,0x7c52,0x7431,
0x8cd4,0x9515,0xa597,0xadd8,0xb619,0xb619,0xa5b8,0x9536,
0x9516,0x8d15,0x9536,0x9d77,0xa5b8,0xa5b8,0xa5b8,0xa5b8,
0x9d35,0x94f4,0x9d35,0xadb7,0xa555,0x8cb2,0x9d55,0xce9a,
0xef9e,0xefbf,0xf7df,0xffff,0xffff,0xf7df,0xef9e,0xe75d,
0xf7df,0xf7df,0xe75d,0xce9a,0xc639,0xb5d7,0xad96,0xb5b7,
0xb5d7,0x8451,0x7bf0,0xa555,0xc619,0xb5b7,0xad96,0xbe19,
0xbe19,0xd6dc,0xb5b6,0xc638,0xa4f3,0x8c51,0xff7e,0xffbe,
0xffbb,0xf798,0xf775,0xf795,0xffb6,0xff98,0xff9b,0xff9d,
0xffff,0xffdf,0xdedc,0xad97,0xad97,0xb5f8,0xa577,0xadb8,
0xa5b8,0x9536,0x84b3,0x7c73,0x8493,0x8cd4,0x8cf4,0x8cf4,
0x9d56,0xa597,0xadd8,0xb619,0xb619,0xb619,0xadf9,0xa5b8,
0xa5b8,0xa597,0x9d77,0xa598,0xa5d8,0xadf9,0xadf9,0xae19,
0xa555,0xadb6,0xadb7,0xa575,0xa576,0xbe59,0xe75d,0xffff,
0xefbf,0xefbf,0xf7df,0xf7df,0xf7df,0xf7df,0xffff,0xffff,
0xef9e,0xf7df,0xffdf,0xffdf,0xffff,0xffff,0xffff,0xffff,
0xe73d,0xbdf8,0xbdd7,0xef5d,0xffff,0xf7df,0xf79e,0xffff,
0xffff,0xffff,0xf7be,0xffff,0xef3c,0xd639,0xff9e,0xffde,
0xff9a,0xe6b4,0xde91,0xef52,0xf794,0xef35,0xf739,0xffde,
0xef5d,0xffff,0xffdf,0xbe19,0x9d15,0xa597,0xadb8,0xadb8,
0xadb8,0x9536,0x8cd4,0x8cd4,0x9515,0x9d76,0xa5b7,0xadd8,
0xadf8,0xbe39,0xbe5a,0xb639,0xadf9,0xadd8,0xadd8,0xadd8,
0xb619,0xadd8,0xa5b8,0xa5b8,0xadf9,0xadf9,0xae19,0xb63a,
0xa576,0x9d14,0x8cb3,0x9d14,0xcebb,0xffff,0xffff,0xe73d,
0xffff,0xf7ff,0xf7bf,0xf79f,0xef9e,0xf79f,0xf7bf,0xf7bf,
0xef5d,0xf79e,0xf79e,0xf7bf,0xffdf,0xf7bf,0xef7e,0xef7e,
0xffff,0xffff,0xffff,0xf7be,0xf77e,0xef7d,0xf79e,0xf7bf,
0xef7e,0xdedc,0xf7be,0xf77d,0xf79d,0xffff,0xf75d,0xf75c,
0xff59,0xe6b4,0xce4f,0xd68e,0xe6f1,0xf735,0xff59,0xffbd,
0xffff,0xf79e,0xffdf,0xd69b,0x94d4,0x9d15,0xa597,0x9515,
0xa598,0x9d56,0x9536,0x9d56,0xa576,0xa597,0xadb7,0xb5f8,
0xb5f8,0xbe5a,0xbe5a,0xb5f8,0x9d56,0x9d36,0x9d56,0xa597,
0xadb8,0xa598,0xa597,0xa5b8,0xa5b8,0xa5b8,0xa5b8,0xa5d8,
0x9d35,0x8cb2,0xad76,0xef7e,0xffff,0xe73d,0xe71d,0xffff,
0xf7bf,0xefbf,0xf7be,0xf7df,0xffff,0xffff,0xf7bf,0xf79f,
0xf7bf,0xffdf,0xff9f,0xff7e,0xff9f,0xff7f,0xf75e,0xf77e,
0xf75e,0xf75e,0xf77e,0xff9f,0xff7e,0xf77e,0xf77e,0xf79f,
0xf79f,0xffdf,0xf7be,0xfffe,0xf79d,0xef1c,0xf75d,0xff7c,
0xf75a,0xf758,0xdeb2,0xc5ce,0xd671,0xffd8,0xfffc,0xf77c,
0xffdf,0xe71c,0xb5d7,0x8c93,0x8cb3,0x94f4,0x94d4,0xadd8,
0x9d56,0x9d76,0xa597,0xadd8,0xa5b7,0x9d76,0x9d56,0x9d76,
0xa597,0xb5f8,0xb619,0xa597,0x8cd4,0x84b3,0x8cf5,0x9d56,
0x9536,0x9536,0x9d56,0x9d97,0x9d97,0x9d56,0x9556,0x9556,
0x9d55,0x94b2,0xff7f,0xff7f,0xef3e,0xffbf,0xff3f,0xeedc,
0xe77d,0xf7ff,0xef7d,0xffde,0xf7de,0xf7de,0xe6dc,0xff9f,
0xf7bf,0xff9f,0xff3f,0xfefe,0xfede,0xfebd,0xf6fd,0xf71e,
0xf75f,0xff7f,0xff5f,0xff1e,0xf6fe,0xf73f,0xf77f,0xf79f,
0xffbf,0xffbf,0xf79e,0xf79e,0xf77e,0xf77e,0xff7e,0xff9e,
0xf73c,0xffbd,0xffbc,0xe6f8,0xf7bb,0xfffd,0xe73a,0xffff,
0xf7be,0xdf1c,0xa555,0x8471,0x7410,0x8cb3,0x84b3,0xa5b7,
0xa596,0x9d76,0xa596,0xadd7,0xa5b7,0x9535,0x84b3,0x84b3,
0x9535,0x9d97,0xa5b7,0x9535,0x7c72,0x7c93,0x84d4,0x7c93,
0x84b3,0x84b3,0x8d15,0x9d76,0x9d97,0x9d76,0x9535,0x8d35,
0xa555,0xd6db,0xffdf,0xff7f,0xff7f,0xeefe,0xee3b,0xf6bc,
0xe77d,0xf7ff,0xf79d,0xffbe,0xefbd,0xef9e,0xe6dc,0xff5e,
0xf77f,0xf75e,0xfefe,0xfe7d,0xfe1c,0xf5fb,0xf67c,0xff1e,
0xff3f,0xff5f,0xff3f,0xfede,0xfebe,0xf6ff,0xf75f,0xef7f,
0xffbf,0xffdf,0xffbf,0xffbf,0xff9f,0xff9f,0xff7e,0xff7e,
0xd67a,0xef5d,0xffff,0xf79e,0xef7d,0xef7d,0xfffe,0xe77c,
0xffff,0xf7df,0xf7ff,0xd71c,0x9d34,0x8cd3,0x9d75,0x9514,
0x9d76,0x9d55,0x9d96,0xadd7,0xa5b7,0x8d14,0x7c93,0x7c92,
0x84d4,0x8d15,0x8d35,0x84b3,0x6c31,0x7472,0x84d3,0x7c92,
0x7472,0x7472,0x7cb3,0x84f4,0x8d35,0x8d15,0x8d14,0x8d14,
0xceba,0xffff,0xff5e,0xf6fe,0xf71e,0xeebd,0xee5c,0xf6bc,
0xef7d,0xefde,0xffbe,0xff9e,0xe73c,0xe73d,0xeedc,0xf6fe,
0xff7f,0xf6fe,0xfe9d,0xfe5c,0xfdfb,0xedda,0xee3b,0xf6dd,
0xff3f,0xff3f,0xfeff,0xfe9e,0xf67d,0xf6be,0xef1f,0xef3e,
0xf79f,0xff9e,0xffbf,0xffbf,0xff9f,0xff7f,0xf75e,0xf75e,
0xd65a,0xe71c,0xd679,0xffff,0xffff,0xfffe,0xfffe,0xf7fe,
0xefbe,0xe77e,0xffff,0xf7ff,0xef9e,0x9d55,0x9514,0xa5b7,
0x9d56,0x9535,0x9d76,0x9d97,0x9556,0x8cf4,0x7c93,0x7c93,
0x8cf4,0x8cf4,0x8cf4,0x7c93,0x7431,0x7c93,0x8cf4,0x84b3,
0x7452,0x7431,0x7452,0x84b3,0x8d14,0x8d15,0x8d15,0x9535,
0xf7bf,0xffdf,0xff3e,0xffbf,0xeefe,0xeede,0xf67c,0xe63b,
0xf77e,0xf7be,0xff9e,0xf75d,0xdedc,0xe6fc,0xf6fe,0xf6de,
0xff1e,0xee7c,0xee1b,0xfe3c,0xfe3c,0xf5fb,0xe61b,0xe65c,
0xff5f,0xff1f,0xfebe,0xf65d,0xee3d,0xee7d,0xeede,0xef1e,
0xf75e,0xff7e,0xff9f,0xff9f,0xff9f,0xff9f,0xff5e,0xf75e,
0xeefc,0xf75e,0xb555,0xbdd7,0xffdf,0xffff,0xe75c,0xf7de,
0xef9e,0xffff,0xe75d,0xad96,0xadb7,0xa555,0x9d76,0x9d56,
0x9d36,0x9535,0x9535,0x9536,0x9516,0x8cf5,0x8cf5,0x8d15,
0x9535,0x8d15,0x8d14,0x84b3,0x7c92,0x8cf4,0x9535,0x8cf4,
0x7c72,0x7451,0x7452,0x84b3,0x9535,0x9556,0x9556,0x9d76,
0xffff,0xf75e,0xff1e,0xff3f,0xcdfa,0xcdd9,0xd599,0xee9d,
0xff9f,0xf7bf,0xff9f,0xf6fc,0xe6bb,0xeedd,0xff1f,0xfebe,
0xf67c,0xee1b,0xedda,0xf5db,0xf5db,0xe5ba,0xe5fa,0xe65c,
0xff3f,0xfeff,0xf67d,0xee1c,0xee1c,0xee3d,0xeebe,0xf6ff,
0xff7f,0xff7f,0xff9f,0xff9f,0xff9f,0xff9f,0xff9f,0xff9f,
0xe6dc,0xf75e,0xdebb,0x7bcf,0xdeda,0xffff,0xffff,0xf7be,
0xf7ff,0xffff,0xdf3d,0xc659,0x8cd3,0xa576,0xbe5a,0x9d76,
0x9535,0x9515,0x9536,0x9d57,0x9d77,0x9d77,0x9d77,0x9d77,
0x9556,0x8d15,0x8d15,0x8cf4,0x84d4,0x9535,0x9d76,0x9535,
0x8cf4,0x7c93,0x7451,0x7c72,0x8cf4,0x9555,0x9d76,0x9d97,
0xff9e,0xff9f,0xf6fd,0xe65b,0xde3b,0xd5da,0xcd78,0xff7f,
0xff9f,0xff9f,0xff5e,0xee7b,0xeebc,0xf6bd,0xfede,0xfe7d,
0xedda,0xf5da,0xf5db,0xf5ba,0xe579,0xe599,0xee5c,0xff1f,
0xf6ff,0xf69d,0xee3d,0xee1c,0xedfc,0xf63d,0xf69e,0xfeff,
0xff3f,0xf75e,0xff5e,0xff5f,0xff5f,0xff5f,0xff7f,0xff7f,
0xeedd,0xf73d,0xff7e,0xc5d7,0x9cb2,0xd699,0xdefa,0xdefb,
0xf7ff,0xdf3c,0xadb6,0xceba,0xb5f8,0xa576,0xa596,0xadb7,
0x9515,0x9536,0x9d57,0xa5b8,0xae1a,0xb61a,0xadd9,0xa5b8,
0x9d97,0x9d76,0x9d97,0x9d97,0x9d97,0xadf8,0xae19,0xa5d8,
0xa5b7,0x8d14,0x7c72,0x7452,0x84d3,0x9555,0xa5b7,0xadf8,
0xeefc,0xff9f,0xff7f,0xff1e,0xf6fe,0xde1b,0xf67d,0xff3f,
0xff5e,0xff7f,0xfefd,0xe5f9,0xfebd,0xfebd,0xfe7d,0xf5db,
0xed79,0xf59a,0xf5ba,0xed79,0xe579,0xedfb,0xfebe,0xff3f,
0xee5c,0xe61c,0xedfc,0xf61c,0xf63d,0xfe5e,0xfe9e,0xfedf,
0xf6fe,0xf71e,0xf71e,0xf71e,0xf71e,0xf71e,0xf71e,0xf71e,
0xff7f,0xf73e,0xef1d,0xffdf,0x9471,0x8c71,0x8c50,0x9d13,
0xd6da,0xdf5c,0x8cd2,0x73ef,0x8cb2,0x9514,0x9d55,0x9514,
0x9d76,0x9d56,0x9d76,0xa5b8,0xb61a,0xb65b,0xae1a,0xa5b8,
0xa5b8,0xa5b7,0xadf8,0xb639,0xb639,0xb65a,0xbe5a,0xae19,
0xa5b7,0x9515,0x7c93,0x84b3,0x9535,0xa5b7,0xadf8,0xae19,
0xf6fc,0xff5e,0xff1e,0xddfa,0x9c13,0x93b1,0xff3f,0xff1f,
0xff1e,0xff5e,0xfebc,0xe598,0xfebd,0xfe9d,0xfdfb,0xed59,
0xed18,0xf518,0xed18,0xe538,0xedba,0xfe9d,0xfede,0xfe9d,
0xe5da,0xe5ba,0xedbb,0xf61d,0xfe5e,0xfe5e,0xfe7e,0xfebf,
0xfefe,0xf71e,0xf71e,0xf71e,0xf6fe,0xf6fe,0xf6de,0xeedd,
0xf71e,0xeefd,0xf75e,0xf73d,0xef5d,0x9cf3,0xb595,0xad74,
0x9d33,0xa594,0xa553,0x9d33,0x9d54,0x9d13,0xceda,0xadd7,
0xadd7,0xa576,0x9535,0x9d56,0xadd8,0xb63a,0xae19,0xa5b8,
0x9d77,0x9d96,0xadf8,0xb619,0xae18,0xae18,0xadf8,0x9d97,
0x9535,0x84d3,0x7c93,0x8cf4,0xa597,0xadf8,0xae18,0xadf8,
0xff3e,0xe67b,0xffbf,0xd5fa,0x38e6,0x2844,0xfedd,0xfefe,
0xfebc,0xff1d,0xbc32,0xed77,0xfe9c,0xfd98,0xdc95,0xdc34,
0xdc14,0xf4b7,0xdc96,0xed59,0xfe3c,0xfe7d,0xfebe,0xf63c,
0xeddb,0xfe1c,0xfe3d,0xfe1c,0xf5fc,0xfe3d,0xfe7f,0xfedf,
0xfeff,0xf6fe,0xf6de,0xf6fe,0xf6fe,0xf6fe,0xf6de,0xeebd,
0xe67c,0xf71e,0xf73e,0xff7e,0xffbf,0xe71b,0xbdd6,0xb595,
0xc657,0xad94,0xbe36,0xbe36,0xb616,0xced9,0xceb9,0xe77d,
0xc6ba,0xadf7,0x9d55,0x9d55,0xa597,0xa5b7,0xa5b7,0xa5d8,
0x9d96,0xadf8,0xae19,0xa5d8,0xa5b7,0xa5d8,0xa5d8,0xa5b7,
0x9535,0x8493,0x7c52,0x8cf4,0xa597,0xadf8,0xadf8,0xadf8,
0xd5d8,0xff9f,0xff5f,0xbd16,0x2023,0x2823,0x8b6f,0xff7f,
0xfebc,0xc432,0xd472,0xfe9b,0xfd97,0xdc12,0xd3d1,0xdbf3,
0xf475,0xec76,0xecd7,0xf599,0xf5fb,0xfe5c,0xfe7d,0xed9a,
0xf59a,0xfddb,0xfdfc,0xfdfc,0xf5dc,0xf5fc,0xfe1d,0xfe7e,
0xf69e,0xfeff,0xff1f,0xfedf,0xf6de,0xfede,0xfeff,0xf6de,
0xf6fe,0xf73e,0xf71d,0xef3d,0xffbf,0xffdf,0xdeda,0xbdd6,
0xc657,0xb5f5,0xc677,0xc677,0xc698,0xdf3a,0xd71a,0xe77c,
0xdf3b,0xbe58,0x9d75,0x9534,0x9534,0x9535,0x9555,0x9d96,
0x9d76,0xa5b7,0xa5d8,0x9d97,0x9d76,0x9d97,0xa5b7,0x9d97,
0x9556,0x84d4,0x8493,0x8d15,0x9d96,0x9d97,0x9d76,0x9d76,
0xddd8,0xff9f,0xff5e,0xde3a,0x2823,0x3064,0xa432,0xff7e,
0xe514,0xab0c,0xfd95,0xfdf7,0xdbcf,0xd36e,0xdb8f,0xdb90,
0xf434,0xe3d3,0xf4d7,0xfdb9,0xfdfa,0xfe7c,0xfe1b,0xed38,
0xf539,0xf539,0xf57a,0xf5bb,0xf5bb,0xedbb,0xf5dc,0xfe3d,
0xf67d,0xfeff,0xff1f,0xfedf,0xf69e,0xf6be,0xfedf,0xf6de,
0xff3f,0xff3f,0xf71e,0xef1d,0xf77e,0xffff,0xf7be,0xd699,
0xbe16,0xbe36,0xc677,0xc698,0xdf3a,0xe79c,0xe79c,0xe79c,
0xd6fa,0xbe58,0xadd6,0x9d75,0x9d55,0x9555,0x9d76,0xa5d7,
0xadf8,0xb619,0xadf8,0x9d97,0x9d56,0x9d76,0xa597,0xa597,
0x9d76,0x9515,0x8cf4,0x9515,0x9535,0x8cf4,0x84b3,0x84b3,
0xd557,0xe619,0xff9f,0xff7f,0x4106,0x1800,0xfedb,0xf639,
0xb32c,0xd3ef,0xfdf6,0xe40e,0xd30b,0xeb8d,0xe38e,0xe38f,
0xe391,0xdb92,0xf4f6,0xf599,0xfe5b,0xfe7c,0xed58,0xf518,
0xfd19,0xf4d8,0xecf8,0xed5a,0xe55a,0xdd39,0xed7a,0xf61d,
0xfebf,0xfedf,0xfeff,0xfeff,0xfebf,0xf69e,0xf6be,0xfedf,
0xfeff,0xf71e,0xff5f,0xf75e,0xef1d,0xf79e,0xffff,0xef7d,
0xbdf6,0xbe16,0xc657,0xc657,0xd71a,0xdf1b,0xdf5c,0xd6fa,
0xb637,0xb617,0xb617,0xb618,0xadf7,0xa5b6,0xa5b6,0xa5d7,
0xadf8,0xadf8,0xa597,0x9535,0x8d15,0x9535,0x9d76,0xa597,
0xa597,0x9d56,0x9515,0x9515,0x8cd4,0x7c72,0x7431,0x7411,
0xb453,0xc515,0xff9f,0xff5e,0x8b2e,0x3863,0xff5d,0xedd6,
0xaaca,0xf470,0xfd32,0xdb6b,0xeb4b,0xeb0b,0xeb4b,0xf38e,
0xe32f,0xec13,0xfd37,0xf5b8,0xfebc,0xfe3a,0xdc54,0xf4d7,
0xfcf8,0xf497,0xec97,0xe4f8,0xdd18,0xd4f8,0xe559,0xf5fc,
0xff1f,0xfebf,0xf67e,0xfedf,0xfeff,0xf69e,0xf69e,0xfeff,
0xfeff,0xf6de,0xff5f,0xff7f,0xef1d,0xef3d,0xffdf,0xffdf,
0xce79,0xad95,0xbe17,0xb5d6,0xbe37,0xb5f7,0xbe58,0xadd6,
0xadd6,0xb5f7,0xb638,0xbe59,0xb639,0xadd7,0x9d76,0x9555,
0x9535,0x8cf4,0x8493,0x7c52,0x7c52,0x84b3,0x9535,0x9d76,
0xa5b7,0x9d76,0x9535,0x8d15,0x84d4,0x7c72,0x7c52,0x7c52,
0xc4d5,0x8b4e,0xd5f9,0xff5e,0xd556,0xb431,0xff5c,0xf616,
0xbb0b,0xfc6f,0xfc8f,0xebab,0xf309,0xeac9,0xfb6b,0xdaca,
0xdaee,0xf434,0xfd37,0xfdf9,0xfe9b,0xed78,0xd413,0xf496,
0xf415,0xec15,0xe436,0xe4b7,0xe538,0xe579,0xf5db,0xfe5e,
0xfedf,0xee3d,0xe5dc,0xee3d,0xf69f,0xf67e,0xf69e,0xfeff,
0xff3f,0xf6de,0xf6fe,0xff7f,0xff7e,0xf77e,0xff9e,0xffbf,
0xdf1c,0x8c71,0xa555,0x9d34,0xa555,0xa576,0xb5f7,0xadb7,
0xadd7,0xadd7,0xb5f8,0xb619,0xb619,0xadd8,0x9d76,0x9535,
0x8cd4,0x8493,0x7411,0x6bd0,0x6bd0,0x7452,0x8cd4,0x9535,
0x9d97,0x9d76,0x9535,0x9515,0x8cf4,0x8cf4,0x8cf4,0x8cf4,
0xd537,0x5147,0x72ed,0xff7e,0xee3a,0xf65a,0xff5c,0xf616,
0xc30a,0xfc6f,0xfc4d,0xeb89,0xeaa7,0xfb08,0xfb29,0xd267,
0xe32e,0xf413,0xfd36,0xfe3a,0xedb8,0xd473,0xdc13,0xec14,
0xebb4,0xf3f5,0xf477,0xf519,0xf5bb,0xfe3c,0xfe7d,0xfe9f,
0xfe9f,0xee3e,0xddbc,0xddbb,0xe61d,0xf67e,0xfebf,0xfebf,
0xff3f,0xff1f,0xf6fe,0xf71e,0xff9f,0xffbf,0xf77e,0xf79e,
0xe73d,0x52ab,0x7c10,0x8431,0x94b3,0xa556,0xb5f8,0xbe19,
0xadd8,0xadb7,0xa597,0xadb7,0xadd8,0xadb8,0x9d76,0x9515,
0x8493,0x7431,0x63af,0x5b6e,0x638f,0x7411,0x84b3,0x9515,
0x9d76,0x9d56,0x9535,0x9535,0x9535,0x9535,0x9556,0x9535,
0xccd5,0x5967,0x4987,0xff7e,0xfefc,0xe5d7,0xfeb9,0xfeb8,
0xcb4a,0xfc8e,0xf3ea,0xe348,0xf2e7,0xfae8,0xe245,0xf32b,
0xf3b0,0xec13,0xfd57,0xfe5b,0xd494,0xb34f,0xdbf3,0xd351,
0xf435,0xfcb7,0xfd5a,0xfddb,0xfe5d,0xfe9d,0xfe7d,0xfe5d,
0xfebf,0xfebf,0xee3d,0xdd9b,0xe5dc,0xfebf,0xff1f,0xfedf,
0xf6de,0xff5f,0xff3f,0xeefd,0xff7f,0xff9f,0xf77e,0xf7bf,
0xe75e,0x2967,0x5b0d,0x634e,0x7411,0x9d15,0xadb7,0xb5f9,
0xadd8,0xa597,0x9d56,0x9d56,0xa577,0x9d76,0x8cf4,0x7c73,
0x63d0,0x536f,0x4aed,0x42ed,0x532e,0x6bf0,0x84b4,0x9535,
0x9d77,0x9d76,0x9556,0x9535,0x9555,0x9d56,0x9556,0x9535,
0xc472,0x4082,0x5187,0xff5e,0xfedc,0xee18,0xee16,0xfef8,
0xc389,0xfcce,0xeba8,0xdac5,0xfb89,0xda45,0xda26,0xe2eb,
0xe38f,0xec53,0xfd57,0xfe1a,0xaa8c,0xaa8c,0xc371,0xe475,
0xf558,0xfddb,0xfe3c,0xfe7d,0xfede,0xfebe,0xf63d,0xedfc,
0xeddb,0xfebf,0xfe9e,0xedfc,0xf65d,0xfedf,0xfede,0xfede,
0xff3f,0xff1e,0xf6fe,0xf71e,0xef1e,0xe6fd,0xef3e,0xf79f,
0xe77f,0x10e5,0x1946,0x4b0d,0x6bf1,0x6c31,0x9d97,0xb639,
0xadd8,0x9d36,0x9d56,0xa576,0x9d36,0x9535,0x7cb3,0x5b8f,
0x430e,0x328c,0x222b,0x2a4b,0x42ee,0x5bd1,0x7c73,0x8cf5,
0x9d77,0x9556,0x9556,0x8d15,0x9556,0x9556,0x7cb3,0x84f4,
0xf618,0xa38e,0x82ab,0xfedc,0xfefc,0xe5f7,0xfe78,0xfe77,
0xc389,0xec6b,0xfd0e,0xca63,0xc204,0xdaa8,0xeb0a,0xeb4d,
0xfc93,0xfcf5,0xfd98,0xe412,0xb2cd,0xdc13,0xecf6,0xf557,
0xfdfa,0xfe5c,0xfe5c,0xf63c,0xf65c,0xf65c,0xeddb,0xe5ba,
0xdd9a,0xfe7d,0xfe9e,0xfe7e,0xfebe,0xfede,0xfede,0xff3f,
0xff1f,0xff3f,0xff7f,0xff7f,0xf73e,0xeefd,0xe6fd,0xe73e,
0xffff,0x29a8,0x1967,0x2a09,0x5baf,0x7cb3,0x9556,0x9536,
0x9d77,0xa597,0xa597,0x9d56,0x8cd4,0x7c92,0x5b8e,0x2a6a,
0x11e9,0x09c9,0x11a9,0x19ea,0x2a4b,0x42ed,0x5bb1,0x7453,
0x84b4,0x84d4,0x8cf5,0x84d4,0x8514,0x84f4,0x6c51,0x7472,
0xfe39,0xf65a,0xc4b4,0xfedc,0xfedc,0xcd56,0xfefb,0xfe36,
0x9265,0xb2e6,0xfdb1,0xebeb,0xebcc,0xeb8c,0xe34c,0xdb2d,
0xd3d0,0xec94,0xfdb9,0xc350,0xd3f2,0xf517,0xf558,0xf599,
0xfe1b,0xfe3b,0xf63b,0xf63c,0xf63c,0xf63c,0xf5fb,0xedbb,
0xe59a,0xee1c,0xf65c,0xfebe,0xfeff,0xf6be,0xee7d,0xf6be,
0xf6bd,0xff1f,0xff7f,0xff7f,0xf73f,0xeefe,0xeefe,0xef3f,
0xe75f,0x1927,0x21a8,0x2a09,0x4b0d,0x63d0,0x7c93,0x9556,
0x9515,0xadb8,0xa598,0x8cf4,0x7c52,0x5baf,0x328a,0x1187,
0x0147,0x0188,0x11a9,0x19c9,0x19ea,0x2a2b,0x42ee,0x5bb0,
0x7453,0x7c93,0x8cf5,0x84d4,0x7cd3,0x7472,0x5baf,0x63f0,
0xdd56,0xfe9b,0xee3a,0xff1e,0xfedd,0xcd77,0xfefc,0xdd54,
0x71a4,0x79a3,0xe48e,0xdc0c,0xfcf1,0xdbce,0xdbcf,0xdbf1,
0xe474,0xed37,0xfd98,0xcbf2,0xfd99,0xfd99,0xf578,0xfe3b,
0xfe1b,0xf61b,0xf63b,0xf63b,0xedfb,0xedda,0xed9a,0xe559,
0xedfb,0xe5db,0xe5da,0xee5c,0xfeff,0xff1f,0xf6de,0xee7d,
0xeebd,0xeebd,0xf6fe,0xff3f,0xff1e,0xeedd,0xf6fe,0xff7f,
0xd69d,0x0884,0x31e9,0x428c,0x532e,0x6bf1,0x7453,0x7c73,
0x8cf5,0xadb8,0xa598,0x8cd4,0x7432,0x4b0d,0x19e8,0x0967,
0x11a9,0x11ea,0x1a0b,0x1a0a,0x19c9,0x19ca,0x328c,0x534f,
0x6c12,0x7c73,0x8d15,0x84d4,0x7cb3,0x6c52,0x538f,0x5bcf,
0xed98,0xe598,0xf65b,0xfefe,0xfefe,0xee3b,0xfefd,0xbcb2,
0x6985,0x3820,0xc3ed,0xb34b,0xcbef,0xecf4,0xfdf9,0xfe3b,
0xfebd,0xfe9d,0xcc74,0xc413,0xfdda,0xfdb9,0xfdda,0xfe5c,
0xfe7c,0xf61b,0xf63b,0xf61b,0xe599,0xe559,0xed59,0xdd18,
0xe59a,0xdd79,0xdd79,0xddba,0xee5c,0xff1f,0xff1f,0xe67c,
0xeebd,0xde5b,0xe67c,0xff3f,0xff3f,0xee9d,0xeebd,0xff5f,
0xd67c,0x18c6,0x3a2a,0x322a,0x29e9,0x534e,0x7c94,0x7c73,
0x8cd5,0x9d57,0x9d57,0x8cf5,0x7432,0x3aab,0x0967,0x0987,
0x11e9,0x19ea,0x19ea,0x19c9,0x1189,0x19a9,0x2a4b,0x42ed,
0x63d1,0x7473,0x8d15,0x7cd4,0x7c93,0x6c52,0x5baf,0x5bd0,
0xed98,0xd4d5,0xf63b,0xfe9d,0xfe7d,0xfe9d,0xff1e,0xe5b8,
0x82aa,0x3000,0xfe58,0xff3c,0xfe18,0xfe7b,0xfe1a,0xedb9,
0xfe5c,0xff3f,0xd4f6,0xe558,0xfe1b,0xfe1b,0xfe3c,0xf63b,
0xfe7c,0xedfa,0xf63b,0xfe3c,0xedba,0xfdda,0xfe3c,0xfe1c,
0xfdfb,0xf61c,0xfe3c,0xee1b,0xe5fb,0xee7c,0xf6bd,0xe63b,
0xde3b,0xd5fa,0xde5c,0xff3f,0xff7f,0xf6de,0xf6de,0xff7f,
0xa4b5,0x0002,0x2127,0x4a8c,0x532e,0x530e,0x6390,0x532e,
0x7412,0x7412,0x7432,0x7453,0x5b90,0x222a,0x0967,0x11a8,
0x11c9,0x11c9,0x11c9,0x11c9,0x11a9,0x11a9,0x220a,0x328c,
0x63f1,0x7c94,0x8d36,0x84f4,0x7c93,0x6c52,0x538f,0x5baf,
0xdcd6,0xd4b5,0xedb9,0xf61b,0xf63c,0xfe5c,0xfefe,0xfefd,
0xff9e,0xbc92,0xfebb,0xff3d,0xedf9,0xd537,0xe5da,0xfe7d,
0xe5fb,0xfeff,0xfe7d,0xfeff,0xfede,0xfe9e,0xfebd,0xfe9d,
0xf63b,0xe5b9,0xf61b,0xfe7c,0xf5ba,0xfdba,0xfe1c,0xfddb,
0xfdbb,0xfddb,0xfe7e,0xfebe,0xfe7d,0xfe9d,0xfefe,0xf6bd,
0xde3b,0xe65b,0xeebd,0xff3f,0xff5f,0xff3f,0xff3f,0xff9f,
0xeefe,0x62ce,0x2127,0x1906,0x530e,0x5b6f,0x7432,0x7453,
0x6bf1,0x5b70,0x5b4f,0x4b2e,0x326b,0x11a8,0x09a8,0x11c9,
0x1a0a,0x220b,0x222b,0x224b,0x220a,0x19c9,0x21e9,0x222a,
0x536f,0x6c32,0x84f5,0x7cb4,0x7493,0x7473,0x5bb0,0x5baf,
0xdc94,0xdcd6,0xdcb6,0xed78,0xfe7d,0xfe7d,0xfe5c,0xfe7b,
0xedf9,0xfefc,0xd536,0xf63a,0xff3f,0xd578,0xee5c,0xddba,
0xff5f,0xee9d,0xee5c,0xf69d,0xf67d,0xf67d,0xfe9d,0xfebe,
0xf65c,0xe5b9,0xf63b,0xfe3b,0xe517,0xdc75,0xdc34,0xcb72,
0xcb93,0xc372,0xe496,0xfe1c,0xfe9e,0xfede,0xff3f,0xff1f,
0xfedd,0xff5f,0xff7f,0xf71e,0xeedd,0xf71e,0xff5f,0xff5f,
0xf71f,0xffdf,0xdebd,0x5aed,0x5b2f,0x6390,0x8494,0x8cd5,
0x8cf6,0x7412,0x5b4f,0x3a8c,0x1188,0x0967,0x11e9,0x11e9,
0x2a6c,0x328d,0x32cd,0x32cd,0x2a6c,0x19ea,0x11a8,0x11a8,
0x220a,0x430e,0x6432,0x6c52,0x7493,0x7cb4,0x6411,0x6411,
0xecf6,0xcbf2,0xdc95,0xf579,0xfdba,0xfe1c,0xfe1b,0xfdfa,
0xfdfa,0xedb9,0xdd77,0xdd98,0xee1b,0xfe7d,0xf63d,0xdddb,
0xf6de,0xf6de,0xe63c,0xf69e,0xf67d,0xfebe,0xee3b,0xf67c,
0xfe9d,0xfebd,0xf61b,0xed79,0xf538,0xe495,0xdbd3,0xe3f4,
0xec15,0xe3d4,0xe3f4,0xec96,0xfd59,0xf559,0xed99,0xfe5c,
0xfebd,0xee7c,0xe63b,0xe67c,0xeefe,0xf75f,0xf71e,0xe6dd,
0xf73f,0xef1f,0xb578,0x73d1,0x4a8c,0x6bb0,0x8cf5,0xa598,
0x9537,0x8cd5,0x6bd2,0x3a6c,0x1168,0x0147,0x09c9,0x1a2a,
0x32ad,0x3aee,0x4b4f,0x432f,0x32ac,0x220a,0x19c9,0x19c9,
0x220a,0x328c,0x53b0,0x7494,0x7cd5,0x7493,0x6c52,0x6c52,
0xfe1a,0xd433,0xd413,0xecd6,0xfd38,0xfd79,0xfd79,0xfdba,
0xed38,0xed98,0xe558,0xd4f6,0xdd38,0xf5fb,0xfe3d,0xe5db,
0xee9e,0xeebe,0xee9e,0xf69e,0xee5d,0xfe9d,0xf67d,0xfe7d,
0xf63b,0xfe7c,0xf5fa,0xe517,0xecf7,0xf496,0xec14,0xf414,
0xfc15,0xfbf5,0xebd4,0xebf4,0xe414,0xd3b3,0xcbf3,0xdcf7,
0xfe3b,0xf63b,0xe63b,0xe67b,0xeedd,0xef1d,0xef1d,0xeefd,
0xeedd,0xce1a,0xc5fa,0x2106,0x31e9,0x8494,0x8cb4,0xadf9,
0xa598,0x8cf6,0x6391,0x29ea,0x0947,0x0988,0x11ea,0x1a0a,
0x2a6c,0x3aee,0x4b70,0x4b4f,0x32ad,0x19ea,0x1188,0x0968,
0x11c9,0x222a,0x432e,0x6432,0x74b4,0x7494,0x7494,0x7cd4,
0xfe3a,0xecf6,0xe494,0xd3f2,0xdbf3,0xfd18,0xfd59,0xf4d7,
0xecf7,0xed38,0xe538,0xd4b6,0xd4b6,0xed59,0xfdfc,0xfe3d,
0xf67d,0xee9e,0xf6df,0xf69e,0xf65d,0xf65c,0xfe9e,0xfe7c,
0xfe5c,0xfe9d,0xfdda,0xecf7,0xecb6,0xfcb6,0xf435,0xf3d4,
0xf393,0xfbb4,0xf393,0xeb72,0xdb51,0xcaf0,0xcb71,0xe475,
0xf599,0xf5fa,0xfe7c,0xfedd,0xff1e,0xf73e,0xf73e,0xf73e,
0xd61a,0xffdf,0xffdf,0xce5a,0x52ac,0x6bb0,0x8cb4,0x9d36,
0x9d57,0x7c74,0x4ace,0x1988,0x0927,0x11a9,0x120a,0x11c9,
0x2a6c,0x3aee,0x4b70,0x4b2f,0x32ac,0x1a0a,0x11a9,0x11a8,
0x0988,0x11c9,0x328c,0x5390,0x6c53,0x7494,0x7cb4,0x84f5,
0xfdd9,0xf537,0xf4f6,0xd3d2,0xcb50,0xf475,0xfcd7,0xf476,
0xfd18,0xecb7,0xe4d7,0xed18,0xe4d8,0xdc97,0xf519,0xfe3d,
0xfe9e,0xe63c,0xf69e,0xf67d,0xfe9e,0xee1c,0xfe7d,0xf63c,
0xfe9d,0xfe3b,0xf599,0xecf6,0xf4b6,0xfc96,0xfc14,0xf3b3,
0xeb11,0xf332,0xf332,0xeb31,0xeb31,0xe351,0xebd3,0xfcd7,
0xf4d6,0xf578,0xfe3b,0xfedd,0xff3e,0xff3e,0xff5e,0xff5e,
0xf73e,0xffbf,0xf77f,0xffff,0xbe3a,0x5b0d,0x9516,0x8494,
0x7c32,0x5b2f,0x320a,0x1988,0x1989,0x19c9,0x120a,0x11ea,
0x220a,0x2a2b,0x2a4b,0x220a,0x11c9,0x1188,0x0988,0x0988,
0x11a8,0x11c9,0x222a,0x430e,0x5bd1,0x6432,0x6c53,0x7473,
0xfe5c,0xdc95,0xdc34,0xe434,0xdb92,0xdb72,0xebf4,0xfcb7,
0xfcd8,0xec97,0xec97,0xf4f9,0xecb8,0xdc15,0xe435,0xf519,
0xfebf,0xddfb,0xee1c,0xf63d,0xfebe,0xedfb,0xf61b,0xf61b,
0xfe7c,0xed78,0xe4d6,0xecd6,0xfcb6,0xfc35,0xf3b3,0xf372,
0xeb31,0xf331,0xeaf0,0xeaf0,0xf352,0xfb92,0xfbd3,0xfc55,
0xec14,0xf496,0xfd58,0xfdfa,0xfe9c,0xfedd,0xff1e,0xff3e,
0xffdf,0xf73d,0xef1d,0xe73d,0xffff,0xadb7,0x5b2e,0x7c32,
0x532e,0x3a2b,0x21a9,0x21c9,0x21ea,0x19ca,0x1a0b,0x2a8c,
0x222b,0x220b,0x19ea,0x11a9,0x11a9,0x19c9,0x11c9,0x09a8,
0x11c9,0x11c9,0x19e9,0x2a8c,0x432f,0x5390,0x5bb1,0x5bb1,
0xfede,0xd495,0xcbd2,0xd3b2,0xd371,0xe392,0xebd4,0xfc56,
0xf477,0xfcb8,0xfcf9,0xf4b8,0xec77,0xec36,0xebf5,0xd3f4,
0xfebf,0xee1c,0xdd7a,0xe5ba,0xfe7e,0xf61c,0xedda,0xfe1b,
0xfe7d,0xe537,0xdc95,0xf4d6,0xfc95,0xf3d3,0xeb72,0xeb31,
0xf371,0xf371,0xeb10,0xeaf0,0xfb72,0xfb93,0xfb72,0xf372,
0xeb92,0xebf3,0xec54,0xecf6,0xf599,0xfe5b,0xfedd,0xff1d,
0xff3d,0xffbf,0xffff,0xffff,0xefbf,0xefff,0x6bd0,0x530d,
0x426b,0x29c9,0x2188,0x21c9,0x21ea,0x19ca,0x2a6c,0x432f,
0x430e,0x42ee,0x3aad,0x328c,0x32cd,0x3aee,0x2aac,0x1a2a,
0x11e9,0x11c9,0x11c9,0x222a,0x32ad,0x432e,0x4b4f,0x4b4f,
0xfe7d,0xd4d6,0xcbf3,0xc371,0xcb31,0xebf4,0xf415,0xf415,
0xfc78,0xfcf9,0xfd1a,0xfcb9,0xf477,0xf436,0xebd5,0xd393,
0xfe7e,0xfe7e,0xd539,0xd4f8,0xf5fc,0xfe5d,0xf5da,0xfe7d,
0xfdda,0xdcb5,0xdc54,0xec75,0xebd3,0xe372,0xf352,0xf351,
0xf392,0xfbd2,0xf371,0xf351,0xfb92,0xfb93,0xfb31,0xf310,
0xe2f0,0xe351,0xebd3,0xec75,0xed17,0xf5b9,0xfe3b,0xfebc,
0xff3d,0xeefc,0xff9e,0xef5d,0xefbf,0xefdf,0xe79f,0x426a,
0x3a2a,0x320a,0x320a,0x320b,0x2a0b,0x2a6c,0x3b0f,0x53b1,
0x5bb1,0x5bb1,0x5390,0x4b70,0x5390,0x53b1,0x434f,0x32ad,
0x1a2a,0x1a0a,0x11e9,0x1a0a,0x328c,0x430e,0x4b4f,0x4b4f,
0xfe1c,0xcc55,0xcbf3,0xd3f4,0xd393,0xdb93,0xebd5,0xfc98,
0xfcb9,0xfcb9,0xfcd9,0xfcfa,0xfc78,0xf3d5,0xeb73,0xe3b4,
0xfe1d,0xfedf,0xd4f8,0xc476,0xe579,0xfe9d,0xfdfb,0xfe9d,
0xdc54,0xd392,0xd392,0xe392,0xd310,0xe330,0xfbb2,0xfbb2,
0xfbb2,0xfc33,0xfc13,0xfbb2,0xfb92,0xfb71,0xfaef,0xf2af,
0xda0c,0xe2af,0xf392,0xf454,0xf4d6,0xf537,0xed98,0xedf9,
0xeedc,0xf77d,0xe6fc,0xffff,0xefbe,0xf7ff,0xe77e,0x532d,
0x3209,0x42ac,0x4acd,0x42ac,0x3aad,0x4b4f,0x5bf1,0x6412,
0x7494,0x7c94,0x7473,0x6c32,0x6c32,0x6c73,0x6432,0x53b0,
0x2a8b,0x224b,0x1a0a,0x222a,0x328c,0x430e,0x4b6f,0x5390,
0xf579,0xdc96,0xd3f4,0xdc15,0xec56,0xec36,0xec36,0xf457,
0xf457,0xfc78,0xfc98,0xfc37,0xf3b5,0xfbb5,0xf333,0xca90,
0xecf9,0xfedf,0xe4f9,0xcc35,0xd4b6,0xfe7c,0xfefd,0xfdb9,
0xba6d,0xd28e,0xa8e7,0xb9aa,0xeb91,0xf3d2,0xfbf4,0xfb71,
0xfbd3,0xfb91,0xfb70,0xfb91,0xfb91,0xfb2f,0xf28d,0xea0b,
0xea0b,0xf28d,0xf330,0xfbf3,0xf474,0xe4b5,0xed78,0xfe9c,
0xe69b,0xf77e,0xe71c,0xffff,0xefbf,0xf7ff,0xefbf,0x426a,
0x3a6a,0x532d,0x532e,0x530e,0x6390,0x6c11,0x6c32,0x7cb4,
0x7c93,0x84d4,0x84d4,0x7cb3,0x7cb3,0x7cb3,0x7472,0x6410,
0x4b4e,0x2a6a,0x2a6b,0x32ab,0x222a,0x32ac,0x53af,0x53af,
0xe4d7,0xd455,0xd414,0xdc35,0xe436,0xe416,0xe416,0xec57,
0xe3f6,0xec16,0xfc57,0xf3f5,0xf394,0xf374,0xeaf2,0xc24f,
0xe477,0xfdfd,0xe4d8,0xb351,0xd496,0xe537,0xfe1a,0xfe3b,
0xd2ce,0x9866,0xc98a,0xeacf,0xf3b2,0xfc13,0xfbd2,0xf371,
0xfbf2,0xfbf2,0xfbd1,0xfb90,0xf2ed,0xea6b,0xea2a,0xea4a,
0xea2a,0xea6c,0xe2ad,0xe32f,0xec13,0xecd6,0xf5b9,0xfedd,
0xf71d,0xf79e,0xef5d,0xffff,0xf79f,0xf7df,0xffff,0x94f4,
0x31e9,0x4aec,0x636f,0x63d0,0x6bf1,0x6c11,0x7432,0x7c93,
0x84d4,0x9514,0x9535,0x8cf4,0x84f4,0x8cf4,0x84d3,0x7472,
0x6410,0x4b4d,0x4b6e,0x538e,0x430c,0x4b4d,0x5bf0,0x53cf,
0xcc95,0xcc75,0xd455,0xdc76,0xe456,0xe415,0xec16,0xf457,
0xebf6,0xf416,0xfc57,0xf416,0xebb4,0xf394,0xeb12,0xc26f,
0xcbb4,0xff1f,0xecd8,0xaad0,0xbbd3,0xfe9d,0xed57,0xfe5b,
0xe3b2,0x8045,0xfbb2,0xfcd6,0xeb90,0xeb91,0xf3b1,0xfc53,
0xf3d0,0xebcf,0xeb8e,0xe32c,0xd269,0xca07,0xd208,0xe26a,
0xe24a,0xe28c,0xd2ad,0xd30f,0xe454,0xf578,0xfe5c,0xfefe,
0xff7f,0xf79e,0xf79f,0xffff,0xf7bf,0xef9e,0xffff,0xdf5d,
0x7c31,0x6bd0,0x6bb0,0x6c11,0x7452,0x7c93,0x84d4,0x84b3,
0x8cf4,0x9d55,0xa5b7,0x9d96,0x9d96,0x9d76,0x9555,0x84f4,
0x84d3,0x6c51,0x7492,0x7cb3,0x6c31,0x6c51,0x7492,0x6c51,
0xc4b5,0xccb5,0xd4b6,0xdcb7,0xe476,0xe436,0xec36,0xf457,
0xf457,0xf436,0xf457,0xec16,0xe3b4,0xebb4,0xe373,0xcad1,
0xc332,0xfd9b,0xfddc,0xd435,0x81cb,0xf538,0xf538,0xfd79,
0xfe1b,0xbaae,0xe3b1,0xfc95,0xebb1,0xfc12,0xeb4f,0xeb6f,
0xd32b,0xcac9,0xc268,0xc247,0xc227,0xca07,0xca07,0xd228,
0xd209,0xdaac,0xdaed,0xd370,0xecb5,0xfdfb,0xfe7d,0xfede,
0xff7f,0xf77e,0xffdf,0xffff,0xf7bf,0xef7e,0xef9f,0xf7ff,
0x9d56,0x7411,0x63af,0x6bd0,0x6bf0,0x7432,0x7c93,0x7452,
0x8cf4,0x9d96,0xb618,0xb659,0xb639,0xae18,0xa5b7,0x9d96,
0x9d76,0x9535,0x9576,0x9d97,0x8d55,0x8d56,0x9576,0x8d35,
0xcd36,0xcd16,0xd4d6,0xdcd7,0xe497,0xe476,0xec56,0xec57,
0xec57,0xec16,0xe416,0xdbd5,0xdb94,0xe3b4,0xe3b4,0xd352,
0xaa4e,0xfd19,0xfedf,0xaa8e,0x91ec,0xec96,0xfd59,0xe475,
0xfe1b,0xfdd9,0xbb2f,0xcb6f,0xd34f,0xe36f,0xca8c,0xca8a,
0xc268,0xba06,0xb9c4,0xb9e5,0xc206,0xca06,0xc9e7,0xc9e7,
0xc9a8,0xda8c,0xe32f,0xe3b2,0xf4d7,0xfddb,0xfe5d,0xfe9d,
0xff7f,0xf77e,0xffbf,0xff9f,0xf79f,0xffdf,0xef7f,0xf7df,
0x7c11,0x6bd0,0x7c52,0x8493,0x7431,0x6c11,0x7c93,0x7cb3,
0x9535,0xa596,0xb639,0xb659,0xb659,0xb639,0xae18,0xadf8,
0xadf8,0xa5d7,0xa5d8,0xa5b8,0xa5b7,0xa5d8,0xadf8,0xa5f8,
0xcd58,0xcd37,0xd4f7,0xd4f7,0xe4d7,0xe4b8,0xec98,0xec77,
0xec98,0xe457,0xe436,0xdc15,0xdbd5,0xe3f5,0xec16,0xe3b4,
0xba2e,0xf415,0xfddb,0xcb31,0xba8f,0xec36,0xfcb7,0xf4f8,
0xcc54,0xfefe,0xc3f1,0xb2ed,0xc2cd,0xcacc,0xc26b,0xdb0c,
0xc226,0xc226,0xc226,0xc226,0xc206,0xc1c6,0xc9e7,0xd208,
0xc9e9,0xe2cd,0xeb70,0xebf3,0xf4d7,0xfdbb,0xfe5d,0xfedf,
0xff5f,0xff7e,0xff7f,0xf75e,0xff9f,0xffff,0xffff,0xf7df,
0x73f0,0x7411,0x8cb3,0x9515,0x8cf4,0x84f4,0x8d35,0x9556,
0x9535,0x9d55,0x9d96,0x9d96,0x9d97,0xa5b7,0xa5b7,0xa5d7,
0xa5d7,0xa5d7,0xa597,0x9d56,0x9d56,0x9d77,0xa597,0xa5b7,
0xd559,0xd579,0xdd59,0xe559,0xed5a,0xed5a,0xed5a,0xed3a,
0xed3a,0xed19,0xecf9,0xecf9,0xec98,0xf498,0xfc77,0xf3f5,
0xd28f,0x8846,0xd2f0,0xfe5e,0xca6f,0xb1cd,0xd312,0xfd5a,
0xdcf7,0xfe5b,0xd4d4,0xa2ac,0xcb0d,0xd30d,0xc24a,0xc269,
0xb9e6,0xba06,0xba06,0xb9e6,0xb1a5,0xa965,0xb9a6,0xc209,
0xca6b,0xe32f,0xebb2,0xec34,0xf4f7,0xfdbb,0xfe7d,0xff1f,
0xff7f,0xff7f,0xff7f,0xff9f,0xff9f,0xffdf,0xffff,0xef7e,
0x7c11,0x8472,0x8473,0x8493,0x8cf4,0x8d15,0x8d15,0x8d35,
0x9535,0x9535,0x9514,0x9514,0x9515,0x9515,0x9535,0x9555,
0x9d76,0xa597,0x9d56,0x9515,0x9515,0x9535,0x9515,0x9535,
0xdd5a,0xe59b,0xedbc,0xf5dc,0xf5fc,0xf5fd,0xf61d,0xf5fd,
0xf5fd,0xeddc,0xf5dc,0xfdbc,0xfd3a,0xfcd9,0xfc78,0xf3b4,
0xc9cc,0xa8a7,0xa0c8,0xfbb3,0xfcf9,0xfb95,0xb9cd,0xdb93,
0xfdfb,0xe578,0xfe9b,0xa2ed,0xaa2a,0xb1c8,0x9105,0xa186,
0x9985,0x9964,0x9144,0x8924,0x8924,0x9124,0x9966,0xa1c8,
0xba8c,0xcb2f,0xd3d2,0xdc54,0xed38,0xf5da,0xf67d,0xff1f,
0xff7f,0xff7f,0xff7f,0xffdf,0xf79f,0xef5e,0xf79f,0xdefc,
0x6b8f,0x8cb3,0x9515,0x8cd4,0x8cf4,0x84f4,0x84f4,0x9556,
0x9555,0x9535,0x9535,0x9555,0x9d56,0x9535,0x8d14,0x8cf4,
0x9d56,0xa597,0x9d77,0x9535,0x9d36,0x9d36,0x9515,0x9515,
0xe53a,0xed7b,0xfe3e,0xedbd,0xedfd,0xfedf,0xf6bf,0xf6df,
0xeebe,0xf69e,0xfe7e,0xfddc,0xfd5a,0xfcd9,0xfd5b,0xe2f1,
0xb8c8,0xb066,0xa066,0xa067,0xc96c,0xfbd6,0xfbd6,0xa12a,
0xc3b2,0xfe3b,0xfedd,0xecf5,0x6001,0x88a4,0xa187,0xa208,
0xaaaa,0xd430,0xd451,0xcc31,0xe514,0xf576,0xed35,0xf556,
0xe4f5,0xe536,0xdcf5,0xd536,0xee1a,0xee9c,0xe6dc,0xf75f,
0xff9f,0xff7f,0xff9f,0xf75e,0xef5e,0xe71d,0xf79f,0xb5b7,
0x7c11,0x94f4,0x9d76,0x9515,0x7c93,0x6c11,0x7451,0x84f4,
0x84d4,0x9535,0xa5d7,0xb639,0xb639,0xadf8,0xa5b7,0xa597,
0xa597,0xadb7,0xadb8,0xadb8,0xa577,0x9d56,0x9d36,0x9d15,
0xf59d,0xf57c,0xfdfe,0xf61e,0xfebf,0xff1f,0xe69f,0xef1f,
0xffbf,0xff5f,0xee3c,0xfe1c,0xfe3d,0xfd59,0xfc56,0xd22e,
0xb887,0xb845,0xb066,0xa846,0xa005,0xa807,0xe20f,0xfc77,
0xa20c,0xbb91,0xfe5b,0xfe1a,0x99c9,0xe390,0xec11,0xfcf5,
0xfe19,0xfe39,0xfe39,0xfebb,0xff5e,0xfefc,0xfebb,0xff5e,
0xfefd,0xff1e,0xfefd,0xf6bc,0xeedc,0xe71d,0xe75d,0xf7bf,
0xff9f,0xffdf,0xffff,0xe6dc,0xdedc,0xe71d,0xe73d,0x8452,
0x94f4,0xa576,0xa597,0x8d15,0x7c93,0x6bf0,0x63d0,0x6c31,
0x84d3,0x9d76,0xb639,0xbe9a,0xbe7a,0xb619,0xb5f8,0xb618,
0xadf8,0xadf8,0xadf8,0xadd8,0xadb8,0xadb8,0xa597,0xa577,
0xfd7d,0xfdbe,0xfdff,0xf61e,0xf69f,0xf6df,0xe6be,0xffbf,
0xdebd,0xd63a,0xfefd,0xfebd,0xfe3b,0xf495,0x9928,0xa908,
0xb866,0xc066,0xb025,0xb026,0xb847,0xa806,0xb047,0xc9cd,
0xfcb7,0xcb71,0xdbf3,0xfe5c,0xfcf6,0xfd16,0xec73,0xfdb8,
0xfdf9,0xedd9,0xfe9c,0xfedd,0xee3a,0xf69c,0xff5f,0xff1e,
0xfefd,0xf6bc,0xff1d,0xffbf,0xff9f,0xef5e,0xefbf,0xffff,
0xef5e,0xd69b,0xce5a,0xc619,0xb5b8,0xa515,0xa556,0x8452,
0xadb7,0xadd8,0xa597,0x9515,0x84b3,0x7431,0x63f0,0x6bf0,
0x84d3,0xa576,0xbe59,0xc69a,0xbe5a,0xb619,0xb619,0xbe39,
0xadf8,0xa5b7,0x9d76,0x9d56,0x9d56,0x9d56,0x9535,0x94f5,
0xf59d,0xfe3f,0xfe3f,0xedfd,0xf67f,0xf6bf,0xe6bd,0xf73f,
0xf77f,0xffdf,0xff9e,0xdd55,0xab2d,0xbb0d,0x9966,0xa926,
0xb886,0xd0c7,0xc086,0xb004,0xb005,0xb026,0xa805,0x9004,
0xc1cc,0xfc96,0xd330,0xfd17,0xfd79,0xfd37,0xfd98,0xfe3a,
0xfe3b,0xf61b,0xf67c,0xfedd,0xff1e,0xff9f,0xff7f,0xee9c,
0xff9f,0xff1f,0xff1e,0xf71e,0xeefd,0xf79f,0xf7bf,0xdefc,
0xb5d8,0x9cd4,0xa536,0xbe19,0xad77,0x7bf1,0x8472,0xa576,
0xa597,0xa597,0x9535,0x84d3,0x84b3,0x7472,0x7431,0x7c92,
0x8cf4,0x9d76,0xb5f8,0xb618,0xadb7,0xa597,0xa5b7,0xa5d7,
0xa5b7,0x9535,0x8cd4,0x84d4,0x8cf5,0x8cf5,0x8cd4,0x84b3,
0xfe5f,0xfe7f,0xf61e,0xf63e,0xfebf,0xf6be,0xe69c,0xeebb,
0xff7d,0xf71b,0xd5b5,0xdd94,0x92a8,0x68e1,0x8984,0x9924,
0xb8e6,0xb004,0xb845,0xc086,0xb004,0xb025,0xb887,0xa826,
0x9004,0xfc15,0xeb72,0xfcf7,0xfd17,0xcc33,0xcc53,0xcc94,
0xccd5,0xd537,0xdd98,0xf67c,0xff5f,0xf6bd,0xee9c,0xffbf,
0xf6de,0xff7f,0xff9f,0xf6fe,0xf71e,0xffdf,0xe6dc,0x83f0,
0x5aec,0x6baf,0x94f5,0xad97,0x9d35,0x94d4,0x8cb3,0x8cd4,
0x9514,0x9514,0x84b3,0x7c51,0x7451,0x6c10,0x7451,0x84d3,
0x9d56,0xa596,0xa597,0x9d56,0x9515,0x9515,0x9515,0x8d14,
0x84d4,0x7452,0x6bf0,0x6c11,0x7452,0x7c72,0x7c72,0x7452,
0xfedf,0xf67f,0xee1d,0xf67e,0xee3c,0xe5fa,0xfebc,0xff5d,
0xee99,0x6247,0x5162,0x7a86,0x8285,0x8a44,0x7140,0x8901,
0xb925,0xa803,0xb844,0xd0c7,0xb865,0xb086,0xb8a7,0x9803,
0xb025,0xb067,0xc1ac,0xfcf8,0xfd99,0xe537,0xbc54,0xac32,
0xf63a,0xc4f5,0xd5b8,0xd5d8,0x9c52,0xacd5,0xe69c,0xde7c,
0xe69d,0xe69d,0xeebd,0xeebd,0xe69c,0xc5b8,0x736f,0x20e5,
0x31a8,0x52ec,0x7c31,0x8cb3,0x8cf4,0xa597,0x94f4,0x84b3,
0x9514,0x9514,0x8cd3,0x7c92,0x7431,0x6bf0,0x7431,0x8cd3,
0xadd7,0xadd7,0xa597,0x9535,0x8cf4,0x8cd4,0x84b3,0x7c52,
0x7452,0x63d0,0x5b8f,0x63af,0x63d0,0x63d0,0x5baf,0x63d0,
0xee9e,0xee9e,0xee5d,0xf67d,0xedfa,0xf61a,0xfebc,0xe5d7,
0x4902,0x4901,0x8b28,0x6a23,0x7222,0xa366,0x7a00,0x7920,
0xa0c3,0xb885,0xc8a6,0xb824,0x9801,0xa003,0xb085,0xa845,
0xb826,0xb006,0xd1cc,0xfc55,0xe4d6,0xdd99,0xbcd6,0x8b90,
0x834d,0x28c2,0x3944,0x41c6,0x18c3,0x6b6e,0xa556,0x52ac,
0x62ed,0x422a,0x41ea,0x5aad,0x62ee,0x39e9,0x2146,0x2987,
0x31e8,0x426b,0x636e,0x8472,0x8cd4,0xa597,0x9514,0xa5b7,
0xa5b7,0xa5b7,0x9d76,0x9535,0x84d3,0x7431,0x7431,0x8cf4,
0xadb7,0xb5d8,0xadb7,0x9d55,0x9515,0x8cd4,0x7c52,0x63cf,
0x6bf0,0x63af,0x5b8f,0x5baf,0x5b8f,0x534e,0x4b4e,0x538e,
0xde5c,0xeebd,0xe69c,0xee9c,0xfebc,0xff7e,0xfe38,0x69c5,
0x69e4,0x8b07,0x5180,0x6a42,0x9ba7,0x8261,0xa304,0x70c0,
0x8020,0x9001,0x9801,0xa002,0xb0a5,0xb0a5,0xa844,0xb065,
0xc066,0xb867,0xa8a8,0xfc55,0xfdda,0xbcd5,0x9412,0x730e,
0x5a8a,0x4a28,0x4a48,0x4a89,0x426a,0x428a,0x428a,0x3229,
0x52ed,0x636f,0x634f,0x52ee,0x4aac,0x31e9,0x1926,0x1967,
0x08c4,0x29c8,0x532d,0x7431,0x7c52,0x9535,0x84b3,0xa5b7,
0xadf8,0xae18,0xadf8,0xa5b7,0x9555,0x7c92,0x7c72,0x8cf4,
0x9d76,0xadb7,0xadd8,0xa596,0x9515,0x84b3,0x7411,0x5b6e,
0x3a6b,0x326a,0x3a8b,0x3acc,0x3acc,0x328b,0x3aab,0x430d,
0xe65b,0xee9c,0xef1c,0xf77d,0xe698,0xb4d0,0x5962,0x6182,
0x9307,0x5140,0x72c3,0x7b04,0x7261,0x9b05,0x99e2,0x7860,
0x88a0,0x88a1,0x7820,0x8021,0x9843,0xb044,0xb025,0xb825,
0xc066,0xc109,0xa908,0xf4b5,0xfebc,0xff5e,0xeefd,0xa4d4,
0x6b6e,0x7c10,0x8c92,0x8472,0x63af,0x4acc,0x42ab,0x4aed,
0x5b4f,0x5b6f,0x534f,0x4aee,0x42cd,0x322b,0x19a8,0x19a8,
0x1988,0x21e9,0x42cc,0x5bb0,0x63f0,0x63cf,0x6c10,0x7c92,
0x9535,0xa5b7,0xb639,0xb659,0xa5f8,0x9555,0x84f4,0x7cb3,
0x8d15,0x9d56,0xa5b7,0x9d96,0x8cf5,0x84b3,0x6bf1,0x4aed,
0x2a2a,0x1987,0x1167,0x19c8,0x19c9,0x21e9,0x2a2a,0x2a4a,
0xde7a,0xdebb,0xa533,0x6b8b,0x18e0,0x0800,0x30e0,0x9367,
0x7262,0x6200,0x72c2,0x6a61,0x7221,0x9263,0x9960,0x90e0,
0x8100,0xa2c6,0x9ae7,0x7183,0x6800,0x7801,0xa085,0xb0c7,
0xb908,0xb96a,0xa189,0xd413,0xfebc,0xff9f,0xeefd,0xffbf,
0xd6fd,0xadb8,0x94f5,0x9536,0x8cf5,0x63d0,0x4aed,0x42ed,
0x4aed,0x4aed,0x42ed,0x430e,0x4b0e,0x328c,0x19a9,0x1188,
0x2a0a,0x326b,0x4b0e,0x63f1,0x6bf1,0x5b8f,0x534e,0x63af,
0x84b3,0x9535,0xa5d7,0xa5f8,0x9db7,0x8d35,0x84f4,0x84f4,
0x9d97,0xa597,0xa5b8,0x9d76,0x8cf5,0x7c93,0x6bf1,0x4b0d,
0x21e9,0x1167,0x1147,0x1188,0x19a8,0x21e9,0x2a4b,0x2a4b,
0x5b0b,0x3a48,0x0040,0x00a0,0x08a0,0x10e0,0x4221,0x5ac2,
0x41c0,0x72a2,0x82a2,0x8a21,0x9a42,0x91a0,0x78c0,0x7900,
0x8aa3,0x72e4,0x6b45,0x6326,0x72c7,0x6a06,0x6966,0x7105,
0x8127,0x8948,0xbacf,0xb371,0xac54,0xf73f,0xff1f,0xeeff,
0xe73f,0xb63a,0xa597,0xa5b8,0x9536,0x6bf1,0x532e,0x534e,
0x4b0e,0x326b,0x19a9,0x19a9,0x220a,0x19c9,0x1168,0x1188,
0x2a2b,0x3aac,0x538f,0x7473,0x7cb4,0x7431,0x6bf0,0x6bf0,
0x84b3,0x9535,0x9db7,0x9d96,0x8d35,0x84f4,0x7cd4,0x84f4,
0x9d77,0x9d56,0x9556,0x8d15,0x7c93,0x7c73,0x63d1,0x42cc,
0x21e9,0x19a8,0x1188,0x19a8,0x21e9,0x328c,0x42ee,0x3acd,
0x0080,0x00a0,0x00a0,0x1961,0x1940,0x1160,0x3260,0x42a1,
0x6323,0x7b43,0x7220,0x79a0,0x89e1,0x89a0,0x89e1,0x9ac4,
0x9b46,0x7305,0x6c08,0x642a,0x63ca,0x52e8,0x5aa9,0x7aeb,
0x7209,0x58a4,0xa2ae,0xc434,0x93d2,0xbd58,0xbd38,0xb538,
0x94d5,0x9d56,0xa5b8,0x9d77,0x8494,0x63d0,0x5b90,0x63b0,
0x6c33,0x4b2f,0x220a,0x1188,0x19a9,0x1168,0x1188,0x220a,
0x220a,0x328c,0x5bb0,0x8cf5,0x9d98,0x9576,0x8d15,0x8cf4,
0x84d3,0x8d14,0x8d14,0x84d3,0x6c51,0x6c11,0x6c51,0x7c93,
0x84d4,0x84d4,0x84d4,0x84b4,0x7c93,0x7c73,0x63f1,0x42cd,
0x2a2a,0x220a,0x220a,0x2a0a,0x326c,0x4b4f,0x5bd1,0x5bb1,
0x1963,0x00a0,0x0900,0x1960,0x2a22,0x42e3,0x42c2,0x42c1,
0x6322,0x5a60,0x6240,0x8b24,0x9b65,0x8ae3,0x8304,0x8ac4,
0x7962,0x8247,0x9caf,0x63ec,0x4b29,0x3ac8,0x532b,0x634c,
0x93cf,0x8aec,0x930d,0xbc93,0xacf4,0x9cb3,0x83d0,0x8c52,
0x7411,0x7452,0x7c73,0x7c73,0x6c12,0x63b0,0x63d1,0x6c32,
0x7cd5,0x6c53,0x5370,0x3acd,0x2a4c,0x11a9,0x0968,0x19a9,
0x21c9,0x326b,0x5b90,0x8d15,0xa5f9,0xadf9,0x9d77,0x9535,
0x7c72,0x7c72,0x6c11,0x536e,0x42ec,0x42cc,0x4b4e,0x5bb0,
0x7452,0x7c72,0x84d4,0x8cf4,0x84d4,0x84b4,0x6c12,0x4b0e,
0x3aac,0x328c,0x328c,0x328c,0x3acd,0x5390,0x6433,0x6412,
0x0060,0x0040,0x0900,0x0920,0x2a42,0x4324,0x4343,0x5bc4,
0x6ba4,0x41e0,0x51c0,0x7a81,0x7a41,0x7a21,0x8a63,0x89e3,
0x8081,0x70a3,0x938d,0x6b6c,0x638c,0x5bac,0x6c2f,0x742f,
0xbdd5,0xb4f3,0x9bce,0xb4b2,0x9cf2,0x9512,0x94b1,0x7bef,
0x7411,0x532e,0x42cc,0x42ed,0x42cc,0x326b,0x4b2e,0x7453,
0x7cd5,0x7cf5,0x7474,0x5390,0x3acd,0x19c9,0x0968,0x19a9,
0x19a9,0x2a2a,0x534f,0x84d4,0xadd9,0xae19,0xa5b8,0x9d56,
0x84b3,0x7452,0x63af,0x42cc,0x2a09,0x21e9,0x324a,0x3aac,
0x6bf1,0x7452,0x8cf5,0x8d15,0x84d4,0x7cb4,0x6c32,0x4b4e,
0x4b4e,0x430d,0x42ed,0x42ed,0x42ee,0x536f,0x5bf2,0x5bd1,
0x1101,0x08e0,0x00e0,0x00c0,0x1a61,0x22c2,0x2b02,0x3b42,
0x3aa0,0x39a0,0x7241,0x8a22,0x9140,0xa100,0x9840,0x9800,
0xb8c5,0x9064,0xbb8f,0x9bcf,0x9451,0x8c71,0x9d74,0xb617,
0xa512,0x6b0a,0x6aa9,0xad12,0x9531,0x84f0,0x94f1,0x8cb1,
0x6bf0,0x42ed,0x2a0a,0x21e9,0x1988,0x1147,0x2a2b,0x5b90,
0x7494,0x84f6,0x7cb5,0x5bb1,0x3acd,0x222b,0x19ea,0x222b,
0x19c9,0x2a2a,0x4b0e,0x7c93,0xa5d8,0xb63a,0xadf9,0x9d77,
0x8d15,0x84b3,0x6c11,0x532e,0x3a8c,0x324b,0x328b,0x3aac,
0x63d0,0x7c72,0x8cf5,0x84f5,0x7c73,0x7473,0x6c32,0x538f,
0x536f,0x430e,0x42ed,0x3aed,0x32ad,0x3acd,0x432f,0x432f,
0x0020,0x0901,0x00e0,0x0940,0x4346,0x3304,0x4385,0x4b23,
0x4220,0x61c0,0xa264,0x9921,0xa040,0xb8a1,0xb000,0xc0a3,
0xa022,0x90a3,0xd471,0xbcd2,0xce16,0xc637,0x9532,0x532a,
0x1902,0x31a4,0x39c5,0x6b8c,0x9593,0xa636,0x8cf2,0x94f3,
0x7c93,0x5bb0,0x326b,0x19c8,0x1188,0x19a8,0x21e9,0x2a2a,
0x4b4f,0x6412,0x6412,0x4b4f,0x328c,0x21ea,0x11a9,0x19a9,
0x21ea,0x2a2a,0x4b0d,0x7453,0x9d98,0xae19,0xa5b8,0x9556,
0x8cf4,0x84b3,0x7452,0x63d0,0x5b6f,0x534f,0x536f,0x5b8f,
0x63f1,0x7c73,0x8d15,0x84f4,0x7452,0x7452,0x7452,0x63f1,
0x4b2e,0x328c,0x326c,0x328c,0x2a4b,0x222b,0x2a6c,0x328c,
0x00c0,0x08e1,0x10e1,0x0840,0x10a0,0x4a84,0x6326,0x5201,
0x8243,0x9982,0xb0a1,0xc841,0xc842,0xc062,0xa881,0x8880,
0x78c0,0x79a1,0xb50d,0xbdf1,0xced5,0x6beb,0x2204,0x19c3,
0x3aa7,0x63ac,0x8cd2,0x9d54,0x8d54,0x8514,0x94d5,0x94f6,
0x8cd5,0x5bb0,0x326b,0x19c9,0x19a8,0x19a8,0x19c9,0x21ea,
0x220a,0x2a2a,0x2a2a,0x220a,0x21ea,0x220a,0x220a,0x220a,
0x2a4b,0x324a,0x3a8c,0x536f,0x84b4,0x9d97,0xa5b7,0x9d56,
0x9556,0x9515,0x84b4,0x7452,0x7432,0x7c73,0x7473,0x7452,
0x7c93,0x8d15,0x9556,0x8d15,0x7473,0x6c11,0x5b90,0x4b4e,
0x324b,0x220a,0x21e9,0x220a,0x222b,0x222b,0x222b,0x2a4c,
0x00c1,0x00a0,0x0860,0x0840,0x0860,0x2940,0x5a63,0x7aa5,
0x91e3,0xb102,0xc821,0xd801,0xd022,0xb882,0x90a2,0x70e0,
0x71c0,0x8365,0x8489,0x5bc6,0x21c0,0x42e5,0x4b69,0x748e,
0x6c4e,0x7cf1,0x9554,0x9575,0x8575,0x8536,0x94b6,0x8c55,
0x63d1,0x4b0e,0x326b,0x2a4a,0x2a2a,0x220a,0x2a2a,0x2a4b,
0x2a2a,0x2a4a,0x2a4b,0x222a,0x220a,0x222a,0x2a4b,0x2a4b,
0x328b,0x3a8b,0x3aac,0x534e,0x7452,0x9555,0xa597,0xa597,
0x8cd4,0x84d4,0x84b4,0x84d4,0x8cd5,0x84f5,0x84b4,0x7c94,
0x7c73,0x84d5,0x8d16,0x84f5,0x7cb4,0x6c32,0x536f,0x3acc,
0x220a,0x19e9,0x19c9,0x19ea,0x222b,0x2a4b,0x2a4c,0x328c,
0x0061,0x0060,0x0080,0x00c0,0x0100,0x0940,0x39e1,0x7ac6,
0xa245,0xb943,0xc842,0xc801,0xc022,0xa8a2,0x8102,0x6161,
0x7282,0x4a40,0x2a40,0x53e7,0x4b87,0x8d2f,0x746d,0x644d,
0x8511,0x8d73,0x9594,0x8d54,0x8595,0x8d96,0x8cb5,0x7bd2,
0x5b4f,0x4b2e,0x430d,0x430d,0x42ed,0x3aac,0x3acc,0x430d,
0x42cd,0x430d,0x4b0e,0x42ed,0x3aac,0x3aac,0x3acc,0x3acc,
0x4b2e,0x532d,0x5b6e,0x63d0,0x7c92,0x9555,0xa5b7,0xa5b7,
0x8cd3,0x84b3,0x8cd4,0x9536,0x9536,0x8cf5,0x84d4,0x84d5,
0x84d4,0x8cf5,0x8d15,0x8d15,0x8d15,0x7cb4,0x5bb0,0x3aac,
0x21ea,0x19c9,0x11a9,0x19ea,0x222b,0x2a4c,0x2a8c,0x32ad,
0x0800,0x10a1,0x00e1,0x0120,0x01a1,0x0980,0x2120,0x5120,
0x9162,0xa8e2,0xb8a2,0xb8c2,0xa923,0x9984,0x8204,0x6a44,
0x51a0,0x41e1,0x5366,0x642a,0x63ea,0x42c7,0x4b29,0x748f,
0x8d32,0x9db4,0xa5d5,0x9594,0x8db5,0x8db6,0x8cd4,0x6bb0,
0x63b0,0x5bb0,0x63d0,0x63d1,0x538f,0x4b2e,0x4b4e,0x5bb0,
0x5bd0,0x6c32,0x7453,0x6c32,0x5bb0,0x536f,0x4b2e,0x4b0d,
0x534e,0x5b8f,0x6bf0,0x7c93,0x9556,0xadf8,0xb5f8,0xadd8,
0x9d35,0x8cf4,0x8cf4,0x9556,0x9536,0x84b4,0x7c93,0x84d5,
0x7cb4,0x7c93,0x7473,0x7452,0x7453,0x6c32,0x4b4f,0x326b,
0x220a,0x19e9,0x19c9,0x19ea,0x220b,0x2a4b,0x2a6c,0x2a8c,
0x1801,0x18a2,0x0901,0x0140,0x0180,0x00e0,0x1820,0x4020,
0x8942,0xa183,0xaa04,0xa245,0x8244,0x6203,0x49c1,0x4981,
0x6163,0x8ae9,0x6b2a,0x29e5,0x530a,0x3227,0x42c9,0x6c0e,
0x9553,0xae15,0xb636,0x9db4,0x7d52,0x7d32,0x7490,0x63ae,
0x63d0,0x6c11,0x7452,0x7473,0x63f1,0x536f,0x536f,0x63d0,
0x7473,0x84f4,0x9556,0x8d35,0x7c93,0x63f0,0x536f,0x4b2d,
0x42ec,0x534d,0x6bf0,0x84d3,0xa5d7,0xbe59,0xbe59,0xb618,
0x9d55,0x9514,0x9515,0x9d76,0x9556,0x84b3,0x7c93,0x84f5,
0x84d5,0x7cb4,0x6c32,0x5bb0,0x5b90,0x5b90,0x4b2e,0x328c,
0x2a2a,0x220a,0x19c9,0x19c9,0x19ea,0x1a0a,0x1a0b,0x1a0a,
0x1862,0x1081,0x00c0,0x0120,0x0120,0x00a0,0x28a0,0x6161,
0x9a44,0xa265,0x9a85,0x8a43,0x69c1,0x5140,0x50e0,0x50a0,
0x5000,0xb36e,0x836d,0x4248,0x5b2c,0x42ea,0x3aa9,0x5bcd,
0x84b1,0x9d33,0x9d33,0x7c70,0x53ed,0x540d,0x640e,0x63ef,
0x63d0,0x6c32,0x84d4,0x8d15,0x7cb4,0x6c11,0x63f1,0x6c31,
0x84d4,0x9576,0xa5f8,0xa5b7,0x8d15,0x7452,0x63d0,0x5b8f,
0x536e,0x5baf,0x7431,0x8cf3,0xa596,0xadf7,0xadd7,0x9d75,
0x84b3,0x84b3,0x9535,0xa5b7,0x9d76,0x84d4,0x7c93,0x84d5,
0x8d36,0x84f5,0x7453,0x63b0,0x538f,0x538f,0x4b4f,0x42ed,
0x2a6b,0x2a4b,0x220a,0x19e9,0x19ea,0x1a0a,0x1a0a,0x19ea,
0x08a1,0x0080,0x00a0,0x08e0,0x10e0,0x2940,0x5202,0x6a63,
0x7222,0x7201,0x71c0,0x7940,0x80e0,0x98a0,0xb081,0xb0a3,
0x8883,0xc3af,0x7b2b,0x4ac9,0x4b4b,0x330a,0x1a47,0x32ea,
0x5b8d,0x6bce,0x738e,0x5b2c,0x3b0b,0x436d,0x63f0,0x7452,
0x7c93,0x84d4,0x9556,0x9d97,0x9556,0x84d4,0x7cb3,0x84d4,
0x9556,0xa5d8,0xb639,0xa5d8,0x8d15,0x7c92,0x7431,0x6c31,
0x6c31,0x7c92,0x84f3,0x9534,0x9534,0x9534,0x84b2,0x7430,
0x6bef,0x7431,0x8cd3,0x9d56,0x9535,0x84b3,0x7452,0x7c73,
0x7c94,0x7c93,0x6c32,0x5bb0,0x538f,0x538f,0x4b4f,0x42ed,
0x3acd,0x3acd,0x328c,0x2a6c,0x2a6c,0x32ad,0x32ad,0x2a6c,
0x00c1,0x00c0,0x08e0,0x08a0,0x10c0,0x4a23,0x6284,0x49a0,
0x5a00,0x61e0,0x69a0,0x8160,0xa0e0,0xb880,0xd000,0xc801,
0xa084,0xc38e,0x838c,0x42a8,0x432b,0x3b4b,0x3b8c,0x3b4c,
0x4b2c,0x5b2c,0x630d,0x52cc,0x432d,0x53af,0x6c73,0x84f5,
0x9577,0x9d97,0x9db7,0xa5d8,0x9d97,0x8d15,0x8d15,0x9535,
0x9d97,0xadf8,0xb639,0xa5b7,0x8cf4,0x7c72,0x7451,0x7451,
0x7431,0x84d3,0x9534,0x9555,0x8d13,0x7c71,0x6bcf,0x5b4d,
0x5b6d,0x6bcf,0x7c72,0x84d3,0x7c93,0x7431,0x6bf1,0x6bf1,
0x7452,0x7453,0x6c52,0x6c11,0x6c12,0x6412,0x5bd1,0x4b4f,
0x4b4f,0x4b4f,0x430f,0x3aee,0x430f,0x4b50,0x4b70,0x434f
};
# 21 "RA8876.c" 2
# 1 "./8876demo.h" 1
# 11 "./8876demo.h"
void BTE_Compare(void)
{
   unsigned int i,temp;
 unsigned long im=1;


   Select_Main_Window_16bpp();
 Main_Image_Start_Address(0);
 Main_Image_Width(1024);
 Main_Window_Start_XY(0,0);

 Canvas_Image_Start_address(0);
 Canvas_image_width(1024);
    Active_Window_XY(0,0);
 Active_Window_WH(1024,600);

  Foreground_color_65k(0xFFFF);
 Line_Start_XY(0,0);
 Line_End_XY(1023,575);
 Start_Square_Fill();

 Foreground_color_65k(0x051F);
 Line_Start_XY(0,576);
 Line_End_XY(1023,599);
 Start_Square_Fill();
# 44 "./8876demo.h"
 Foreground_color_65k(0xFFFF);
 Background_color_65k(0x051F);
 CGROM_Select_Internal_CGROM();
 Font_Select_12x24_24x24();
 Goto_Text_XY(0,576);
 Show_String("    	             Demo BTE Compare");
 Foreground_color_65k(0x0000);
 Background_color_65k(0xFFFF);
 Font_Select_12x24_24x24();
 Goto_Text_XY(0,552);
 Show_String("Execute Logic 'OR' 0xf000");



 Enable_SFlash_SPI();
    Select_SFI_1();
    Select_SFI_DMA_Mode();
    Select_SFI_24bit_Address();


    Select_SFI_Waveform_Mode_3();


    Select_SFI_8_DummyRead();



    Select_SFI_Single_Mode();



    SPI_Clock_Period(0);


 SFI_DMA_Destination_Upper_Left_Corner(50,40);
    SFI_DMA_Transfer_Width_Height(200,200);
    SFI_DMA_Source_Width(1024);

 SFI_DMA_Source_Start_Address(2457600);
 Start_SFI_DMA();
    Check_Busy_SFI_DMA();

 SFI_DMA_Destination_Upper_Left_Corner(50+200+50,40);
    SFI_DMA_Transfer_Width_Height(200,200);
    SFI_DMA_Source_Width(1024);

 SFI_DMA_Source_Start_Address(2457600);
 Start_SFI_DMA();
    Check_Busy_SFI_DMA();

 SFI_DMA_Destination_Upper_Left_Corner(50+200+50+200+50,40);
    SFI_DMA_Transfer_Width_Height(200,200);
    SFI_DMA_Source_Width(1024);

 SFI_DMA_Source_Start_Address(im*1024*600*2*2);
 Start_SFI_DMA();
    Check_Busy_SFI_DMA();


  Foreground_color_65k(0x0000);
 Background_color_65k(0xFFFF);
 CGROM_Select_Internal_CGROM();
 Font_Select_12x24_24x24();
 Goto_Text_XY(50,40+200+40 );
 Show_String("Without BTE");
  Goto_Text_XY(50+200+50,40+200+40 );
 Show_String("With BTE Write");
   Goto_Text_XY(50+200+50,40+200+40+24 );
 Show_String("ROP");
   Goto_Text_XY(50+200+50+200+50,40+200+40 );
 Show_String("With BTE Move");
   Goto_Text_XY(50+200+50+200+50,40+200+40+24 );
 Show_String("ROP");

 delay_ms(1000);




    Active_Window_XY(50,40);
    Active_Window_WH(200,200);

     Goto_Pixel_XY(50,40);
     LCD_CmdWrite(0x04);
     temp = LCD_DataRead();
   Check_Mem_RD_FIFO_not_Empty();

     for(i=0; i<200*200;i++)
    {
     temp = LCD_DataRead();

     temp=temp|(LCD_DataRead()<<8);
     Check_Mem_RD_FIFO_not_Empty();
     temp |= 0xf000;
     LCD_DataWrite(temp);
     LCD_DataWrite(temp>>8);
     Check_Mem_WR_FIFO_not_Full();
     }


  Active_Window_XY(0,0);
     Active_Window_WH(1024,600);



   Foreground_color_65k(0x0000);
  Background_color_65k(0xFFFF);
  CGROM_Select_Internal_CGROM();
  Font_Select_12x24_24x24();
  Goto_Text_XY(50,40+200+40+72 );
  Show_String("Spent 51.12ms");

    delay_ms(1000);







    BTE_S0_Color_16bpp();

       BTE_S1_Color_16bpp();
       BTE_S1_Memory_Start_Address(0);
       BTE_S1_Image_Width(1024);
       BTE_S1_Window_Start_XY(50+200+50,40);

       BTE_Destination_Color_16bpp();
       BTE_Destination_Memory_Start_Address(0);
       BTE_Destination_Image_Width(1024);
       BTE_Destination_Window_Start_XY(50+200+50,40);
       BTE_Window_Size(200,200);

    BTE_ROP_Code(14);
       BTE_Operation_Code(0);
       BTE_Enable();

       LCD_CmdWrite(0x04);
        for(i=0; i<200*200;i++)
    {
     LCD_DataWrite(0xf000);
     LCD_DataWrite(0xf000>>8);
     Check_Mem_WR_FIFO_not_Full();
     }
       Check_Mem_WR_FIFO_Empty();
       Check_BTE_Busy();





    Foreground_color_65k(0x0000);
  Background_color_65k(0xFFFF);
  CGROM_Select_Internal_CGROM();
  Font_Select_12x24_24x24();
  Goto_Text_XY(50+200+50,40+200+40+72 );
  Show_String("Spent 25.56ms");
    delay_ms(1000);






     Canvas_Image_Start_address(1228800);
     Canvas_image_width(1024);
        Active_Window_XY(0,0);
     Active_Window_WH(1024,600);

      Foreground_color_65k(0xf000);
     Line_Start_XY(0,0);
     Line_End_XY(200,200);
     Start_Square_Fill();


  BTE_S0_Color_16bpp();
  BTE_S0_Memory_Start_Address(1228800);
  BTE_S0_Image_Width(1024);
     BTE_S0_Window_Start_XY(0,0);

        BTE_S1_Color_16bpp();
        BTE_S1_Memory_Start_Address(0);
        BTE_S1_Image_Width(1024);
        BTE_S1_Window_Start_XY(50+200+50+200+50,40);

        BTE_Destination_Color_16bpp();
        BTE_Destination_Memory_Start_Address(0);
        BTE_Destination_Image_Width(1024);
        BTE_Destination_Window_Start_XY(50+200+50+200+50,40);
        BTE_Window_Size(200,200);

     BTE_ROP_Code(14);
        BTE_Operation_Code(2);
        BTE_Enable();
  Check_BTE_Busy();




  Canvas_Image_Start_address(0);
    Foreground_color_65k(0x0000);
  Background_color_65k(0xFFFF);
  CGROM_Select_Internal_CGROM();
  Font_Select_12x24_24x24();
  Goto_Text_XY(50+200+50+200+50,40+200+40+72 );
  Show_String("SSpent 6.4ms");
   delay_ms(1000);
   NextStep();

}


void BTE_Color_Expansion(void)
{ unsigned int i,j;
    unsigned long im=1;

  Select_Main_Window_16bpp();
 Main_Image_Start_Address(0);
 Main_Image_Width(1024);
 Main_Window_Start_XY(0,0);

 Canvas_Image_Start_address(0);
 Canvas_image_width(1024);
    Active_Window_XY(0,0);
 Active_Window_WH(1024,600);

  Foreground_color_65k(0x0000);
 Line_Start_XY(0,0);
 Line_End_XY(1023,575);
 Start_Square_Fill();

 Foreground_color_65k(0x051F);
 Line_Start_XY(0,576);
 Line_End_XY(1023,599);
 Start_Square_Fill();



 Foreground_color_65k(0xFFFF);
 Background_color_65k(0x051F);
 CGROM_Select_Internal_CGROM();
 Font_Select_12x24_24x24();
 Goto_Text_XY(0,576);
 Show_String("            Demo BTE Color Expansion");



 Enable_SFlash_SPI();
    Select_SFI_1();
    Select_SFI_DMA_Mode();
    Select_SFI_24bit_Address();


    Select_SFI_Waveform_Mode_3();


    Select_SFI_8_DummyRead();



    Select_SFI_Single_Mode();



    SPI_Clock_Period(0);


 SFI_DMA_Destination_Upper_Left_Corner(80,40);
    SFI_DMA_Transfer_Width_Height(640,480);
    SFI_DMA_Source_Width(1024);

 SFI_DMA_Source_Start_Address(im*1024*600*2*3);
 Start_SFI_DMA();
    Check_Busy_SFI_DMA();





  j=0;
 do
 {
   for(i=0;i<3;i++)
   {

  Canvas_Image_Start_address(1228800);
   Foreground_color_65k(0x0000);
  Line_Start_XY(0,0);
  Line_End_XY(1023,575);
  Start_Square_Fill();

  Start_SFI_DMA();
     Check_Busy_SFI_DMA();

  BTE_S0_Color_16bpp();

     BTE_S1_Color_16bpp();

     BTE_Destination_Color_16bpp();
     BTE_Destination_Memory_Start_Address(1228800);
     BTE_Destination_Image_Width(1024);
     BTE_Destination_Window_Start_XY(80+70,40+70);
     BTE_Window_Size(160,160);
  Foreground_color_65k(0x001f);
     Background_color_65k(0xf800);
  BTE_ROP_Code(15);
     BTE_Operation_Code(8);

  BTE_Enable();
  LCD_CmdWrite(0x04);

  switch(i)
  {
   case 0 :
     Show_picture1(10*160,f1);
     Check_Mem_WR_FIFO_Empty();
           Check_BTE_Busy();
     break;
   case 1 :
     Show_picture1(10*160,f2);
     Check_Mem_WR_FIFO_Empty();
           Check_BTE_Busy();
     break;
   case 2 :
     Show_picture1(10*160,f3);
     Check_Mem_WR_FIFO_Empty();
           Check_BTE_Busy();
     break;
    default:
     break;
  }


  Foreground_color_65k(0x0000);
 Background_color_65k(0xFFFF);
 CGROM_Select_Internal_CGROM();
 Font_Select_12x24_24x24();
 Goto_Text_XY(80+70,40+70+160+20);
 Show_String("Color Expansion");



  Foreground_color_65k(0x001f);
     Background_color_65k(0xf800);

  BTE_Operation_Code(9);
  BTE_Destination_Window_Start_XY(80+320+70,40+70);
  BTE_Enable();
  LCD_CmdWrite(0x04);

  switch(i)
  {
   case 0 :
     Show_picture1(10*160,f1);
     Check_Mem_WR_FIFO_Empty();
           Check_BTE_Busy();
     break;
   case 1 :
     Show_picture1(10*160,f2);
     Check_Mem_WR_FIFO_Empty();
           Check_BTE_Busy();
     break;
   case 2 :
     Show_picture1(10*160,f3);
     Check_Mem_WR_FIFO_Empty();
           Check_BTE_Busy();
     break;
    default:
     break;
  }


 Foreground_color_65k(0x0000);
 Background_color_65k(0xFFFF);
 CGROM_Select_Internal_CGROM();
 Font_Select_12x24_24x24();
 Goto_Text_XY(80+320+70,40+70+160+20);
 Show_String("Color Expansion");
 Goto_Text_XY(80+320+70,40+70+160+20+24);
 Show_String("Color With chroma key");

    Foreground_color_65k(0x001f);
     Background_color_65k(0xf800);



       BTE_S0_Memory_Start_Address(1228800);
       BTE_S0_Image_Width(1024);
       BTE_S0_Window_Start_XY(0,0);


       BTE_Destination_Memory_Start_Address(0);
       BTE_Destination_Image_Width(1024);
       BTE_Destination_Window_Start_XY(0,0);
       BTE_Window_Size(1024,575);

       BTE_ROP_Code(12);
       BTE_Operation_Code(2);
       BTE_Enable();
       Check_BTE_Busy();


   j++;
 }

   }while(j<12);

    NextStep();

}



void BTE_Pattern_Fill(void)
{ unsigned long im=1;

  Select_Main_Window_16bpp();
 Main_Image_Start_Address(0);
 Main_Image_Width(1024);
 Main_Window_Start_XY(0,0);

 Canvas_Image_Start_address(0);
 Canvas_image_width(1024);
    Active_Window_XY(0,0);
 Active_Window_WH(1024,600);

  Foreground_color_65k(0x0000);
 Line_Start_XY(0,0);
 Line_End_XY(1023,575);
 Start_Square_Fill();

 Foreground_color_65k(0x051F);
 Line_Start_XY(0,576);
 Line_End_XY(1023,599);
 Start_Square_Fill();


 Foreground_color_65k(0xFFFF);
 Background_color_65k(0x051F);
 CGROM_Select_Internal_CGROM();
 Font_Select_12x24_24x24();
 Goto_Text_XY(0,576);
 Show_String("              Demo BTE Pattern Fill");


 Enable_SFlash_SPI();
    Select_SFI_1();
    Select_SFI_DMA_Mode();
    Select_SFI_24bit_Address();


    Select_SFI_Waveform_Mode_3();


    Select_SFI_8_DummyRead();



    Select_SFI_Single_Mode();



    SPI_Clock_Period(0);


 SFI_DMA_Destination_Upper_Left_Corner(80,40);
    SFI_DMA_Transfer_Width_Height(640,480);
    SFI_DMA_Source_Width(1024);

 SFI_DMA_Source_Start_Address(im*1024*600*2*1);
 Start_SFI_DMA();
    Check_Busy_SFI_DMA();



 Pattern_Format_16X16();
 Canvas_Image_Start_address(6144000);
    Canvas_image_width(16);
    Active_Window_XY(0,0);
    Active_Window_WH(16,16);
    Goto_Pixel_XY(0,0);
    Show_picture(16*16,pattern16x16_16bpp);

 Canvas_Image_Start_address(0);
    Canvas_image_width(1024);
    Active_Window_XY(0,0);
    Active_Window_WH(1024,600);


 BTE_S0_Color_16bpp();
    BTE_S0_Memory_Start_Address(6144000);
    BTE_S0_Image_Width(16);

    BTE_S1_Color_16bpp();
    BTE_S1_Memory_Start_Address(0);
    BTE_S1_Image_Width(1024);

    BTE_Destination_Color_16bpp();
    BTE_Destination_Memory_Start_Address(0);
    BTE_Destination_Image_Width(1024);

    BTE_ROP_Code(0xc);
    BTE_Operation_Code(0x06);

 BTE_S1_Window_Start_XY(0,0);
    BTE_Destination_Window_Start_XY(80,40);
    BTE_Window_Size(300,300);

    BTE_Enable();
    Check_BTE_Busy();

 Foreground_color_65k(0x0000);
 Background_color_65k(0xFFFF);
 CGROM_Select_Internal_CGROM();
 Font_Select_12x24_24x24();
 Goto_Text_XY(80,350);
 Show_String("Pattern Fill");

 Background_color_65k(0xf800);
 BTE_S1_Window_Start_XY(0,0);
    BTE_Destination_Window_Start_XY(80+300+40,40);
    BTE_Window_Size(300,300);
 BTE_Operation_Code(0x07);

 BTE_Enable();
    Check_BTE_Busy();

 Foreground_color_65k(0x0000);
 Background_color_65k(0xFFFF);
 CGROM_Select_Internal_CGROM();
 Font_Select_12x24_24x24();
 Goto_Text_XY(80+300+40,350);
 Show_String("Pattern Fill With");

 Foreground_color_65k(0x0000);
 Background_color_65k(0xFFFF);
 CGROM_Select_Internal_CGROM();
 Font_Select_12x24_24x24();
 Goto_Text_XY(80+300+40,374);
 Show_String("Chroma Key");
    delay_ms(1000);
   NextStep();
}


void PIP_Demo(void)
{ unsigned long i;
   unsigned long im=1;

 Select_Main_Window_16bpp();
 Main_Image_Start_Address(0);
 Main_Image_Width(1024);
 Main_Window_Start_XY(0,0);

 Canvas_Image_Start_address(0);
 Canvas_image_width(1024);
    Active_Window_XY(0,0);
 Active_Window_WH(1024,600);

  Foreground_color_65k(0xFFFF);
 Line_Start_XY(0,0);
 Line_End_XY(1023,575);
 Start_Square_Fill();

 Foreground_color_65k(0x051F);
 Line_Start_XY(0,576);
 Line_End_XY(1023,599);
 Start_Square_Fill();

 Foreground_color_65k(0xFFFF);
 Background_color_65k(0x051F);
 CGROM_Select_Internal_CGROM();
 Font_Select_12x24_24x24();
 Goto_Text_XY(0,576);
 Show_String("                    Demo PIP");


  Memory_16bpp_Mode();
  delay_ms(20);
  Canvas_Image_Start_address(1228800);
  Canvas_image_width(1024);
     Active_Window_XY(0,0);
  Active_Window_WH(320,240);
     Goto_Pixel_XY(0,0);
  LCD_CmdWrite(0x04);
  for(i=0;i<76800;i++)
  {
   LCD_DataWrite(0x001f);
   LCD_DataWrite(0x001f>>8);

   }
   Check_Mem_WR_FIFO_Empty();


 Foreground_color_65k(0xFFFF);
 Background_color_65k(0x001f);
 CGROM_Select_Internal_CGROM();
 Font_Select_12x24_24x24();
 Goto_Text_XY(120,120);
 Show_String("PIP1");




 Canvas_Image_Start_address(2457600);
 Canvas_image_width(1024);
    Active_Window_XY(0,0);
 Active_Window_WH(320,240);
    Goto_Pixel_XY(0,0);
 LCD_CmdWrite(0x04);
 for(i=0;i<76800;i++)
 {
  LCD_DataWrite(0xf800);
   LCD_DataWrite(0xf800>>8);

  }
 Check_Mem_WR_FIFO_Empty();

 Foreground_color_65k(0xFFFF);
 Background_color_65k(0xf800);
 CGROM_Select_Internal_CGROM();
 Font_Select_12x24_24x24();
 Goto_Text_XY(120,120);
 Show_String("PIP2");



  Select_PIP1_Window_16bpp();
 Select_PIP1_Parameter();
 PIP_Image_Start_Address(1228800);
 PIP_Image_Width(1024);
 PIP_Window_Width_Height(320,240);
 PIP_Window_Image_Start_XY(0,0);
 PIP_Display_Start_XY(80,40);
 Enable_PIP1();
 delay_ms(50);


    Select_PIP2_Window_16bpp();
 Select_PIP2_Parameter();
 PIP_Image_Start_Address(2457600);
 PIP_Image_Width(1024);
 PIP_Window_Width_Height(320,240);
 PIP_Window_Image_Start_XY(0,0);
 PIP_Display_Start_XY(80+320,40+240);
 Enable_PIP2();
 delay_ms(50);


     for(i=0;i<160;i++)
  {
   Select_PIP1_Parameter();
   PIP_Display_Start_XY(80+i,40+i);

   delay_ms(1);
   Select_PIP2_Parameter();
   PIP_Display_Start_XY(80+320-i,40+240-i);

   delay_ms(10);
  }

  for(i=0;i<160;i++)
  {
   Select_PIP1_Parameter();
   PIP_Display_Start_XY(80+159-i,40+159-i);

   delay_ms(1);
   Select_PIP2_Parameter();
   PIP_Display_Start_XY(80+320-159+i,40+240-159+i);

   delay_ms(10);
   }

   delay_ms(2000);



 Enable_SFlash_SPI();
    Select_SFI_1();
    Select_SFI_DMA_Mode();
    Select_SFI_24bit_Address();


    Select_SFI_Waveform_Mode_3();


    Select_SFI_8_DummyRead();



    Select_SFI_Single_Mode();



    SPI_Clock_Period(0);

 Canvas_Image_Start_address(1228800);
 Canvas_image_width(1024);

 SFI_DMA_Destination_Upper_Left_Corner(0,0);
    SFI_DMA_Transfer_Width_Height(320,240);
    SFI_DMA_Source_Width(1024);
 SFI_DMA_Source_Start_Address(0);
 Start_SFI_DMA();
    Check_Busy_SFI_DMA();

    Canvas_Image_Start_address(2457600);
 Canvas_image_width(1024);

 SFI_DMA_Destination_Upper_Left_Corner(0,0);
    SFI_DMA_Transfer_Width_Height(320,240);
    SFI_DMA_Source_Width(1024);
 SFI_DMA_Source_Start_Address(im*1024*600*2*2);
 Start_SFI_DMA();
    Check_Busy_SFI_DMA();


  for(i=0;i<160;i++)
  {
   Select_PIP1_Parameter();
   PIP_Display_Start_XY(80+i,40+i);

   delay_ms(1);
   Select_PIP2_Parameter();
   PIP_Display_Start_XY(80+320-i,40+240-i);

   delay_ms(10);
  }

  for(i=0;i<160;i++)
  {
   Select_PIP1_Parameter();
   PIP_Display_Start_XY(80+159-i,40+159-i);

   delay_ms(1);
   Select_PIP2_Parameter();
   PIP_Display_Start_XY(80+320-159+i,40+240-159+i);

   delay_ms(10);
   }

   delay_ms(1000);
  NextStep();

   Disable_PIP1();
   Disable_PIP2();

}


void App_Demo_Waveform(void)
{
    unsigned int i,h;

 unsigned int point1y,point2y;
 unsigned int point21y,point22y;
 unsigned int point31y,point32y;
 point2y = 0;
 point22y = 0;
 point32y = 0;





 Select_Main_Window_16bpp();
 Main_Image_Start_Address(0);
 Main_Image_Width(1024);
 Main_Window_Start_XY(0,0);

  Canvas_Image_Start_address(0);
 Canvas_image_width(1024);
    Active_Window_XY(0,0);
 Active_Window_WH(1024,600);

  Foreground_color_65k(0x001F);
 Line_Start_XY(0,0);
 Line_End_XY(1023,575);
 Start_Square_Fill();

 Foreground_color_65k(0x051F);
 Line_Start_XY(0,576);
 Line_End_XY(1023,599);
 Start_Square_Fill();


  Foreground_color_65k(0xFFFF);
 Background_color_65k(0x051F);
 CGROM_Select_Internal_CGROM();
 Font_Select_12x24_24x24();
 Goto_Text_XY(0,576);
 Show_String("           Application Demo Waveform");


  Foreground_color_65k(0xFFFF);
 Background_color_65k(0x001F);
 CGROM_Select_Internal_CGROM();
 Font_Select_12x24_24x24();
 Goto_Text_XY(0,528);
 Show_String("BTE memory copy + Geometric draw demo waveform");


 Canvas_Image_Start_address(1228800);



    Foreground_color_65k(0x0000);
 Line_Start_XY(0,0);
 Line_End_XY(1023,599);
 Start_Square_Fill();

    for(i=0;i<=601;i+=50)
 {
  Foreground_color_65k(2113*12);
  Line_Start_XY(i,0);
     Line_End_XY(i,401 -1);
  Start_Line();
 }

  for(i=0;i<=401;i+=50)
 {
  Foreground_color_65k(2113*12);
  Line_Start_XY(0,i);
     Line_End_XY(601 -1,i);
  Start_Line();
 }


    BTE_S0_Color_16bpp();
       BTE_S0_Memory_Start_Address(1228800);
       BTE_S0_Image_Width(1024);
       BTE_S0_Window_Start_XY(0,0);






       BTE_Destination_Color_16bpp();
       BTE_Destination_Memory_Start_Address(0);
       BTE_Destination_Image_Width(1024);
       BTE_Destination_Window_Start_XY(100,40);
       BTE_Window_Size(601,401);


       BTE_ROP_Code(12);
       BTE_Operation_Code(2);
       BTE_Enable();
       Check_BTE_Busy();


    Canvas_Image_Start_address(0);

  h=0;
 do{
     for(i=0;i<600;i+=2)
    {

   BTE_S0_Window_Start_XY(i,0);

   BTE_Destination_Window_Start_XY(100+i,40);
         BTE_Window_Size(2,401);
   BTE_Enable();
         Check_BTE_Busy();


   point1y = point2y;
         point2y = rand()%90;

   point21y = point22y;
         point22y = rand()%99;

   point31y = point32y;
         point32y = rand()%67;

   Foreground_color_65k(0xf800|0x07e0);
   Line_Start_XY(i+100,point1y+80);
   Line_End_XY(i+1+100,point2y+80);
      Start_Line();

   Foreground_color_65k(0xf800|0x001f);
   Line_Start_XY(i+100,point21y+200);
   Line_End_XY(i+1+100,point22y+200);
      Start_Line();

   Foreground_color_65k(0x07e0);
   Line_Start_XY(i+100,point31y+300);
   Line_End_XY(i+1+100,point32y+300);
      Start_Line();


     }

    h++;
   }
  while(h<10);

   NextStep();

}


void App_Demo_Scrolling_Text(void)
{
    unsigned int i;



  Select_Main_Window_16bpp();
 Main_Image_Start_Address(0);
 Main_Image_Width(1024);
 Main_Window_Start_XY(0,0);

 Canvas_Image_Start_address(1228800);
 Canvas_image_width(1024);
    Active_Window_XY(0,0);
 Active_Window_WH(1024,600);

  Foreground_color_65k(0x0000);
 Line_Start_XY(0,0);
 Line_End_XY(1023,575);
 Start_Square_Fill();

 Foreground_color_65k(0x051F);
 Line_Start_XY(0,576);
 Line_End_XY(1023,599);
 Start_Square_Fill();




 Foreground_color_65k(0xFFFF);
 Background_color_65k(0x051F);
 CGROM_Select_Internal_CGROM();
 Font_Select_12x24_24x24();
 Goto_Text_XY(0,576);
 Show_String("               Demo Scrolling Text");
 Foreground_color_65k(0xFFFF);
 Background_color_65k(0x0000);
 Font_Select_12x24_24x24();
 Goto_Text_XY(0,552);
 Show_String("Used Move BTE with Chroma Key ");




 Enable_SFlash_SPI();
    Select_SFI_1();
    Select_SFI_DMA_Mode();
    Select_SFI_24bit_Address();


    Select_SFI_Waveform_Mode_3();


    Select_SFI_8_DummyRead();



    Select_SFI_Single_Mode();



    SPI_Clock_Period(0);


 SFI_DMA_Destination_Upper_Left_Corner(0,40);
    SFI_DMA_Transfer_Width_Height(1024,480);
    SFI_DMA_Source_Width(1024);
 SFI_DMA_Source_Start_Address(0);
 Start_SFI_DMA();
    Check_Busy_SFI_DMA();



    BTE_S0_Color_16bpp();
       BTE_S0_Memory_Start_Address(1228800);
       BTE_S0_Image_Width(1024);
       BTE_S0_Window_Start_XY(0,0);






       BTE_Destination_Color_16bpp();
       BTE_Destination_Memory_Start_Address(0);
       BTE_Destination_Image_Width(1024);
       BTE_Destination_Window_Start_XY(0,0);
       BTE_Window_Size(1024,600);

       BTE_ROP_Code(12);
       BTE_Operation_Code(2);
       BTE_Enable();
       Check_BTE_Busy();



   Canvas_Image_Start_address(2457600);
   Canvas_image_width(1024);
      Active_Window_XY(0,0);
   Active_Window_WH(1024,600);

   Foreground_color_65k(0xF800);
   Line_Start_XY(0,0);
   Line_End_XY(1023,599);
   Start_Square_Fill();

 Foreground_color_65k(0x07E0);
 Background_color_65k(0xF800);
 CGROM_Select_Internal_CGROM();
 Font_Select_12x24_24x24();
 Goto_Text_XY(0,0);
 Show_String("Demo Scrolling Text");

 Foreground_color_65k(0xFFE0);
 Background_color_65k(0xF800);
 Goto_Text_XY(0,24);
 Show_String("Demo Scrolling Text");
 Foreground_color_65k(0xF81F);
 Background_color_65k(0xF800);
 Goto_Text_XY(0,48);
 Show_String("Demo Scrolling Text");
 Foreground_color_65k(0xF7DE);
 Background_color_65k(0xF800);
 Goto_Text_XY(0,72);
 Show_String("Demo Scrolling Text");





   for(i=0;i<200;i+=8)
   {
     Canvas_Image_Start_address(1228800);
     Canvas_image_width(1024);
        Active_Window_XY(0,0);
     Active_Window_WH(1024,600);

       Foreground_color_65k(0x0000);
      Line_Start_XY(0,0);
      Line_End_XY(1023,520);
      Start_Square_Fill();

   SFI_DMA_Destination_Upper_Left_Corner(0,40);
         SFI_DMA_Transfer_Width_Height(1024,480);
         SFI_DMA_Source_Width(1024);
      SFI_DMA_Source_Start_Address(0);
      Start_SFI_DMA();
         Check_Busy_SFI_DMA();



       BTE_S0_Memory_Start_Address(2457600);
       BTE_S0_Image_Width(1024);
       BTE_S0_Window_Start_XY(0,0);







       BTE_Destination_Memory_Start_Address(1228800);
       BTE_Destination_Image_Width(1024);
       BTE_Destination_Window_Start_XY(1015-i,72);
       BTE_Window_Size(0+i,24*4);

    Background_color_65k(0xF800);

       BTE_ROP_Code(12);
       BTE_Operation_Code(5);
       BTE_Enable();
       Check_BTE_Busy();
# 1127 "./8876demo.h"
       BTE_S0_Memory_Start_Address(1228800);
       BTE_S0_Image_Width(1024);
       BTE_S0_Window_Start_XY(0,0);


       BTE_Destination_Memory_Start_Address(0);
       BTE_Destination_Image_Width(1024);
       BTE_Destination_Window_Start_XY(0,0);
       BTE_Window_Size(1024,600);

       BTE_ROP_Code(12);
       BTE_Operation_Code(2);
       BTE_Enable();
       Check_BTE_Busy();
   }

   for(i=0;i<100;i+=8)
   {
     Canvas_Image_Start_address(1228800);
     Canvas_image_width(1024);
        Active_Window_XY(0,0);
     Active_Window_WH(1024,600);

       Foreground_color_65k(0x0000);
      Line_Start_XY(0,0);
      Line_End_XY(1023,520);
      Start_Square_Fill();

   SFI_DMA_Destination_Upper_Left_Corner(0,40);
         SFI_DMA_Transfer_Width_Height(1024,480);
         SFI_DMA_Source_Width(1024);
      SFI_DMA_Source_Start_Address(1228800);
      Start_SFI_DMA();
         Check_Busy_SFI_DMA();



       BTE_S0_Memory_Start_Address(2457600);
       BTE_S0_Image_Width(1024);
       BTE_S0_Window_Start_XY(i,0);







       BTE_Destination_Memory_Start_Address(1228800);
       BTE_Destination_Image_Width(1024);
       BTE_Destination_Window_Start_XY(0,72);
       BTE_Window_Size(1023-i,24*4);

    Background_color_65k(0xF800);

       BTE_ROP_Code(12);
       BTE_Operation_Code(5);
       BTE_Enable();
       Check_BTE_Busy();
# 1194 "./8876demo.h"
       BTE_S0_Memory_Start_Address(1228800);
       BTE_S0_Image_Width(1024);
       BTE_S0_Window_Start_XY(0,0);


       BTE_Destination_Memory_Start_Address(0);
       BTE_Destination_Image_Width(1024);
       BTE_Destination_Window_Start_XY(0,0);
       BTE_Window_Size(1024,600);

       BTE_ROP_Code(12);
       BTE_Operation_Code(2);
       BTE_Enable();
       Check_BTE_Busy();
   }

    NextStep();

}



void App_Demo_multi_frame_buffer(void)
{ unsigned int i,j;
      unsigned long im=1;
    Select_Main_Window_16bpp();
 Main_Image_Start_Address(0);
 Main_Image_Width(1024);
 Main_Window_Start_XY(0,0);


 Enable_SFlash_SPI();
    Select_SFI_1();
    Select_SFI_DMA_Mode();
    Select_SFI_24bit_Address();


    Select_SFI_Waveform_Mode_3();


    Select_SFI_8_DummyRead();



    Select_SFI_Single_Mode();



    SPI_Clock_Period(0);

 SFI_DMA_Destination_Upper_Left_Corner(180,40);
    SFI_DMA_Transfer_Width_Height(640,480);
    SFI_DMA_Source_Width(1024);


 for(i=0;i<6;i++)
  {

 Canvas_Image_Start_address(im*1024*600*2*i);
 Canvas_image_width(1024);
    Active_Window_XY(0,0);
 Active_Window_WH(1024,600);

  Foreground_color_65k(0x0000);
 Line_Start_XY(0,0);
 Line_End_XY(1024,575);
 Start_Square_Fill();

 Foreground_color_65k(0x051F);
 Line_Start_XY(0,576);
 Line_End_XY(1023,599);
 Start_Square_Fill();


 Foreground_color_65k(0xFFFF);
 Background_color_65k(0x051F);
 CGROM_Select_Internal_CGROM();
 Font_Select_12x24_24x24();
 Goto_Text_XY(0,576);
 Show_String("             Demo Multi Frame Buffer");





   SFI_DMA_Source_Start_Address(im*640*480*2*i);
   Start_SFI_DMA();
      Check_Busy_SFI_DMA();

   delay_ms(50);
   Main_Image_Width(1024);
      Main_Window_Start_XY(0,0);
   Main_Image_Start_Address(im*1024*600*2*i);
  }




    Select_Main_Window_16bpp();
 Main_Image_Start_Address(0);
 Main_Image_Width(8188);
 Main_Window_Start_XY(0,0);
 Canvas_Image_Start_address(0);
 Canvas_image_width(8188);
 Active_Window_XY(0,0);
 Active_Window_WH(8188,600);

 for(im=0;im<6;im++)
    {
 Canvas_Image_Start_address(0);

  Foreground_color_65k(0x0000);
 Line_Start_XY(0+im*1024,0);
 Line_End_XY(1023+im*1024,575);
 Start_Square_Fill();

 Foreground_color_65k(0x051F);
 Line_Start_XY(0+im*1024,576);
 Line_End_XY(1023+im*1024,599);
 Start_Square_Fill();


    SFI_DMA_Destination_Upper_Left_Corner(80+im*1024,40);
 SFI_DMA_Source_Start_Address(im*640*480*2);
 Start_SFI_DMA();
    Check_Busy_SFI_DMA();


 Foreground_color_65k(0xFFFF);
 Background_color_65k(0x051F);
 CGROM_Select_Internal_CGROM();
 Font_Select_12x24_24x24();
 Goto_Text_XY(i*1024,576);
 Show_String("             Demo Mulit Frame Buffer");

 }


   for(j=0;j<5;j++)
   {
 for(i=0;i<1024;i++)
 {
  Main_Window_Start_XY(i+j*1024,0);
  delay_ms(1);
 }
    delay_ms(300);
   }

   for(j=5;j>0;j--)
   {
 for(i=0;i<1024;i++)
 {
  Main_Window_Start_XY(j*1024-i,0);
  delay_ms(5);
 }

   }

   delay_ms(500);

      NextStep();
}



void App_Demo_slide_frame_buffer(void)
{ unsigned long im=1;
     unsigned int i,j;

    Select_Main_Window_16bpp();
 Main_Image_Start_Address(0);
 Main_Image_Width(1024);
 Main_Window_Start_XY(0,0);


 Enable_SFlash_SPI();
    Select_SFI_1();
    Select_SFI_DMA_Mode();
    Select_SFI_24bit_Address();


    Select_SFI_Waveform_Mode_3();


    Select_SFI_8_DummyRead();



    Select_SFI_Single_Mode();



    SPI_Clock_Period(0);

 SFI_DMA_Destination_Upper_Left_Corner(0,0);
    SFI_DMA_Transfer_Width_Height(1024,600);
    SFI_DMA_Source_Width(1024);





    Select_Main_Window_16bpp();
 Main_Image_Start_Address(0);
 Main_Image_Width(2048);
 Main_Window_Start_XY(0,0);
 Canvas_Image_Start_address(0);
 Canvas_image_width(2048);
 Active_Window_XY(0,0);
 Active_Window_WH(2048,1200);

 Canvas_Image_Start_address(0);

  Foreground_color_65k(0x0000);
 Line_Start_XY(0,0);
 Line_End_XY(2047,1199);
 Start_Square_Fill();

    SFI_DMA_Destination_Upper_Left_Corner(0,0);
 SFI_DMA_Source_Start_Address(0);
 Start_SFI_DMA();
    Check_Busy_SFI_DMA();

    SFI_DMA_Destination_Upper_Left_Corner(1024,0);
 SFI_DMA_Source_Start_Address(im*1024*600*2);
 Start_SFI_DMA();
    Check_Busy_SFI_DMA();

 SFI_DMA_Destination_Upper_Left_Corner(0,600);
 SFI_DMA_Source_Start_Address(im*1024*600*4);
 Start_SFI_DMA();
    Check_Busy_SFI_DMA();

 SFI_DMA_Destination_Upper_Left_Corner(1024,600);
 SFI_DMA_Source_Start_Address(im*1024*600*6);
 Start_SFI_DMA();
    Check_Busy_SFI_DMA();


 Foreground_color_65k(0xFFFF);
 Background_color_65k(0x051F);
 CGROM_Select_Internal_CGROM();
 Font_Select_12x24_24x24();
 Goto_Text_XY(0*1024,576);
 Show_String("             Demo slide Buffer");




 for(i=0;i<2048-1024+1;i++)
 {
  Main_Window_Start_XY(i,0);
  delay_ms(5);
 }
    delay_ms(1);

 for(j=0;j<1200-600+1;j++)
 {
  Main_Window_Start_XY(1024,j);
  delay_ms(5);
 }
 delay_ms(1);


 for(i=2048-1024;i>0;i--)
 {
  Main_Window_Start_XY(i,600);
  delay_ms(5);
 }
 Main_Window_Start_XY(0,600);
 delay_ms(1);
    delay_ms(5);

 for(j=1200-600;j>0;j--)
 {
  Main_Window_Start_XY(0,j);
  delay_ms(5);
 }
 Main_Window_Start_XY(0,0);
 delay_ms(5);
 delay_ms(1);

   NextStep();
}


void App_Demo_Alpha_Blending(void)
{ unsigned long im=1;
     unsigned int i,j;

    Select_Main_Window_16bpp();
 Main_Image_Start_Address(0);
 Main_Image_Width(1024);
 Main_Window_Start_XY(0,0);

 Canvas_Image_Start_address(0);
 Canvas_image_width(1024);
    Active_Window_XY(0,0);
 Active_Window_WH(1024,600);

  Foreground_color_65k(0x0000);
 Line_Start_XY(0,0);
 Line_End_XY(1023,575);
 Start_Square_Fill();

 Foreground_color_65k(0x051F);
 Line_Start_XY(0,576);
 Line_End_XY(1023,599);
 Start_Square_Fill();


 Foreground_color_65k(0xFFFF);
 Background_color_65k(0x051F);
 CGROM_Select_Internal_CGROM();
 Font_Select_12x24_24x24();
 Goto_Text_XY(0,576);
 Show_String("               Demo Alpha Blending");
 Foreground_color_65k(0xFFFF);
 Background_color_65k(0x0000);
 Font_Select_12x24_24x24();
 Goto_Text_XY(0,552);
 Show_String("Fade in and fade out");


 Enable_SFlash_SPI();
    Select_SFI_1();
    Select_SFI_DMA_Mode();
    Select_SFI_24bit_Address();


    Select_SFI_Waveform_Mode_3();


    Select_SFI_8_DummyRead();



    Select_SFI_Single_Mode();



 SPI_Clock_Period(0);



 Canvas_Image_Start_address(1228800);
    Foreground_color_65k(0x0000);
 Line_Start_XY(0,0);
 Line_End_XY(1023,599);
 Start_Square_Fill();


 SFI_DMA_Destination_Upper_Left_Corner(80,40);
    SFI_DMA_Transfer_Width_Height(640,480);
    SFI_DMA_Source_Width(1024);
 SFI_DMA_Source_Start_Address(0);
 Start_SFI_DMA();
    Check_Busy_SFI_DMA();



 Canvas_Image_Start_address(2457600);
    Foreground_color_65k(0x0000);
 Line_Start_XY(0,0);
 Line_End_XY(1023,599);
 Start_Square_Fill();


 SFI_DMA_Destination_Upper_Left_Corner(80,40);
    SFI_DMA_Transfer_Width_Height(640,480);
    SFI_DMA_Source_Width(1024);
 SFI_DMA_Source_Start_Address(im*1024*600*2);
 Start_SFI_DMA();
    Check_Busy_SFI_DMA();


  BTE_Destination_Color_16bpp();
     BTE_Destination_Memory_Start_Address(0);
     BTE_Destination_Image_Width(1024);
     BTE_Destination_Window_Start_XY(0,0);
     BTE_Window_Size(1024,520);

     BTE_S0_Color_16bpp();
     BTE_S0_Memory_Start_Address(1228800);
     BTE_S0_Image_Width(1024);
     BTE_S0_Window_Start_XY(0,0);

     BTE_S1_Color_16bpp();
     BTE_S1_Memory_Start_Address(2457600);
     BTE_S1_Image_Width(1024);
     BTE_S1_Window_Start_XY(0,0);


 BTE_ROP_Code(15);
    BTE_Operation_Code(10);

  for(j=0;j<6;j+=2)
  {

 Canvas_Image_Start_address(1228800);
    SFI_DMA_Destination_Upper_Left_Corner(80,40);
    SFI_DMA_Transfer_Width_Height(640,480);
    SFI_DMA_Source_Width(1024);
 SFI_DMA_Source_Start_Address(im*j*640*480*2);
 Start_SFI_DMA();
    Check_Busy_SFI_DMA();

 Canvas_Image_Start_address(2457600);
 SFI_DMA_Source_Start_Address(im*(j+1)*640*480*2);
 Start_SFI_DMA();
    Check_Busy_SFI_DMA();

    for(i=0;i<32;i++)
    {
  BTE_Alpha_Blending_Effect(i);
  BTE_Enable();
  delay_ms(200);
    }

    for(i=32;i>0;i--)
    {
  BTE_Alpha_Blending_Effect(i);
  BTE_Enable();
  delay_ms(200);
    }
   }

  NextStep();

}

void mono_Demo(void)
{

 Select_Main_Window_16bpp();
 Main_Image_Start_Address(0);
 Main_Image_Width(1024);
 Main_Window_Start_XY(0,0);

    Canvas_Image_Start_address(0);
 Canvas_image_width(1024);
    Active_Window_XY(0,0);
 Active_Window_WH(1024,600);






 Foreground_color_65k(0xF800);
 Line_Start_XY(0,0);
 Line_End_XY(1023,599);
 Start_Square_Fill();
 NextStep();
 Foreground_color_65k(0x07E0);
 Line_Start_XY(0,0);
 Line_End_XY(1023,599);
 Start_Square_Fill();
 NextStep();
  Foreground_color_65k(0x001F);
 Line_Start_XY(0,0);
 Line_End_XY(1023,599);
 Start_Square_Fill();
 NextStep();
 Foreground_color_65k(0x7FFF);
 Line_Start_XY(0,0);
 Line_End_XY(1023,599);
 Start_Square_Fill();
 NextStep();
 Foreground_color_65k(0xFFE0);
 Line_Start_XY(0,0);
 Line_End_XY(1023,599);
 Start_Square_Fill();
 NextStep();
   Foreground_color_65k(0xF81F);
 Line_Start_XY(0,0);
 Line_End_XY(1023,599);
 Start_Square_Fill();
 NextStep();
  Foreground_color_65k(0xFFFF);
 Line_Start_XY(0,0);
 Line_End_XY(1023,599);
 Start_Square_Fill();
 NextStep();
   Foreground_color_65k(0x0000);
 Line_Start_XY(0,0);
 Line_End_XY(1023,599);
 Start_Square_Fill();
 NextStep();
}


void Text_Demo(void)
{
    unsigned int i,j;
 Select_Main_Window_16bpp();
 Main_Image_Start_Address(0);
 Main_Image_Width(1024);
 Main_Window_Start_XY(0,0);

    Canvas_Image_Start_address(0);
 Canvas_image_width(1024);
    Active_Window_XY(0,0);
 Active_Window_WH(1024,600);







  Foreground_color_65k(0xFFFF);
 Line_Start_XY(0,0);
 Line_End_XY(1023,575);
 Start_Square_Fill();

 Foreground_color_65k(0x051F);
 Line_Start_XY(0,576);
 Line_End_XY(1023,599);
 Start_Square_Fill();


 LCD_DisplayString(0,24 ,"EastRising Technology",0x051F,0xFFFF);
 Foreground_color_65k(0xFFFF);
 Background_color_65k(0x051F);
 CGROM_Select_Internal_CGROM();
 Font_Select_12x24_24x24();
  Goto_Text_XY(0,72);
 Show_String("www.buydisplay.ocm");
 Foreground_color_65k(0x051F);
 Background_color_65k(0xFFFF);
 Goto_Text_XY(0,120);
 Show_String("10.1 inch TFT Module  1024*600 Dots");

 NextStep();


  Foreground_color_65k(0xFFFF);
 Line_Start_XY(0,0);
 Line_End_XY(1023,599);
 Start_Square_Fill();


 Foreground_color_65k(0x0000);
 Background_color_65k(0xFFFF);
 CGROM_Select_Internal_CGROM();
 Font_Select_8x16_16x16();
 Goto_Text_XY(0,10);
 Show_String("Embedded 8x16 ASCII Character");

 Font_Select_12x24_24x24();
 Goto_Text_XY(0,26);
 Show_String("Embedded 12x24 ASCII Character");

 Font_Select_16x32_32x32();
 Goto_Text_XY(0,50);
 Show_String("Embedded 16x32 ASCII Character");
# 1766 "./8876demo.h"
 Font_Select_8x16_16x16();
 Font_Width_X1();
 Font_Height_X1();
 Goto_Text_XY(0,100);
 Show_String("Supporting Genitop Inc. UNICODE/BIG5/GB etc. Serial Character ROM with 16x16/24x24/32X32 dots Font.");
 Goto_Text_XY(0,116);
 Show_String("The supporting product numbers are GT21L16TW/GT21H16T1W, GT23L16U2W, GT23L24T3Y/GT23H24T3Y, GT23L24M1Z, and GT23L32S4W/GT23H32S4W, GT23L24F6Y, GT23L24S1W.");
# 1781 "./8876demo.h"
        CGROM_Select_Genitop_FontROM();



     GTFont_Select_GT23L24T3Y_GT23H24T3Y();
# 1794 "./8876demo.h"
   Font_Width_X1();
      Font_Height_X1();
   CGROM_Select_Genitop_FontROM();
      Font_Select_12x24_24x24();
   Select_SFI_0();
      Select_SFI_Font_Mode();
      Select_SFI_24bit_Address();
      Select_SFI_Waveform_Mode_0();
      Select_SFI_0_DummyRead();
      Select_SFI_Single_Mode();
      SPI_Clock_Period(4);

   Enable_SFlash_SPI();

   Foreground_color_65k(0x07e0);
   Background_color_65k(0x001f);

   Set_GTFont_Decoder(0x11);

   Goto_Text_XY(0,160);
      Show_String("Demo GT23L24T3Y BIG5:");
   Font_Select_8x16_16x16();
   Goto_Text_XY(0,190);
      Show_String("栋硄いゅ羉砰16x16:RA8876 TFT 瓜北竟");
   Font_Select_12x24_24x24();
   Goto_Text_XY(0,214);
      Show_String("栋硄いゅ羉砰24x24:RA8876 TFT 瓜北竟");


   Foreground_color_65k(0xf800|0x001f);
   Background_color_65k(0xf800|0x07e0);
   Set_GTFont_Decoder(0x01);
   Goto_Text_XY(0,246);
      Show_String("Demo GT23L24T3Y GB2312:");
   Font_Select_8x16_16x16();
   Goto_Text_XY(0,276);
      Show_String("集通中文简体16x16:RA8876 TFT 图形控制器");
   Font_Select_12x24_24x24();
   Goto_Text_XY(0,300);
      Show_String("集通中文简体16x16:RA8876 TFT 图形控制器");

   Set_GTFont_Decoder(0x11);


   Foreground_color_65k(0x0000);
   Font_Background_select_Transparency();


   Active_Window_XY(0,330);
   Active_Window_WH(80,80);
   Goto_Pixel_XY(0,330);
   Show_picture(80*80,pic_80x80);
   Active_Window_XY(0,0);
   Active_Window_WH(1024,600);

   Goto_Text_XY(0,330);
      Show_String("Demo text transparent write");
   Goto_Text_XY(0,354);
      Show_String("璉春硓糶");



   Font_Background_select_Color();
   Foreground_color_65k(0x0000);
   Background_color_65k(0xffff);

   Goto_Text_XY(0,430);
      Show_String("Demo text cursor:");

   Goto_Text_XY(0,454);
   Show_String("0123456789");
   Text_cursor_initial();
  delay_ms(1000);

   for(i=0;i<14;i++)
   {
    delay_ms(100);
    Text_Cursor_H_V(1+i,15-i);
   }
     delay_ms(2000);

   Disable_Text_Cursor();

   CGROM_Select_Internal_CGROM();
   Font_Select_8x16_16x16();

   Foreground_color_65k(0x001f);
   Goto_Text_XY(0,484);
      Show_String("Demo graphic cursor:");

   Set_Graphic_Cursor_Color_1(0xff);
      Set_Graphic_Cursor_Color_2(0x00);

   Graphic_cursor_initial();
   Graphic_Cursor_XY(0,508);
   Select_Graphic_Cursor_1();
     delay_ms(2000);
   Select_Graphic_Cursor_2();
   delay_ms(2000);
   Select_Graphic_Cursor_3();
   delay_ms(2000);
   Select_Graphic_Cursor_4();
   delay_ms(2000);
   Select_Graphic_Cursor_2();

   for(j=0;j<2;j++)
   {
    for(i=0;i<1024;i++)
    {
     Graphic_Cursor_XY(i,508+j*20);
  delay_ms(2);
    }
   }
    Graphic_Cursor_XY(0,508);

  delay_ms(2000);
  Disable_Graphic_Cursor();

 NextStep();


 }


 void DMA_Demo(void)
{
  unsigned long i;



  Select_Main_Window_16bpp();
 Main_Image_Start_Address(0);
 Main_Image_Width(1024);
 Main_Window_Start_XY(0,0);

 Canvas_Image_Start_address(0);
 Canvas_image_width(1024);
    Active_Window_XY(0,0);
 Active_Window_WH(1024,600);

  Foreground_color_65k(0xFFFF);
 Line_Start_XY(0,0);
 Line_End_XY(1023,575);
 Start_Square_Fill();

 Foreground_color_65k(0x051F);
 Line_Start_XY(0,576);
 Line_End_XY(1023,599);
 Start_Square_Fill();







  Foreground_color_65k(0xFFFF);
 Background_color_65k(0x051F);
 CGROM_Select_Internal_CGROM();
 Font_Select_12x24_24x24();
 Goto_Text_XY(0,576);
 Show_String("                    Demo DMA");
 Foreground_color_65k(0x0000);
 Background_color_65k(0xFFFF);
 Font_Select_12x24_24x24();
 Goto_Text_XY(0,552);
 Show_String("  Demo direct access serial FLASH to show picture");


 Enable_SFlash_SPI();
    Select_SFI_1();
    Select_SFI_DMA_Mode();
    Select_SFI_24bit_Address();


    Select_SFI_Waveform_Mode_3();


    Select_SFI_8_DummyRead();



    Select_SFI_Single_Mode();



    SPI_Clock_Period(0);
# 2014 "./8876demo.h"
 SFI_DMA_Destination_Upper_Left_Corner(0,0);
    SFI_DMA_Transfer_Width_Height(1024,600);
    SFI_DMA_Source_Width(1024);


  for(i=0;i<4;i++)
  {
   SFI_DMA_Source_Start_Address(i*1024*600*2);
   Start_SFI_DMA();
      Check_Busy_SFI_DMA();
   delay_ms(30);
  NextStep();
  }
}

 void Geometric(void)
{unsigned int i;
  Select_Main_Window_16bpp();
 Main_Image_Start_Address(0);
 Main_Image_Width(1024);
 Main_Window_Start_XY(0,0);

 Canvas_Image_Start_address(0);
 Canvas_image_width(1024);
    Active_Window_XY(0,0);
 Active_Window_WH(1024,600);





    Foreground_color_65k(0x0000);
 Line_Start_XY(0,0);
 Line_End_XY(1023,599);
 Start_Square_Fill();

   for(i=0;i<=280;i+=8)
 {Foreground_color_65k(0xF800);
 Line_Start_XY(0+i,0+i);
 Line_End_XY(1023-i,599-i);
 Start_Square();
 delay_ms(30);
 }

    for(i=0;i<=280;i+=8)
 {Foreground_color_65k(0x0000);
 Line_Start_XY(0+i,0+i);
 Line_End_XY(1023-i,599-i);
 Start_Square();
 delay_ms(30);
 }
    delay_ms(500);

    Foreground_color_65k(0x0000);
 Line_Start_XY(0,0);
 Line_End_XY(1023,599);
 Start_Square_Fill();

   for(i=0;i<=280;i+=8)
 {Foreground_color_65k(0x07E0);
 Line_Start_XY(0+i,0+i);
 Line_End_XY(1023-i,599-i);
 Circle_Square_Radius_RxRy(10,10);
 Start_Circle_Square();
 delay_ms(30);
 }

    for(i=0;i<=280;i+=8)
 {Foreground_color_65k(0x0000);
 Line_Start_XY(0+i,0+i);
 Line_End_XY(1023-i,599-i);
 Circle_Square_Radius_RxRy(10,10);
 Start_Circle_Square();
 delay_ms(30);
 }
    delay_ms(500);


   Foreground_color_65k(0x0000);
 Line_Start_XY(0,0);
 Line_End_XY(1023,599);
 Start_Square_Fill();

   for(i=0;i<=300;i+=8)
 {Foreground_color_65k(0x001F);
 Circle_Center_XY(1024/2,600/2);
 Circle_Radius_R(i);
 Start_Circle_or_Ellipse();
 delay_ms(30);
 }

    for(i=0;i<=300;i+=8)
 {Foreground_color_65k(0x0000);
 Circle_Center_XY(1024/2,600/2);
 Circle_Radius_R(i);
 Start_Circle_or_Ellipse();
 delay_ms(30);
 }
    delay_ms(500);


   Foreground_color_65k(0x0000);
 Line_Start_XY(0,0);
 Line_End_XY(1023,599);
 Start_Square_Fill();

   for(i=0;i<=300;i+=8)
 {Foreground_color_65k(0xFFFF);
 Circle_Center_XY(1024/2,600/2);
 Ellipse_Radius_RxRy(i+100,i);
 Start_Circle_or_Ellipse();
 delay_ms(30);
 }

    for(i=0;i<=300;i+=8)
 {Foreground_color_65k(0x0000);
 Circle_Center_XY(1024/2,600/2);
 Ellipse_Radius_RxRy(i+100,i);
 Start_Circle_or_Ellipse();
 delay_ms(30);
 }
    delay_ms(500);


    Foreground_color_65k(0x0000);
 Line_Start_XY(0,0);
 Line_End_XY(1023,599);
 Start_Square_Fill();

    for(i=0;i<=300;i+=8)
 {Foreground_color_65k(0xFFE0);
 Triangle_Point1_XY(1024/2,i);
 Triangle_Point2_XY(i,599-i);
 Triangle_Point3_XY(1023-i,599-i);
 Start_Triangle();
 delay_ms(30);
 }

    for(i=0;i<=300;i+=8)
 {Foreground_color_65k(0x0000);
 Triangle_Point1_XY(1024/2,i);
 Triangle_Point2_XY(i,599-i);
 Triangle_Point3_XY(1023-i,599-i);
 Start_Triangle();
 delay_ms(30);
 }
    delay_ms(500);



    Foreground_color_65k(0x0000);
 Line_Start_XY(0,0);
 Line_End_XY(1023,599);
 Start_Square_Fill();

    for(i=0;i<=1024;i+=8)
 {Foreground_color_65k(0x7FFF);
 Line_Start_XY(i,0);
 Line_End_XY(1023-i,599);
 Start_Line();
 delay_ms(10);
 }
     for(i=0;i<=600;i+=8)
 {Foreground_color_65k(0x7FFF);
 Line_Start_XY(0,599-i);
 Line_End_XY(1023,i);
 Start_Line();
 delay_ms(10);
 }


    for(i=0;i<=1024;i+=8)
 {Foreground_color_65k(0x0000);
 Line_Start_XY(i,0);
 Line_End_XY(1023-i,599);
 Start_Line();
 delay_ms(5);
 }
 for(i=0;i<=600;i+=8)
 {Foreground_color_65k(0x0000);
 Line_Start_XY(0,599-i);
 Line_End_XY(1023,i);
 Start_Line();
 delay_ms(5);
 }

    delay_ms(500);


}

void gray(void)
{ int i,col,line;
  Select_Main_Window_16bpp();
 Main_Image_Start_Address(0);
 Main_Image_Width(1024);
 Main_Window_Start_XY(0,0);

 Canvas_Image_Start_address(0);
 Canvas_image_width(1024);
    Active_Window_XY(0,0);
 Active_Window_WH(1024,600);


  col=0;line=0;
 for(i=0;i<32;i++)
    { Foreground_color_65k(i<<11);
  Line_Start_XY(col,line);
  Line_End_XY(col+32,line+100);
  Start_Square_Fill();
  col+=32;
 }
    col=0;line=100;
  for(i=31;i>=0;i--)
    { Foreground_color_65k(i<<11);
  Line_Start_XY(col,line);
  Line_End_XY(col+32,line+100);
  Start_Square_Fill();
  col+=32;
 }

  col=0;line=200;
 for(i=0;i<64;i++)
    { Foreground_color_65k(i<<5);
  Line_Start_XY(col,line);
  Line_End_XY(col+16,line+100);
  Start_Square_Fill();
  col+=16;
 }
    col=0;line=300;
  for(i=63;i>=0;i--)
    { Foreground_color_65k(i<<5);
  Line_Start_XY(col,line);
  Line_End_XY(col+16,line+100);
  Start_Square_Fill();
  col+=16;
 }


  col=0;line=400;
 for(i=0;i<32;i++)
    { Foreground_color_65k(i);
  Line_Start_XY(col,line);
  Line_End_XY(col+32,line+100);
  Start_Square_Fill();
  col+=32;
 }
    col=0;line=500;
  for(i=31;i>=0;i--)
    { Foreground_color_65k(i);
  Line_Start_XY(col,line);
  Line_End_XY(col+32,line+100);
  Start_Square_Fill();
  col+=32;
 }


   delay_ms(1000);
  NextStep();
}
# 22 "RA8876.c" 2
# 1 "./SD.h" 1



sbit SD_CLK = P1^7;
sbit SD_DI = P1^5;
sbit SD_DO = P1^6;
sbit SD_CS = P1^4;


unsigned char xdata DATA[512]=0;



void SdWrite(unsigned char n)
{

unsigned char i;

for(i=8;i;i--)
{
SD_CLK=0;
SD_DI=(n&0x80);
n<<=1;
SD_CLK=1;
}
SD_DI=1;
}


unsigned char SdRead()
{
unsigned char n,i;
for(i=8;i;i--)
{
SD_CLK=0;
SD_CLK=1;
n<<=1;
if(SD_DO) n|=1;

}
return n;
}


unsigned char SdResponse()
{
unsigned char i=0,response;

while(i<=8)
{
response = SdRead();
if(response==0x00)
break;
if(response==0x01)
break;
i++;
}
return response;
}


void SdCommand(unsigned char command, unsigned long argument, unsigned char CRC)
{

SdWrite(command|0x40);
SdWrite(((unsigned char *)&argument)[0]);
SdWrite(((unsigned char *)&argument)[1]);
SdWrite(((unsigned char *)&argument)[2]);
SdWrite(((unsigned char *)&argument)[3]);
SdWrite(CRC);
}


unsigned char SdInit(void)
{
int delay=0, trials=0;
unsigned char i;
unsigned char response=0x01;

SD_CS=1;
for(i=0;i<=9;i++)
SdWrite(0xff);
SD_CS=0;


SdCommand(0x00,0,0x95);


response=SdResponse();

if(response!=0x01)
{
return 0;
}

while(response==0x01)
{
SD_CS=1;
SdWrite(0xff);
SD_CS=0;
SdCommand(0x01,0x00ffc000,0xff);
response=SdResponse();
}

SD_CS=1;
SdWrite(0xff);
return 1;
}


unsigned char SdWriteBlock(unsigned char *Block, unsigned long address,int len)
{
unsigned int count;
unsigned char dataResp;



SD_CS=0;

SdCommand(0x18,address,0xff);

if(SdResponse()==00)
{
SdWrite(0xff);
SdWrite(0xff);
SdWrite(0xff);


SdWrite(0xfe);

for(count=0;count<len;count++) SdWrite(*Block++);

for(;count<512;count++) SdWrite(0);

SdWrite(0xff);
SdWrite(0xff);

dataResp=SdRead();




while(SdRead()==0);

dataResp=dataResp&0x0f;
SD_CS=1;
SdWrite(0xff);
if(dataResp==0x0b)
{

return 0;
}
if(dataResp==0x05)
return 1;


return 0;
}

return 0;
}



unsigned char SdReadBlock(unsigned char *Block, unsigned long address,int len)
{
unsigned int count;





SD_CS=0;

SdCommand(0x11,address,0xff);

if(SdResponse()==00)
{


while(SdRead()!=0xfe);

for(count=0;count<len;count++) *Block++=SdRead();

for(;count<512;count++) SdRead();


SdRead();
SdRead();

SD_CS=1;
SdRead();
return 1;
}

return 0;
}


void Display_JPG_SDCARD()
{ unsigned long jn;
  unsigned int in;

  unsigned long AddTemp=317952;
  unsigned char mn=16;


    Select_Main_Window_16bpp();
 Main_Image_Start_Address(0);
 Main_Image_Width(1024);
 Main_Window_Start_XY(0,0);

 Canvas_Image_Start_address(0);
 Canvas_image_width(1024);
    Active_Window_XY(0,0);
 Active_Window_WH(1024,600);

 Foreground_color_65k(0x001F);
 Line_Start_XY(0,0);
 Line_End_XY(1023,599);
 Start_Square_Fill();


   SdInit();
 for(;mn!=0;mn--)
  {
       LCD_SetCursor(0,0);


   for(jn=0;jn<2400;jn++)
      {
      SdReadBlock(DATA,AddTemp+(jn*512),512);
      LCD_WriteRAM_Prepare();
      for(in=0;in<512;in+=2)
      {
       LCD_DataWrite(DATA[in+1]);
       LCD_DataWrite(DATA[in]);
         }
        while(!next)return;
       }
       AddTemp = AddTemp+((jn+0)*512);

    NextStep();
 }



}
# 23 "RA8876.c" 2
# 1 "./TP.h" 1




sbit TCLK = P3^1;
sbit TCS = P3^4;
sbit TDIN = P3^0;
sbit DOUT = P3^3;
sbit PEN = P3^2;
# 19 "./TP.h"
unsigned int x[1]=0;
unsigned int y[1]=0;



 float xfac=0;
 float yfac=0;
 short xoff=0;
 short yoff=0;

unsigned char touchtype=0;



unsigned char CMD_RDX=0XD0;
unsigned char CMD_RDY=0X90;



 void FAST_Clear(unsigned int colour)
 { Select_Main_Window_16bpp();
 Main_Image_Start_Address(0);
 Main_Image_Width(1024);
 Main_Window_Start_XY(0,0);

 Canvas_Image_Start_address(0);
 Canvas_image_width(1024);
    Active_Window_XY(0,0);
 Active_Window_WH(1024,600);

  Foreground_color_65k(colour);
 Line_Start_XY(0,0);
 Line_End_XY(1024,600);
 Start_Square_Fill();
}





void LCD_DrawPoint(unsigned int x1,unsigned int y1,unsigned int POINT_COLOR)
{
  LCD_SetCursor(x1,y1);
  LCD_WriteRAM_Prepare();
  LCD_DataWrite(POINT_COLOR);
  LCD_DataWrite(POINT_COLOR>>8);
}



void LCD_DrawLine(unsigned int x1,unsigned int x2,unsigned int y1,unsigned int y2,unsigned int POINT_COLOR)
{
 unsigned int t;
 int xerr=0,yerr=0,delta_x,delta_y,distance;
 int incx,incy,uRow,uCol;

 delta_x=x2-x1;
 delta_y=y2-y1;
 uRow=x1;
 uCol=y1;
 if(delta_x>0)incx=1;
 else if(delta_x==0)incx=0;
 else {incx=-1;delta_x=-delta_x;}
 if(delta_y>0)incy=1;
 else if(delta_y==0)incy=0;
 else{incy=-1;delta_y=-delta_y;}
 if( delta_x>delta_y)distance=delta_x;
 else distance=delta_y;
 for(t=0;t<=distance+1;t++ )
 {

 LCD_SetPoint(uRow,uCol,POINT_COLOR);
  xerr+=delta_x ;
  yerr+=delta_y ;
  if(xerr>distance)
  {
   xerr-=distance;
   uRow+=incx;
  }
  if(yerr>distance)
  {
   yerr-=distance;
   uCol+=incy;
  }
 }
}
# 115 "./TP.h"
void TP_Write_Byte(unsigned char num)
{
 unsigned char count=0;
 for(count=0;count<8;count++)
 {
  if(num&0x80)TDIN=1;
  else TDIN=0;
  num<<=1;
  TCLK=0;
  _nop_();_nop_();_nop_();_nop_();
  TCLK=1;
 }
}




unsigned int TP_Read_AD(unsigned char CMD)
{
 unsigned char count=0;
 unsigned int Num=0;
 TCLK=0;
 TDIN=0;
 TCS=0;
 _nop_();
 TP_Write_Byte(CMD);

 _nop_();_nop_();_nop_();_nop_();_nop_();_nop_();
 TCLK=1;
 _nop_();_nop_();_nop_();_nop_();

 TCLK=0;
 _nop_();_nop_();_nop_();_nop_();

 for(count=0;count<12;count++)
 {
  Num<<=1;
  TCLK=0;
  _nop_();_nop_();_nop_();_nop_();
   TCLK=1;
   if(DOUT)Num++;
 }
 TCS=1;
 return(Num);
}







unsigned int TP_Read_XOY(unsigned char xy)
{ unsigned int i, j;
 unsigned int buf[10];
 unsigned int sum=0;
 unsigned int temp;
 for(i=0;i<10;i++)buf[i]=TP_Read_AD(xy);
 for(i=0;i<10 -1; i++)
 {
  for(j=i+1;j<10;j++)
  {
   if(buf[i]>buf[j])
   {
    temp=buf[i];
    buf[i]=buf[j];
    buf[j]=temp;
   }
  }
 }
 sum=0;
 for(i=2;i<10 -2;i++)sum+=buf[i];
 temp=sum/(10 -2*2);
 return temp;
}




unsigned char TP_Read_XY(unsigned int *x,unsigned int *y)
{
 unsigned int xtemp,ytemp;
 xtemp=TP_Read_XOY(CMD_RDX);
 ytemp=TP_Read_XOY(CMD_RDY);

 *x=xtemp;
 *y=ytemp;
 return 1;
}






unsigned char TP_Read_XY2(unsigned int *x,unsigned int *y)
{
 unsigned int x1,y1;
  unsigned int x2,y2;
  unsigned char flag;
    flag=TP_Read_XY(&x1,&y1);
    if(flag==0)return(0);
    flag=TP_Read_XY(&x2,&y2);
    if(flag==0)return(0);
    if(((x2<=x1&&x1<x2+100)||(x1<=x2&&x2<x1+100))
    &&((y2<=y1&&y1<y2+100)||(y1<=y2&&y2<y1+100)))
    {
        *x=(x1+x2)/2;
        *y=(y1+y2)/2;
        return 1;
    }else return 0;
}







void TP_Drow_Touch_Point(unsigned int x,unsigned int y,unsigned int color)
{
 LCD_DrawLine(x-12,x+13,y,y,color);
 LCD_DrawLine(x,x,y-12,y+13,color);
 LCD_DrawPoint(x+1,y+1,color);
 LCD_DrawPoint(x-1,y+1,color);
 LCD_DrawPoint(x+1,y-1,color);
 LCD_DrawPoint(x-1,y-1,color);
}






void TP_Scan(unsigned char tp)
{
 if(PEN==0)
 delay_ms(30);
 if(PEN==0)
 {
  if(tp)TP_Read_XY2(&x[0],&y[0]);
  else if(TP_Read_XY2(&x[0],&y[0]))

  {
    x[0]=xfac*x[0]+xoff;
   y[0]=yfac*y[0]+yoff;
   }

 }
 else
 {


   x[0]=0;
   y[0]=0;

 }

 return ;
}
# 310 "./TP.h"
unsigned int my_abs(unsigned int x1,unsigned int x2)
{
 if(x1>x2)return x1-x2;
 else return x2-x1;
}





unsigned char TP_Adjust(void)
{
 unsigned int pos_temp[4][2];
 unsigned char cnt=0;
 unsigned int d1,d2;
 unsigned long tem1,tem2;
 double fac;
 unsigned int outtime=0;
  cnt=0;


 Foreground_color_65k(0x0000);
 Background_color_65k(0xFFFF);
 CGROM_Select_Internal_CGROM();
 Font_Select_8x16_16x16();
 Goto_Text_XY(100,40);
 Show_String("TP Need readjust!");
 Goto_Text_XY(20,80);
 Show_String("Please use the stylus click the cross on the screen.");
 Goto_Text_XY(20,100);
 Show_String("The cross will always move until the screen adjustment is completed.");



 TP_Drow_Touch_Point(20,20,0xf800);
 xfac=0;
 while(1)
 { TP_Scan(1);
   if(next==0)return 1;
  if(!PEN)
  {
   outtime=0;


   pos_temp[cnt][0]=x[0];
   pos_temp[cnt][1]=y[0];
   cnt++;
   switch(cnt)
   {
    case 1: while(!PEN);
     TP_Drow_Touch_Point(20,20,0xFFFF);
     TP_Drow_Touch_Point(1024 -20,20,0xF800);
     break;
    case 2:while(!PEN);
      TP_Drow_Touch_Point(1024 -20,20,0xFFFF);
     TP_Drow_Touch_Point(20,600 -20,0xF800);
     break;
    case 3:while(!PEN);
      TP_Drow_Touch_Point(20,600 -20,0xFFFF);
      TP_Drow_Touch_Point(1024 -20,600 -20,0xF800);
     break;
    case 4: while(!PEN);

     tem1=my_abs(pos_temp[0][0],pos_temp[1][0]);
     tem2=my_abs(pos_temp[0][1],pos_temp[1][1]);
     tem1*=tem1;
     tem2*=tem2;
     d1=sqrt(tem1+tem2);


     tem1=my_abs(pos_temp[2][0],pos_temp[3][0]);
     tem2=my_abs(pos_temp[2][1],pos_temp[3][1]);
     tem1*=tem1;
     tem2*=tem2;
     d2=sqrt(tem1+tem2);
     fac=(float)d1/d2;
     if(fac<0.8||fac>1.2||d1==0||d2==0)

     {
      cnt=0;
          TP_Drow_Touch_Point(1024 -20,600 -20,0xFFFF);
          TP_Drow_Touch_Point(20,20,0xF800);

       continue;
     }
     tem1=my_abs(pos_temp[0][0],pos_temp[2][0]);
     tem2=my_abs(pos_temp[0][1],pos_temp[2][1]);
     tem1*=tem1;
     tem2*=tem2;
     d1=sqrt(tem1+tem2);

     tem1=my_abs(pos_temp[1][0],pos_temp[3][0]);
     tem2=my_abs(pos_temp[1][1],pos_temp[3][1]);
     tem1*=tem1;
     tem2*=tem2;
     d2=sqrt(tem1+tem2);
     fac=(float)d1/d2;
     if(fac<0.8||fac>1.2)

     {
      cnt=0;
          TP_Drow_Touch_Point(1024 -20,600 -20,0xFFFF);
          TP_Drow_Touch_Point(20,20,0xF800);

      continue;
     }


     tem1=my_abs(pos_temp[1][0],pos_temp[2][0]);
     tem2=my_abs(pos_temp[1][1],pos_temp[2][1]);
     tem1*=tem1;
     tem2*=tem2;
     d1=sqrt(tem1+tem2);

     tem1=my_abs(pos_temp[0][0],pos_temp[3][0]);
     tem2=my_abs(pos_temp[0][1],pos_temp[3][1]);
     tem1*=tem1;
     tem2*=tem2;
     d2=sqrt(tem1+tem2);
     fac=(float)d1/d2;
     if(fac<0.8||fac>1.2)

     {
      cnt=0;
          TP_Drow_Touch_Point(1024 -20,600 -20,0xFFFF);
          TP_Drow_Touch_Point(20,20,0xF800);

      continue;
     }


     if((pos_temp[1][0]>pos_temp[0][0]))
     xfac=(float)(1024 -40)/(pos_temp[1][0]-pos_temp[0][0]);
         else xfac=(float)(1024 -40)/(pos_temp[0][0]-pos_temp[1][0]);

     xoff=(1024 -xfac*(pos_temp[1][0]+pos_temp[0][0]))/2;

     if((pos_temp[2][1]>pos_temp[0][1]))
     yfac=(float)(600 -40)/(pos_temp[2][1]-pos_temp[0][1]);
         else yfac=(float)(600 -40)/(pos_temp[0][1]-pos_temp[2][1]);
     yoff=(600 -yfac*(pos_temp[2][1]+pos_temp[0][1]))/2;

     if(abs(xfac)>2||abs(yfac)>2)
     {
      cnt=0;
          TP_Drow_Touch_Point(1024 -20,600 -20,0xFFFF);
          TP_Drow_Touch_Point(20,20,0xF800);

      Foreground_color_65k(0x0000);
      Background_color_65k(0xFFFF);
      CGROM_Select_Internal_CGROM();
      Font_Select_8x16_16x16();
      Goto_Text_XY(40,26);
      Show_String("TP Need readjust!");


      touchtype=!touchtype;
      if(touchtype)

      {
       CMD_RDX=0X90;
       CMD_RDY=0XD0;
      }else
      {
       CMD_RDX=0XD0;
       CMD_RDY=0X90;
      }
      continue;
     }

      Foreground_color_65k(0x0000);
      Background_color_65k(0xFFFF);
      CGROM_Select_Internal_CGROM();
      Font_Select_8x16_16x16();
      Goto_Text_XY(20,150);
      Show_String("Touch Screen Adjust succeed!");


     delay_ms(2000);
        FAST_Clear(0xFFFF);
     return 0;
   }
  }
  delay_ms(10);

  }
}



void Load_Drow_Dialog(void)
{
 FAST_Clear(0xFFFF);


 Foreground_color_65k(0x0000);
 Background_color_65k(0xFFFF);
 CGROM_Select_Internal_CGROM();
 Font_Select_8x16_16x16();
 Goto_Text_XY(0,4);
 Show_String("EXIT");
 Goto_Text_XY(0,20);
 Show_String("EXIT");
 Goto_Text_XY(984,4);
 Show_String("CLEAR");
 Goto_Text_XY(984,20);
 Show_String("CLEAR");


}


void TPTEST(void)
{ unsigned char exit=0;
 unsigned char ss[6];

 FAST_Clear(0xFFFF);

 if(xfac==0)TP_Adjust();
 exit= TP_Adjust();
 if(exit==1) return;

 Foreground_color_65k(0x0000);
 Background_color_65k(0xFFFF);
 CGROM_Select_Internal_CGROM();
 Font_Select_8x16_16x16();
 Goto_Text_XY(24,50);
 Show_String("Drawing line");
  Goto_Text_XY(0,4);
 Show_String("EXIT");
 Goto_Text_XY(0,20);
 Show_String("EXIT");
 Goto_Text_XY(984,4);
 Show_String("CLEAR");
 Goto_Text_XY(984,20);
 Show_String("CLEAR");



 while(1)
 {


  if(PEN==0 )

  { TP_Scan(0);
    if(x[0]<1024&&y[0]<600)
   {
    if(x[0]>(1024 -40)&&y[0]<16)Load_Drow_Dialog();

    if(x[0]<40&&x[0]>0&&y[0]<16&&y[0]>0)return;


    LCD_DrawPoint((x[0]-1),y[0],0xF800);
     LCD_DrawPoint((x[0]),y[0],0xF800);
    LCD_DrawPoint((x[0]+1),y[0],0xF800);
    LCD_DrawPoint((x[0]),y[0]-1,0xF800);
    LCD_DrawPoint((x[0]),y[0]+1,0xF800);


    ss[0]=x[0]/10000+48;
    ss[1]=(x[0]/1000)-((x[0]/10000)*10)+48;
    ss[2]=(x[0]/100)-((x[0]/1000)*10)+48;
    ss[3]=(x[0]/10)-((x[0]/100)*10)+48;
    ss[4]=x[0]-((x[0]/10)*10)+48;
    ss[5]=0;

    Foreground_color_65k(0x0000);
    Background_color_65k(0xFFFF);
    CGROM_Select_Internal_CGROM();
    Font_Select_8x16_16x16();
    Goto_Text_XY(10,305);
    Show_String("X:");
     Goto_Text_XY(28,305);
    Show_String(ss);


    ss[0]=y[0]/10000+48;
    ss[1]=(y[0]/1000)-((y[0]/10000)*10)+48;
    ss[2]=(y[0]/100)-((y[0]/1000)*10)+48;
    ss[3]=(y[0]/10)-((y[0]/100)*10)+48;
    ss[4]=y[0]-((y[0]/10)*10)+48;
    ss[5]=0;

    Foreground_color_65k(0x0000);
    Background_color_65k(0xFFFF);
    CGROM_Select_Internal_CGROM();
    Font_Select_8x16_16x16();
    Goto_Text_XY(120,305);
    Show_String("Y:");
     Goto_Text_XY(138,305);
    Show_String(ss);

   }
  }
  else delay_ms(10);

 }



}
# 24 "RA8876.c" 2
# 36 "RA8876.c"
void main(void)
{

 P0=0xff;
 P1=0xff;
 P2=0xff;
 P3=0xff;



   delay_ms(100);
    RA8876_HW_Reset();
    delay_ms(100);
  while(LCD_StatusRead()&0x02);

   RA8876_initial();
  Display_ON();
  delay_ms(20);


    Foreground_color_65k(0xFFFF);
 Line_Start_XY(0,0);
 Line_End_XY(1023,599);
 Start_Square_Fill();

 while(1)
  {

   Enable_PWM0_Interrupt();
 Clear_PWM0_Interrupt_Flag();
  Mask_PWM0_Interrupt_Flag();
 Select_PWM0_Clock_Divided_By_2();
  Select_PWM0();
  Enable_PWM0_Dead_Zone();
 Auto_Reload_PWM0();
  Start_PWM0();
  Set_Timer0_Compare_Buffer(0xffff);
   delay_ms(2000);

   Set_Timer0_Compare_Buffer(0x0000);
   delay_ms(2000);
  Set_Timer0_Compare_Buffer(0x0ff0);
   delay_ms(2000);
    Set_Timer0_Compare_Buffer(0xffff);
   delay_ms(2000);





   Geometric();
 Text_Demo();
  mono_Demo();
 gray();
 TPTEST();
 delay_ms(3000);
 Display_JPG_SDCARD();
 delay_ms(3000);
 DMA_Demo();
 BTE_Compare();
 BTE_Pattern_Fill();
   BTE_Color_Expansion();

   PIP_Demo();
  App_Demo_Waveform();
  App_Demo_Scrolling_Text();

  App_Demo_slide_frame_buffer();
  App_Demo_multi_frame_buffer();
  App_Demo_Alpha_Blending();
 }
}
