# in this file we just implement the API - there's no implementation
# impl directory implements application logic
# runtime directory implements functionality that makes the code run
#   application.ex is the interface to the elixir runtime, telling it where to start
#   server.ex implments the genserver layer on top of the code in impl
defmodule Hangman do
  alias Hangman.Runtime.Server
  alias Hangman.Type

  @opaque game :: Server.t()
  @type tally :: Type.tally()

  @spec new_game() :: game
  def new_game do
    {:ok, pid} = Hangman.Runtime.Application.start_game()
    pid
  end

  @spec make_move(game, String.t()) :: tally
  def make_move(game, guess) do
    GenServer.call(game, {:make_move, guess})
  end

  @spec tally(game) :: tally
  def tally(game) do
    GenServer.call(game, {:tally})
  end
end
