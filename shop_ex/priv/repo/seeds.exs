# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     ShopEx.Repo.insert!(%ShopEx.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

items = [
  %{name: "Scented Candle", quantity: 50, price: 36.00},
  %{name: "Wireless Headphones", quantity: 100, price: 200.00},
  %{name: "Watercolor set", quantity: 20, price: 15.00},
  %{name: "Ceramic Flower Pot", quantity: 30, price: 24.00},
  %{name: "Alarm Clock", quantity: 100, price: 20.00},
  %{name: "Notebook", quantity: 200, price: 12.00}
]

Enum.each(items, fn item ->
  ShopEx.Inventory.create_item(item)
end)
