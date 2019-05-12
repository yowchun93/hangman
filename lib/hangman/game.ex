defmodule Hangman.Game do

  alias Hangman.Game
  # start with declaring a struct
  defstruct(
    game_state: :initializing,
    turns_left: 7,
    letters: [],
    used: []
  )

  def new_game(word) do
    %Game{letters: String.codepoints(word)}
  end

  def new_game do
    %Game{letters: String.codepoints("hello")}
  end

  def play(game = %Game{game_state: :won}, _) do
    game
  end

  def play(game = %Game{game_state: :lost}, _) do
    game
  end

  def play(game, guess) do
    accept_move(game, guess ,Enum.member?(game.used, guess))
  end
  # how to change multiple values ??
  def accept_move(game, _ ,_already_used=true) do
    new_game = Map.put(game, :game_state, :already_used)
    new_game
  end

  def accept_move(game, guess,_already_used=false) do
    new_game = Map.put(game, :used, [guess | game.used])
    correct_guess(new_game, guess, Enum.member?(game.letters, guess))
  end
  def correct_guess(game, _, _correct=true) do
    letter_set = MapSet.new(game.letters)
    new_state = game_won?(MapSet.subset?(letter_set, MapSet.new(game.used)))
    game |> Map.put(:game_state, new_state)
  end

  def correct_guess(game, guess, _correct=false) do
    %{
      game |
      game_state: :bad_guess,
      turns_left: game.turns_left - 1,
      used: [guess | game.used]
    }
  end

  def game_won?(true) do
    :won
  end

  def game_won?(false) do
    :good_guess
  end

end
