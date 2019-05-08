@ �ե졼��Хåե����Ѥ��ƥǥ����ץ쥤���00���99�򷫤��֤�ɽ������ץ����

    .equ    GPIO_BASE,  0x3f200000 @ GPIO�١������ɥ쥹
    .equ    GPFSEL0,    0x00       @ GPIO�ݡ��Ȥε�ǽ�����򤹤����ϤΥ��ե��å�
    .equ    GPSET0,     0x1C       @ GPIO�ݡ��Ȥν����ͤ�1�ˤ��뤿������ϤΥ��ե��å�
    .equ    GPCLR0,     0x28       @ GPIO�ܡ��Ȥν����ͤ�0�ˤ��뤿������ϤΥ��ե��å�
    .equ    STACK,      0x8000
    .equ    TIMER_BASE, 0x3f003000 @ �����ƥॿ���ޤ�����쥸�������ޥåפ��줿���ϤΥ١������ɥ쥹
    .equ    TIMER_HZ,   500000  @ �����ޡ��μ��ȿ� 1 MHz ��
    .equ    TIMER_HZ_1000, 1000    @ �����ޡ����ȿ� 1MHz �� 1/1000
    .equ    TIMER_CLO,  0x4
	
    .equ    GPFSEL_VEC0, 0x01201000 @ GPFSEL0 �����ꤹ���� (GPIO #4, #7, #8 ������Ѥ�����)
    .equ    GPFSEL_VEC1, 0x01249041 @ GPFSEL1 �����ꤹ���� (GPIO #10, #12, #14, #15, #16, #17, #18 ������Ѥ�����)
    .equ    GPFSEL_VEC2, 0x00209249 @ GPFSEL2 �����ꤹ���� (GPIO #20, #21, #22, #23, #24, #25, #27 ������Ѥ�����)
  

    .equ COL1_PORT, 27
    .equ COL2_PORT, 8
    .equ COL3_PORT, 25
    .equ COL4_PORT, 23
    .equ COL5_PORT, 24
    .equ COL6_PORT, 22
    .equ COL7_PORT, 17
    .equ COL8_PORT, 4
    .equ ROW1_PORT, 14
    .equ ROW2_PORT, 15
    .equ ROW3_PORT, 21
    .equ ROW4_PORT, 18
    .equ ROW5_PORT, 12
    .equ ROW6_PORT, 20
    .equ ROW7_PORT, 7
    .equ ROW8_PORT, 16

    .section .text
    .global clear_tv, _gameover_tv

clear_tv:
    mov     sp, #STACK

    @ �쥸�������ͤ���¸
	str	r0, [sp, #-4]!
	str	r1, [sp, #-4]!
	str	r2, [sp, #-4]!
	str	r3, [sp, #-4]!
	str	r4, [sp, #-4]!
	str	r5, [sp, #-4]!
	str	r6, [sp, #-4]!
	str	r7, [sp, #-4]!
	str	r8, [sp, #-4]!
	str	r9, [sp, #-4]!
	str	r10,[sp, #-4]!
	str	r11, [sp, #-4]!
	str	r12, [sp, #-4]!
	str	r14, [sp, #-4]!
	sub	sp, sp, #4
	
    @ LED�ȥǥ����쥤�Ѥ�IO�ݡ��Ȥ���Ϥ����ꤹ��
    ldr     r0, =GPIO_BASE
    ldr     r1, =GPFSEL_VEC0
    str     r1, [r0, #GPFSEL0 + 0]
    ldr     r1, =GPFSEL_VEC1
    str     r1, [r0, #GPFSEL0 + 4]
    ldr     r1, =GPFSEL_VEC2
    str     r1, [r0, #GPFSEL0 + 8]

	@ �ɤΤ褦�ʿ޷���ɽ�������뤫�η׻���Ԥʤ��ץ������ (�ե졼��Хåե��˽񤭹���)
	mov	r10, #0
	mov	r2, #0

	ldr	r8, =TIMER_BASE
        ldr     r11, =TIMER_HZ           @ 1��ʬ�Υ������
        ldr     r12, [r8, #TIMER_CLO]       @ ���߻���
	movs    r3, #8                   @ �����
loop_c:
	add     r12, r12, r11            @ ��Ū����

	cmp     r3, #8
	ldreq   r10, =bg15
	cmp     r3, #7
	ldreq   r10, =bg16
	cmp     r3, #6
	ldreq   r10, =bg17
	cmp     r3, #5
	ldreq   r10, =bg18
	cmp     r3, #4
	ldreq   r10, =bg19	
        cmp     r3, #3
	ldreq   r10, =bg20
	cmp     r3, #2
	ldreq   r10, =bg21
	cmp     r3, #1
	ldreq   r10, =bg22
	cmp     r3, #0
	ldreq   r10, =bg23
	
timer_c:	
	bl      blink

        ldr     r9, [r8, #TIMER_CLO]
        cmp     r12, r9
        bhi     timer_c

	subs	r3, r3, #1
	ble	loop_c

	@ �쥸����������
	add	sp, sp, #4
	ldr	r14, [sp], #4
	ldr	r12, [sp], #4	
	ldr	r11, [sp], #4
	ldr	r10, [sp], #4
	ldr	r9, [sp], #4
	ldr	r8, [sp], #4
	ldr	r7, [sp], #4	
	ldr	r6, [sp], #4
	ldr	r5, [sp], #4
	ldr	r4, [sp], #4
	ldr	r3, [sp], #4
	ldr	r2, [sp], #4
	ldr	r1, [sp], #4
	ldr	r0, [sp], #4
	
	bx	r14

	b       count			@ ̵�¥롼��

loop:
	b       loop	

gameover_tv:
	mov     sp, #STACK

    @ �쥸�������ͤ���¸
        str	r0, [sp, #-4]!
	str	r1, [sp, #-4]!
	str	r2, [sp, #-4]!
	str	r3, [sp, #-4]!
	str	r4, [sp, #-4]!
	str	r5, [sp, #-4]!
	str	r6, [sp, #-4]!
	str	r7, [sp, #-4]!
	str	r8, [sp, #-4]!
	str	r9, [sp, #-4]!
	str	r10,[sp, #-4]!
	str	r11, [sp, #-4]!
	str	r12, [sp, #-4]!
	str	r14, [sp, #-4]!
	sub	sp, sp, #4
	
    @ LED�ȥǥ����쥤�Ѥ�IO�ݡ��Ȥ���Ϥ����ꤹ��
    ldr     r0, =GPIO_BASE
    ldr     r1, =GPFSEL_VEC0
    str     r1, [r0, #GPFSEL0 + 0]
    ldr     r1, =GPFSEL_VEC1
    str     r1, [r0, #GPFSEL0 + 4]
    ldr     r1, =GPFSEL_VEC2
    str     r1, [r0, #GPFSEL0 + 8]

	@ �ɤΤ褦�ʿ޷���ɽ�������뤫�η׻���Ԥʤ��ץ������ (�ե졼��Хåե��˽񤭹���)
	mov	r10, #0
	mov	r2, #0

	ldr	r8, =TIMER_BASE
        ldr     r11, =TIMER_HZ           @ 1��ʬ�Υ������
        ldr     r12, [r8, #TIMER_CLO]       @ ���߻���
	movs    r3, #14                   @ �����
loop_g:
	add     r12, r12, r11            @ ��Ū����
	
	cmp     r3, #14
	ldreq   r10, =bg0
	cmp	r3, #13
	ldreq	r10, =bg1
	cmp     r3, #12
	ldreq   r10, =bg2
	cmp     r3, #11
	ldreq   r10, =bg3
	cmp     r3, #10
	ldreq   r10, =bg4
	cmp     r3, #9
	ldreq   r10, =bg5
	cmp     r3, #8
	ldreq   r10, =bg6
	cmp     r3, #7
	ldreq   r10, =bg7
	cmp     r3, #6
	ldreq   r10, =bg8
	cmp     r3, #5
	ldreq   r10, =bg9
	cmp     r3, #4
	ldreq   r10, =bg10
	cmp     r3, #3
	ldreq   r10, =bg11
	cmp     r3, #2
	ldreq   r10, =bg12
	cmp     r3, #1
	ldreq   r10, =bg13
	cmp     r3, #0
	ldreq   r10, =bg14
        
timer_g:	
	bl      blink

        ldr     r9, [r8, #TIMER_CLO]
        cmp     r12, r9
        bhi     timer_g

	subs	r3, r3, #1
	ble	loop_g

	@ �쥸����������
	add	sp, sp, #4
	ldr	r14, [sp], #4
	ldr	r12, [sp], #4	
	ldr	r11, [sp], #4
	ldr	r10, [sp], #4
	ldr	r9, [sp], #4
	ldr	r8, [sp], #4
	ldr	r7, [sp], #4	
	ldr	r6, [sp], #4
	ldr	r5, [sp], #4
	ldr	r4, [sp], #4
	ldr	r3, [sp], #4
	ldr	r2, [sp], #4
	ldr	r1, [sp], #4
	ldr	r0, [sp], #4
	
	bx	r14

loop2:
	b       loop2	
	
	
	@ �׻������޷���ɽ����Ԥʤ�(�ե졼��Хåե���ɽ��)
blink:
	@ �쥸�������ͤ�����
        str	r0, [sp, #-4]!
	str	r1, [sp, #-4]!
	str	r2, [sp, #-4]!
	str	r3, [sp, #-4]!
	str	r4, [sp, #-4]!
	str	r5, [sp, #-4]!
	str	r6, [sp, #-4]!
	str	r7, [sp, #-4]!
	str	r8, [sp, #-4]!
	str	r9, [sp, #-4]!
	str	r10, [sp, #-4]!
	str	r11, [sp, #-4]!
	str	r12, [sp, #-4]!
	str	r14, [sp, #-4]!
	sub	sp, sp, #4

	ldr	r8, =TIMER_BASE
        ldr     r11, =TIMER_HZ_1000           @ 0.001��ʬ�Υ������
        ldr     r12, [r8, #TIMER_CLO]       @ ���߻���
        add     r12, r12, r11
1:  
	
	mov     r11, #2 			@ 
	mov     r2, r10
	ldrb    r2, [r2]	
	
	@ ��1�Ԥ�������
	mov     r1, #(1 << ROW1_PORT)
	str     r1, [r0, #GPCLR0]               @ ����
	mov     r1, #(1 << ROW2_PORT)
	str     r1, [r0, #GPSET0]
	mov     r1, #(1 << ROW3_PORT)
	str     r1, [r0, #GPSET0]
	mov     r1, #(1 << ROW4_PORT)
	str     r1, [r0, #GPSET0]
	mov     r1, #(1 << ROW5_PORT)
	str     r1, [r0, #GPSET0]
	mov     r1, #(1 << ROW6_PORT)
	str     r1, [r0, #GPSET0]
	mov     r1, #(1 << ROW7_PORT)
	str     r1, [r0, #GPSET0]
	mov     r1, #(1 << ROW8_PORT)
	str     r1, [r0, #GPSET0]

	@ ��4, 5, 6, 7�� ��������

	bl      retu

        ldr     r9, [r8, #TIMER_CLO]
        cmp     r12, r9
        bhi     1b
	
	@ ��ν����
	bl      reset

	ldr	r8, =TIMER_BASE
        ldr     r11, =TIMER_HZ_1000           @ 0.001��ʬ�Υ������
        ldr     r12, [r8, #TIMER_CLO]       @ ���߻���
        add     r12, r12, r11
2:  
	
	mov     r11, #2 
	mov     r2, r10
	ldrb    r2, [r2, #1]	
	
	@ ��2�Ԥ�������
	mov     r1, #(1 << ROW1_PORT)
	str     r1, [r0, #GPSET0]               
	mov     r1, #(1 << ROW2_PORT)
	str     r1, [r0, #GPCLR0]               
	mov     r1, #(1 << ROW3_PORT)
	str     r1, [r0, #GPSET0]
	mov     r1, #(1 << ROW4_PORT)
	str     r1, [r0, #GPSET0]
	mov     r1, #(1 << ROW5_PORT)
	str     r1, [r0, #GPSET0]
	mov     r1, #(1 << ROW6_PORT)
	str     r1, [r0, #GPSET0]
	mov     r1, #(1 << ROW7_PORT)
	str     r1, [r0, #GPSET0]
	mov     r1, #(1 << ROW8_PORT)
	str     r1, [r0, #GPSET0]

	@ ��3, 8���������
	bl      retu

        ldr     r9, [r8, #TIMER_CLO]
        cmp     r12, r9
        bhi     2b

	@ ��ν����
	bl      reset

	ldr	r8, =TIMER_BASE
        ldr     r11, =TIMER_HZ_1000           @ 0.001��ʬ�Υ������
        ldr     r12, [r8, #TIMER_CLO]       @ ���߻���
        add     r12, r12, r11
3:  	
	mov     r11, #2 
	mov     r2, r10
	ldrb    r2, [r2, #2]	
	
	@ ��3�Ԥ�������
	mov     r1, #(1 << ROW1_PORT)
	str     r1, [r0, #GPSET0]               
	mov     r1, #(1 << ROW2_PORT)
	str     r1, [r0, #GPSET0]               
	mov     r1, #(1 << ROW3_PORT)
	str     r1, [r0, #GPCLR0]
	mov     r1, #(1 << ROW4_PORT)
	str     r1, [r0, #GPSET0]
	mov     r1, #(1 << ROW5_PORT)
	str     r1, [r0, #GPSET0]
	mov     r1, #(1 << ROW6_PORT)
	str     r1, [r0, #GPSET0]
	mov     r1, #(1 << ROW7_PORT)
	str     r1, [r0, #GPSET0]
	mov     r1, #(1 << ROW8_PORT)
	str     r1, [r0, #GPSET0]

	@ ��2, 5, 6�� ��������
	bl      retu

        ldr     r9, [r8, #TIMER_CLO]
        cmp     r12, r9
        bhi     3b
	
	@ ��ν����
	bl      reset

	ldr	r8, =TIMER_BASE
        ldr     r11, =TIMER_HZ_1000           @ 0.001��ʬ�Υ������
        ldr     r12, [r8, #TIMER_CLO]       @ ���߻���
        add     r12, r12, r11
4: 
	
	mov     r11, #2 
	mov     r2, r10
	ldrb    r2, [r2, #3]	
	
	@ ��4�Ԥ�������
	mov     r1, #(1 << ROW1_PORT)
	str     r1, [r0, #GPSET0]               
	mov     r1, #(1 << ROW2_PORT)
	str     r1, [r0, #GPSET0]               
	mov     r1, #(1 << ROW3_PORT)
	str     r1, [r0, #GPSET0]
	mov     r1, #(1 << ROW4_PORT)
	str     r1, [r0, #GPCLR0]
	mov     r1, #(1 << ROW5_PORT)
	str     r1, [r0, #GPSET0]
	mov     r1, #(1 << ROW6_PORT)
	str     r1, [r0, #GPSET0]
	mov     r1, #(1 << ROW7_PORT)
	str     r1, [r0, #GPSET0]
	mov     r1, #(1 << ROW8_PORT)
	str     r1, [r0, #GPSET0]

	@ ��1, 4, 7�� �������� 
	bl      retu

	ldr     r9, [r8, #TIMER_CLO]
        cmp     r12, r9
        bhi     4b

	@ ��ν����
	bl      reset
	
	ldr	r8, =TIMER_BASE
        ldr     r11, =TIMER_HZ_1000           @ 0.001��ʬ�Υ������
        ldr     r12, [r8, #TIMER_CLO]       @ ���߻���
        add     r12, r12, r11
5:  
	
	mov     r11, #2 
	mov     r2, r10
	ldrb    r2, [r2, #4]	
	
	@ ��5�Ԥ�������
	mov     r1, #(1 << ROW1_PORT)
	str     r1, [r0, #GPSET0]               
	mov     r1, #(1 << ROW2_PORT)
	str     r1, [r0, #GPSET0]               
	mov     r1, #(1 << ROW3_PORT)
	str     r1, [r0, #GPSET0]
	mov     r1, #(1 << ROW4_PORT)
	str     r1, [r0, #GPSET0]
	mov     r1, #(1 << ROW5_PORT)
	str     r1, [r0, #GPCLR0]
	mov     r1, #(1 << ROW6_PORT)
	str     r1, [r0, #GPSET0]
	mov     r1, #(1 << ROW7_PORT)
	str     r1, [r0, #GPSET0]
	mov     r1, #(1 << ROW8_PORT)
	str     r1, [r0, #GPSET0]

	@ ��2, 5, 8�� ��������
	bl      retu

	ldr     r9, [r8, #TIMER_CLO]
        cmp     r12, r9
        bhi     5b
	
	@ ��ν����
	bl      reset
	
        ldr	r8, =TIMER_BASE
        ldr     r11, =TIMER_HZ_1000           @ 0.001��ʬ�Υ������
        ldr     r12, [r8, #TIMER_CLO]       @ ���߻���
        add     r12, r12, r11
6:  
	
	mov     r11, #2 
	mov     r2, r10
	ldrb    r2, [r2, #5]	
	
	@ ��6�Ԥ�������
	mov     r1, #(1 << ROW1_PORT)
	str     r1, [r0, #GPSET0]               
	mov     r1, #(1 << ROW2_PORT)
	str     r1, [r0, #GPSET0]               
	mov     r1, #(1 << ROW3_PORT)
	str     r1, [r0, #GPSET0]
	mov     r1, #(1 << ROW4_PORT)
	str     r1, [r0, #GPSET0]
	mov     r1, #(1 << ROW5_PORT)
	str     r1, [r0, #GPSET0]
	mov     r1, #(1 << ROW6_PORT)
	str     r1, [r0, #GPCLR0]
	mov     r1, #(1 << ROW7_PORT)
	str     r1, [r0, #GPSET0]
	mov     r1, #(1 << ROW8_PORT)
	str     r1, [r0, #GPSET0]

	@ ��3, 7���������
	bl      retu

	ldr     r9, [r8, #TIMER_CLO]
        cmp     r12, r9
        bhi     6b
	
	@ ��ν����

	bl      reset
	
	ldr	r8, =TIMER_BASE
        ldr     r11, =TIMER_HZ_1000           @ 0.001��ʬ�Υ������
        ldr     r12, [r8, #TIMER_CLO]       @ ���߻���
        add     r12, r12, r11
7:  
	
	mov     r11, #2 
	mov     r2, r10
	ldrb    r2, [r2, #6]	
	
	@ ��7�Ԥ�������
	mov     r1, #(1 << ROW1_PORT)
	str     r1, [r0, #GPSET0]               
	mov     r1, #(1 << ROW2_PORT)
	str     r1, [r0, #GPSET0]               
	mov     r1, #(1 << ROW3_PORT)
	str     r1, [r0, #GPSET0]
	mov     r1, #(1 << ROW4_PORT)
	str     r1, [r0, #GPSET0]
	mov     r1, #(1 << ROW5_PORT)
	str     r1, [r0, #GPSET0]
	mov     r1, #(1 << ROW6_PORT)
	str     r1, [r0, #GPSET0]
	mov     r1, #(1 << ROW7_PORT)
	str     r1, [r0, #GPCLR0]
	mov     r1, #(1 << ROW8_PORT)
	str     r1, [r0, #GPSET0]

	@ ��4, 6�� ��������

	bl      retu

	ldr     r9, [r8, #TIMER_CLO]
        cmp     r12, r9
        bhi     7b
	
	@ ��ν����
	bl      reset

        ldr	r8, =TIMER_BASE
        ldr     r11, =TIMER_HZ_1000           @ 0.001��ʬ�Υ������
        ldr     r12, [r8, #TIMER_CLO]       @ ���߻���
        add     r12, r12, r11
8:  
	
	mov     r11, #2 
	mov     r2, r10
	ldrb    r2, [r2, #7]	
	
	@ ��8�Ԥ�������
	mov     r1, #(1 << ROW1_PORT)
	str     r1, [r0, #GPSET0]               
	mov     r1, #(1 << ROW2_PORT)
	str     r1, [r0, #GPSET0]               
	mov     r1, #(1 << ROW3_PORT)
	str     r1, [r0, #GPSET0]
	mov     r1, #(1 << ROW4_PORT)
	str     r1, [r0, #GPSET0]
	mov     r1, #(1 << ROW5_PORT)
	str     r1, [r0, #GPSET0]
	mov     r1, #(1 << ROW6_PORT)
	str     r1, [r0, #GPSET0]
	mov     r1, #(1 << ROW7_PORT)
	str     r1, [r0, #GPSET0]
	mov     r1, #(1 << ROW8_PORT)
	str     r1, [r0, #GPCLR0]

	@ ��5�� ��������
	bl      retu

	ldr     r9, [r8, #TIMER_CLO]
        cmp     r12, r9
        bhi     8b
	
	@ ��ν����
	bl      reset

	@ �쥸����������
	add	sp, sp, #4
	ldr	r14, [sp], #4
	ldr	r12, [sp], #4	
	ldr	r11, [sp], #4
	ldr	r10, [sp], #4
	ldr	r9, [sp], #4
	ldr	r8, [sp], #4
	ldr	r7, [sp], #4	
	ldr	r6, [sp], #4
	ldr	r5, [sp], #4
	ldr	r4, [sp], #4
	ldr	r3, [sp], #4
	ldr	r2, [sp], #4
	ldr	r1, [sp], #4
	ldr	r0, [sp], #4

	bx      r14
	
	@ �ɤ����1��Ω�äƤ���Τ����������
retu:
	@ �쥸�������ͤ���¸
        str	r0, [sp, #-4]!
	str	r1, [sp, #-4]!
	str	r3, [sp, #-4]!
	str	r4, [sp, #-4]!
	str	r5, [sp, #-4]!
	str	r6, [sp, #-4]!
	str	r7, [sp, #-4]!
	str	r8, [sp, #-4]!
	str	r9, [sp, #-4]!
	str	r10, [sp, #-4]!
	str	r11, [sp, #-4]!
	str	r12, [sp, #-4]!
	str	r14, [sp, #-4]!
	sub	sp, sp, #4

	@ �׻������ͤ�2�ǳ�ä�;�꤬�ǤƤ���������, 0�ʤ����
	udiv    r3, r2, r11
	mul     r12, r11, r3	
	subs    r2, r2, r12	
	mov     r1, #(1 << COL1_PORT)           
	strne   r1, [r0, #GPSET0]
	streq   r1, [r0, #GPCLR0]
	
	udiv    r4, r3, r11
	mul     r12, r11, r4
	subs    r3, r3, r12
	mov     r1, #(1 << COL2_PORT)
	strne   r1, [r0, #GPSET0]
	streq   r1, [r0, #GPCLR0]
	
	udiv    r5, r4, r11
	mul     r12, r11, r5
	subs    r4, r4, r12
	mov     r1, #(1 << COL3_PORT)
	strne   r1, [r0, #GPSET0]
	streq   r1, [r0, #GPCLR0]
	
	udiv    r6, r5, r11
	mul     r12, r11, r6
	subs    r5, r5, r12
	mov     r1, #(1 << COL4_PORT)
	strne   r1, [r0, #GPSET0]               
	streq   r1, [r0, #GPCLR0]
	
	udiv    r7, r6, r11
	mul     r12, r11, r7
	subs    r6, r6, r12
	mov     r1, #(1 << COL5_PORT)
	strne   r1, [r0, #GPSET0]               
	streq   r1, [r0, #GPCLR0]
	
	udiv    r8, r7, r11
	mul     r12, r11, r8
	subs    r7, r7, r12
	mov     r1, #(1 << COL6_PORT)
	strne   r1, [r0, #GPSET0]               
	streq   r1, [r0, #GPCLR0]
	
	udiv    r9, r8, r11
	mul     r12, r11, r9
	subs    r8, r8, r12
	mov     r1, #(1 << COL7_PORT)
	strne   r1, [r0, #GPSET0]               
	streq   r1, [r0, #GPCLR0]
	
	udiv    r10, r9, r11
	mul     r12, r11, r10
	subs    r9, r9, r12
	mov     r1, #(1 << COL8_PORT)
	strne   r1, [r0, #GPSET0]
	streq   r1, [r0, #GPCLR0]

	@ �쥸�������ͤ�����
	add	sp, sp, #4
	ldr	r14, [sp], #4
	ldr	r12, [sp], #4	
	ldr	r11, [sp], #4
	ldr	r10, [sp], #4
	ldr	r9, [sp], #4
	ldr	r8, [sp], #4
	ldr	r7, [sp], #4	
	ldr	r6, [sp], #4
	ldr	r5, [sp], #4
	ldr	r4, [sp], #4
	ldr	r3, [sp], #4
	ldr	r1, [sp], #4
	ldr	r0, [sp], #4
	
	bx      r14
	
	@ ���ƤιԤ����
reset:
	@ �쥸�������ͤ���¸
        str	r0, [sp, #-4]!
	str	r1, [sp, #-4]!
	str	r2, [sp, #-4]!
	str	r3, [sp, #-4]!
	str	r4, [sp, #-4]!
	str	r5, [sp, #-4]!
	str	r6, [sp, #-4]!
	str	r7, [sp, #-4]!
	str	r8, [sp, #-4]!
	str	r9, [sp, #-4]!
	str	r10,[sp, #-4]!
	str	r11, [sp, #-4]!
	str	r12, [sp, #-4]!
	str	r14, [sp, #-4]!
	sub	sp, sp, #4

	@ ��ξ���
	mov     r1, #(1 << COL1_PORT)
	str     r1, [r0, #GPCLR0]
	mov     r1, #(1 << COL2_PORT)
	str     r1, [r0, #GPCLR0]
	mov     r1, #(1 << COL3_PORT)
	str     r1, [r0, #GPCLR0]
	mov     r1, #(1 << COL4_PORT)
	str     r1, [r0, #GPCLR0]              
	mov     r1, #(1 << COL5_PORT)
	str     r1, [r0, #GPCLR0]               
	mov     r1, #(1 << COL6_PORT)
	str     r1, [r0, #GPCLR0]              
	mov     r1, #(1 << COL7_PORT)
	str     r1, [r0, #GPCLR0]              	
	mov     r1, #(1 << COL8_PORT)
	str     r1, [r0, #GPCLR0]

	@ �쥸����������
	add	sp, sp, #4
	ldr	r14, [sp], #4
	ldr	r12, [sp], #4	
	ldr	r11, [sp], #4
	ldr	r10, [sp], #4
	ldr	r9, [sp], #4
	ldr	r8, [sp], #4
	ldr	r7, [sp], #4	
	ldr	r6, [sp], #4
	ldr	r5, [sp], #4
	ldr	r4, [sp], #4
	ldr	r3, [sp], #4
	ldr	r2, [sp], #4
	ldr	r1, [sp], #4
	ldr	r0, [sp], #4
	
	bx      r14


	
	.section .data
@ gameover
bg0:
.byte 0x3c, 0x42, 0x95, 0x14, 0xc3, 0x08, 0x81, 0x42	
bg1:
.byte 0x3c, 0x42, 0x81, 0x36, 0x00, 0x08, 0x81, 0x42	
bg2:
.byte 0x3c, 0x42, 0x81, 0x36, 0x42, 0x08, 0x81, 0x42
bg3:
.byte 0x3c, 0x42, 0x81, 0x36, 0x00, 0x4a, 0x81, 0x42
bg4:
.byte 0x3c, 0x42, 0x81, 0x36, 0x00, 0x08, 0x81, 0x42
bg5:
.byte 0x3c, 0x42, 0x81, 0x36, 0x42, 0x08, 0x81, 0x42
bg6:
.byte 0x3c, 0x42, 0x81, 0x36, 0x00, 0x4a, 0x81, 0x42
bg7:
.byte 0x00, 0x38, 0x44, 0x04, 0x64, 0x44, 0x78, 0x40
bg8:
.byte 0x00, 0x18, 0x24, 0x24, 0x3c, 0x24, 0x24, 0x00
bg9:
.byte 0x00, 0x28, 0x54, 0x54, 0x54, 0x54, 0x54, 0x00
bg10:
.byte 0x00, 0x7e, 0x02, 0x02, 0x7e, 0x02, 0x7e, 0x00
bg11:
.byte 0x00, 0x18, 0x24, 0x42, 0x42, 0x24, 0x18, 0x00
bg12:
.byte 0x00, 0x44, 0x44, 0x44, 0x44, 0x28, 0x10, 0x00
bg13:
.byte 0x00, 0x7e, 0x02, 0x02, 0x7e, 0x02, 0x7e, 0x00
bg14:
.byte 0x00, 0x3c, 0x44, 0x3c, 0x14, 0x24, 0x44, 0x00

@ clear
bg15:
.byte 0x3c, 0x42, 0x95, 0x14, 0xc3, 0x08, 0x81, 0x42
bg16:
.byte 0x3c, 0x42, 0x95, 0x14, 0xc3, 0x14, 0x89, 0x42
bg17:
.byte 0x3c, 0x42, 0x95, 0x14, 0xc3, 0x08, 0x81, 0x42
bg18:
.byte 0x3c, 0x42, 0x95, 0x14, 0xc3, 0x14, 0x89, 0x42
bg19:
.byte 0x00, 0x3c, 0x42, 0x02, 0x02, 0x42, 0x3c, 0x00
bg20:
.byte 0x00, 0x02, 0x02, 0x02, 0x02, 0x02, 0x7e, 0x00
bg21:
.byte 0x00, 0x7e, 0x02, 0x02, 0x7e, 0x02, 0x7e, 0x00
bg22:	
.byte 0x00, 0x18, 0x24, 0x24, 0x3c, 0x24, 0x24, 0x00
bg23:	
.byte 0x00, 0x3c, 0x44, 0x3c, 0x14, 0x24, 0x44, 0x00
	
