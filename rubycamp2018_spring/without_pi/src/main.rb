require 'dxruby'
require_relative 'scene'
require_relative 'scene_title/director'
require 'smalrubot'
require_relative 'scene_con/director'
require_relative 'scene_con2/director'
require_relative 'scene_game/director'
require_relative 'scene_game2/director'
require_relative 'scene_game3/director3'
require_relative 'scene_cre/riku'


Window.width = 800
Window.height = 600

board = Smalrubot::Board.new(Smalrubot::TxRx::Serial.new)

Scene.add(Title::Director.new(board),:title)
Scene.add(Game::Director.new(board), :game)
Scene.add(Con::Director.new(board),:con)
Scene.add(Game2::Director.new(board),:game2)
Scene.add(Con2::Director.new(board),:con2)
Scene.add(Game3::Director.new(board), :game3)
Scene.add(Riku::Riku.new(board),:riku)
Scene.move_to(:title)

Window.loop do
  break if Input.key_push?(K_ESCAPE)

  Scene.play
end
