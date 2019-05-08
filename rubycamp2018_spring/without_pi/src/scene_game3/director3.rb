require_relative 'player3'
require_relative 'enemy31'
require_relative 'enemy32'
#require_relative 'enemy23'
require_relative 'beam3'
require_relative 'noene3'
require_relative 'miBoss3'
require_relative 'Boss3'
require_relative 'enebeam3'
require_relative 'bosbeam3'
require 'smalrubot'

module Game3
  class Director
    def initialize(board)
      @image1 = Image.load('images/bg_forest1.png')
      @text = Image.load('images/text.png')
      @fontpoint = Font.new(36, 'ＭＳ Ｐゴシック')
      @font = Font.new(36, 'ＭＳ Ｐゴシック')
      @board = board
      @player = Player3.new
      @enemys = [Enemy3_1.new]
      @beam = []
      @noene = [Noene3_1.new]
      @boss = Boss3.new
      @miboss = [Miboss3.new , Miboss3.new]
      @miboss[0].y =200
      @miboss[1].y =400
      @j=0
      @a=0
      @bossmode =0
      @frmbossmain=0
      @enebeam = [Enebeam3.new,Enebeam3.new]
      @bosbeam = Bosbeam3.new
      @a=0
      @j=rand(5)+15
      @frm = 1
      @frm2 = 1
      @frm3 = 1
      @frmboss = 1
      @dx = 0
      @dy = 0
      @i=0
      @time_st = Time.now
      @time_now = Time.now
      @right=0
      @enebeamtime =0
      @bosbeamtime = 0
      @se_misairu = Sound.new("se/brrn.wav")
      @se_damege = Sound.new("se/damege2.wav")
      @se_damege2 = Sound.new("se/damege1.wav")
      @se_dog = Sound.new("se/dog1.wav")
    end


    #初期化メソッド
    def shyoki
      @player = Player3.new
      @enemys = [Enemy3_1.new]
      @beam = []
      @noene = [Noene3_1.new]
      @boss = Boss3.new
      @miboss = [Miboss3.new , Miboss3.new]
      @miboss[0].y =200
      @miboss[1].y =400
      @j=0
      @a=0
      @bossmode =0
      @frmbossmain=0
      @enebeam = [Enebeam3.new,Enebeam3.new]
      @bosbeam = Bosbeam3.new
      @a=0
      @j=rand(5)+15
      @frm = 1
      @frm2 = 1
      @frm3 = 1
      @frmboss = 1
      @dx = 0
      @dy = 0
      @i=0
      @time_st = Time.now
      @time_now = Time.now
      @right=0
      @enebeamtime =0
      @bosbeamtime = 0
    end

    def play
      @score = Scene.get_score
      Window.draw(0,0,@image1)
      Window.draw_font(11, 11," score #{@score} ", @fontpoint, :color => [0, 0, 0])



      if @bossmode ==5 then
        @boss.draw
        @player.draw
         @text = Image.load('images/text.png')
         Window.draw(0,400,@text,0)
         Window.draw_font(0, 420," 眠たいので割愛\n クリアおめでとう", @fontpoint, :color =>[255, 255,0])

         if 1 == @board.digital_read(2) then

           Scene.move_to(:riku)

         end

      elsif @bossmode == 8 then
        @boss.draw
        @player.draw
        Window.draw(0,400,@text)
        Window.draw_font(50, 450," 眠たいので割愛", @fontpoint, :color =>[255, 255, 255])
          if 1 == @board.digital_read(2) then
            @bossmode=1

            @miboss[0].mibosspop
            @miboss[1].mibosspop
            @boss.draw
            @miboss[0].draw
            @miboss[1].draw
            @text = Image.load('images/empty.png')
            Window.draw(0,0,@text)

          end


     else


      if @frm >= 5 && 1== @board.digital_read(2)
        @dy = 1 *10
      elsif @frm >= 5 && 1== @board.digital_read(3)
         @dy = -1 *10
       end

       if @frm2 >=10 then
        if @board.analog_read(0) > 300 then
          @se_misairu.play
          @beam.push(Beam3.new)
          @beam.last.x = @player.x
          @beam.last.y = @player.y
        end
      end
      @frm += 1
      @frm = 0 if @frm > 5

      @player.y += @dy
      @player.y =100 if @player.y<100
      @player.y =500 if @player.y>500

      @player.draw


      #@dx = @board.analog_read(0) / 10 if @frm == 30
      #@dx = @board.analog_read(0)/100 if @frm2 == 30
      @frm2 += 1
      @frm2 = 0 if @frm2 > 10

      if @frm3 >= 10  && 1 == rand(2) then
          @enemys.push(Enemy3_1.new)
          @enemys.last.x = 900
          @enemys.last.y = rand(400) + 100
        end
      if @frm3 >= 10  && 1 == rand(3) then
          @noene.push(Noene.new)
          @noene.last.x = rand(350)+400
          @noene.last.y = -rand(100)*100+0

      end

      @frm3+=1
      @frm3 = 0 if @frm3 > 10

      if @bossmode ==4 && @frmbossmain >=5 then
        @boss.move
        @boss.draw
      if @bosbeamtime == 0 then
          if 1== rand(45) then
          @bosbeam.visible = true
          @bosbeam.x = @boss.x - 600
          @bosbeam.y = @boss.y + 100
          @bosbeam.draw
          @bosbeamtime +=1
          end
        elsif @bosbeamtime < 60 then
          @bosbeam.visible = true
          @bosbeam.x = @boss.x - 600
          @bosbeam.y = @boss.y + 100
          @bosbeam.draw
          @bosbeamtime +=1
        else
          @bosbeamtime=0
          @bosbeam.visible = false
        end

        @frmboss = 0
      end

      @frmbossmain +=1
      @frmbossmain =0 if @frmbossmain >5

      @j=0
      if @bossmode ==2  then
        while @j < @miboss.size
          @miboss[@j].go
          @miboss[@j].draw
          if @enebeamtime == 0 then
            if 1== rand(45) then
            @enebeam[@j].visible = true
            @enebeam[@j].x = @miboss[@j].x - 600
            @enebeam[@j].y = @miboss[@j].y
            @enebeam[@j].draw
            @enebeamtime +=1
            end
          elsif @enebeamtime < 30 then
            @enebeam[@j].x = @miboss[@j].x - 600
            @enebeam[@j].y = @miboss[@j].y
            @enebeam[@j].draw
            @enebeamtime +=1
          elsif @enebeamtime >= 30 then
            @enebeamtime=0
            @enebeam[@j].visible = false
          end
          @j+=1
        end
        @frmboss = 0
      elsif @bossmode == 3 then
        @boss.x -= 10
        if @boss.x < 600 then
          @bossmode =4
        end
      end

      @frmboss +=1
      @frmboss = 0 if @frmboss>5


      @boss.draw

      @beam.each do |item|
        item.go
        item.upload
        item.draw
      end

      @enemys.each do |item|
        item.go
        item.upload
        item.draw
      end

      @noene.each do |item|
        item.go
        item.upload
        item.draw
      end
      if @player === @enemys

      end
      #p @score
      #Sprite.check(@beam,@enemys)
      if Sprite.check(@beam,@enemys)
        @se_dog.play
        @score += 100

      end

      if Sprite.check(@beam, @noene)
        @se_damege2.play
        @score -= 500
      end

      if Sprite.check(@player, @enemys)
        @se_damege2.play
        @score -= 500
      end

      if Sprite.check(@player, @bosbeam) && @bosbeam.visible == true
        #@se_damege2.play
        @score -= 10
      end

      if Sprite.check(@player, @enebeam)
        @se_damege2.play
        @score -= 5
      end

    #  Sprite.check(@enemys,@beam)
      #Sprite.check(@beam,@noene)
      #Sprite.clean([@player,@noene,@beam,@enemys])

      if @bossmode == 2 then
        if Sprite.check(@beam,@miboss)
          @se_damege.play
        end
        Sprite.clean([@player,@miboss,@beam,@enebeam])
        if [] == @miboss then
          Sprite.clean([@enebeam])
          @bossmode = 3
        end

      elsif @bossmode == 4 then
        if Sprite.check(@beam,@boss)
          @se_damege.play
        end
        if 1000 < @boss.y then
           Sprite.clean([@player,@boss,@beam])
           @bossmode = 5
           p  " finish",@bossmode

         end
       end


      if @bossmode ==0 then
      @time_now = Time.now
        if @time_now - @time_st >5 then
            #Scene.move_to(:riku)
            #初期化メソッド
            #self.shyoki

          @boss.x -=2
            if @boss.x < 600 then
              @bossmode =8

            end
          end

      elsif @bossmode ==1 then
        @boss.x+=8
        if @boss.x >=1100 then
          @bossmode = 2
        end
      end


      Scene.set_score(@score)
    end

    end
  end
end
