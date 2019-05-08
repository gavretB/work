	.equ    STACK,      0x8000


	.equ	fa, 349
	.equ	fa_s, 370
	.equ	so, 392
	.equ	ra_f, 415
	.equ	si_f, 466
	.equ	si, 494
	.equ	DO, 523
	.equ	DO_s, 554
	.equ	RE, 587
	.equ	MI_f, 622
	.equ	MI, 659
	.equ	FA, 698
	.equ	FA_s, 740
	.equ	SO, 784
	.equ	RA_f, 830
	.equ	RA, 880
	.equ	SI_f, 932
	.equ	SI, 988
	.equ	DOO, 1047
	.equ	DOO_s, 1109
	.equ	REE, 1174
	.equ	MII_f, 1245
	.equ	MII, 1319
	.equ	FAA, 1397
	.equ	FAA_s, 1480
	.equ	SOO, 1568
	.equ	SII_f, 1865
	
	.section .text
	.global ending_text

ending_text:
	@ r1に周波数の先頭番地, r2に音数を入れるサブルーチン
	
	@ レジスタの値を保存
        str	r0, [sp, #-4]!
	str	r2, [sp, #-4]!
	str	r3, [sp, #-4]!
	str	r4, [sp, #-4]!
	str	r5, [sp, #-4]!
	str	r6, [sp, #-4]!
	str	r8, [sp, #-4]!
	str	r9, [sp, #-4]!
	str	r10,[sp, #-4]!
	str	r11, [sp, #-4]!
	str	r12, [sp, #-4]!
	str	r14, [sp, #-4]!

	cmp	r7, #12
	ldreq	r1, =A_
@	moveq	r2, #64
	
	cmp	r7, #11
	ldreq	r1, =B_
@	moveq	r2, #64
	
	cmp	r7, #10
	ldreq	r1, =C_
@	moveq	r2, #64
	
	cmp	r7, #9
	ldreq	r1, =D_
@	moveq	r2, #64
	
	cmp	r7, #8
	ldreq	r1, =E_
@	moveq	r2, #64
	
	cmp	r7, #7
	ldreq	r1, =F_
@	moveq	r2, #64
	
	cmp	r7, #6
	ldreq	r1, =G_
@	moveq	r2, #64
	
	cmp	r7, #5
	ldreq	r1, =H_
@	moveq	r2, #64
	
	cmp	r7, #4
	ldreq	r1, =I_
@	moveq	r2, #64
	
	cmp	r7, #3
	ldreq	r1, =J_
@	moveq	r2, #64

	cmp	r7, #2
	ldreq	r1, =K_
@	moveq	r2, #64

	cmp	r7, #1
	ldreq	r1, =L_
@	moveq    r2, #64

	
	@ レジスタを復元
	ldr	r14, [sp], #4
	ldr	r12, [sp], #4	
	ldr	r11, [sp], #4
	ldr	r10, [sp], #4
	ldr	r9, [sp], #4
	ldr	r8, [sp], #4
	ldr	r6, [sp], #4
	ldr	r5, [sp], #4
	ldr	r4, [sp], #4
	ldr	r3, [sp], #4
	ldr	r2, [sp], #4
	ldr	r0, [sp], #4
	
	bx      r14

	.section .data	
A_:
	.word	MII_f, MII_f, 1, 1, MII_f, MII_f, REE, REE,   1, 1, MII_f, MII_f, MII_f, MII_f, MII_f, MII_f
	.word	1, 1, 1, 1, FAA, FAA, MII_f, MII_f,   1, 1, REE, REE, REE, REE, REE, REE
	.word	DOO, DOO, DOO, DOO, DOO, DOO, SOO, SOO,   SOO, SOO, SOO, SOO, SOO, SOO, SI_f, SI_f
	.word	1, 1, DOO, DOO, 1, 1, REE, REE,   1, 1, MII_f, MII_f, FAA, FAA, SII_f, SII_f
B_:
	.word	1, 1, 1, 1, RE, RE, MI_f, MI_f,   RE, RE, MI_f, MI_f, MI_f, MI_f, MI_f, MI_f
	.word	1, 1, 1, 1, FA, 1, FA, FA,   MI_f, MI_f, FA, FA, FA, FA, si_f, si_f
	.word	SO, SO, SO, SO, RA_f, RA_f, SO, SO,   SO, SO, MI_f, MI_f, MI_f, MI_f, DO, DO
	.word	SO, SO, SO, SO, RA_f, RA_f, SO, SO,   SO, SO, FA, FA, MI_f, MI_f, FA, FA
C_:
	.word	1, 1, 1, 1, MI_f, MI_f, MI_f, MI_f,   RE, RE, MI_f, MI_f, MI_f, MI_f, RE, RE
	.word	RE, RE, si, si, si, 1, si, si,   FA, FA, FA, MI_f, MI_f, MI_f, RE, 1
	.word	RE, RE, RE, RE, MI_f, 1, MI_f, MI_f,   MI_f, MI_f, MI_f, MI_f, MI_f, MI_f, si_f, si_f
	.word	MI_f, MI_f, FA, FA, SO, SO, FA, FA,   FA, FA, SO, SO, FA, FA, MI_f, MI_f
D_:
	.word	FA_s, FA_s, FA_s, FA_s, FA_s, FA_s, fa_s, fa_s,   fa_s, fa_s, FA, FA, fa_s, fa_s, MI_f, MI_f
	.word	DO_s, DO_s, DO_s, DO_s, DO_s, DO_s, fa, fa,   fa, fa, si_f, si_f, fa, fa, si, si
	.word	DO_s, DO_s, DO_s, DO_s, DO_s, 1, DO_s, 1,   DO_s, DO_s, DO_s, DO_s, si_f, si_f, DO_s, DO_s
	.word	DO_s, DO_s, MI_f, MI_f, MI_f, MI_f, si, si,   si, si, si, 1, si, si, DO_s, DO_s
E_:
	.word	si, si, si_f, si_f, si, si, DO_s, DO_s,   DO_s, DO_s, si, si, DO_s, DO_s, MI_f, MI_f
	.word	MI_f, MI_f, RE, RE, MI_f, MI_f, FA, FA,   FA, FA, MI_f, MI_f, RE, RE, MI_f, MI_f
	.word	FA, FA, FA, FA, FA, FA, FA, FA,   FA, FA, FA, FA, FA, FA, SO, SO
	.word	1, 1, SO, SO, 1, 1, RA, RA,   SO, SO, 1, 1, 1, 1, 1, 1
F_:
	.word	RA, 1, RA, RA, RA, 1, RA, 1,   RA, RA, RA, 1, RA, RA, SO, SO
	.word	SO, SO, FA, FA, SO, SO, RA, RA,    RA, RA, RA, RA, RA, RA, RA, 1
	.word	RA, 1, RA, RA, RA, 1, RA, 1,   RA, RA, RA, 1, RA, RA, SI_f, SI_f
	.word	SI_f, SI_f, RA, RA, SI_f, SI_f, DOO, DOO,   DOO, DOO, DOO, DOO, DO, DO, DOO, DOO
G_:
	.word	SI_f, SI_f, SI_f, SI_f, RA, RA, FA, FA,   FA, FA, FA, FA, DOO, 1, DOO, DOO
	.word	SI_f, SI_f, SI_f, SI_f, RA, RA, FA, FA,   FA, FA, FA, FA, DOO, 1, DOO, DOO
	.word	SI_f, SI_f, SI_f, SI_f, RA_f, RA_f, SO, SO,   SO, SO, FA, FA, FA, FA, SO, SO
	.word	1, 1, FAA, FAA, 1, 1, FAA_s, FAA_s,    1, 1, SOO, SOO, SOO, SOO, SOO, SOO
H_:
	.word	RA, 1, RA, RA, RA, 1, RA, 1,   RA, RA, RA, 1, RA, RA, SO, SO
	.word	SO, SO, FA, FA, SO, SO, RA, RA,   RA, RA, RA, RA, RA, RA, RA, 1
	.word	RA, 1, RA, 1, RA, 1, RA, 1,   RA, RA, RA, 1, RA, RA, SI_f, SI_f
	.word	SI_f, SI_f, RA, RA, SI_f, SI_f, DOO, DOO,   DOO, DOO, DOO, DOO, DO, DO, DOO, DOO
I_:
	.word	SI_f, SI_f, SI_f, SI_f, RA, RA, FA, FA,   FA, FA, FA, FA, DOO, DOO, DOO, DOO
	.word	REE, REE, REE, REE, RA, RA, SO, SO,   SO, SO, FA, FA, FA, FA, FA, FA
	.word	SI_f, SI_f, SI_f, 1, SI_f, SI_f, SI_f, 1,   SI_f, SI_f, SI_f, 1, SI_f, SI_f, DOO, DOO
	.word	SI_f, SI_f, SI_f, SI_f, RA, RA, SO, SO,   SO, SO, SO, SO, FA, FA, SO, SO
J_:
	.word	RA_f, RA_f, RA_f, 1, RA_f, RA_f, SO, SO,   SO, SO, FA, FA, fa, fa, so, so
	.word	ra_f, ra_f, ra_f, 1, ra_f, ra_f, so, so,   so, so, fa, fa, FA, FA, SO, SO
	.word	RA_f, RA_f, RA_f, 1, RA_f, RA_f, FA_s, FA_s,   FA_s, FA_s, MI, MI, MI, MI, MI, MI
	.word	1, 1, 1, 1, si, si, si, 1,   si, si, MI, MI, MI, MI, MI_f, MI_f
K_:
	.word	MI_f, MI_f, MI, MI, MI_f, MI_f, 1, 1,   1, 1, MI, MI, MI_f, MI_f, 1, 1
	.word	1, 1, MI, MI, MI_f, MI_f, MI, MI,   MI_f, MI_f, 1, 1, DO_s, DO_s, DO_s, DO_s
	.word	DO_s, DO_s, RE, RE, RE, RE, RE, RE,   RE, RE, MI_f, MI_f, 1, 1, DO_s, DO_s
	.word	RE, RE, MI_f, MI_f, 1, 1, DOO_s, DOO_s,   REE, REE, MII_f, MII_f, 1, 1, MII, MII
L_:
	.word	1, 1, MII_f, MII_f, 1, 1, 1, 1,   1, 1, 1, 1, 1, 1, 1, 1
	.word	1, 1, 1, 1, 1, 1, 1, 1,   1, 1, 1, 1, 1, 1, 1, 1
	.word	1, 1, 1, 1, 1, 1, 1, 1,   1, 1, 1, 1, 1, 1, 1, 1
	.word	1, 1, 1, 1, 1, 1, 1, 1,   1, 1, 1, 1, 1, 1, 1, 1
