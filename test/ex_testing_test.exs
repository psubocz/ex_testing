defmodule ExTestingTest do
  use ExUnit.Case

  setup do
      :ok = Ecto.Adapters.SQL.Sandbox.checkout(ExTesting.Repo)
      Ecto.Adapters.SQL.Sandbox.mode(ExTesting.Repo, {:shared, self()})
      start_supervised({Task.Supervisor, name: ExTesting.TaskSupervisor}, restart: :temporary)
      on_exit(fn -> Process.sleep(1000) end)
      :ok
  end
  
  @tag supervised: true
  test "log now" do
    ExTesting.log_now("test log")
    %ExTesting.Log{log: "test log"} = ExTesting.Log |> Ecto.Query.last |> ExTesting.Repo.one
  end

  @tag supervised: true 
  test "log later" do
    ExTesting.log_later("test log")
  end

  @tag supervised: true
  test "log fail" do
    ExTesting.log_later("test log")
    assert true == false
  end

  @tag supervised: false
  test "log fail unsupervised" do
    ExTesting.log_later_unsupervised("test log")
    assert true == false
  end

  @tag supervised: false
  test "log later unsupervised" do
    ExTesting.log_later_unsupervised("test log")
  end

  @tag supervised: true
  test "wait for task to finish" do
    ExTesting.log_later("test log")
    wait_for_background_tasks()
  end

  defp wait_for_background_tasks do
    ExTesting.TaskSupervisor
    |> Task.Supervisor.children()
    |> Enum.map(fn child ->
      ref = Process.monitor(child)
      assert_receive({:DOWN, ^ref, :process, child, _}, 1000)
    end)
  end
end
