module Title
  class Director
    def initialize(board)
      @board=board
      @font = Font.new(46, 'ＭＳ Ｐゴシック')
      @titleimage = Image.load('images/bg_title1.png')
      @se_start = Sound.new("se/prpr.wav")
      Scene.set_bgm("bgm/3po.mid")
    end

    def play
      @dx=@board.digital_read(2)
      Window.draw(0,0,@titleimage)

      Window.draw_font(250, 280, "\n\nボタンを押して敵をよけてね", @font)
      Window.draw_font(250, 500, "ボタンを押す始まります", @font)
      if @dx == 1
        @se_start.play
        Scene.move_to(:game)
      end
    end
  end
end
