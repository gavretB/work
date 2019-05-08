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
	.equ	DO_s, 1109
	.equ	RE, 1175
	.equ	MI_f,1245
	.equ	MI, 1319
	.equ	FA, 1397
	.equ	FA_s, 1480
	.equ	SO, 1568
	.equ	RA_f, 1661
	.equ	RA, 1760
	.equ	SI_f, 1865
	.equ	SI, 1976
	.equ	DOO, 2093
	.equ	FAA_s, 2960
	.equ	SOO, 3136
	.equ	DOOO, 4186
	.equ	REEE, 4699
	.equ	MIII, 5274
	.equ	SOOO, 6272

	
	.section .text
	.global gameover
gameover:
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

	cmp	r7, #1
	ldreq	r1, =A_
	
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
	.word	DOO, 1, SI, SI_f, 1, RA, RA_f, 1, MI_f, MI_f, RA
	.word	SO, 1, 1, 1, 1, 1, FAA_s, SOO, 1, 1, 1, 1, 1, 1
	.word	1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
	.word	1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
	.word	1, 1, 1, 1, 1 
