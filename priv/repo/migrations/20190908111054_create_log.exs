defmodule ExTesting.Repo.Migrations.CreateLog do
  use Ecto.Migration

  def change do
    create table(:log) do
      add :log, :string
    end
  end
end
