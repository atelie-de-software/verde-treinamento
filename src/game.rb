class Game
  DEFAULT_TICK_SPEED = 10.freeze

  def initialize
    @ticks = 0
    @frog_x = 0
    @frog_y = 4
    @rocks = [
      { x: 2, y: 1, dir: 1},
      { x: 2, y: 2, dir: -1},
      { x: 2, y: 3, dir: 1}
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
      [':', ':', ':', ':', ':', "\n"],
      ['=', '=', '=', '=', '=', "\n"],
      ['=', '=', '=', '=', '=', "\n"],
      ['=', '=', '=', '=', '=', "\n"],
      [' ', ' ', ' ', ' ', ' ']
    ]
  end

  def screen
    @matrix = empty_matrix_first_map

    game_engine
    tile_overwrite

    @matrix.flatten.join('')
  end

  def game_engine
    @rocks.each do |rock|
      @matrix[rock[:y]][rock[:x]] = 'O'
    end
  end

  def tile_overwrite
    case @matrix[@frog_y][@frog_x]
    when '='
      @matrix[@frog_y][@frog_x] = 'X'
      @matrix[4] = ['D', 'E', 'A', 'T', 'H']
    when ':'
      @matrix[@frog_y][@frog_x] = '#'
      @matrix[4] = [' ', 'W', 'I', 'N', ' ']
    when 'O'
      @matrix[@frog_y][@frog_x] = 'B'
    else
      @matrix[@frog_y][@frog_x] = 'M'
    end
  end

  def tick
    @ticks += 1

    if @ticks.modulo(DEFAULT_TICK_SPEED).zero?
      @rocks.each do |rock|
        rock[:dir] = -rock[:dir] if rock[:x] + rock[:dir] > 4 || rock[:x] + rock[:dir] < 0

        @frog_x += rock[:dir] if rock[:x] == @frog_x && rock[:y] == @frog_y
        rock[:x] += rock[:dir]
      end
    end

    self
  end
end
