class Item1 < Sprite


  def initialize(x=0, y=0, image = nil,vx=0)
    image = Image.load('images/fish1.png')
    image.set_color_key(C_BLACK)
    @vx = rand(6)+3
    super
    self.x = rand(50)*100+800
    self.y = rand(400)+100

    #@sprite = Sprite.new(@x, @y, @image)

  end

  def draw
    super
  end

  def go
    self.x -= @vx

  end

  def hit (obj)
    self.vanish
  end
end
