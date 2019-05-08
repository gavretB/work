	.equ    GPIO_BASE,  0x3f200000 @ GPIO�١������ɥ쥹
	.equ    GPFSEL0,    0x00       @ GPIO�ݡ��Ȥε�ǽ�����򤹤����ϤΥ��ե��å�
	.equ    GPSET0,     0x1C       @ GPIO�ݡ��Ȥν����ͤ�1�ˤ��뤿������ϤΥ��ե��å�
	.equ    GPCLR0,     0x28       @ GPIO�ܡ��Ȥν����ͤ�0�ˤ��뤿������ϤΥ��ե��å�

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
	.equ	KEY_4D, PWM_HZ / 293	@ �㤤��
	.equ	KEY_4E, PWM_HZ / 329	@ �㤤��
	.equ	KEY_4F, PWM_HZ / 349	@ �㤤�ե�
	.equ	KEY_4G, PWM_HZ / 391    @ �㤤��
	.equ	KEY_4Af, PWM_HZ / 415	@ ���
	.equ    KEY_4A, PWM_HZ / 440    @ 440Hz �ΤȤ���1�����Υ���å��� ��
	.equ	KEY_4Bf, PWM_HZ / 466	@ ����
	.equ	KEY_4B, PWM_HZ / 494	@ ��
	.equ	KEY_5C, PWM_HZ / 523	@ ��
	.equ	KEY_5D, PWM_HZ / 587	@ ��
	.equ	KEY_5Ef, PWM_HZ / 622	@ �ߢ�
	.equ	KEY_5E, PWM_HZ / 659	@ ��
	.equ	KEY_5F, PWM_HZ / 698	@ �ե�
	.equ	KEY_5G, PWM_HZ / 784	@ ��
	.equ	KEY_5A, PWM_HZ / 880	@ �⤤��

	.equ	GPFSEL_VEC1, 0x10000001  @ GPIO #19 #10 ������Ѥ�����
	.equ	PWM_CTL, 0x8100

	.section .text
	.global music
music:
	@(GPIO #19 ��ޤᡤGPIO�����Ӥ����ꤹ��)
	ldr	r2, =GPIO_BASE
@	ldr	r3, =GPFSEL_VEC1
@	str	r3, [r2, #GPFSEL0 + 4]
	
	@(PWM �Υ���å������������ꤹ��)
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
	
	@(PWM ��ư��⡼�ɤ����ꤹ��)
	ldr	r0, =PWM_BASE
	ldr	r6, =PWM_CTL
	str	r6, [r0, #GPFSEL0]

	@�ɥɥɥɡ���������������ɥå����ɡ�  �����ե��������ե������������顼�����顼�饽���ե����ߡ��ե��졼�������ե��������ե������������顼�����顼�饽���ե������������ɡ���
	ldr	r10, =TIMER_BASE
	
	@ �ɤβ����Ĥ餹
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

	@ �ɤβ����Ĥ餹
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

	@ �ɤβ����Ĥ餹
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

	@ �ɤβ����Ĥ餹
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

	@ ����β����Ĥ餹
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

	@ �����β����Ĥ餹
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

	@ �ɤβ����Ĥ餹
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

	@ �����β����Ĥ餹
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

	@ �ɤβ����Ĥ餹
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

	
	
	@ ���β����Ĥ餹
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

	@ �ե��β����Ĥ餹
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

	@ ���β����Ĥ餹
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

	@ �ե��β����Ĥ餹
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

	@ �����β����Ĥ餹
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

	@ �����β����Ĥ餹
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

	@ ��β����Ĥ餹
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

	@ �����β����Ĥ餹
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

	@ ��β����Ĥ餹
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

	@ ��β����Ĥ餹
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

	@ ���β����Ĥ餹
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

	@ �ե��β����Ĥ餹
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

	@ �ߤβ����Ĥ餹
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

	@ �ե��β����Ĥ餹
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

	@ ��β����Ĥ餹
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





	

	
	@ ���β����Ĥ餹
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

	@ �ե��β����Ĥ餹
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

	@ ���β����Ĥ餹
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

	@ �ե��β����Ĥ餹
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

	@ �����β����Ĥ餹
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

	@ �����β����Ĥ餹
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

	@ ��β����Ĥ餹
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

	@ �����β����Ĥ餹
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

	@ ��β����Ĥ餹
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

	@ ��β����Ĥ餹
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

	@ ���β����Ĥ餹
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

	@ �ե��β����Ĥ餹
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

	@ ���β����Ĥ餹
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

	@ �����β����Ĥ餹
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

	@ �ɤβ����Ĥ餹
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
	

