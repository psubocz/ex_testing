defmodule ExTesting do
  def log_now(log) do
    ExTesting.Repo.insert(%ExTesting.Log{log: log})
  end

  def log_later_unsupervised(log) do
    Task.start(fn ->
      Process.sleep(500)
      ExTesting.Repo.insert(%ExTesting.Log{log: log})
    end)
  end

  def log_later(log) do
    Task.Supervisor.start_child(ExTesting.TaskSupervisor, fn ->
      Process.sleep(500)
      ExTesting.Repo.insert(%ExTesting.Log{log: log})
    end)
  end
end
