defmodule ExTesting.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application
  require Task.Supervisor

  def start(_type, _args) do
    
    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ExTesting.Supervisor]
    Supervisor.start_link(get_sup_children(Application.get_env(:ex_testing, :env)), opts)
  end

  defp get_sup_children(:test) do
    [
      {ExTesting.Repo, []}
    ]
  end

  defp get_sup_children(_) do
    [
      {Task.Supervisor, name: ExTesting.TaskSupervisor},
      {ExTesting.Repo, []}
    ]
  end
end
