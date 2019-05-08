class Noene < Sprite


  def initialize(x=0, y=0, image = nil,vx=0)
    image = Image.load('images/fish1.png')
    image.set_color_key(C_BLACK)
    @vy = rand(6)+3
    super
    self.x = rand(350)+400
    self.y = -rand(100)*100+0

    #@sprite = Sprite.new(@x, @y, @image)

  end

  def draw
    super
  end

  def upload
    if self.y> 1000 then
      self.vanish
    end
  end

  def go
    self.y += @vy

  end

  def hit(obj)
    self.vanish
  end

end
