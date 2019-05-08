module Con
  class Director
    def initialize
      #@board=board
      @font = Font.new(55, 'ＭＳ Ｐゴシック')
    end

    def play
      #@dx=@board.digital_read(2)
      Window.draw_font(250, 280, "STAGE2へ", @font)
      Window.draw_font(30, 400, "光センサでレーザーを調節して、\n見方を倒さずに敵だけ倒してね", @font)
      if Input.key_push?(K_SPACE)#@dx==1

        Scene.move_to(:game2)
      end
   end
  end
end
