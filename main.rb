require 'ruby2d'
require_relative 'src/game'

SPRITE_WIDTH = 62.freeze
SPRITE_HEIGHT = 62.freeze

game = Game.new

update do
  system 'clear'

  game_screen = game.screen
  puts game_screen
  coord_y = 0
  game_screen.split("\n").each do |lines|
    coord_x = 0
    lines.split('').each do |sprite|
      case sprite
      when '='
        Image.new('assets/images/water.png', x: coord_x, y: coord_y)
      when ' '
        Image.new('assets/images/start.png', x: coord_x, y: coord_y)
      when ':'
        Image.new('assets/images/finish.png', x: coord_x, y: coord_y)
      when 'X'
        Image.new('assets/images/dead.png', x: coord_x, y: coord_y)
      when 'M'
        Image.new('assets/images/start.png', x: coord_x, y: coord_y)
        Image.new('assets/images/frog.png', x: coord_x, y: coord_y)
      when 'O'
        Image.new('assets/images/water.png', x: coord_x, y: coord_y)
        Image.new('assets/images/leaf.png', x: coord_x, y: coord_y)
      when 'B'
        Image.new('assets/images/water.png', x: coord_x, y: coord_y)
        Image.new('assets/images/leaf.png', x: coord_x, y: coord_y)
        Image.new('assets/images/frog.png', x: coord_x, y: coord_y)
      when '#'
        Image.new('assets/images/finish.png', x: coord_x, y: coord_y)
        Image.new('assets/images/frog.png', x: coord_x, y: coord_y)
      end

      coord_x += SPRITE_WIDTH
    end
    coord_y += SPRITE_HEIGHT
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

show
