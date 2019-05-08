	.equ    GPIO_BASE,  0x3f200000 @ GPIOベースアドレス
	.equ    GPFSEL0,    0x00       @ GPIOポートの機能を選択する番地のオフセット
	.equ    GPSET0,     0x1C       @ GPIOポートの出力値を1にするための番地のオフセット
	.equ    GPCLR0,     0x28       @ GPIOボートの出力値を0にするための番地のオフセット
	.equ    STACK,      0x8000
	.equ    TIMER_BASE, 0x3f003000 @ システムタイマの制御レジスタがマップされた番地のベースアドレス
	.equ    TIMER_HZ_1,   100000  @ タイマーの周波数 1 MHz の 1/1
	.equ    TIMER_HZ_1000, 1000    @ タイマー周波数 1MHz の 1/1000
	.equ    TIMER_CLO,  0x4
	
	.equ    GPFSEL_VEC0, 0x01201000 @ GPFSEL0 に設定する値 (GPIO #4, #7, #8 を出力用に設定)
	.equ    GPFSEL_VEC1, 0x11249041 @ GPFSEL1 に設定する値 (GPIO #10, #12, #14, #15, #16, #17, #18, #19 を出力用に設定)
	.equ    GPFSEL_VEC2, 0x00209249 @ GPFSEL2 に設定する値 (GPIO #20, #21, #22, #23, #24, #25, #27 を出力用に設定)

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

	.equ	PWM_CTL, 0x8100
	

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

	.equ LED_PORT,   10           @ LEDが接続されたGPIOのポート番号
	.equ GPFSEL_IN,  0x0          @ 入力用
	.equ GPFSEL_OUT, 0x1          @ 出力用

	.section .init
	.global _start
_start:	
	mov     sp, #STACK
	
	@ LEDとディスレイ用のIOポートを出力に設定する
	ldr     r0, =GPIO_BASE
	ldr     r1, =GPFSEL_VEC0
	str     r1, [r0, #GPFSEL0 + 0]
	ldr     r1, =GPFSEL_VEC1
	str     r1, [r0, #GPFSEL0 + 4]
	ldr     r1, =GPFSEL_VEC2
	str     r1, [r0, #GPFSEL0 + 8]
restart:
	ldr     r1, =PWM_BASE
	ldr	r5, =GPFSEL0
	str	r5, [r1, #PWM_DAT2]
	
	mov	r1, #14
	ldr	r2, =bgm_buffer7
	str	r1, [r2]

	mov	r1, #0
	ldr	r2, =bgm_buffer6
	str	r1, [r2]
	
	mov	r3, #0
	mov	r6, #0
	@ スタート画面(カービィの顔を表示)
op_re:	
	mov	r1, #14
	ldr	r2, =bgm_buffer74
	str	r1, [r2]

	mov	r1, #0
	ldr	r2, =bgm_buffer64
	str	r1, [r2]
	
s_frame:
	ldr	r2, =kabyi_frame
	ldrb	r2, [r2, r3]
	ldr	r4, =frame_buffer
	strb	r2, [r4, r6]
	add	r3, r3, #1
	add	r6, r6, #1
	cmp	r6, #8
	blt	s_frame

	ldr	r9, =TIMER_BASE
	ldr	r9, [r9, #TIMER_CLO]
	ldr	r11, =80000
	add	r10, r9, r11
kabyiii:	
	bl	blink

	ldr	r6, [r0, #0x0034]	@ スイッチ4(SW4)
	and	r6, r6, #(1 << 6)	@ 6bit目に1が立っている値との論理積をとる
	lsr	r6, r6, #6		@ 6bit目の値を1bit目にもってくる

	cmp	r6, #1			@ SW4が押されたら
	beq	game_start		@ ゲーム開始へ
	
	mov	r6, #0

	ldr	r9, =TIMER_BASE
	ldr	r9, [r9, #TIMER_CLO]

	cmp	r10, r9
	bhi	kabyiii			@ スイッチ4が押されるまでカービィを表示

	bl	op

	ldr	r2, =bgm_buffer74
	ldr	r1, [r2]

	cmp	r1, #0
	bls	op_re

	cmp	r3, #96
	moveq	r3, #0
	b	s_frame


	

@ ゲーム開始
game_start:	
	mov	r1, #36			@ start_buffer 火の玉の定位置
	mov	r2, #0
	mov	r3, #0
	mov	r6, #0
	mov	r12, #0

@ 始めのモーションをバッファに保存(リスタートのため)
syokika:
	ldr	r5, =start_buffer
	strb	r6, [r5, r2]
	add	r2, r2, #1

	cmp	r2, #40
	blt	syokika

	mov	r6, #0x02
	strb	r6, [r5, #36]
	strb	r6, [r5, #29]
	strb	r6, [r5, #20]
	strb	r6, [r5, #10]
	strb	r6, [r5, #0]

	mov	r2, #0
	mov	r6, #0

	ldr	r9, =TIMER_BASE
	ldr	r9, [r9, #TIMER_CLO]
	ldr	r11, =69000000	           @ クリアするために生き残らなければならない時間
	add	r10, r9, r11
	str	r10, [sp, #-4]!		   @ スタックにゴール時刻を保存
        ldr     r11, =TIMER_HZ_1           @ 0.1秒分のカウント
	add	r10, r9, r11

start_fire:	
	ldr	r5, =start_buffer
	ldrb	r5, [r5, r2]
	ldr	r7, =background
	ldrb	r7, [r7, r3]
	add	r8, r5, r7
	orr	r5, r5, r7
	
	ldr	r4, =frame_buffer
	strb	r5, [r4, r6]

	add	r2, r2, #1
	add	r3, r3, #1
	add	r6, r6, #1

	cmp	r2, #32			@ 開始直後はあたり判定しない
	bls	atari

	ldr	r4, [sp], #4
	ldr	r7, =5000000		@ クリア時間 - 5000000
	sub	r7, r4, r7		@ あたり判定を終了する時間\
	str	r4, [sp, #-4]!
	ldr	r9, =TIMER_BASE
	ldr	r9, [r9, #TIMER_CLO]
	cmp	r9, r7
	bhi	atari
	
	cmp	r8, r5			@ addをとったものとorrをとったもの比較してあたり判定
	blne	game_over
atari:	
	cmp	r6, #8 
	blt	start_fire

	bl 	bgm_routine
	
	mov	r6, #0

	ldr	r5, [r0, #0x0034]
	and	r5, r5, #(1 << 13)
	lsr	r5, r5, #13

	ldr	r7, [r0, #0x0034]
	and	r7, r7, #(1 << 5)
	lsr	r7, r7, #5
	
timer:
	bl	blink

	ldr	r9, =TIMER_BASE
	ldr	r9, [r9, #TIMER_CLO]
	
	cmp	r9, r10
	bls	timer

	ldr	r4, [sp], #4		@ ゴール時刻を取り出し

	cmp	r4, r9			@ ゴール時刻を越えたらclearへ
	bmi	clear

	str	r4, [sp, #-4]!

	bl	fireboal		@ カービィの上下移動ルーチン

	ldr	r7, [r0, #0x0034]	@ スイッチ2(SW2)
	and	r7, r7, #(1 << 26)	@ 26bit目に1が立っている値との論理積をとる
	lsr	r7, r7, #26		@ 26bit目の値を1bit目にもってくる
	
	cmp	r7, #1			@ SW2が押されたらrestartへ
	beq	restart	

	add	r12, r12, #1
	
	cmp	r12, #5			@ 0.1秒 × 5 で次の背景フレームへ
	sublt	r3, r3, #8
	sublt	r2, r2, #8
	moveq	r12, #0

        ldr     r11, =TIMER_HZ_1           @ 0.1秒分のカウント
	add	r10, r10, r11
	
	cmp	r2, #40
	moveq	r2, #32
	blt	start_fire

	b	start_fire

loop:
	b       loop

op:	
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
	
	ldr	r0, =bgm_buffer74
	ldr	r7, [r0]
	
	ldr	r8, =bgm_buffer64
	ldr	r6, [r8]
	
	bl	op_bgm

	ldr	r0, =bgm_buffer74
	ldr	r8, =bgm_buffer64

	add	r6, r6, #4

	cmp	r6, #256
	subeq 	r7, r7, #1
	streq	r7, [r0]
	moveq	r6, #0

	str	r6, [r8]


	@ レジスタを復元
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

	
@--------------------bgm_routine--------------------
bgm_routine:
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
	
	ldr	r0, =bgm_buffer7
	ldr	r7, [r0]
	
	ldr	r8, =bgm_buffer6
	ldr	r6, [r8]
	
	bl	bgm

	ldr	r0, =bgm_buffer7
	ldr	r8, =bgm_buffer6

	add	r6, r6, #4

	cmp	r6, #256
	subeq 	r7, r7, #1
	streq	r7, [r0]
	moveq	r6, #0

	str	r6, [r8]


	@ レジスタを復元
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

@-------------------clear--------------------
clear:	
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
	
	bl	clear_tv

	ldr	r0, =GPIO_BASE

1:		
	ldr	r1, [r0, #0x0034]	@ スイッチ2(SW2)
	and	r1, r1, #(1 << 26)	@ 26bit目に1が立っている値との論理積をとる
	lsr	r1, r1, #26		@ 26bit目の値を1bit目にもってくる

	cmp	r1, #1
	mov	r1, #2
	
	cmp	r1, #2			@ SW2が押されたらrestartへ
	beq	restart			

	b	1b
	

	@ レジスタを復元
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

@-------------------game_over--------------------
game_over:
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

	
@ 終了画面を表示
	bl	gameover_tv	
	
	ldr	r0, =GPIO_BASE
1:	
	ldr	r1, [r0, #0x0034]	@ スイッチ2(SW2)
	and	r1, r1, #(1 << 26)	@ 26bit目に1が立っている値との論理積をとる
	lsr	r1, r1, #26		@ 26bit目の値を1bit目にもってくる
	
	cmp	r1, #1			@ SW2が押されたらrestartへ
	moveq	r1, #2

	cmp	r1, #2
	beq	restart			

	b	1b

	@ レジスタを復元
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
	
@--------------------fireboal-------------------
fireboal:
	@ レジスタの値を保存
	str	r2, [sp, #-4]!
	str	r3, [sp, #-4]!
	str	r4, [sp, #-4]!

	str	r6, [sp, #-4]!

	str	r8, [sp, #-4]!
	str	r9, [sp, #-4]!
	str	r10,[sp, #-4]!
	str	r11, [sp, #-4]!
	str	r12, [sp, #-4]!
	str	r14, [sp, #-4]!
	
	@ カービィの上下移動

	mov	r6, #0x02
	mov	r4, #0
	ldr	r9, =start_buffer

fire:
	ldr	r8, [r0, #0x0034]
	and	r8, r8, #(1 << 13)
	lsr	r8, r8, #13
	
	cmp	r8, #1			@ sw1が押されたらr5 + 1
	addeq	r5, r5, #1
	movne	r5, #0

	cmp	r1, #39
	beq	skip
	cmp	r5, #1			@ r5 が 1 の間だけ上に移動
	streqb	r4, [r9, r1]
	addeq	r1, r1, #1
	streqb	r6, [r9, r1]
skip:
	
	ldr	r12, [r0, #0x0034]	
	and	r12, r12, #(1 << 5)
	lsr	r12, r12, #5

	cmp	r12, #1			@ sw3が押されたらr7 + 1
	addeq	r7, r7, #1
	movne	r7, #0
	
	cmp	r1, #32
	beq	skip2
	cmp	r7, #1			@ r7 が 1 の間だけ下に移動
	streqb	r4, [r9, r1]
	subeq	r1, r1, #1
	streqb	r6, [r9, r1]
skip2:
	
	@ レジスタを復元
	ldr	r14, [sp], #4
	ldr	r12, [sp], #4
	ldr	r11, [sp], #4
	ldr	r10, [sp], #4
	ldr	r9, [sp], #4
	ldr	r8, [sp], #4
	
	ldr	r6, [sp], #4

	ldr	r4, [sp], #4
	ldr	r3, [sp], #4
	ldr	r2, [sp], #4

	bx	r14
	
@--------------------blink--------------------
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

	ldr	r8, =TIMER_BASE
        ldr     r11, =TIMER_HZ_1000           @ 0.001秒分のカウント
        ldr     r12, [r8, #TIMER_CLO]       @ 現在時刻
        add     r12, r12, r11
1:  
	
	mov     r11, #2 			@ 
	ldr     r2, =frame_buffer
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
	ldr     r2, =frame_buffer
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
	ldr     r2, =frame_buffer
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
	ldr     r2, =frame_buffer
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
	ldr     r2, =frame_buffer
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
	ldr     r2, =frame_buffer
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
	ldr     r2, =frame_buffer
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
	ldr     r2, =frame_buffer
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
	
@ 表示したい図形を計算して格納する領域
frame_buffer:	
	.byte 0x0, 0x0, 0x0, 0x00, 0x0, 0x0, 0x0, 0x0
@ 開始時のモーション
start_buffer:	
	.byte 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00
@ 背景(ステージ)
background:
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xff, 0xff
@ 2	
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x80, 0xff, 0xff
	.byte 0x00, 0x00, 0x00, 0x80, 0x80, 0xc0, 0xff, 0xff
	.byte 0x00, 0x00, 0x00, 0x40, 0xc0, 0xe0, 0xff, 0xff
	.byte 0x00, 0x00, 0x00, 0x20, 0x60, 0xf0, 0xff, 0xff
	.byte 0x00, 0x00, 0x00, 0x10, 0x30, 0x78, 0xff, 0xff
	.byte 0x00, 0x00, 0x80, 0x08, 0x18, 0x3c, 0xff, 0xff
	.byte 0x00, 0x80, 0xc0, 0x84, 0x0c, 0x1e, 0xff, 0xff
	.byte 0x00, 0x40, 0xe0, 0x42, 0x06, 0x0f, 0x7f, 0xff
@ 3
	.byte 0x00, 0x20, 0x70, 0x21, 0x03, 0x07, 0x3f, 0xff
	.byte 0x00, 0x10, 0x38, 0x10, 0x81, 0x03, 0x1f, 0xff
	.byte 0x00, 0x08, 0x1c, 0x88, 0xc0, 0x01, 0x0f, 0xff
	.byte 0x00, 0x84, 0x0e, 0x44, 0xe0, 0x00, 0x07, 0xff
	.byte 0x80, 0xc2, 0x87, 0x22, 0x70, 0x00, 0x03, 0xff
	.byte 0x40, 0xe1, 0x43, 0x11, 0x38, 0x00, 0x81, 0xff
	.byte 0x20, 0x70, 0x21, 0x08, 0x1c, 0x80, 0xc0, 0xff
	.byte 0x10, 0x38, 0x10, 0x04, 0x0e, 0x40, 0xe0, 0xff
@ 4
	.byte 0x88, 0x1c, 0x08, 0x02, 0x07, 0x20, 0x70, 0xff
	.byte 0xc4, 0x0e, 0x04, 0x01, 0x03, 0x10, 0x38, 0xff
	.byte 0x62, 0x07, 0x02, 0x00, 0x01, 0x08, 0x1c, 0xff
	.byte 0xb1, 0x03, 0x00, 0x00, 0x80, 0x04, 0x0e, 0xff
	.byte 0xd8, 0x01, 0x00, 0x80, 0x40, 0x02, 0x07, 0xff
	.byte 0x6c, 0x00, 0x00, 0x40, 0x20, 0x01, 0x03, 0xff
	.byte 0xb6, 0x80, 0x00, 0xa0, 0x90, 0x00, 0x81, 0xff
	.byte 0xdb, 0xc0, 0x00, 0x50, 0x48, 0x00, 0x40, 0xff
@ 5
	.byte 0x6d, 0x60, 0x00, 0xa8, 0x24, 0x00, 0x20, 0xff
	.byte 0xb6, 0x30, 0x00, 0x54, 0x12, 0x00, 0x10, 0xff
	.byte 0xdb, 0x18, 0x00, 0x2a, 0x09, 0x80, 0x08, 0xff
	.byte 0x6d, 0x0c, 0x00, 0x15, 0x04, 0x40, 0x84, 0xff
	.byte 0xb6, 0x06, 0x00, 0x8a, 0x02, 0x20, 0x42, 0xff
	.byte 0xdb, 0x03, 0x00, 0xc4, 0x01, 0x10, 0x21, 0xff
	.byte 0x6d, 0x01, 0x80, 0xe2, 0x80, 0x08, 0x10, 0xff
	.byte 0x36, 0x00, 0x40, 0xf1, 0x40, 0x04, 0x08, 0xff
@ 6
	.byte 0x9b, 0x00, 0x20, 0x78, 0x20, 0x02, 0x84, 0xff
	.byte 0xcd, 0x80, 0x10, 0x3c, 0x10, 0x81, 0xc2, 0xff
	.byte 0xe6, 0xc0, 0x88, 0x1e, 0x88, 0xc0, 0xe1, 0xff
	.byte 0xf3, 0xe0, 0x44, 0x0f, 0x44, 0xe0, 0xf0, 0xff
	.byte 0xf9, 0x70, 0x22, 0x07, 0x22, 0x70, 0xf8, 0xff
	.byte 0xfc, 0x38, 0x11, 0x03, 0x11, 0x38, 0x7c, 0xff
	.byte 0xfe, 0x9c, 0x08, 0x01, 0x08, 0x1c, 0x3e, 0xff
	.byte 0xff, 0xce, 0x84, 0x80, 0x04, 0x0e, 0x1f, 0xff
@ 7	
	.byte 0xff, 0xe7, 0x42, 0x40, 0x02, 0x07, 0x8f, 0xff
	.byte 0xff, 0x73, 0x21, 0x20, 0x81, 0x83, 0xe7, 0xff
	.byte 0xff, 0x39, 0x10, 0x10, 0x40, 0x41, 0xe3, 0xff
	.byte 0xff, 0x1c, 0x08, 0x08, 0x20, 0x20, 0x71, 0xff
	.byte 0xff, 0x8e, 0x04, 0x04, 0x10, 0x10, 0xb8, 0xff
	.byte 0xff, 0xc7, 0x82, 0x02, 0x08, 0x88, 0xdc, 0xff
	.byte 0xff, 0x63, 0x41, 0x01, 0x04, 0x44, 0x6e, 0xff
	.byte 0xff, 0x31, 0x20, 0x00, 0x02, 0x22, 0x37, 0xff
@ 8	
	.byte 0xff, 0x18, 0x10, 0x01, 0x01, 0x11, 0x1b, 0xff
	.byte 0xff, 0x8c, 0x88, 0x00, 0x00, 0x88, 0x8d, 0xff
	.byte 0xff, 0xc6, 0x44, 0x80, 0x80, 0x44, 0x46, 0xff
	.byte 0xff, 0x63, 0x22, 0x20, 0x20, 0x22, 0x23, 0xff
	.byte 0xff, 0x31, 0x11, 0x08, 0x08, 0x11, 0x11, 0xff
	.byte 0xff, 0x18, 0x08, 0x02, 0x02, 0x08, 0x08, 0xff
	.byte 0xff, 0x0c, 0x04, 0x00, 0x80, 0x04, 0x04, 0xff
	.byte 0xff, 0x06, 0x02, 0x00, 0xc0, 0x02, 0x02, 0xff
@ 9
	.byte 0xff, 0x83, 0x01, 0x80, 0xe0, 0x01, 0x01, 0xff
	.byte 0xff, 0x41, 0x00, 0x40, 0xf0, 0x00, 0x00, 0xff
	.byte 0xff, 0xa0, 0x00, 0xa0, 0xf8, 0x00, 0x00, 0xff
	.byte 0xff, 0x50, 0x00, 0x50, 0xfc, 0x00, 0x00, 0xff
	.byte 0xff, 0xa8, 0x00, 0xa8, 0xfe, 0x00, 0x00, 0xff
	.byte 0xff, 0x54, 0x00, 0x54, 0xff, 0x00, 0x00, 0xff
	.byte 0xff, 0xaa, 0x00, 0xaa, 0xff, 0x00, 0x00, 0xff
	.byte 0xff, 0x55, 0x00, 0x55, 0xff, 0x00, 0x00, 0xff
@ 10
	.byte 0xff, 0xaa, 0x00, 0xaa, 0x7f, 0x00, 0x80, 0xff
	.byte 0x7f, 0x55, 0x80, 0x55, 0x3f, 0x00, 0x40, 0xff
	.byte 0x3f, 0x2a, 0x40, 0x2a, 0x1f, 0x00, 0x20, 0xff
	.byte 0x1f, 0x15, 0x20, 0x15, 0x0f, 0x00, 0x10, 0xff
	.byte 0x0f, 0x0a, 0x10, 0x8a, 0x07, 0x00, 0x08, 0xff
	.byte 0x07, 0x05, 0x88, 0xc5, 0x83, 0x00, 0x04, 0xff
	.byte 0x02, 0x02, 0x44, 0xe2, 0x41, 0x00, 0x02, 0x7f
	.byte 0x01, 0x01, 0x22, 0x71, 0x20, 0x00, 0x01, 0x3f
@ 11
	.byte 0x00, 0x00, 0x11, 0x38, 0x10, 0x00, 0x00, 0x1f
	.byte 0x00, 0x00, 0x08, 0x1c, 0x08, 0x00, 0x00, 0x0f
	.byte 0x00, 0x00, 0x04, 0x0e, 0x04, 0x00, 0x00, 0x07
	.byte 0x00, 0x00, 0x02, 0x07, 0x02, 0x00, 0x00, 0x03
	.byte 0x00, 0x00, 0x01, 0x03, 0x01, 0x00, 0x80, 0x01
	.byte 0x00, 0x00, 0x00, 0x01, 0x00, 0x40, 0xe0, 0x40
	.byte 0x00, 0x00, 0x00, 0x80, 0xc0, 0x90, 0x38, 0x10
	.byte 0x00, 0x00, 0x00, 0x20, 0x70, 0x24, 0x0e, 0x04
@ 12
	.byte 0x00, 0x00, 0x00, 0x08, 0x1c, 0x09, 0x03, 0x01
	.byte 0x00, 0x00, 0x00, 0x02, 0x07, 0x02, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x80, 0x00
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x80, 0xc0, 0x80
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0xc0, 0xe0, 0xc0
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0xe0, 0xf0, 0xe0
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x70, 0xf8, 0x70
@ 13
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x38, 0x7c, 0x38
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x1c, 0x3e, 0x9c
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x0e, 0x9f, 0xce
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x07, 0xcf, 0xe7
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x03, 0x67, 0xf3
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x33, 0x79
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x19, 0x3c
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0c, 0x9e
@ 14
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x86, 0x4f
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x80, 0x43, 0x27
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0xc0, 0x21, 0x13
	.byte 0x80, 0x40, 0x80, 0x40, 0x20, 0xe0, 0x10, 0x09
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0xf0, 0x08, 0x04
	.byte 0x20, 0x10, 0x20, 0x10, 0x08, 0xf8, 0x04, 0x02
	.byte 0x80, 0x40, 0x80, 0x40, 0x20, 0xfc, 0x02, 0x01
	.byte 0x00, 0x00, 0x00, 0x00 ,0x00, 0xfe, 0x01, 0x00
@ 15
	.byte 0x20, 0x10, 0x20, 0x10, 0x08, 0xff, 0x00, 0x00
	.byte 0x80, 0x80, 0x00, 0x80, 0x80, 0xff, 0x00, 0x00
	.byte 0x40, 0x40, 0x00, 0x00, 0x00, 0xff, 0x40, 0x40
	.byte 0x20, 0x20, 0x00, 0x20, 0x20, 0xff, 0x00, 0x00
	.byte 0x90, 0x90, 0x00, 0x80, 0x80, 0xff, 0x10, 0x10
	.byte 0x48, 0x48, 0x00, 0x08, 0x08, 0xff, 0x40, 0x40
	.byte 0x24, 0x24, 0x00, 0x20, 0x20, 0x7f, 0x04, 0x04
	.byte 0x12, 0x12, 0x00, 0x02, 0x02, 0xbf, 0x10, 0x10
@ 16
	.byte 0x09, 0x09, 0x80, 0x08, 0x08, 0xdf, 0x01, 0x01
	.byte 0x04, 0x44, 0xe0, 0x40, 0x00, 0xef, 0x04, 0x04
	.byte 0x02, 0x02, 0x20, 0x02, 0x02, 0xf7, 0x00, 0x00
	.byte 0x01, 0x11, 0x38, 0x10, 0x00, 0xfb, 0x01, 0x01
	.byte 0x00, 0x80, 0x08, 0x00, 0x80, 0xfd, 0x00, 0x00
	.byte 0x00, 0x84, 0xce, 0x84, 0x40, 0xfe, 0x00, 0x00
	.byte 0x40, 0xe0, 0x42, 0x40, 0xa0, 0xff, 0x00, 0x00
	.byte 0x00, 0x21, 0x73, 0x21, 0x50, 0xff, 0x80, 0x80
@ 17
	.byte 0x10, 0x38, 0x10, 0x10, 0x28, 0x7f, 0x40, 0x40
	.byte 0x00, 0x08, 0x1c, 0x08, 0x14, 0x3f, 0x20, 0x20
	.byte 0x04, 0x0e, 0x04, 0x04, 0x0a, 0x1f, 0x10, 0x10
	.byte 0x00, 0x02, 0x07, 0x02, 0x05, 0x0f, 0x08, 0x08
	.byte 0x01, 0x03, 0x01, 0x01, 0x02, 0x07, 0x04, 0x04
	.byte 0x00, 0x00, 0x01, 0x00, 0x01, 0x03, 0x02, 0x02
	.byte 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x01, 0x01
@ 18

	.byte 0x00, 0x00, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80
	.byte 0x00, 0x80, 0x40, 0xc0, 0x40, 0x40, 0x40, 0xc0
	.byte 0x80, 0x40, 0x20, 0xe0, 0xa0, 0x20, 0x20, 0xe0
	.byte 0xc0, 0x20, 0x10, 0xf0, 0xd0, 0x90, 0x10, 0xf0
	.byte 0xe0, 0x10, 0x08, 0xf8, 0xe8, 0x48, 0x08, 0xf8
	.byte 0x70, 0x88, 0x04, 0xfc, 0x74, 0x24, 0x04, 0xfc
	.byte 0x38, 0x44, 0x82, 0xfe, 0xba, 0x92, 0x82, 0xfe
	.byte 0x1c, 0x22, 0x41, 0x7f, 0x5d, 0x49, 0x41, 0x7f
	.byte 0x0e, 0x11, 0x20, 0x3f, 0x2e, 0x24, 0x20, 0x3f
	.byte 0x07, 0x08, 0x10, 0x1f, 0x17, 0x12, 0x10, 0x1f
	.byte 0x03, 0x04, 0x08, 0x0f, 0x0b, 0x09, 0x08, 0x0f

@ スタート画面(カービィの顔)
kabyi_frame:
	.byte 0x3c, 0x42, 0x95, 0x94, 0xe3, 0x88, 0x81, 0x42
        .byte 0x3c, 0x42, 0x95, 0x94, 0xe3, 0x88, 0x81, 0x42
	.byte 0x3c, 0x42, 0x95, 0x94, 0xe3, 0x88, 0x81, 0x42
        .byte 0x3c, 0x42, 0x95, 0x94, 0xe3, 0x88, 0x81, 0x42
	.byte 0x3c, 0x42, 0x81, 0xb6, 0xe3, 0x88, 0x81, 0x42
	.byte 0x3c, 0x42, 0x81, 0xb6, 0xe3, 0x88, 0x81, 0x42
	.byte 0x3c, 0x42, 0x81, 0xb6, 0xe3, 0x88, 0x81, 0x42
	.byte 0x3c, 0x42, 0x81, 0xb6, 0xe3, 0x88, 0x81, 0x42
	.byte 0x3c, 0x42, 0x95, 0x94, 0xe3, 0x88, 0x81, 0x42
        .byte 0x3c, 0x42, 0x95, 0x94, 0xe3, 0x88, 0x81, 0x42
	.byte 0x3c, 0x42, 0x95, 0x94, 0xe3, 0x88, 0x81, 0x42
        .byte 0x3c, 0x42, 0x95, 0x94, 0xe3, 0x88, 0x81, 0x42
@ ゲームオーバー画面
go_frame:	
	.byte 0x02, 0x01, 0x3e, 0x41, 0x80, 0x9b, 0x40, 0xed

bgm_buffer6:
	.byte 0, 0, 0, 0, 0, 0, 0, 0

bgm_buffer7:
	.byte 14, 0, 0, 0, 0, 0, 0, 0

bgm_buffer64:
	.byte 0, 0, 0, 0, 0, 0, 0, 0

bgm_buffer74:
	.byte 14, 0, 0, 0, 0, 0, 0, 0
