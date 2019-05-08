class Player < Sprite
  #attr_accessor :x,:y

  def initialize (x=0,y=0,image=nil)
    image = Image.load('images/yamaneko1.png')
    image.set_color_key(C_BLACK)
    super
    self.x = 100
    self.y = 500
    #@sprite = Sprite.new(@x, @y, @image)
  end

  def draw
    #Window.draw(@x,@y,@image)
    #@y -= Input.y
    super
  end
end
