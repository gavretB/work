@ フレームバッファを用いてディスプレイ上に00~99を繰り返し表示するプログラム

    .equ    GPIO_BASE,  0x3f200000 @ GPIOベースアドレス
    .equ    GPFSEL0,    0x00       @ GPIOポートの機能を選択する番地のオフセット
    .equ    GPSET0,     0x1C       @ GPIOポートの出力値を1にするための番地のオフセット
    .equ    GPCLR0,     0x28       @ GPIOボートの出力値を0にするための番地のオフセット
    .equ    STACK,      0x8000
    .equ    TIMER_BASE, 0x3f003000 @ システムタイマの制御レジスタがマップされた番地のベースアドレス
    .equ    TIMER_HZ,   500000  @ タイマーの周波数 1 MHz の
    .equ    TIMER_HZ_1000, 1000    @ タイマー周波数 1MHz の 1/1000
    .equ    TIMER_CLO,  0x4
	
    .equ    GPFSEL_VEC0, 0x01201000 @ GPFSEL0 に設定する値 (GPIO #4, #7, #8 を出力用に設定)
    .equ    GPFSEL_VEC1, 0x01249041 @ GPFSEL1 に設定する値 (GPIO #10, #12, #14, #15, #16, #17, #18 を出力用に設定)
    .equ    GPFSEL_VEC2, 0x00209249 @ GPFSEL2 に設定する値 (GPIO #20, #21, #22, #23, #24, #25, #27 を出力用に設定)
  

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

    @ レジスタの値を保存
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
	
    @ LEDとディスレイ用のIOポートを出力に設定する
    ldr     r0, =GPIO_BASE
    ldr     r1, =GPFSEL_VEC0
    str     r1, [r0, #GPFSEL0 + 0]
    ldr     r1, =GPFSEL_VEC1
    str     r1, [r0, #GPFSEL0 + 4]
    ldr     r1, =GPFSEL_VEC2
    str     r1, [r0, #GPFSEL0 + 8]

	@ どのような図形を表示させるかの計算を行なうプログラム片 (フレームバッファに書き込む)
	mov	r10, #0
	mov	r2, #0

	ldr	r8, =TIMER_BASE
        ldr     r11, =TIMER_HZ           @ 1秒分のカウント
        ldr     r12, [r8, #TIMER_CLO]       @ 現在時刻
	movs    r3, #8                   @ 初期値
loop_c:
	add     r12, r12, r11            @ 目的時刻

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

	@ レジスタを復元
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

	b       count			@ 無限ループ

loop:
	b       loop	

gameover_tv:
	mov     sp, #STACK

    @ レジスタの値を保存
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
	
    @ LEDとディスレイ用のIOポートを出力に設定する
    ldr     r0, =GPIO_BASE
    ldr     r1, =GPFSEL_VEC0
    str     r1, [r0, #GPFSEL0 + 0]
    ldr     r1, =GPFSEL_VEC1
    str     r1, [r0, #GPFSEL0 + 4]
    ldr     r1, =GPFSEL_VEC2
    str     r1, [r0, #GPFSEL0 + 8]

	@ どのような図形を表示させるかの計算を行なうプログラム片 (フレームバッファに書き込む)
	mov	r10, #0
	mov	r2, #0

	ldr	r8, =TIMER_BASE
        ldr     r11, =TIMER_HZ           @ 1秒分のカウント
        ldr     r12, [r8, #TIMER_CLO]       @ 現在時刻
	movs    r3, #14                   @ 初期値
loop_g:
	add     r12, r12, r11            @ 目的時刻
	
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

	@ レジスタを復元
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
	
	
	@ 計算した図形の表示を行なう(フレームバッファを表示)
blink:
	@ レジスタの値を退避
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
        ldr     r11, =TIMER_HZ_1000           @ 0.001秒分のカウント
        ldr     r12, [r8, #TIMER_CLO]       @ 現在時刻
        add     r12, r12, r11
1:  
	
	mov     r11, #2 			@ 
	mov     r2, r10
	ldrb    r2, [r2]	
	
	@ 第1行だけ点灯
	mov     r1, #(1 << ROW1_PORT)
	str     r1, [r0, #GPCLR0]               @ 点灯
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

	@ 第4, 5, 6, 7列 だけ点灯

	bl      retu

        ldr     r9, [r8, #TIMER_CLO]
        cmp     r12, r9
        bhi     1b
	
	@ 列の初期化
	bl      reset

	ldr	r8, =TIMER_BASE
        ldr     r11, =TIMER_HZ_1000           @ 0.001秒分のカウント
        ldr     r12, [r8, #TIMER_CLO]       @ 現在時刻
        add     r12, r12, r11
2:  
	
	mov     r11, #2 
	mov     r2, r10
	ldrb    r2, [r2, #1]	
	
	@ 第2行だけ点灯
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

	@ 第3, 8列だけ点灯
	bl      retu

        ldr     r9, [r8, #TIMER_CLO]
        cmp     r12, r9
        bhi     2b

	@ 列の初期化
	bl      reset

	ldr	r8, =TIMER_BASE
        ldr     r11, =TIMER_HZ_1000           @ 0.001秒分のカウント
        ldr     r12, [r8, #TIMER_CLO]       @ 現在時刻
        add     r12, r12, r11
3:  	
	mov     r11, #2 
	mov     r2, r10
	ldrb    r2, [r2, #2]	
	
	@ 第3行だけ点灯
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

	@ 第2, 5, 6列 だけ点灯
	bl      retu

        ldr     r9, [r8, #TIMER_CLO]
        cmp     r12, r9
        bhi     3b
	
	@ 列の初期化
	bl      reset

	ldr	r8, =TIMER_BASE
        ldr     r11, =TIMER_HZ_1000           @ 0.001秒分のカウント
        ldr     r12, [r8, #TIMER_CLO]       @ 現在時刻
        add     r12, r12, r11
4: 
	
	mov     r11, #2 
	mov     r2, r10
	ldrb    r2, [r2, #3]	
	
	@ 第4行だけ点灯
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

	@ 第1, 4, 7列 だけ点灯 
	bl      retu

	ldr     r9, [r8, #TIMER_CLO]
        cmp     r12, r9
        bhi     4b

	@ 列の初期化
	bl      reset
	
	ldr	r8, =TIMER_BASE
        ldr     r11, =TIMER_HZ_1000           @ 0.001秒分のカウント
        ldr     r12, [r8, #TIMER_CLO]       @ 現在時刻
        add     r12, r12, r11
5:  
	
	mov     r11, #2 
	mov     r2, r10
	ldrb    r2, [r2, #4]	
	
	@ 第5行だけ点灯
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

	@ 第2, 5, 8列 だけ点灯
	bl      retu

	ldr     r9, [r8, #TIMER_CLO]
        cmp     r12, r9
        bhi     5b
	
	@ 列の初期化
	bl      reset
	
        ldr	r8, =TIMER_BASE
        ldr     r11, =TIMER_HZ_1000           @ 0.001秒分のカウント
        ldr     r12, [r8, #TIMER_CLO]       @ 現在時刻
        add     r12, r12, r11
6:  
	
	mov     r11, #2 
	mov     r2, r10
	ldrb    r2, [r2, #5]	
	
	@ 第6行だけ点灯
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

	@ 第3, 7列だけ点灯
	bl      retu

	ldr     r9, [r8, #TIMER_CLO]
        cmp     r12, r9
        bhi     6b
	
	@ 列の初期化

	bl      reset
	
	ldr	r8, =TIMER_BASE
        ldr     r11, =TIMER_HZ_1000           @ 0.001秒分のカウント
        ldr     r12, [r8, #TIMER_CLO]       @ 現在時刻
        add     r12, r12, r11
7:  
	
	mov     r11, #2 
	mov     r2, r10
	ldrb    r2, [r2, #6]	
	
	@ 第7行だけ点灯
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

	@ 第4, 6列 だけ点灯

	bl      retu

	ldr     r9, [r8, #TIMER_CLO]
        cmp     r12, r9
        bhi     7b
	
	@ 列の初期化
	bl      reset

        ldr	r8, =TIMER_BASE
        ldr     r11, =TIMER_HZ_1000           @ 0.001秒分のカウント
        ldr     r12, [r8, #TIMER_CLO]       @ 現在時刻
        add     r12, r12, r11
8:  
	
	mov     r11, #2 
	mov     r2, r10
	ldrb    r2, [r2, #7]	
	
	@ 第8行だけ点灯
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

	@ 第5列 だけ点灯
	bl      retu

	ldr     r9, [r8, #TIMER_CLO]
        cmp     r12, r9
        bhi     8b
	
	@ 列の初期化
	bl      reset

	@ レジスタを復元
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
	
	@ どの列に1が立っているのかを求めて点灯
retu:
	@ レジスタの値を保存
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

	@ 計算した値を2で割って余りがでてきたら点灯, 0なら消灯
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

	@ レジスタの値を復元
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
	
	@ 全ての行を消灯
reset:
	@ レジスタの値を保存
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

	@ 列の消灯
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

	@ レジスタを復元
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
	
