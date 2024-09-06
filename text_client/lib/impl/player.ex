defmodule TextClient.Impl.Player do
  @typep game :: Hangman.game
  @typep tally :: Hangman.tally
  @typep state :: { game, tally }

  @spec start() :: :ok
  def start() do
    game = Hangman.new_game()
    tally = Hangman.tally(game)
    interact({ game, tally })
  end

  #   @type state :: :initializing | :won | :lost | :good_guess | :bad_guess | :already_used
  @spec interact(state) :: :ok

  def interact({ _game, tally = %{ game_state: :won } }) do
    IO.puts "Congrats. You won! The word was #{tally.letters}"
  end

  def interact({ game, _tally = %{ game_state: :lost } }) do
    IO.puts "Sorry, you lost. The word was #{game.letters}"
  end

  def interact({ game, tally }) do
    # feedback
    IO.puts feedback_for(tally)

    # display current word
    IO.puts current_word(tally)

    # get next guess
    guess = get_guess()

    # make move
    Hangman.make_move(game, guess)
    |>  interact()
  end

  ########### HELPERS ###########
  @spec feedback_for(tally) :: String.t

  def feedback_for(tally = %{ game_state: :initializing }) do
    "Welcome to Hangman! I'm thinking of a #{tally.letters |> length} letter word."
  end
  def feedback_for(_tally = %{ game_state: :good_guess }), do: "Good guess!"
  def feedback_for(_tally = %{ game_state: :bad_guess }), do: "Sorry, that's not in the word."
  def feedback_for(_tally = %{ game_state: :already_used }), do: "You already tried that letter."

  @spec current_word(tally) :: String.t
  def current_word(tally) do
    [
      "Word so far: ", tally.letters |> Enum.join(" "),
      "    turns left: ", tally.turns_left |> to_string(),
      "    used: ", tally.used |> Enum.join(", ")
    ]
  end

  @spec get_guess() :: String.t
  def get_guess() do
    IO.gets("Next letter: ") |> String.trim() |> String.downcase()
  end
end
