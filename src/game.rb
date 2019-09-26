class Game
  DEFAULT_TICK_SPEED = 10.freeze

  def initialize
    @ticks = 0
    @frog_x = 0
    @frog_y = 4
    @flies = [
      {x: 0, y: 3},
      {x: 5, y: 0},
      {x: 1, y: 2},
      {x: 4, y: 4},
      {x: 1, y: 0}
    ]
  end

  def move(dx: 0, dy: 0)
    @frog_y = [[0, @frog_y + dy].max, 4].min
    @frog_x = [[0, @frog_x + dx].max, 5].min
    screen
    
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
    eat_fly if @flies.any?
    @matrix[@frog_y][@frog_x] = 'M'
  end

  def eat_fly
    active_fly = @flies.first
    @matrix[active_fly[:y]][active_fly[:x]] = '*'
    @flies.shift if @matrix[@frog_y][@frog_x] == '*'
  end

  def tick
    @ticks += 1
    self
  end
end
