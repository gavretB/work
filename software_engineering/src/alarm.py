# -*- coding: utf-8 -*-

import pygame.mixer
import time


def alarm():
#mixerモジュールの初期化
    pygame.mixer.init()
#音楽ファイルの読み込み
    pygame.mixer.music.load("test.mp3")
#再生
    pygame.mixer.music.play(1)


    time.sleep(5)
# 再生の終了
    pygame.mixer.music.stop()
