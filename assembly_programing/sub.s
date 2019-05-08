	.equ    GPIO_BASE,  0x3f200000 @ GPIOベースアドレス
	.equ    GPFSEL0,    0x00       @ GPIOポートの機能を選択する番地のオフセット
	.equ    GPSET0,     0x1C       @ GPIOポートの出力値を1にするための番地のオフセット
	.equ    GPCLR0,     0x28       @ GPIOボートの出力値を0にするための番地のオフセット

	.equ	TIMER_BASE, 0x3f003000
	.equ	TIMER_HZ_1, 100000
	.equ	TIMER_HZ_1000, 1000
	.equ	TIMER_CLO, 0x4
	
	.equ	CM_BASE, 0x3f101000
	.equ	CM_PWMCTL, 0xa0
	.equ	CM_PWMDIV, 0xa4
	
	.equ	PWM_BASE, 0x3f20c000
	.equ	PWM_RNG2, 0x20
	.equ	PWM_DAT2, 0x24
	.equ    PWM_HZ, 9600 * 1000
	.equ	KEY_4D, PWM_HZ / 293	@ 低いレ
	.equ	KEY_4E, PWM_HZ / 329	@ 低いミ
	.equ	KEY_4F, PWM_HZ / 349	@ 低いファ
	.equ	KEY_4G, PWM_HZ / 391    @ 低いソ
	.equ	KEY_4Af, PWM_HZ / 415	@ ラ♭
	.equ    KEY_4A, PWM_HZ / 440    @ 440Hz のときの1周期のクロック数 ラ
	.equ	KEY_4Bf, PWM_HZ / 466	@ シ♭
	.equ	KEY_4B, PWM_HZ / 494	@ シ
	.equ	KEY_5C, PWM_HZ / 523	@ ド
	.equ	KEY_5D, PWM_HZ / 587	@ レ
	.equ	KEY_5Ef, PWM_HZ / 622	@ ミ♭
	.equ	KEY_5E, PWM_HZ / 659	@ ミ
	.equ	KEY_5F, PWM_HZ / 698	@ ファ
	.equ	KEY_5G, PWM_HZ / 784	@ ソ
	.equ	KEY_5A, PWM_HZ / 880	@ 高いラ

	.equ	GPFSEL_VEC1, 0x10000001  @ GPIO #19 #10 を出力用に設定
	.equ	PWM_CTL, 0x8100

	.section .text
	.global music
music:
	@(GPIO #19 を含め，GPIOの用途を設定する)
	ldr	r2, =GPIO_BASE
@	ldr	r3, =GPFSEL_VEC1
@	str	r3, [r2, #GPFSEL0 + 4]
	
	@(PWM のクロックソースを設定する)
	ldr	r4, =CM_BASE
	ldr	r5, =0x5a000021
	str	r5, [r4, #CM_PWMCTL]
	
1:	ldr	r5, [r4, #CM_PWMCTL]
	tst	r5, #0x80
	bne	1b

	ldr	r5, =(0x5a000000 | (2 << 12))
	str	r5, [r4, #CM_PWMDIV]
	ldr	r5, =0x5a000211
	str	r5, [r4, #CM_PWMCTL]
	
	@(PWM の動作モードを設定する)
	ldr	r0, =PWM_BASE
	ldr	r6, =PWM_CTL
	str	r6, [r0, #GPFSEL0]

	@ドドドドー　ラ♭ーシ♭ードッシ♭ドー  ソーファーソーファシ♭ーシ♭ラーシ♭ラーラソーファーミーファレー　ソーファーソーファシ♭ーシ♭ラーシ♭ラーラソーファーソーシ♭ドー　
	ldr	r10, =TIMER_BASE
	
	@ ドの音を鳴らす
	ldr    r0, =PWM_BASE
	ldr    r1, =KEY_5C
	str    r1, [r0, #PWM_RNG2]
	lsr    r1, r1, #1
	str    r1, [r0, #PWM_DAT2]

	ldr	r7, =0x12500
	ldr	r9, [r10, #TIMER_CLO]
	add	r11, r9, r7

1:	ldr	r9, [r10, #TIMER_CLO]
	cmp	r9, r11	
	bmi	1b

	ldr	r7, =GPFSEL0
	str	r7, [r0, #PWM_DAT2]

	ldr	r7, =0x12500
	ldr	r9, [r10, #TIMER_CLO]
	add	r11, r9, r7
2:	ldr	r9, [r10, #TIMER_CLO]
	cmp	r9, r11
	bmi	2b

	@ ドの音を鳴らす
	ldr    r0, =PWM_BASE
	ldr    r1, =KEY_5C
	str    r1, [r0, #PWM_RNG2]
	lsr    r1, r1, #1
	str    r1, [r0, #PWM_DAT2]

	ldr	r7, =0x12500
	ldr	r9, [r10, #TIMER_CLO]
	add	r11, r9, r7
3:	ldr	r9, [r10, #TIMER_CLO]
	cmp	r9, r11
	bmi	3b

	ldr	r7, =GPFSEL0
	str	r7, [r0, #PWM_DAT2]

	ldr	r7, =0x12500
	ldr	r9, [r10, #TIMER_CLO]
	add	r11, r9, r7
4:	ldr	r9, [r10, #TIMER_CLO]
	cmp	r9, r11
	bmi	4b

	@ ドの音を鳴らす
	ldr    r0, =PWM_BASE
	ldr    r1, =KEY_5C
	str    r1, [r0, #PWM_RNG2]
	lsr    r1, r1, #1
	str    r1, [r0, #PWM_DAT2]

	ldr	r7, =0x12500
	ldr	r9, [r10, #TIMER_CLO]
	add	r11, r9, r7
5:	ldr	r9, [r10, #TIMER_CLO]
	cmp	r9, r11
	bmi	5b

	ldr	r7, =GPFSEL0
	str	r7, [r0, #PWM_DAT2]

	ldr	r7, =0x12500
	ldr	r9, [r10, #TIMER_CLO]
	add	r11, r9, r7
6:	ldr	r9, [r10, #TIMER_CLO]
	cmp	r9, r11
	bmi	6b

	@ ドの音を鳴らす
	ldr    r0, =PWM_BASE
	ldr    r1, =KEY_5C
	str    r1, [r0, #PWM_RNG2]
	lsr    r1, r1, #1
	str    r1, [r0, #PWM_DAT2]

	ldr	r7, =0x75000
	ldr	r9, [r10, #TIMER_CLO]
	add	r11, r9, r7
7:	ldr	r9, [r10, #TIMER_CLO]
	cmp	r9, r11
	bmi	7b

	@ ラ♭の音を鳴らす
	ldr    r0, =PWM_BASE
	ldr    r1, =KEY_4Af
	str    r1, [r0, #PWM_RNG2]
	lsr    r1, r1, #1
	str    r1, [r0, #PWM_DAT2]

	ldr	r7, =0x75000
	ldr	r9, [r10, #TIMER_CLO]
	add	r11, r9, r7
8:	ldr	r9, [r10, #TIMER_CLO]
	cmp	r9, r11
	bmi	8b

	@ シ♭の音を鳴らす
	ldr    r0, =PWM_BASE
	ldr    r1, =KEY_4Bf
	str    r1, [r0, #PWM_RNG2]
	lsr    r1, r1, #1
	str    r1, [r0, #PWM_DAT2]

	ldr	r7, =0x75000
	ldr	r9, [r10, #TIMER_CLO]
	add	r11, r9, r7
9:	ldr	r9, [r10, #TIMER_CLO]
	cmp	r9, r11
	bmi	9b

	@ ドの音を鳴らす
	ldr    r0, =PWM_BASE
	ldr    r1, =KEY_5C
	str    r1, [r0, #PWM_RNG2]
	lsr    r1, r1, #1
	str    r1, [r0, #PWM_DAT2]

	ldr	r7, =0x25000
	ldr	r9, [r10, #TIMER_CLO]
	add	r11, r9, r7
10:	ldr	r9, [r10, #TIMER_CLO]
	cmp	r9, r11
	bmi	10b

	ldr	r7, =GPFSEL0
	str	r7, [r0, #PWM_DAT2]

	ldr	r7, =0x25000
	ldr	r9, [r10, #TIMER_CLO]
	add	r11, r9, r7
11:	ldr	r9, [r10, #TIMER_CLO]
	cmp	r9, r11
	bmi	11b

	@ シ♭の音を鳴らす
	ldr    r0, =PWM_BASE
	ldr    r1, =KEY_4Bf
	str    r1, [r0, #PWM_RNG2]
	lsr    r1, r1, #1
	str    r1, [r0, #PWM_DAT2]

	ldr	r7, =0x25000
	ldr	r9, [r10, #TIMER_CLO]
	add	r11, r9, r7
12:	ldr	r9, [r10, #TIMER_CLO]
	cmp	r9, r11
	bmi	12b

	@ ドの音を鳴らす
	ldr    r0, =PWM_BASE
	ldr    r1, =KEY_5C
	str    r1, [r0, #PWM_RNG2]
	lsr    r1, r1, #1
	str    r1, [r0, #PWM_DAT2]

	ldr	r7, =0x225000
	ldr	r9, [r10, #TIMER_CLO]
	add	r11, r9, r7
13:	ldr	r9, [r10, #TIMER_CLO]
	cmp	r9, r11
	bmi	13b

	ldr	r7, =GPFSEL0
	str	r7, [r0, #PWM_DAT2]

	ldr	r7, =0x000001
	ldr	r9, [r10, #TIMER_CLO]
	add	r11, r9, r7
11:	ldr	r9, [r10, #TIMER_CLO]
	cmp	r9, r11
	bmi	11b



ff:

	
	
	@ ソの音を鳴らす
	ldr    r0, =PWM_BASE
	ldr    r1, =KEY_4G
	str    r1, [r0, #PWM_RNG2]
	lsr    r1, r1, #1
	str    r1, [r0, #PWM_DAT2]

	ldr	r7, =0x75000
	ldr	r9, [r10, #TIMER_CLO]
	add	r11, r9, r7
14:	ldr	r9, [r10, #TIMER_CLO]
	cmp	r9, r11
	bmi	14b

	ldr	r7, =GPFSEL0
	str	r7, [r0, #PWM_DAT2]

	ldr	r7, =0x000001
	ldr	r9, [r10, #TIMER_CLO]
	add	r11, r9, r7
11:	ldr	r9, [r10, #TIMER_CLO]
	cmp	r9, r11
	bmi	11b

	@ ファの音を鳴らす
	ldr    r0, =PWM_BASE
	ldr    r1, =KEY_4F
	str    r1, [r0, #PWM_RNG2]
	lsr    r1, r1, #1
	str    r1, [r0, #PWM_DAT2]

	ldr	r7, =0x75000
	ldr	r9, [r10, #TIMER_CLO]
	add	r11, r9, r7
15:	ldr	r9, [r10, #TIMER_CLO]
	cmp	r9, r11
	bmi	15b

	@ ソの音を鳴らす
	ldr    r0, =PWM_BASE
	ldr    r1, =KEY_4G
	str    r1, [r0, #PWM_RNG2]
	lsr    r1, r1, #1
	str    r1, [r0, #PWM_DAT2]

	ldr	r7, =0x75000
	ldr	r9, [r10, #TIMER_CLO]
	add	r11, r9, r7
16:	ldr	r9, [r10, #TIMER_CLO]
	cmp	r9, r11
	bmi	16b

	@ ファの音を鳴らす
	ldr    r0, =PWM_BASE
	ldr    r1, =KEY_4F
	str    r1, [r0, #PWM_RNG2]
	lsr    r1, r1, #1
	str    r1, [r0, #PWM_DAT2]

	ldr	r7, =0x32500
	ldr	r9, [r10, #TIMER_CLO]
	add	r11, r9, r7
17:	ldr	r9, [r10, #TIMER_CLO]
	cmp	r9, r11
	bmi	17b

	@ シ♭の音を鳴らす
	ldr    r0, =PWM_BASE
	ldr    r1, =KEY_4Bf
	str    r1, [r0, #PWM_RNG2]
	lsr    r1, r1, #1
	str    r1, [r0, #PWM_DAT2]

	ldr	r7, =0x75000
	ldr	r9, [r10, #TIMER_CLO]
	add	r11, r9, r7
18:	ldr	r9, [r10, #TIMER_CLO]
	cmp	r9, r11
	bmi	18b

	ldr	r7, =GPFSEL0
	str	r7, [r0, #PWM_DAT2]

	ldr	r7, =0x75000
	ldr	r9, [r10, #TIMER_CLO]
	add	r11, r9, r7
2:	ldr	r9, [r10, #TIMER_CLO]
	cmp	r9, r11
	bmi	2b

	@ シ♭の音を鳴らす
	ldr    r0, =PWM_BASE
	ldr    r1, =KEY_4Bf
	str    r1, [r0, #PWM_RNG2]
	lsr    r1, r1, #1
	str    r1, [r0, #PWM_DAT2]

	ldr	r7, =0x32500
	ldr	r9, [r10, #TIMER_CLO]
	add	r11, r9, r7
19:	ldr	r9, [r10, #TIMER_CLO]
	cmp	r9, r11
	bmi	19b

	@ ラの音を鳴らす
	ldr    r0, =PWM_BASE
	ldr    r1, =KEY_4A
	str    r1, [r0, #PWM_RNG2]
	lsr    r1, r1, #1
	str    r1, [r0, #PWM_DAT2]

	ldr	r7, =0x150000
	ldr	r9, [r10, #TIMER_CLO]
	add	r11, r9, r7
20:	ldr	r9, [r10, #TIMER_CLO]
	cmp	r9, r11
	bmi	20b

	@ シ♭の音を鳴らす
	ldr    r0, =PWM_BASE
	ldr    r1, =KEY_4Bf
	str    r1, [r0, #PWM_RNG2]
	lsr    r1, r1, #1
	str    r1, [r0, #PWM_DAT2]

	ldr	r7, =0x75000
	ldr	r9, [r10, #TIMER_CLO]
	add	r11, r9, r7
21:	ldr	r9, [r10, #TIMER_CLO]
	cmp	r9, r11
	bmi	21b

	@ ラの音を鳴らす
	ldr    r0, =PWM_BASE
	ldr    r1, =KEY_4A
	str    r1, [r0, #PWM_RNG2]
	lsr    r1, r1, #1
	str    r1, [r0, #PWM_DAT2]

	ldr	r7, =0x137500
	ldr	r9, [r10, #TIMER_CLO]
	add	r11, r9, r7
22:	ldr	r9, [r10, #TIMER_CLO]
	cmp	r9, r11
	bmi	22b

	ldr	r7, =GPFSEL0
	str	r7, [r0, #PWM_DAT2]

	ldr	r7, =0x12500
	ldr	r9, [r10, #TIMER_CLO]
	add	r11, r9, r7
23:	ldr	r9, [r10, #TIMER_CLO]
	cmp	r9, r11
	bmi	23b

	@ ラの音を鳴らす
	ldr    r0, =PWM_BASE
	ldr    r1, =KEY_4A
	str    r1, [r0, #PWM_RNG2]
	lsr    r1, r1, #1
	str    r1, [r0, #PWM_DAT2]

	ldr	r7, =0x75000
	ldr	r9, [r10, #TIMER_CLO]
	add	r11, r9, r7
24:	ldr	r9, [r10, #TIMER_CLO]
	cmp	r9, r11
	bmi	24b

	@ ソの音を鳴らす
	ldr    r0, =PWM_BASE
	ldr    r1, =KEY_4G
	str    r1, [r0, #PWM_RNG2]
	lsr    r1, r1, #1
	str    r1, [r0, #PWM_DAT2]

	ldr	r7, =0x150000
	ldr	r9, [r10, #TIMER_CLO]
	add	r11, r9, r7
25:	ldr	r9, [r10, #TIMER_CLO]
	cmp	r9, r11
	bmi	25b

	@ ファの音を鳴らす
	ldr    r0, =PWM_BASE
	ldr    r1, =KEY_4F
	str    r1, [r0, #PWM_RNG2]
	lsr    r1, r1, #1
	str    r1, [r0, #PWM_DAT2]

	ldr	r7, =0x150000
	ldr	r9, [r10, #TIMER_CLO]
	add	r11, r9, r7
26:	ldr	r9, [r10, #TIMER_CLO]
	cmp	r9, r11
	bmi	26b	

	@ ミの音を鳴らす
	ldr    r0, =PWM_BASE
	ldr    r1, =KEY_4E
	str    r1, [r0, #PWM_RNG2]
	lsr    r1, r1, #1
	str    r1, [r0, #PWM_DAT2]

	ldr	r7, =0x150000
	ldr	r9, [r10, #TIMER_CLO]
	add	r11, r9, r7
27:	ldr	r9, [r10, #TIMER_CLO]
	cmp	r9, r11
	bmi	27b

	@ ファの音を鳴らす
	ldr    r0, =PWM_BASE
	ldr    r1, =KEY_4F
	str    r1, [r0, #PWM_RNG2]
	lsr    r1, r1, #1
	str    r1, [r0, #PWM_DAT2]

	ldr	r7, =0x75000
	ldr	r9, [r10, #TIMER_CLO]
	add	r11, r9, r7
28:	ldr	r9, [r10, #TIMER_CLO]
	cmp	r9, r11
	bmi	28b

	@ レの音を鳴らす
	ldr    r0, =PWM_BASE
	ldr    r1, =KEY_4D
	str    r1, [r0, #PWM_RNG2]
	lsr    r1, r1, #1
	str    r1, [r0, #PWM_DAT2]

	ldr	r7, =0x675000
	ldr	r9, [r10, #TIMER_CLO]
	add	r11, r9, r7
29:	ldr	r9, [r10, #TIMER_CLO]
	cmp	r9, r11
	bmi	29b

	ldr	r7, =GPFSEL0
	str	r7, [r0, #PWM_DAT2]

	ldr	r7, =0x000001
	ldr	r9, [r10, #TIMER_CLO]
	add	r11, r9, r7
29:	ldr	r9, [r10, #TIMER_CLO]
	cmp	r9, r11
	bmi	29b





	

	
	@ ソの音を鳴らす
	ldr    r0, =PWM_BASE
	ldr    r1, =KEY_4G
	str    r1, [r0, #PWM_RNG2]
	lsr    r1, r1, #1
	str    r1, [r0, #PWM_DAT2]

	ldr	r7, =0x150000
	ldr	r9, [r10, #TIMER_CLO]
	add	r11, r9, r7
31:	ldr	r9, [r10, #TIMER_CLO]
	cmp	r9, r11
	bmi	31b

	@ ファの音を鳴らす
	ldr    r0, =PWM_BASE
	ldr    r1, =KEY_4F
	str    r1, [r0, #PWM_RNG2]
	lsr    r1, r1, #1
	str    r1, [r0, #PWM_DAT2]

	ldr	r7, =0x150000
	ldr	r9, [r10, #TIMER_CLO]
	add	r11, r9, r7
32:	ldr	r9, [r10, #TIMER_CLO]
	cmp	r9, r11
	bmi	32b

	@ ソの音を鳴らす
	ldr    r0, =PWM_BASE
	ldr    r1, =KEY_4G
	str    r1, [r0, #PWM_RNG2]
	lsr    r1, r1, #1
	str    r1, [r0, #PWM_DAT2]

	ldr	r7, =0x150000
	ldr	r9, [r10, #TIMER_CLO]
	add	r11, r9, r7
33:	ldr	r9, [r10, #TIMER_CLO]
	cmp	 r9, r11
	bmi	33b

	@ ファの音を鳴らす
	ldr    r0, =PWM_BASE
	ldr    r1, =KEY_4F
	str    r1, [r0, #PWM_RNG2]
	lsr    r1, r1, #1
	str    r1, [r0, #PWM_DAT2]

	ldr	r7, =0x75000
	ldr	r9, [r10, #TIMER_CLO]
	add	r11, r9, r7
34:	ldr	r9, [r10, #TIMER_CLO]
	cmp	r9, r11
	bmi	34b

	@ シ♭の音を鳴らす
	ldr    r0, =PWM_BASE
	ldr    r1, =KEY_4Bf
	str    r1, [r0, #PWM_RNG2]
	lsr    r1, r1, #1
	str    r1, [r0, #PWM_DAT2]

	ldr	r7, =0x137500
	ldr	r9, [r10, #TIMER_CLO]
	add	 r11, r9, r7
35:	ldr	r9, [r10, #TIMER_CLO]
	cmp	r9, r11
	bmi	35b

	ldr	r7, =GPFSEL0
	str	r7, [r0, #PWM_DAT2]

	ldr	r7, =0x0012500
	ldr	r9, [r10, #TIMER_CLO]
	add	r11, r9, r7
36:	ldr	r9, [r10, #TIMER_CLO]
	cmp	r9, r11
	bmi	36b

	@ シ♭の音を鳴らす
	ldr    r0, =PWM_BASE
	ldr    r1, =KEY_4Bf
	str    r1, [r0, #PWM_RNG2]
	lsr    r1, r1, #1
	str    r1, [r0, #PWM_DAT2]

	ldr	r7, =0x75000
	ldr	r9, [r10, #TIMER_CLO]
	add	r11, r9, r7
37:	ldr	r9, [r10, #TIMER_CLO]
	cmp	r9, r11
	bmi	37b

	@ ラの音を鳴らす
	ldr    r0, =PWM_BASE
	ldr    r1, =KEY_4A
	str    r1, [r0, #PWM_RNG2]
	lsr    r1, r1, #1
	str    r1, [r0, #PWM_DAT2]

	ldr	r7, =0x150000
	ldr	r9, [r10, #TIMER_CLO]
	add	r11, r9, r7
38:	ldr	r9, [r10, #TIMER_CLO]
	cmp	r9, r11
	bmi	38b

	@ シ♭の音を鳴らす
	ldr    r0, =PWM_BASE
	ldr    r1, =KEY_4Bf
	str    r1, [r0, #PWM_RNG2]
	lsr    r1, r1, #1
	str    r1, [r0, #PWM_DAT2]

	ldr	r7, =0x75000
	ldr	r9, [r10, #TIMER_CLO]
	add	r11, r9, r7
39:	ldr	r9, [r10, #TIMER_CLO]
	cmp	r9, r11
	bmi	39b

	@ ラの音を鳴らす
	ldr    r0, =PWM_BASE
	ldr    r1, =KEY_4A
	str    r1, [r0, #PWM_RNG2]
	lsr    r1, r1, #1
	str    r1, [r0, #PWM_DAT2]

	ldr	r7, =0x137500
	ldr	r9, [r10, #TIMER_CLO]
	add	r11, r9, r7
40:	ldr	r9, [r10, #TIMER_CLO]
	cmp	r9, r11
	bmi	40b

	ldr	r7, =GPFSEL0
	str	r7, [r0, #PWM_DAT2]

	ldr	r7, =0x0012500
	ldr	r9, [r10, #TIMER_CLO]
	add	r11, r9, r7
41:	ldr	r9, [r10, #TIMER_CLO]
	cmp	r9, r11
	bmi	41b

	@ ラの音を鳴らす
	ldr    r0, =PWM_BASE
	ldr    r1, =KEY_4A
	str    r1, [r0, #PWM_RNG2]
	lsr    r1, r1, #1
	str    r1, [r0, #PWM_DAT2]

	ldr	r7, =0x75000
	ldr	r9, [r10, #TIMER_CLO]
	add	r11, r9, r7
42:	ldr	r9, [r10, #TIMER_CLO]
	cmp	r9, r11
	bmi	42b

	ldr	r7, =GPFSEL0
	str	r7, [r0, #PWM_DAT2]

	ldr	r7, =0x000001
	ldr	r9, [r10, #TIMER_CLO]
	add	r11, r9, r7
43:	ldr 	r9, [r10, #TIMER_CLO]
	cmp	r9, r11
	bmi	43b

	@ ソの音を鳴らす
	ldr    r0, =PWM_BASE
	ldr    r1, =KEY_4G
	str    r1, [r0, #PWM_RNG2]
	lsr    r1, r1, #1
	str    r1, [r0, #PWM_DAT2]

	ldr	r7, =0x150000
	ldr	r9, [r10, #TIMER_CLO]
	add	r11, r9, r7
44:	ldr	r9, [r10, #TIMER_CLO]
	cmp	r9, r11
	bmi	44b

	@ ファの音を鳴らす
	ldr    r0, =PWM_BASE
	ldr    r1, =KEY_4F
	str    r1, [r0, #PWM_RNG2]
	lsr    r1, r1, #1
	str    r1, [r0, #PWM_DAT2]

	ldr	r7, =0x150000
	ldr	r9, [r10, #TIMER_CLO]
	add	r11, r9, r7
45:	ldr	r9, [r10, #TIMER_CLO]
	cmp	r9, r11
	bmi	45b

	@ ソの音を鳴らす
	ldr    r0, =PWM_BASE
	ldr    r1, =KEY_4G
	str    r1, [r0, #PWM_RNG2]
	lsr    r1, r1, #1
	str    r1, [r0, #PWM_DAT2]

	ldr	r7, =0x150000
	ldr	r9, [r10, #TIMER_CLO]
	add	r11, r9, r7
46:	ldr	r9, [r10, #TIMER_CLO]
	cmp	r9, r11
	bmi	46b

	@ シ♭の音を鳴らす
	ldr    r0, =PWM_BASE
	ldr    r1, =KEY_4Bf
	str    r1, [r0, #PWM_RNG2]
	lsr    r1, r1, #1
	str    r1, [r0, #PWM_DAT2]

	ldr	r7, =0x75000
	ldr	r9, [r10, #TIMER_CLO]
	add	r11, r9, r7
47:	ldr	r9, [r10, #TIMER_CLO]
	cmp	r9, r11
	bmi	47b

	@ ドの音を鳴らす
	ldr    r0, =PWM_BASE
	ldr    r1, =KEY_5C
	str    r1, [r0, #PWM_RNG2]
	lsr    r1, r1, #1
	str    r1, [r0, #PWM_DAT2]

	ldr	r7, =0x675000
	ldr	r9, [r10, #TIMER_CLO]
	add	r11, r9, r7
48:	ldr	r9, [r10, #TIMER_CLO]
	cmp	r9, r11
	bmi	48b

	ldr	r7, =GPFSEL0
	str	r7, [r0, #PWM_DAT2]

	ldr	r7, =0x000001
	ldr	r9, [r10, #TIMER_CLO]
	add	r11, r9, r7
49:	ldr	r9, [r10, #TIMER_CLO]
	cmp	r9, r11
	bmi	49b
	
	bx	r14
	

