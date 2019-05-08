	.equ    GPIO_BASE,  0x3f200000 @ GPIO�١������ɥ쥹
	.equ    GPFSEL0,    0x00       @ GPIO�ݡ��Ȥε�ǽ�����򤹤����ϤΥ��ե��å�
	.equ    GPSET0,     0x1C       @ GPIO�ݡ��Ȥν����ͤ�1�ˤ��뤿������ϤΥ��ե��å�
	.equ    GPCLR0,     0x28       @ GPIO�ܡ��Ȥν����ͤ�0�ˤ��뤿������ϤΥ��ե��å�

	.equ    CM_BASE,    0x3f101000
	.equ    CM_PWMCTL,  0xa0
	.equ    CM_PWMDIV,  0xa4

	
	.equ    PWM_BASE,   0x3f20c000
	.equ    PWM_RNG2,   0x20
	.equ    PWM_DAT2,   0x24
	.equ    PWM_HZ,     9600 * 1000
	.equ    KEY_4A, PWM_HZ / 440     @ 440Hz �ΤȤ���1�����Υ���å��� ��
	.equ    KEY_4B, PWM_HZ / 494     @��
	.equ	KEY_5C, PWM_HZ / 523	 @��
	.equ	KEY_5D, PWM_HZ / 587	 @��
	.equ 	KEY_5E, PWM_HZ / 659     @��
	.equ	KEY_5F, PWM_HZ / 698	 @�ե�
	.equ	KEY_5G, PWM_HZ / 784	 @��
	.equ	KEY_5A, PWM_HZ / 880	 @��

	.equ    TIMER_BASE, 0x3f003000 @ �����ƥॿ���ޤ�����쥸�������ޥåפ��줿���ϤΥ١������ɥ쥹
        .equ    TIMER_HZ, 80000    @ �����ޡ����ȿ� 1MHz
        .equ    TIMER_CLO,  0x4


	.equ    GPFSEL_VEC1, 0x10000001 @ GPFSEL1 �����ꤹ���� (GPIO #19��010������)
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
	
	@ (GPIO #19 ��ޤᡤGPIO�����Ӥ����ꤹ��)
	ldr    r2, =GPIO_BASE
	
	@ (PWM �Υ���å������������ꤹ��)

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

	
	@(PWM ��ư��⡼�ɤ����ꤹ��)
	ldr	r3, =PWM_BASE
	ldr     r0, =PWM_CTL
	str     r0, [r3, #GPFSEL0]
	
	ldr     r0, =PWM_BASE
	ldr	r3, =PWM_HZ 

	ldr	r5, =GPFSEL0
	@ r1�˼��ȿ�����Ƭ����, r2�˲���������륵�֥롼����
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
