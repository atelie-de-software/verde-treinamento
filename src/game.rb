class Game
  DEFAULT_TICK_SPEED = 10.freeze

  def initialize
    @ticks = 0
    @frog_x = 0
    @frog_y = 4
    @flies = [
      {x: 0, y: 3},
      {x: 5, y: 0}
    ]
  end

  def move(dx: 0, dy: 0)
    @frog_y = [[0, @frog_y + dy].max, 4].min
    @frog_x = [[0, @frog_x + dx].max, 4].min
    self
  end

  def up()    move(dy: -1) end
  def down()  move(dy:  1) end
  def left()  move(dx: -1) end
  def right() move(dx:  1) end

  def empty_matrix_first_map
    [
      ['=', '=', '=', '=', '=', '=', "\n"],
      ['=', '=', '=', '=', '=', '=', "\n"],
      ['=', '=', '=', '=', '=', '=', "\n"],
      ['=', '=', '=', '=', '=', '=', "\n"],
      ['=', '=', '=', '=', '=', '=']
    ]
  end

  def screen
    @matrix = empty_matrix_first_map

    tile_overwrite

    @matrix.flatten.join('')
  end

  def tile_overwrite
    active_fly = @flies.first
    @matrix[active_fly[:y]][active_fly[:x]] = '*'

    @flies.shift if @matrix[@frog_y][@frog_x] == '*'

    @matrix[@frog_y][@frog_x] = 'M'
  end

  def tick
    @ticks += 1

    if @ticks.modulo(DEFAULT_TICK_SPEED).zero?

    end

    self
  end
end
