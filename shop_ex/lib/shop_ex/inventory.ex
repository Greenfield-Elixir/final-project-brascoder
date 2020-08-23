defmodule ShopEx.Inventory do
  @moduledoc """
  The Inventory context.
  """

  import Ecto.Query, warn: false
  alias ShopEx.Repo
  alias ShopEx.Inventory.Item

  @doc """
  Returns the list of items.

  ## Examples

      iex> list_items()
      [%Item{}, ...]

  """
  def list_items do
    Repo.all(Item)
  end

  @doc """
  Gets a single item.

  Raises `Ecto.NoResultsError` if the Item does not exist.

  ## Examples

      iex> get_item!(123)
      %Item{}

      iex> get_item!(456)
      ** (Ecto.NoResultsError)

  """
  def get_item!(id), do: Repo.get!(Item, id)

  @doc """
  Creates an item.

  ## Examples

      iex> do_create_item(%{field: value})
      {:ok, %Item{}}

      iex> do_create_item(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  defp do_create_item(attrs \\ %{}) do
    %Item{}
    |> Item.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Creates an item and publishes any messages.

  ## Examples

      iex> create_item(%{field: value})
      {:ok, %Item{}}

      iex> create_item(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_item(attrs \\ %{}) do
    case do_create_item(attrs) do
      {:ok, item} ->
        # do any publishing here
        {:ok, item}

      {:error, changeset} ->
        {:error, changeset}
    end
  end

  @doc """
  Updates a item.

  ## Examples

      iex> do_update_item(item, %{field: new_value})
      {:ok, %Item{}}

      iex> do_update_item(item, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  defp do_update_item(%Item{} = item, attrs) do
    item
    |> Item.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Updates an item and publishes any messages


  ## Examples
      iex> update_item(item, %{field: new_value})
      {:ok, %Item{}}

      iex> update_item(item, %{field: bad_value})
      {:error, %Ecto.Changeset{}}
  """
  def update_item(%Item{} = item, attrs) do
    case do_update_item(item, attrs) do
      {:ok, item} ->
        # Call Inventory.diff_item(socket.assigns.item, updated_item) to see what was updated
        # and publish any messages based on these changes
        {:ok, item}

      {:error, changeset} ->
        {:error, changeset}
    end
  end

  @doc """
  Deletes a item.

  ## Examples

      iex> do_delete_item(item)
      {:ok, %Item{}}

      iex> do_delete_item(item)
      {:error, %Ecto.Changeset{}}

  """
  defp do_delete_item(%Item{} = item) do
    Repo.delete(item)
  end

  @doc """
  Deletes an item and publishes any messages.

  ## Examples

      iex> delete_item(item)
      {:ok, %Item{}}

      iex> delete_item(item)
      {:error, %Ecto.Changeset{}}

  """
  def delete_item(%Item{} = item) do
    case do_delete_item(item) do
      {:ok, item} ->
        # do any publishing here
        {:ok, item}

      {:error, changeset} ->
        {:error, changeset}
    end
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking item changes.

  ## Examples

      iex> change_item(item)
      %Ecto.Changeset{data: %Item{}}

  """
  def change_item(%Item{} = item, attrs \\ %{}) do
    Item.changeset(item, attrs)
  end

  @doc """
  Returns a struct describing what changed when an item was updated

  ## Examples

      iex> diff_item(original_item, updated_item)
      %EctoDiff{}
  """
  def diff_item(original_item, updated_item) do
    EctoDiff.diff(original_item, updated_item)
  end
end
