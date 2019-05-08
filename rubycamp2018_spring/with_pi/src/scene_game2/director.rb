require_relative 'player'
require_relative 'enemy21'
require_relative 'enemy22'
#require_relative 'enemy23'
require_relative 'beam'
require_relative 'noene'
#require 'smalrubot'

module Game2
  class Director
    def initialize
      @fontpoint = Font.new(36, 'ＭＳ Ｐゴシック')
      @image1 = Image.load('images/bg_mountain1.png')
      #h@board = board
      @player = Player.new
      @enemys = [Enemy2_1.new]
      @enemys2 = [Enemy2_2.new]
      @beam = Beam.new
      @noene = [Noene.new]
      @j=rand(10)+15
      @a=0
      while  @a<@j
        @enemys.push(Enemy2_1.new)
        @a+=1
      end

      @a=0
      @j=rand(10)+15
      while  @a<@j
        @enemys.push(Enemy2_2.new)
        @a+=1
      end

      @a=0
      @j=rand(5)+15
      while  @a<@j
        @noene.push(Noene.new)
        @a+=1
      end

      @frm = 1
      @frm2 = 1
      @frm3 = 1
      @dx = 0
      @dy = 0
      @i=0
      @time_st = Time.now
      @time_now = Time.now

      @right=0
      @se_beamS = Sound.new("se/attack1.wav")
      @se_beamL = Sound.new("se/final_attack.wav")
      @se_ok = Sound.new("se/dog1.wav")
      @se_no = Sound.new("se/damege2.wav")
      @se_up = Sound.new("se/po.wav")
      @se_dw = Sound.new("se/pu.wav")
    end
    #初期化メソッド
    def shyoki2

    @player = Player.new
    @enemys = [Enemy2_1.new]
    @enemys2 = [Enemy2_2.new]
    @beam = Beam.new
    @noene = [Noene.new]
    @j=rand(10)+15
    @a=0
    while  @a<@j
      @enemys.push(Enemy2_1.new)
      @a+=1
    end

    @a=0
    @j=rand(10)+15
    while  @a<@j
      @enemys.push(Enemy2_2.new)
      @a+=1
    end

    @a=0
    @j=rand(5)+15
    while  @a<@j
      @noene.push(Noene.new)
      @a+=1
    end

    @frm = 1
    @frm2 = 1
    @dx = 0
    @dy = 0
    @i=0
    @time_st = Time.now
    @time_now = Time.now

    @right=0
end

    def play
      @score = Scene.get_score
      Window.draw(0,0,@image1)
      Window.draw_font(11, 11," score #{@score} ", @fontpoint, :color =>[0, 0, 0])
      #if @frm == 5 && 1== @board.digital_read(2)
      #  @dy = 1*10
      #elsif @frm == 5 && 1== @board.digital_read(3)
      #   @dy = -1*10
      #end

      @y = Input.y * 10
      if @y > 0 #@frm == 5 && 1== @board.digital_read(2)
        @dy = @y #1 *10
        @se_dw.play
      elsif @y < 0 #@frm == 5 && 1== @board.digital_read(3)
        @dy = @y #-1 *10
        @se_up.play
      end

      #if @frm2 ==10 then
        #if @board.analog_read(0) > 250 && @board.analog_read(0) <500 then
        #  @se_beamS.play
        #  @right =1
        #  @beam.image =Image.load('images/beams.png')
        #  @beam.visible  = true
        #  @beam.y = @player.y + 50

        #elsif @board.analog_read(0) >=500  then
        if Input.key_push?(K_SPACE)
          #@se_beamL.play
          @beam.visible  = true
          @right =2
          @beam.image = Image.load('images/beam.png')
          @beam.y = @player.y + 50
          @se_beamL.play
          @frm = 1
        end
        if @frm == 61
          @right =0
          @beam.visible = false
        end
      #end
      @frm += 1
      #@frm = 0 if @frm > 5


      if @frm3 >= 10  && 1 == rand(2) then
          @enemys.push(Enemy2_1.new)
        end
        if @frm3 >= 10  && 1 == rand(2) then
            @enemys.push(Enemy2_2.new)
        end
      if @frm3 >= 10  && 1 == rand(3) then
          @noene.push(Noene.new)
          @noene.last.x = rand(350)+400
          @noene.last.y = -rand(100)*100+0

      end

      @frm3+=1
      @frm3 = 0 if @frm3 > 10

      @player.y += @dy
      @player.y =100 if @player.y<100
      @player.y =500 if @player.y>500

      @player.draw
      @beam.x = @player.x + 60
      @beam.y = @player.y + 20
      @beam.draw
      #@dx = @board.analog_read(0) / 10 if @frm == 30
      #@dx = @board.analog_read(0)/100 if @frm2 == 30
      @frm2 += 1
      @frm2 = 0 if @frm2 > 10
      @enemys.each do |item|
        item.go
        item.draw
      end

      @enemys2.each do |item|
        item.go
        item.draw
      end

      @noene.each do |item|
        item.go
        item.draw
      end
      if @player === @enemys
        p "gameover"
      end

      if @beam.visible  == true
          #Sprite.check(@beam,@enemys)

          #Sprite.check(@beam,@enemys2)

          #Sprite.check(@beam,@noene)

          if Sprite.check(@beam,@enemys) || Sprite.check(@beam,@enemys2)
            @score += 100 * @right
            @se_ok.play
          end

          if Sprite.check(@beam, @noene)
            @score -= 300 * @right
            @se_no.play
          end


      end
      @time_now = Time.now
      if @time_now - @time_st >40 then
        Scene.set_score(@score)
        Scene.move_to(:con2)
        #初期化
        self.shyoki2
      end


      Scene.set_score(@score)



    end
  end
end
