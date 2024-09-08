defmodule Hangman.Runtime.Server do

  @type t :: pid

  alias Hangman.Impl.Game

  # macro that generates code that's injected into our module
  use GenServer # behaviour specifies like 9-11 callbacks

  ### client process
  # the throwaway param is cuz it's being run by a supervisor
  def start_link(_) do
    GenServer.start_link(__MODULE__, nil) # genserver is gonna create new process, and call init within process
  end

  ### server process
  def init(_) do
    { :ok, Game.new_game() }
  end

  def handle_call({:make_move, guess}, _from, game) do
    {updated_game, tally} = Game.make_move(game, guess)
    {:reply, tally, updated_game} # response, value we want, new state is the common return value
  end

  def handle_call({:tally}, _from, game) do
    {:reply, Game.tally(game), game}
  end
end
