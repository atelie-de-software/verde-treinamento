require './src/game'

RSpec.describe Game do
  let!(:game) { Game.new }

  describe 'initial screen' do
    it 'is correct' do
      expected_screen =
        ":::::\n" +
        "==O==\n" +
        "==O==\n" +
        "==O==\n" +
        "M    "
      expect(game.screen).to eq(expected_screen)
    end
  end

  describe 'frog moves to the right' do
    subject { game.right }

    it 'responds correctly' do
      subject

      expected_screen =
        ":::::\n" +
        "==O==\n" +
        "==O==\n" +
        "==O==\n" +
        " M   "
      expect(game.screen).to eq(expected_screen)
    end
  end

  describe 'frog moves to a plant' do
    subject do
      game.right.right.up
    end

    it 'responds correctly' do
      subject
      expected_screen =
        ":::::\n" +
        "==O==\n" +
        "==O==\n" +
        "==B==\n" +
        "     "
      expect(game.screen).to eq(expected_screen)
    end
  end

  describe 'frog falling into water' do
    context 'from beginning of the game' do
      it 'dies moving up' do
        game.up

        expected_screen =
        ":::::\n" +
        "==O==\n" +
        "==O==\n" +
        "X=O==\n" +
        "DEATH"
        expect(game.screen).to eq(expected_screen)
      end
    end

    context 'from a plant' do
      subject(:moves_to_plant) do
        game.right.right.up.up
      end

      it 'dies moving left' do
        moves_to_plant
        game.left

        expected_screen =
          ":::::\n" +
          "==O==\n" +
          "=XO==\n" +
          "==O==\n" +
          "DEATH"

        expect(game.screen).to eq(expected_screen)
      end

      it 'die moving right' do
        moves_to_plant
        game.right

        expected_screen =
          ":::::\n" +
          "==O==\n" +
          "==OX=\n" +
          "==O==\n" +
          "DEATH"

        expect(game.screen).to eq(expected_screen)
      end
    end
  end

  describe 'plant movement' do
    context 'after 10 ticks' do
      it 'the plants should move' do
        10.times do
          game.tick
        end
        expected_screen =
          ":::::\n" +
          "===O=\n" +
          "=O===\n" +
          "===O=\n" +
          "M    "
        expect(game.screen).to eq(expected_screen)
      end
    end

    context 'after 20 ticks' do
      it 'the plants should have on the borders' do
        20.times do
          game.tick
        end
        expected_screen =
          ":::::\n" +
          "====O\n" +
          "O====\n" +
          "====O\n" +
          "M    "
        expect(game.screen).to eq(expected_screen)
      end
    end

    context 'after 30 ticks' do
      it 'the plants should move back' do
        30.times do
          game.tick
        end
        expected_screen =
          ":::::\n" +
          "===O=\n" +
          "=O===\n" +
          "===O=\n" +
          "M    "
        expect(game.screen).to eq(expected_screen)
      end
    end
  end

  describe 'frog is on the plant' do
    it 'moves with a plant' do
      game.right.right.up
      10.times do
        game.tick
      end

      expected_screen =
        ":::::\n" +
        "===O=\n" +
        "=O===\n" +
        "===B=\n" +
        "     "
      expect(game.screen).to eq(expected_screen)
    end
  end

  describe 'wins first level' do
    def wins_first_level(game)
      game.right.right.up.up.up.up
    end
    
    
    context 'before 5 ticks' do
      it 'shows victory screen' do
        wins_first_level(game)
        expected_screen =
          "::W::\n" +
          "==O==\n" +
          "==O==\n" +
          "==O==\n" +
          " WIN "
        expect(game.screen).to eq(expected_screen)
      end
    end
    
    context 'after 5 ticks' do
      xit 'renders second level with moving cars' do
        wins_first_level(game)
        
        5.times do
          game.tick
        end

        expected_screen =
          ":::::\n" +
          "___Q_\n" +
          "_C___\n" +
          "___Q_\n" +
          "  M  "
        expect(game.screen).to eq(expected_screen)

        expected_screen =
          ":::::\n" +
          "__Q__\n" +
          "__C__\n" +
          "__Q__\n" +
          "  E  "

        8.times do
          game.tick
        end

        expect(game.screen).to eq(expected_screen)
      end

      xit 'after a while cars disapear from one side and apear at the other' do
        wins_first_level(game)
        
        5.times do
          game.tick
        end

        (8*3).times do
          game.tick
        end

        expected_screen =
          ":::::\n" +
          "Q____\n" +
          "____C\n" +
          "Q____\n" +
          "  E  "
        expect(game.screen).to eq(expected_screen)

        (8).times do
          game.tick
        end

        expected_screen =
          ":::::\n" +
          "____Q\n" +
          "C____\n" +
          "____Q\n" +
          "  E  "
        expect(game.screen).to eq(expected_screen)
      end

      xit 'frog dies if hit by a car coming from the right' do
        wins_first_level(game)
        
        5.times do
          game.tick
        end

        game.up

        expected_screen =
          ":::::\n" +
          "___Q_\n" +
          "_C___\n" +
          "__SQ_\n" +
          "     "
        expect(game.screen).to eq(expected_screen)

        8.times do
          game.tick
        end

        expected_screen =
          ":::::\n" +
          "__Q__\n" +
          "__C__\n" +
          "__X__\n" +
          "DEATH"
        expect(game.screen).to eq(expected_screen)
      end

      xit 'frog dies if hit by a car coming from the left' do
        wins_first_level(game)
        
        5.times do
          game.tick
        end

        game.up
        game.up

        expected_screen =
          ":::::\n" +
          "___Q_\n" +
          "_CS__\n" +
          "___Q_\n" +
          "     "
        expect(game.screen).to eq(expected_screen)

        8.times do
          game.tick
        end

        expected_screen =
          ":::::\n" +
          "__Q__\n" +
          "__X__\n" +
          "__Q__\n" +
          "DEATH"
        expect(game.screen).to eq(expected_screen)
      end
    end
  end
end
