	.equ    STACK,      0x8000
	.equ	sii, 247
	.equ	do, 494
	.equ	re, 587
	.equ	mi, 659
	.equ	fa, 698
	.equ	so, 784
	.equ	ra_f,831
	.equ	ra, 880
	.equ	si_f,932
	.equ	si, 988
	.equ	DO, 1047
	.equ	DO_s, 1109
	.equ	RE, 1175
	.equ	RE_s, 1245
	.equ	MI_f,1245
	.equ	MI, 1319
	.equ	FA, 1397
	.equ	FA_s, 1480
	.equ	SO, 1568
	.equ	SO_s, 1661
	.equ	RA, 1760
	.equ	SI, 1976
	.equ	DOO, 2093
	.equ	DOOO, 4186
	.equ	REEE, 4699
	.equ	MIII, 5274
	.equ	SOOO, 6272

	
	.section .text
	.global op_text

op_text:
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
	sub	sp, sp, #4

	cmp	r7, #14
	ldreq	r1, =A_
	@moveq	r2, #64
	
	cmp	r7, #13
	ldreq	r1, =B_
	@moveq	r2, #64
	
	cmp	r7, #12
	ldreq	r1, =C_
	@moveq	r2, #64
	
	cmp	r7, #11
	ldreq	r1, =D_
	@moveq	r2, #64
	
	cmp	r7, #10
	ldreq	r1, =E_
	@moveq	r2, #64
	
	cmp	r7, #9
	ldreq	r1, =F_
	@moveq	r2, #64
	
	cmp	r7, #8
	ldreq	r1, =G_
	@moveq	r2, #64

	cmp	r7, #7
	ldreq	r1, =H_
	@moveq	r2, #64

	cmp	r7, #6
	ldreq	r1, =I_
	@moveq	r2, #64

	cmp	r7, #5
	ldreq	r1, =I_
	@moveq	r2, #64

	cmp	r7, #4
	ldreq	r1, =J_
	@moveq	r2, #64

	cmp	r7, #3
	ldreq	r1, =K_
	@moveq	r2, #64

	cmp	r7, #2
	ldreq	r1, =L_
	@moveq	r2, #64

	cmp	r7, #1
	ldreq	r1, =M_
	@moveq	r2, #64
	
	
	@ レジスタを復元
	add	sp, sp, #4
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
	.word	1, 1, 1, 1, mi, 1, mi, 1, 1, 1, 1, mi, mi, mi, 1
	.word	1, 1, 1, 1, mi, 1, mi, 1, 1, 1, 1, mi, mi, mi, 1
	.word	1, 1, 1, 1, mi, 1, mi, 1, 1, 1, 1, mi, mi, mi, 1
	.word	1, 1, 1, 1, mi, 1, mi, 1, 1, 1, 1, mi, mi, mi, 1
B_:	
	.word	si_f, si_f, si_f, 1, si_f, si_f, si_f, 1, si_f, si_f, si_f, 1, so, 1, si_f, si_f
	.word	si_f, si_f, si_f, 1, 1, 1, si_f, 1, si_f, 1, DO, 1, MI_f, 1, FA, 1, MI_f, 1
	.word	SO, 1, FA, 1, MI_f, MI_f, MI_f, MI_f, 1, 1, 1, 1, 1, 1, 1, 1
	.word	1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
C_:	
	.word	si_f, si_f, si_f, 1, si_f, si_f, si_f, 1, si_f, si_f, si_f, 1, so, 1, si_f, si_f
	.word	si_f, si_f, si_f, 1, 1, 1, si_f, 1, DO, 1, MI_f, 1, FA, 1, MI_f, 1
	.word	SO, 1, FA, 1, MI_f, MI_f, MI_f, MI_f, 1, 1, 1, 1, 1, 1, 1, 1
	.word	1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, DO, RE, MI_f
D_:	
	.word	ra_f, ra_f, ra_f, 1, ra_f, ra_f, ra_f, 1, si_f, si_f, si_f, 1, DO, DO, DO, 1
	.word	si_f, si_f, si_f, 1, DO, DO, DO, 1, RE, RE, RE, 1, si_f, si_f, si_f, 1
	.word	MI_f, MI_f, MI_f, MI_f, MI_f, MI_f, MI_f, 1, MI_f, 1, RE, 1, DO, 1, si_f, 1
	.word	DO, 1, si_f, 1, so, so, so, so, so, so, so, 1, 1, 1, 1, 1
E_:	
	.word	ra_f, ra_f, ra_f, 1, ra_f, ra_f, ra_f, 1, si_f, 1, DO, DO, DO, DO, DO, 1
	.word	si_f, si_f, si_f, 1, DO, DO, DO, 1, RE, 1, si_f, si_f, si_f, si_f, si_f, 1
	.word	MI_f, MI_f, MI_f, MI_f, MI_f, MI_f, MI_f, MI_f, MI_f, MI_f, MI_f, MI_f, MI_f, MI_f, MI_f, 1
	.word	1, 1, SI, 1, SI, 1, SI, 1, SI, 1, SI, 1, SI, 1, SI, 1
F_:	
	.word	si_f, si_f, si_f, 1, si_f, si_f, si_f, 1, si_f, si_f, si_f, 1, so, 1, si_f, si_f
	.word	si_f, si_f, si_f, 1, 1, 1, si_f, 1, DO, 1, MI_f, 1, FA, 1, MI_f, 1
	.word	SO, 1, FA, 1, MI_f, MI_f, MI_f, MI_f, 1, 1, 1, 1, 1, 1, 1, 1
	.word	DOO, DOO, 1, 1, DOO, DOO, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
G_:	
	.word	si_f, si_f, si_f, 1, si_f, si_f, si_f, 1, si_f, si_f, si_f, 1, so, 1, si_f, si_f
	.word	si_f, si_f, si_f, si_f, 1, 1, si_f, 1, si, 1, MI_f, 1, FA, 1, MI_f, 1
	.word	SO, 1, FA, 1, MI_f, MI_f, MI_f, MI_f, 1, 1, 1, 1, 1, 1, 1, 1
	.word	DOO, DOO, 1, 1, 1, 1, DOO, DOO, 1, 1, DO, DO,  RE, RE,  MI_f, MI_f
H_:	
	.word	ra_f, ra_f, ra_f, 1, ra_f, ra_f, ra_f, 1, si_f, si_f, si_f, 1, si_f, si_f, si_f, 1
	.word	si_f, si_f, si_f, 1, DO, DO, DO, 1, RE, RE, RE, 1, si_f, si_f, si_f, 1
	.word	MI_f, MI_f, MI_f, MI_f, MI_f, MI_f, MI_f, 1, MI_f, 1, RE, 1, DO, 1, si_f, 1
	.word	DO, 1, si_f, 1, so, so, so, so, so, so, so, so, so, so, so, 1
I_:	
	.word	ra_f, ra_f, ra_f, 1, ra_f, ra_f, ra_f, 1, si_f, 1, DO, DO, DO, DO, DO, 1
	.word	si_f, si_f, si_f, 1, DO, DO, DO, 1, RE, 1, si_f, si_f, si_f, si_f, si_f, 1
	.word	MI_f, MI_f, MI_f, MI_f, MI_f, MI_f, MI_f, MI_f, MI_f, MI_f, MI_f, MI_f, MI_f, MI_f, MI_f, 1
	.word	1, 1, 1, 1, 1, 1, 1, 1, 1, 1,sii, sii, do, do, re, re
J_:	
	.word	mi, mi, mi, 1, MI_f, MI_f, MI_f, 1, SO, SO, SO, 1, SI, SI, SI, 1
	.word	DOO, DOO, DOO, 1, SI, 1, DOO, 1, DOO, 1, SI, 1, SO, 1, FA, 1
	.word	MI_f, 1, MI_f, 1, MI_f, 1, DO, 1, MI_f, MI_f, MI_f, MI_f, MI_f, MI_f, MI_f, 1
	.word	so, so, so, 1, so, 1, so, 1, so, 1, so, 1, 1, 1, 1, 1
K_:	
	.word	1, 1, 1, 1, DO, DO, DO, 1, MI_f, MI_f, MI_f, 1, FA, FA, FA, 1
	.word	SO, SO, SO, 1, FA, 1, SO, SO, SO, 1, FA, 1, MI_f, 1, FA, 1
	.word	SO, 1, SI, 1, SO, 1, FA, 1, MI_f, MI_f, MI_f, 1, 1, DO, MI_f, DO
	.word	SI, 1, SI, 1, RA, 1, RA, 1, SO, 1, SO, 1, FA, 1, FA, 1
L_:	
	.word	si_f, si_f, si_f, 1, si_f, si_f, si_f, 1, si_f, si_f, si_f, 1, so, 1, si_f, si_f
	.word	si_f, si_f, si_f, si_f, 1, 1, si_f, 1, DO, 1, MI_f, 1, FA, 1, MI_f, 1
	.word	SO, 1, FA, 1, MI_f, MI_f, MI_f, MI_f, 1, 1, 1, 1, 1, 1, 1, 1
	.word	DOO, DOO, 1, SI, SI, 1, DOO, DOO, 1, 1, DO, DO, RE, RE, MI_f, MI_f
M_:	
	.word	ra_f, ra_f, ra_f, 1, ra_f, ra_f, ra_f, 1, si_f, 1, DO, DO, DO, DO, DO, 1
	.word	si_f, si_f, si_f, 1, DO, DO, DO, 1, RE, RE, RE, 1, si_f, si_f, si_f, 1
	.word	MI_f, MI_f, MI_f, MI_f, MI_f, MI_f, MI_f, MI_f, MI_f, MI_f, MI_f, MI_f, MI_f, MI_f, MI_f, 1
	.word	1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
