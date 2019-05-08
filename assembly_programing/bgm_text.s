	.equ    STACK,      0x8000
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
	.equ	RE, 1175
	.equ	MI_f,1245
	.equ	MI, 1319
	.equ	FA, 1397
	.equ	SO, 1568
	.equ	RA, 1760
	.equ	SI, 1976
	.equ	DOO, 2093
	.equ	DOOO, 4186
	.equ	REEE, 4699
	.equ	MIII, 5274
	.equ	SOOO, 6272

	
	.section .text
	.global bgm_text

bgm_text:
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
	
	cmp	r7, #14
	ldreq	r1, =A_
@	moveq	r2, #64
	
	cmp	r7, #13
	ldreq	r1, =B_
@	moveq	r2, #64
	
	cmp	r7, #12
	ldreq	r1, =C_
@	moveq	r2, #64
	
	cmp	r7, #11
	ldreq	r1, =D_
@	moveq	r2, #64
	
	cmp	r7, #10
	ldreq	r1, =E_
@	moveq	r2, #64
	
	cmp	r7, #9
	ldreq	r1, =F_
@	moveq	r2, #64
	
	cmp	r7, #8
	ldreq	r1, =G_
@	moveq	r2, #64
	
	cmp	r7, #7
	ldreq	r1, =H_
@	moveq	r2, #64
	
	cmp	r7, #6
	ldreq	r1, =I_
@	moveq	r2, #64
	
	cmp	r7, #5
	ldreq	r1, =J_
@	moveq	r2, #64

	cmp	r7, #4
	ldreq	r1, =K_
@	moveq	r2, #64

	cmp	r7, #3
	ldreq	r1, =L_
@	moveq    r2, #64

	cmp	r7, #2
	ldreq	r1, =M_
@	moveq	r2, #64
	
	cmp	r7, #1
	ldreq	r1, =N_
@	moveq	r2, #12
	
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
@	.align	4
A_:
	.word	do, 1, mi, 1, mi, 1, mi, 1,   mi, 1, mi, 1, mi, 1, mi, 1
	.word	do, 1, mi, 1, mi, 1, mi, 1,   mi, 1, mi, 1, mi, 1, mi, 1
	.word	re, 1, fa, 1, fa, 1, fa, 1,   fa, 1, fa, 1, fa, 1, fa, 1
	.word	1, 1, FA, 1, FA, 1, SO, 1,   SO, 1, 1, 1, so, so, 1, so
B_:	
	.word	DO, DO, DO, DO, DO, DO, DO, DO,   DO, DO, DO, 1, DO, DO, DO, MI	
	.word	SO, SO, DOO, DOO, SI, SI, RA, RA,   SO, SO, SO, SO, MI, MI, MI, SO
	.word	FA, FA, FA, FA, RE, RE, RE, MI,   RE, RE, RE, RE, MI, MI, MI, RE
	.word	DO, DO, DO, DO, DO, DO, DO, DO,   DO, DO, DO, DO, so, so, 1, so
C_:		
	.word	DO, DO, DO, DO, DO, DO, DO, DO,   DO, DO, DO, 1, DO, DO, DO, MI	
	.word	SO, SO, DOO, DOO, SI, SI, RA, RA,   SO, SO, SO, SO, MI, MI, MI, SO
	.word	FA, FA, FA, FA, RE, RE, RE, MI,   RE, RE, RE, RE, MI, MI, MI, RE
	.word	DO, DO, DO, DO, DO, DO, DO, DO,   DO, DO, DO, DO, DO, DO, DO, 1
D_:		
	.word	DO, DO, 1, DO, RE, RE, MI, MI,   1, 1, DO, DO, RE, RE, DO, DO	
	.word	DO, 1, MI, 1, MI, 1, MI, 1,   MI, 1, MI, 1, MI, 1, MI, 1
	.word	DO, 1, MI, 1, MI, 1, MI, 1,   MI, MI, 1, 1, DO, DO, DO, RE
        .word	MI_f, MI_f, MI_f, MI_f, RE, RE, RE, MI_f,   FA, FA, FA, FA, MI_f, MI_f, MI_f, FA
E_:	
	.word	SO, SO, SO, SO, FA, FA, FA, SO,   DO, DO, DO, 1, DO, DO, DO, RE
	.word	MI_f, MI_f, MI_f, MI_f, RE, RE, RE, MI_f,   FA, FA, FA, FA, MI_f, MI_f, MI_f, FA
	.word	SO, SO, SO, SO, SO, SO, SO, SO,   DOO, DOO, 1, 1, DO, DO, DO, RE
	.word	MI_f, MI_f, MI_f, MI_f, RE, RE, RE, MI_f,   FA, FA, FA, FA, MI_f, MI_f, MI_f, FA
F_:	
	.word   SO, SO, SO, SO, FA, FA, FA, SO,  DO, DO, DO, 1, DO, DO, DO, RE
	.word	MI_f, MI_f, MI_f, MI_f, RE, RE, RE, MI_f,   FA, FA, FA, FA, MI_f, MI_f, MI_f, FA
	.word	RE, RE, RE, RE, RE, RE, RE, RE,   SO, SO, 1, 1, so, so, 1, so	
	.word	DO, DO, DO, DO, DO, DO, DO, DO,   DO, DO, DO, 1, DO, DO, DO, MI	
G_:	
        .word	SO, SO, DOO, DOO, SI, SI, RA, RA,   SO, SO, SO, SO, MI, MI, MI, SO
	.word	FA, FA, FA, FA, RE, RE, RE, MI,   RE, RE, RE, RE, MI, MI, MI, RE
	.word	DO, DO, DO, DO, DO, DO, DO, DO,   DO, DO, DO, DO, so, so, 1, so
	.word	DO, DO, DO, DO, DO, DO, DO, DO,   DO, DO, DO, 1, DO, DO, DO, MI	
H_:	
	.word	SO, SO, DOO, DOO, SI, SI, RA, RA,   SO, SO, SO, SO, MI, MI, MI, SO
	.word	FA, FA, FA, FA, RE, RE, RE, MI,   RE, RE, RE, RE, MI, MI, MI, RE
	.word	DO, DO, DO, DO, DO, DO, DO, DO,   DO, DO, DO, DO, DO, DO, DO, 1		
	.word	DO, DO, 1, DO, RE, RE, MI, MI,   1, 1, DO, DO, RE, RE, DO, DO	
I_:
	.word	DO, 1, MI, 1, MI, 1, MI, 1,   MI, 1, MI, 1, MI, 1, MI, 1
	.word	DO, 1, MI, 1, MI, 1, MI, 1,   MI, MI, 1, 1, DO, DO, DO, RE
        .word	MI_f, MI_f, MI_f, MI_f, RE, RE, RE, MI_f,   FA, FA, FA, FA, MI_f, MI_f, MI_f, FA	
	.word	SO, SO, SO, SO, FA, FA, FA, SO,   DO, DO, DO, 1, DO, DO, DO, RE
J_:	
	.word	MI_f, MI_f, MI_f, MI_f, RE, RE, RE, MI_f,   FA, FA, FA, FA, MI_f, MI_f, MI_f, FA
	.word	SO, SO, SO, SO, SO, SO, SO, SO,   DOO, DOO, 1, 1, DO, DO, DO, RE
	.word	MI_f, MI_f, MI_f, MI_f, RE, RE, RE, MI_f,   FA, FA, FA, FA, MI_f, MI_f, MI_f, FA	
	.word   SO, SO, SO, SO, FA, FA, FA, SO,  DO, DO, DO, 1, DO, DO, DO, RE
K_:	
	.word	MI_f, MI_f, MI_f, MI_f, RE, RE, RE, MI_f,   FA, FA, FA, FA, MI_f, MI_f, MI_f, FA
	.word	RE, RE, RE, RE, RE, RE, RE, RE,   SO, SO, 1, 1, so, so, 1, so		
	.word	DO, DO, DO, DO, DO, DO, DO, DO,   DO, DO, DO, 1, DO, DO, DO, MI	
	.word	SO, SO, DOO, DOO, SI, SI, RA, RA,   SO, SO, SO, SO, MI, MI, MI, SO
L_:	
	.word	FA, FA, FA, FA, RE, RE, RE, MI,   RE, RE, RE, RE, MI, MI, MI, RE
	.word	DO, DO, DO, DO, DO, DO, DO, DO,   DO, DO, DO, DO, DO, DO, DO, 1	
	.word	DO, DO, 1, DO, RE, RE, MI, MI,   1, 1, DO, DO, RE, RE, DO, DO	
	.word	DO, 1, MI, 1, MI, 1, MI, 1,   MI, 1, MI, 1, MI, 1, MI, 1
M_:	
	.word	DO, 1, MI, 1, MI, 1, MI, 1,   MI, MI, 1, 1, DO, DO, DO, RE
        .word	MI_f, MI_f, MI_f, MI_f, RE, RE, RE, MI_f,   FA, FA, FA, FA, MI_f, MI_f, MI_f, FA   	
	.word	SO, SO, SO, SO, FA, FA, FA, SO,   DO, DO, DO, 1, DO, DO, DO, RE
	.word	MI_f, MI_f, MI_f, MI_f, RE, RE, RE, MI_f,   FA, FA, FA, FA, MI_f, MI_f, MI_f, FA
N_:
	.word	DO, 1, MI, 1, MI, 1, MI, 1,   MI, MI, 1, 1, DO, DO, DO, RE
        .word	MI_f, MI_f, MI_f, MI_f, RE, RE, RE, MI_f,   FA, FA, FA, FA, MI_f, MI_f, MI_f, FA   	
	.word	SO, SO, SO, SO, FA, FA, FA, SO,   DO, DO, DO, 1, DO, DO, DO, RE
	.word	MI_f, MI_f, MI_f, MI_f, RE, RE, RE, MI_f,   FA, FA, FA, FA, MI_f, MI_f, MI_f, FA
@	.word	SO, SO, SO, SO, SO, SO, SO, SO,   DOO, DOO, 1, 1
