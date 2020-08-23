# Final Project
For this workshop's final project, you'll be given a Phoenix app that represents our online store's monolith. This app implements some inventory management actions for which you will define and publish messages over RabbitMQ. You will also be given a generic Phoenix app in which you can define a set of independent services that may want to consume these messages.

## Learning Goals
* Design a messaging system that communicates facts around the world of your online store ecosystem.
  * Practice identifying what facts to communicate and when.
  * Practice designing a sane system of queues and exchanges over which to perform this communication.
* Use Protobuf to design and enforce consistent message contracts.
* Leverage ExRabbitPool to manage RabbitMQ resources to build a system that is appropriately resilient to failure.
* Build a supervision tree that monitors RabbitMQ consumers such that, if one consumer crashes, the others are terminated too.

Keep in mind that with the provided time you may not complete the full exercise. This project is intentionally open-ended. It is designed to give you a change to think through all of the complexities of a robust async messaging system. Make as much progress as you can in the allotted time and remember that you can keep working on this project after this workshop wraps up!

## Instructions  

### The Apps
We've provided you two applications in this repo:

#### ShopEx
ShopEx is your online store's inventory management system. You can view items at `/items` and perform the following actions:

* Add a new item to the store for sale
* Edit an item's name, quantity, price or whether or not it is on sale
* Recall an item, which deletes it from your inventory entirely

`cd` into the `shop_ex` directory and view that application's README to get up and running.

#### Services
The Services app is the home for any and all services that might consume and act on messages published by ShopEx. This is where you will define consumers for ShopEx's Inventory messages. For example, maybe the Services app defines a Marketing service with a consumer for "item on sale" messages so that such items can be promoted to customers accordingly.

`cd` into the `services` directory and view that application's README to get up and running.

### You Will...
* Design and implement Protobuf messages and publish them when inventory actions occur in the ShopEx app.
* Design and implement a set of consumers for those messages in the Service app.
* Manage those consumers with a supervision tree, such that, if one consumer crashes, the others are terminated too.

#### Publishing Messages
We've provided the ShopEx application with the basic tools it needs to connect to RabbitMQ and publish messages. There is a Publisher Pool that you can use when defining a publisher module that sends messages.

We've also provided a `docker-compose.yml` file that you can use to start up RabbitMQ and run the `protoc` utility to convert any Protobuf messages you define in `shop_ex/messages/`.

There are some tests for basic inventory functionality defined in the ShopEx `test/` directory, but this is _not_ a test-driven assignment. It's up to you how you want your publishing workflows to behave.  

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
* What is an appropriate exchange for a given message to be published over?
* What other kinds of services might exist in an online store system? For example, maybe there is a marketing service that wants to know when an item goes on sale so that it can promote that item to customers. Or maybe there is a legal/compliance service that needs to know if an item is recalled.
* What information will you need to include in the messages you send over RabbitMQ so that any consuming services can perform their necessary actions?

#### Consuming Messages
We've provided this application with the basic tools it needs to connect to RabbitMQ and consume messages. There is a Consumer Pool that you can use when defining your RabbitMQ consumers.

We've also provided a `docker-compose.yml` file that you can use to start up RabbitMQ and run the `protoc` utility to convert any Protobuf messages you define in `services/messages/`.

You'll need to brainstorm some services that might care about consuming the inventory messages you are publishing. Is there a marketing service that consumes "item on sale" messages so that those items can be promoted to customers? Is there a legal or compliance service that might need to do if an item has been recalled? What other scenarios can you imagine?

Once you've determined what type of service might consume a given message and why, you'll need to:

* Define a consumer for that message.
  * Make sure your consumer establishes an appropriately named queue and binds it to the correct exchange.
  * Teach your consumer to handle the given message. Consider making this something of a "dummy" function. In other words, you're marketing service probably doesn't _really_ send an email to a set of customers, maybe it just puts out a log statement saying that it did ;)
* Design a supervision tree that manages and monitors your consumer.

Proceed to implement additional message publishers and consumers if you have time.
