class Scene
  @@scenes = {}
  @@score = 0
  @@current_scene_name = nil
  @@current_bgm = nil


  def self.add(scene_obj, scene_name)
    @@scenes[scene_name.to_sym] = scene_obj
  end


  def self.move_to(scene_name)
    @@current_scene_name = scene_name.to_sym
  end

  def self.set_score(score)
    @@score = score
  end

  def self.get_score
    @@score
  end

  def self.play
    @@scenes[@@current_scene_name].play
  end
  
  def self.set_bgm(bgm)
    @@current_bgm = Sound.new(bgm)
    @@current_bgm.play
  end

  def self.stop_bgm
    @@current_bgm.stop
  end
end
