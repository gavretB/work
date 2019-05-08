class Enemy3
  attr_accessor :x,:y

  def initialize
    @image = Image.load('images/yamaneko2.png')
    @image.set_color_key(C_BLACK)
    @x = 2700
    @y = 500
  end

  def draw
    Window.draw(@x, @y, @image)
    @y += Input.y
  end
end
