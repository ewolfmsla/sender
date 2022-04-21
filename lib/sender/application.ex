defmodule Sender.Application do
  @moduledoc """
  A Supervisor to be used for testing supervision of async tasks
  """

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      {Task.Supervisor, name: Sender.EmailTaskSupervisor}
    ]

    opts = [strategy: :one_for_one, name: Sender.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
