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

    it 'eat three flies' do
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

    it 'eat four flies' do
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

    it 'eat five flies' do
      game.up.up.up.up.up.right.right.right.right.right.down.down.left.left.left.left.right.right.right.down.down

      expected_screen =
      "=*====\n" +
      "======\n" +
      "======\n" +
      "======\n" +
      "====M="
      expect(game.screen).to eq(expected_screen)
    end

    xit 'eat six flies' do
      game.up.up.up.up.up.right.right.right.right.right.down.down.left.left.left.left.right.right.right.down.down.up.up.up.up.left.left.left

      expected_screen =
      "=M====\n" +
      "======\n" +
      "======\n" +
      "*=====\n" +
      "======"
      expect(game.screen).to eq(expected_screen)
    end

    xit 'eat seven flies' do
      game.up.up.up.up.up.right.right.right.right.right.down.down.left.left.left.left.right.right.right.down.down.up.up.up.up.left.left.left.left.down.down.down
      expected_screen =
      "=====*\n" +
      "======\n" +
      "======\n" +
      "M=====\n" +
      "======"
      expect(game.screen).to eq(expected_screen)
    end

    xit 'end the game after 1 minute and show the result' do
      game.up.up.up.up.up.right.right.right.right.right.down.down.left.left.left.left.right.right.right.down.down.up.up.up.up.left.left.left

      tick 30

      expected_screen =
      "======\n" +
      "======\n" +
      "==06==\n" +
      "======\n" +
      "======"
      expect(game.screen).to eq(expected_screen)
    end
  end
end
