class Beam3 < Sprite

  def initialize(x=0, y=0, image = nil,image2 = nil,vx=0)
    image = Image.load('images/misairu.png')
    image.set_color_key(C_BLACK)
    @vx = 10
    super
    self.x = 900
    self.y = 510

    #@sprite = Sprite.new(@x, @y, @image)
  end

  def go
    self.x += @vx
  end

  def draw
    super
  end

  def upload
    if self.x>600 then
      self.vanish
    end
  end

  def hit (obj)
    self.vanish

  end


end
