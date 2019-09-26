require './src/game'

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
    subject { game.right }

    it 'responds correctly' do
      subject

      expected_screen =
        "======\n" +
        "======\n" +
        "======\n" +
        "*=====\n" +
        "=M===="
      expect(game.screen).to eq(expected_screen)
    end
  end

  describe 'frog catch the fly' do
    it 'from the begining and other fly shows up' do
      game.up

      expected_screen =
      "======\n" +
      "======\n" +
      "======\n" +
      "M=====\n" +
      "======"
      expect(game.screen).to eq(expected_screen)

      game.tick

      expected_screen =
      "=====*\n" +
      "======\n" +
      "======\n" +
      "M=====\n" +
      "======"
      expect(game.screen).to eq(expected_screen)
    end

    xit 'move two times up' do
      game.up.up

      expected_screen =
      "=====*\n" +
      "======\n" +
      "M=====\n" +
      "======\n" +
      "======"
      expect(game.screen).to eq(expected_screen)
    end

    xit 'move to top right of screen and shows another fly' do
      game.up.up.up.up.up.right.right.right.right.right

      expected_screen =
      "=====M\n" +
      "======\n" +
      "======\n" +
      "======\n" +
      "======"
      expect(game.screen).to eq(expected_screen)

      game.tick

      expected_screen =
      "=====M\n" +
      "======\n" +
      "=*====\n" +
      "======\n" +
      "======"
      expect(game.screen).to eq(expected_screen)
    end

    xit 'move to top right of screen and shows another fly' do
      game.up.up.up.up.up.right.right.right.right.right.down.down.left.left.left.left

      expected_screen =
      "======\n" +
      "======\n" +
      "=M====\n" +
      "======\n" +
      "======"
      expect(game.screen).to eq(expected_screen)

      game.tick

      expected_screen =
      "======\n" +
      "======\n" +
      "=M====\n" +
      "======\n" +
      "====*="
      expect(game.screen).to eq(expected_screen)
    end
  end
end
