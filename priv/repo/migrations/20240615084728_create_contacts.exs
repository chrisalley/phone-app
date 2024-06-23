defmodule PhoneApp.Repo.Migrations.CreateContacts do
  use Ecto.Migration

  def change do
    create table(:contacts) do
      add :phone_number, :text, null: false
      add :name, :text

      timestamps()
    end

    create unique_index(:contacts, [:phone_number])
  end
end
