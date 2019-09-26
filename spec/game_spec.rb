# frozen_string_literal: true

require './src/game'

def screen(*correct_screen)
  expect(game.screen).to eq(correct_screen.join("\n"))
end

RSpec.describe Game do
  let!(:game) { Game.new }

  describe 'initial screen' do
    it 'is correct' do
      screen ':::::',
             '==O==',
             '==O==',
             '==O==',
             'M    '
    end
  end

  describe 'frog moves to the right' do
    subject { game.right }

    it 'responds correctly' do
      subject

      screen ':::::',
             '==O==',
             '==O==',
             '==O==',
             ' M   '
    end
  end

  describe 'frog moves to a plant' do
    subject do
      game.right.right.up
    end

    it 'responds correctly' do
      subject
      screen ':::::',
             '==O==',
             '==O==',
             '==B==',
             '     '
    end
  end

  describe 'frog falling into water' do
    context 'from beginning of the game' do
      it 'dies moving up' do
        game.up

        screen ':::::',
               '==O==',
               '==O==',
               'X=O==',
               'DEATH'
      end
    end

    context 'from a plant' do
      subject(:moves_to_plant) do
        game.right.right.up.up
      end

      it 'dies moving left' do
        moves_to_plant
        game.left

        screen ':::::',
               '==O==',
               '=XO==',
               '==O==',
               'DEATH'
      end

      it 'die moving right' do
        moves_to_plant
        game.right

        screen ':::::',
               '==O==',
               '==OX=',
               '==O==',
               'DEATH'
      end
    end
  end

  describe 'plant movement' do
    context 'after 10 ticks' do
      it 'the plants should move' do
        10.times do
          game.tick
        end
        screen ':::::',
               '===O=',
               '=O===',
               '===O=',
               'M    '
      end
    end

    context 'after 20 ticks' do
      it 'the plants should have on the borders' do
        20.times do
          game.tick
        end
        screen ':::::',
               '====O',
               'O====',
               '====O',
               'M    '
      end
    end

    context 'after 30 ticks' do
      it 'the plants should move back' do
        30.times do
          game.tick
        end
        screen ':::::',
               '===O=',
               '=O===',
               '===O=',
               'M    '
      end
    end
  end

  describe 'frog is on the plant' do
    it 'moves with a plant' do
      game.right.right.up
      10.times do
        game.tick
      end

      screen ':::::',
             '===O=',
             '=O===',
             '===B=',
             '     '
    end
  end

  describe 'wins first level' do
    def wins_first_level(game)
      game.right.right.up.up.up.up
    end

    context 'before 5 ticks' do
      it 'shows victory screen' do
        wins_first_level(game)

        screen '::#::',
               '==O==',
               '==O==',
               '==O==',
               ' WIN '
      end
    end

    context 'after 5 ticks' do
      xit 'renders second level with moving cars' do
        wins_first_level(game)

        5.times do
          game.tick
        end

        screen ':::::',
               '___Q_',
               '_C___',
               '___Q_',
               '  E  '

        8.times do
          game.tick
        end

        screen ':::::',
               '__Q__',
               '__C__',
               '__Q__',
               '  E  '
      end

      xit 'after a while cars disapear from one side and apear at the other' do
        wins_first_level(game)

        5.times do
          game.tick
        end

        (8 * 3).times do
          game.tick
        end

        screen ':::::',
               'Q____',
               '____C',
               'Q____',
               '  E  '

        8.times do
          game.tick
        end

        screen ':::::',
               '____Q',
               'C____',
               '____Q',
               '  E  '
      end

      xit 'frog dies if hit by a car coming from the right' do
        wins_first_level(game)

        5.times do
          game.tick
        end

        game.up

        screen ':::::',
               '___Q_',
               '_C___',
               '__SQ_',
               '     '

        8.times do
          game.tick
        end

        screen ':::::',
               '__Q__',
               '__C__',
               '__X__',
               'DEATH'
      end

      xit 'frog dies if hit by a car coming from the left' do
        wins_first_level(game)

        5.times do
          game.tick
        end

        game.up
        game.up

        screen ':::::',
               '___Q_',
               '_CS__',
               '___Q_',
               '     '

        8.times do
          game.tick
        end

        screen ':::::',
               '__Q__',
               '__X__',
               '__Q__',
               'DEATH'
      end

      xit 'frog wins second level if it crosses the map' do
        wins_first_level(game)

        5.times do
          game.tick
        end

        game.up
        game.up
        game.up
        game.up

        screen '::#::',
               '___Q_',
               '_C___',
               '___Q_',
               ' WIN '

        8.times do
          game.tick
        end

        screen '::#::',
               '__Q__',
               '__C__',
               '__Q__',
               ' WIN '
      end
    end
  end
end
