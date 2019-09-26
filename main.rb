require 'ruby2d'
require_relative 'src/game'

SPRITE_WIDTH = 62.freeze
SPRITE_HEIGHT = 62.freeze

SPRITES = {
  '=': ['assets/images/background.png'],
  'M': ['assets/images/background.png', 'assets/images/frog.png'],
  '*': ['assets/images/background.png', 'assets/images/fly.png']
}

game = Game.new

update do
  clear
  system 'clear'

  game_screen = game.screen
  puts game_screen
  game_screen.split("\n").each_with_index do |lines, index_y|
    lines.split('').each_with_index do |sprite, index_x|
      render_sprite(sprite, index_x, index_y)
    end
  end
  sleep 0.2
  game.tick
end

on :key_down do |event|
  game.right if event.key == 'right'
  game.left if event.key == 'left'
  game.up if event.key == 'up'
  game.down if event.key == 'down'
end

def render_sprite sprite_code, x_index, y_index
  sprite_paths = SPRITES[sprite_code.to_sym]
  x_coord = (x_index * SPRITE_WIDTH)
  y_coord = (y_index * SPRITE_HEIGHT)
  
  sprite_paths.each do |sprite_path|
    Image.new(sprite_path, x: x_coord, y: y_coord, width: SPRITE_WIDTH, height: SPRITE_HEIGHT)
  end
end

show
