require_relative 'player'
require_relative 'enemy1'
require_relative 'enemy2'
require_relative 'enemy3'
require_relative 'item1'
#require 'smalrubot'

module Game
  class Director
    def initialize
      @y = 0
      @fontpoint = Font.new(36, 'ＭＳ Ｐゴシック')
      @score = 0
      @image1 = Image.load('images/bg_cloud1.png')
      #@board = board
      @player = Player.new
      #@enemys =[Enemy1.new,Enemy1.new,Enemy1.new]
      @enemys = [Enemy1.new]
      @j=rand(10)+15
      @a=0
      while  @a<@j
        @enemys.push(Enemy1.new)
        @a+=1
      end
      @items = [Item1.new]
      @j=rand(10)+10
      @a=0
      while  @a<@j
        @items.push(Item1.new)
        @a+=1
      end
      @frm = 1
      #@frm2 = 1
      @frg = 0
      #@dx = 0
      @dy = 0
      @i=0
      @time_st = Time.now
      @time_now = Time.now
      @se_up = Sound.new("se/po.wav")
      @se_dw = Sound.new("se/pu.wav")
      @se_dog = Sound.new("se/dog1.wav")
      @se_cat = Sound.new("se/cat1a.wav")
    end



    def syoki
      #
      @player = Player.new
      @enemys =[Enemy1.new,Enemy1.new,Enemy1.new]
      @enemys = [Enemy1.new]
      @j=rand(10)+15
      @a=0
      while  @a<@j
        @enemys.push(Enemy1.new)
        @a+=1
      end
      @frm = 1
      @frm2 = 1
      @dx = 0
      @dy = 0
      @i=0
      @time_st = Time.now
      @time_now = Time.now
    end
    def play
      #@dy=0
      Window.draw(0,0,@image1)
      Window.draw_font(11, 11," score #{@score} ", @fontpoint, :color => [0, 0, 0])
      @y = Input.y * 10
      if @y > 0 #@frm == 5 && 1== @board.digital_read(2)
        @dy = @y #1 *10
        @se_dw.play
      elsif @y < 0 #@frm == 5 && 1== @board.digital_read(3)
        @dy = @y #-1 *10
        @se_up.play
      end

      @frm += 1
      @frm = 0 if @frm > 5

      @player.y += @dy
      @player.y =100 if @player.y<100
      @player.y =500 if @player.y>500

      @player.draw
      #@dx = @board.analog_read(0) / 10 if @frm == 30
      #@dx = @board.analog_read(0)/100 if @frm2 == 30
      #@frm2 += 1
      #@frm2 = 0 if @frm2 > 30
      #@enemys[0].x -= @dx
      #@enemys[0].draw
      #@enemys[1].x -= @dx + 1
      #@enemys[1].draw
      #@enemys[2].x -= @dx + 3
      #@enemys[2].draw
      @enemys.each do |item|
        item.go
        item.draw

      end
      @items.each do |item|
        item.go
        item.draw

      end

      #def hit(o)
      #  @score -= 100
      #end
      nowenemy = @player.check(@enemys)
      if  !( nowenemy.empty?)
      #@score -= 100 if @before != nowenemy
        if @before != nowenemy
          @score -= 100
          @se_dog.play
        end
        Sprite.check(@player,@enemys)
        @before = nowenemy
      end
      nowitem = @player.check(@items)
      if  !( nowitem.empty?)
        if @beforeitem != nowitem
          @se_cat.play
          @score += 100
        end
        Sprite.check(@player,@items)
        @beforeitem = nowitem
      end
      @time_now = Time.now
      if @time_now - @time_st >20
         Scene.set_score(@score)
         Scene.move_to(:con)
         self.syoki #初期化するメソッド
      end
    end
  end
end
