defmodule Services.ConsumerPool do
  def start_link(config) do
    ExRabbitPool.PoolSupervisor.start_link(config, __MODULE__)
  end

  def rabbitmq_config do
    [channels: 5]
  end

  def connection_pools do
    consumer_pool = [
      name: {:local, :consumer_pool},
      worker_module: ExRabbitPool.Worker.RabbitConnection,
      size: 1,
      max_overflow: 0
    ]

    [consumer_pool]
  end

  def child_spec(_opts) do
    %{
      id: __MODULE__,
      start: {
        __MODULE__,
        :start_link,
        [
          [
            rabbitmq_config: rabbitmq_config(),
            connection_pools: connection_pools()
          ]
        ]
      },
      type: :supervisor
    }
  end
end
