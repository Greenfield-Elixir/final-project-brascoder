# ShopEx

## The App

ShopEx is your online store's inventory management system. You can view items at `/items` and perform the following actions:

* Add a new item to the store for sale
* Edit an item's name, quantity, price or whether or not it is on sale
* Recall an item, which deletes it from your inventory entirely

## Up and Running

To start your Phoenix server:

  * Setup the project with `mix setup`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Messaging
We've provided this application with the basic tools it needs to connect to RabbitMQ and publish messages. There is a Publisher Pool that you can use when defining a publisher module that sends messages.

We've also provided a `docker-compose.yml` file that you can use to start up RabbitMQ and run the `protoc` utility to convert any Protobuf messages you define in `shop_ex/messages/`.

Your job is to think about the inventory actions listed above, pick an action for which you want to publish an event, design a message for that event, and publish it.

You can leverage the existing Inventory context's CRUD functions to enact message publishing. For example, the `ShopEx.Inventory.create_item/1` function looks like this:

```elixir
def create_item(attrs \\ %{}) do
  case do_create_item(attrs) do
    {:ok, item} ->
      # do any publishing here
      {:ok, item}

    {:error, changeset} ->
      {:error, changeset}
  end
end
```

Some things to think about:
* What other kinds of services might exist in an online store system? For example, maybe there is a marketing service that wants to know when an item goes on sale so that it can promote that item to customers. Or maybe there is a legal/compliance service that needs to know if an item is recalled.
* What information will you need to include in the messages you send over RabbitMQ so that any consuming services can perform their necessary actions?
