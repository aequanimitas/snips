defmodule Discuss.Repo.Migrations.AddUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string
      # gh, fb, google?
      add :provider, :string
      add :token, :string

      timestamps()
    end 
  end
end
