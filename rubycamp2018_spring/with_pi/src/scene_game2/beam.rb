class Beam < Sprite
def initialize(x=0, y=0, image = nil,image2 = nil,vx=0)
    image = Image.load('images/beams.png')
    image.set_color_key(C_BLACK)
    super
    self.x = 120
    self.y = 510

    #@sprite = Sprite.new(@x, @y, @image)

  end

  def draw
    super
  end





end
