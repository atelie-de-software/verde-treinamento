require './src/game'

def tick(vezes = 1)
  vezes.times { game.tick }
end

def up(vezes = 1)
  vezes.times { game.up }
end

def down(vezes = 1)
  vezes.times { game.down }
end

def right(vezes = 1)
  vezes.times { game.right }
end

def left(vezes = 1)
  vezes.times { game.left }
end

RSpec.describe Game do
  let!(:game) { Game.new }

  describe 'initial screen' do
    it 'is correct' do
      expected_screen =
        "======\n" +
        "======\n" +
        "======\n" +
        "*=====\n" +
        "M====="
      expect(game.screen).to eq(expected_screen)
    end
  end

  describe 'frog moves to the right' do
    it 'responds correctly' do
      right 1

      expected_screen =
        "======\n" +
        "======\n" +
        "======\n" +
        "*=====\n" +
        "=M===="
      expect(game.screen).to eq(expected_screen)
    end
  end

  describe 'frog catch the flies' do
    it 'from the begining and other fly shows up' do
      game.up

      expected_screen =
      "=====*\n" +
      "======\n" +
      "======\n" +
      "M=====\n" +
      "======"
      expect(game.screen).to eq(expected_screen)
    end

    it 'eat two flies' do
      up 5
      right 5

      expected_screen =
      "=====M\n" +
      "======\n" +
      "=*====\n" +
      "======\n" +
      "======"
      expect(game.screen).to eq(expected_screen)
    end

    it 'eat three flies' do
      up 5
      right 5
      down 2
      left 4

      expected_screen =
      "======\n" +
      "======\n" +
      "=M====\n" +
      "======\n" +
      "====*="
      expect(game.screen).to eq(expected_screen)
    end

    it 'eat four flies' do
      up 5
      right 5
      down 2
      left 4
      right 3
      down 2

      expected_screen =
      "=*====\n" +
      "======\n" +
      "======\n" +
      "======\n" +
      "====M="
      expect(game.screen).to eq(expected_screen)
    end

    it 'eat five flies' do
      up 5
      right 5
      down 2
      left 4
      right 3
      down 2
      up 4
      left 3

      expected_screen =
      "=M====\n" +
      "======\n" +
      "======\n" +
      "*=====\n" +
      "======"
      expect(game.screen).to eq(expected_screen)
    end

    it 'eat six flies' do
      up 5
      right 5
      down 2
      left 4
      right 3
      down 2
      up 4
      left 4
      down 3

      expected_screen =
      "=====*\n" +
      "======\n" +
      "======\n" +
      "M=====\n" +
      "======"
      expect(game.screen).to eq(expected_screen)
    end

    xit 'end the game after 1 minute and show the result' do
      up 5
      right 5
      down 2
      left 4
      right 3
      down 2
      up 4
      left 3

      tick 300

      expected_screen =
      "======\n" +
      "======\n" +
      "==05==\n" +
      "======\n" +
      "======"
      expect(game.screen).to eq(expected_screen)
    end
  end
end
