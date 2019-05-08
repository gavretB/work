require 'dxruby'
#require 'smalrubot'
module Riku
  class Riku
  def initialize
      #@board = board
      @font = Font.new(32,'ＭＳ Ｐゴシック')
      @fontpoint = Font.new(50,'ＭＳ Ｐゴシック')

  end
#background=Image.load("../src/images/umi.jpg")

  def play

  y=600
      Window.loop do
        #  Window.draw(0,0,background)
        Window.draw_font(100,y,"　　TEAMメンバー紹介\n\n\n\n\n野上さん\n\n\n\n\n\n\n\n\n\n\n\n\n\n楠田さん\n\n\n\n\n\n\n\n\n\n\n\n\n田中さん\n\n\n\n\n\n\n\n\n\n\n\n\n\n山根さん\n\n\n\n\n\n\n\n\n\n\n\n\n\n山根さん
          \n\n\n\n\n\n\n\nキャラクターデザイン\n\n\n\n\n\n\n\n\n田中さん\n\n\n\n\n\n\n武本さん\n\n\n\n\n\n\n\n\n
          サウンドチェック\n\n\n\n\n\n\n楠田さん\n\n\n\n\n\n\n\n\n\n\n\nデバッグ\n\n\n\n\n\n\n\n\n\n他の班の人ら\n\n\n
          スペシャルサンクス\n\n\n\n\n株式会社イーストバック及びRuby合宿関係者様\n\n\n\n\n\n\n\n\n\n\nTHANK YOU FOR PLAYING!!",@font)
          y -=4.5

          @score = Scene.get_score
          Window.draw_font(400, 250," score #{@score} ", @fontpoint, :color =>[255, 255, 0])
      # if 1 == @board.digital_read(2) then
      #     Scene.move_to(:title)
      #   end
      end
    end
  end
end
