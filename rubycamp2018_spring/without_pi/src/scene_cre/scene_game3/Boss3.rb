class Boss3 < Sprite
  def initialize(x=0, y=0, image = nil,vy=0)
    image = Image.load('images/lastb1.png')
    image.set_color_key(C_BLACK)
    @damege =0
    super
    self.x = 900
    self.y = 150

  end



  def bosspop
    self.x -= 100
  end

  def bossback
    self.x += 100
  end



  def move
    self.y = (rand(5)+1)*100
  end


  def draw
    super
  end


  def hit(obj)
    @damege += 1
    if @damege >500
      self.y=1300
      self.vanish
    end
  end



end
