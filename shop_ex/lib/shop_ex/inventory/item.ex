defmodule ShopEx.Inventory.Item do
  use Ecto.Schema
  import Ecto.Changeset

  schema "items" do
    field :name, :string
    field :price, :float
    field :on_sale, :boolean, default: false
    field :quantity, :integer
    timestamps()
  end

  @doc false
  def changeset(item, attrs) do
    item
    |> cast(attrs, [:name, :price, :on_sale, :quantity])
    |> validate_required([:name, :price, :on_sale, :quantity])
  end
end
