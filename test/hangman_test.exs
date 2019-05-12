defmodule HangmanTest do
  use ExUnit.Case
  doctest Hangman

  test "greets the world" do
    assert Hangman.hello() == :world
  end
  # test "new game returns a correct structure" do
  #   game = Hangman.new_game
  #   assert game.turns_left == 7
  #   assert game.game_state == :initializing
  # end

end
