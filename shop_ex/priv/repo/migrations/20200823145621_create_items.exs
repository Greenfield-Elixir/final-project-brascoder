defmodule ShopEx.Repo.Migrations.CreateItems do
  use Ecto.Migration

  def change do
    create table(:items) do
      add :name, :string
      add :price, :float
      add :on_sale, :boolean, default: false
      add :quantity, :integer
      timestamps()
    end
  end
end
