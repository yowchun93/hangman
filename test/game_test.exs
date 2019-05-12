defmodule GameTest do
  use ExUnit.Case

  alias Hangman.Game

  @tag :pending
  test "new game returns a correct structure" do
    game = Game.new_game
    assert game.turns_left == 7
    assert game.game_state == :initializing
  end

  # Most interesting thing is that, to transform the game
  # YOu will need to pass it into another function
  @tag :pending
  test "make move does not change game already won" do
    game = Game.new_game |> Map.put(:game_state, :won)
    game = Game.play(game, "a")
    assert game.game_state == :won
  end

  @tag :pending
  test "make move does not change lost game" do
    game = Game.new_game |> Map.put(:game_state, :lost)
    game = Game.play(game, "a")
    assert game.game_state == :lost
  end

  @tag :pending
  test "first occurance of letter that is not used" do
    game = Game.new_game("xray")
    game = Game.play(game, "x")
    assert game.game_state != :already_used
  end

  test "returns already used when repeated word" do
    game = Game.new_game("xray")
    game = Game.play(game, "x")
    game = Game.play(game, "x")
    assert game.game_state == :already_used
  end

  @tag :pending
  test "a good guess is recognized" do
    game = Game.new_game("wibble")
    game = Game.play(game, "w")
    assert game.game_state == :good_guess
    assert game.turns_left == 7
  end

  @tag :pending
  test "a bad guess" do
    game = Game.new_game("wibble")
    game = Game.play(game, "g")
    assert game.game_state == :bad_guess
    assert game.turns_left == 6
  end

  @tag :pending
  test "game won" do
    game = Game.new_game("may")
    game  = Game.play(game, "m")
    game  = Game.play(game, "a")
    game  = Game.play(game, "y")
    IO.inspect(game)
    assert game.game_state == :won
  end

end
