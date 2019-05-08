require 'dxruby'
require_relative 'scene'
require_relative 'scene_title/director'
#require 'smalrubot'
require_relative 'scene_con/director'
require_relative 'scene_con2/director'
require_relative 'scene_game/director'
require_relative 'scene_game2/director'
require_relative 'scene_game3/director3'
require_relative 'scene_cre/riku'


Window.width = 800
Window.height = 600

#board = Smalrubot::Board.new(Smalrubot::TxRx::Serial.new)
#Scene.add(Title::Director.new(board),:title)
Scene.add(Title::Director.new,:title)
#Scene.add(Game::Director.new(board), :game)
Scene.add(Game::Director.new,:game)
Scene.add(Con::Director.new,:con)
Scene.add(Game2::Director.new,:game2)
Scene.add(Con2::Director.new,:con2)
Scene.add(Game3::Director.new, :game3)
Scene.add(Riku::Riku.new,:riku)
Scene.move_to(:title)

Window.loop do
  break if Input.key_push?(K_ESCAPE)

  Scene.play
end
