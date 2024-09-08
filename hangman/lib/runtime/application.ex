defmodule Hangman.Runtime.Application do
  use Application

  @super_name GameStarter

  def start(_type, _args) do
    # the dynamic supervisor will be in charge of starting our server
    supervisor_spec = [
      {DynamicSupervisor, strategy: :one_for_one, name: @super_name}
    ]

    # strategy here is for how the application supervisor handles the dynamic supervisor
    Supervisor.start_link(supervisor_spec, strategy: :one_for_one)
  end

  def start_game do
    DynamicSupervisor.start_child(@super_name, { Hangman.Runtime.Server, nil })
  end
end
