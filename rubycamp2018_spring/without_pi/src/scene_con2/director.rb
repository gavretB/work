module Con2
  class Director
    def initialize(board)
      @board=board
      @font = Font.new(55, 'ＭＳ Ｐゴシック')
    end

    def play
      @dx=@board.digital_read(2)
      Window.draw_font(250, 280, "STAGE3へ\n\n", @font)
      Window.draw_font(150, 350, "ボスをミサイルで倒してね", @font)
      if @dx==1

        Scene.move_to(:game3)
      end
   end
  end
end
