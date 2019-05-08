	.equ    GPIO_BASE,  0x3f200000 @ GPIOベースアドレス
	.equ    GPFSEL0,    0x00       @ GPIOポートの機能を選択する番地のオフセット
	.equ    GPSET0,     0x1C       @ GPIOポートの出力値を1にするための番地のオフセット
	.equ    GPCLR0,     0x28       @ GPIOボートの出力値を0にするための番地のオフセット

	.equ    CM_BASE,    0x3f101000
	.equ    CM_PWMCTL,  0xa0
	.equ    CM_PWMDIV,  0xa4

	
	.equ    PWM_BASE,   0x3f20c000
	.equ    PWM_RNG2,   0x20
	.equ    PWM_DAT2,   0x24
	.equ    PWM_HZ,     9600 * 1000
	.equ    KEY_4A, PWM_HZ / 440     @ 440Hz のときの1周期のクロック数 ラ
	.equ    KEY_4B, PWM_HZ / 494     @シ
	.equ	KEY_5C, PWM_HZ / 523	 @ド
	.equ	KEY_5D, PWM_HZ / 587	 @レ
	.equ 	KEY_5E, PWM_HZ / 659     @ミ
	.equ	KEY_5F, PWM_HZ / 698	 @ファ
	.equ	KEY_5G, PWM_HZ / 784	 @ソ
	.equ	KEY_5A, PWM_HZ / 880	 @ラ

	.equ    TIMER_BASE, 0x3f003000 @ システムタイマの制御レジスタがマップされた番地のベースアドレス
        .equ    TIMER_HZ, 80000    @ タイマー周波数 1MHz
        .equ    TIMER_CLO,  0x4


	.equ    GPFSEL_VEC1, 0x10000001 @ GPFSEL1 に設定する値 (GPIO #19を010に設定)
	.equ    PWM_CTL,    0x8100

	.equ    STACK,      0x8000
	
	.section .text
	.global gameover_bgm
gameover_bgm:
	str	r0, [sp, #-4]!
	str	r1, [sp, #-4]!
	str	r2, [sp, #-4]!
	str	r3, [sp, #-4]!
	str	r4, [sp, #-4]!
	str	r5, [sp, #-4]!
	str	r8, [sp, #-4]!
	str	r9, [sp, #-4]!
	str	r10,[sp, #-4]!
	str	r11, [sp, #-4]!
	str	r12, [sp, #-4]!
	str	r14, [sp, #-4]!
	
	@ (GPIO #19 を含め，GPIOの用途を設定する)
	ldr    r2, =GPIO_BASE
	
	@ (PWM のクロックソースを設定する)

	ldr     r4, =CM_BASE
	ldr     r5, =0x5a000021                     @  src = osc, enable=false
	str     r5, [r4, #CM_PWMCTL]
	
	@ wait for busy bit to be cleared
    
1:	ldr     r5, [r4, #CM_PWMCTL]
	tst     r5, #0x80
	bne     1b

	ldr     r5, =(0x5a000000 | (2 << 12))  @ div = 2.0
	str     r5, [r4, #CM_PWMDIV]
	ldr     r5, =0x5a000211                   @ src = osc, enable=true
	str     r5, [r4, #CM_PWMCTL]

	
	@(PWM の動作モードを設定する)
	ldr	r3, =PWM_BASE
	ldr     r0, =PWM_CTL
	str     r0, [r3, #GPFSEL0]
	
	ldr     r0, =PWM_BASE
	ldr	r3, =PWM_HZ 

	ldr	r5, =GPFSEL0
	@ r1に周波数の先頭番地, r2に音数を入れるサブルーチン
	bl	gameover

	ldr	r10, [r1, r6]
	
	ldr     r0, =PWM_BASE
	
	udiv	r4, r3, r10
	cmp	r4, r3
	streq	r5, [r0, #PWM_DAT2]
	
	strne	r4, [r0, #PWM_RNG2]
	lsrne	r4, r4, #1
	strne	r4, [r0, #PWM_DAT2]

	ldr	r14, [sp], #4
	ldr	r12, [sp], #4
	ldr	r11, [sp], #4
	ldr	r10, [sp], #4
	ldr	r9, [sp], #4
	ldr	r8, [sp], #4
	ldr	r5, [sp], #4
	ldr	r4, [sp], #4
	ldr	r3, [sp], #4
	ldr	r2, [sp], #4
	ldr	r1, [sp], #4
	ldr	r0, [sp], #4

	bx	r14

loop:
	b    loop
