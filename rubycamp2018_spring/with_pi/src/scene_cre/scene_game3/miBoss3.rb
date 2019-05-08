class Miboss3 < Sprite
  def initialize(x=0, y=0, image = nil,vy=0)
    image = Image.load('images/midb1.png')
    image.set_color_key(C_BLACK)
    @vy = 5
    @damege =0
    @flag=0
    super
    self.x = 800
    self.y = 250

  end

  def hit (obj)
    @damege +=1
    if @damege >100
      self.vanish
    end

  end





  def go
    if @flag ==0 then
      self.y -= @vy
      if self.y<100 then
        @flag =1
      end
    elsif
      @flag == 1 then
      self.y += @vy
      if self.y > 500 then
        @flag =0
      end
    end
  end

  def mibosspop
    self.x -= 100
  end

  def bossback
    self.x += 100
  end

  def upload
    if self.y<-50 then
      self.vanish
    end
  end


  def draw
    super
  end


end
