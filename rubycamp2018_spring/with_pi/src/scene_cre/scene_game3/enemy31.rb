class Enemy3_1 < Sprite
  def initialize(x=0, y=0, image = nil,vy=0)
    image = Image.load('images/ene1.png')
    image.set_color_key(C_BLACK)
    @vx = rand(6)+3
    super
    self.x = rand(350)+400
    self.y = rand(100)*100+600

  end

  def go
    self.x -= @vx
  end

  def upload
    if self.x<-50 then
      self.vanish
    end
  end


  def draw
    super
  end

  def hit(obj)
    self.vanish

  end
end
