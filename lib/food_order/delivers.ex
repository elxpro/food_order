defmodule FoodOrder.Delivers do
  @moduledoc """
  The Delivers context.
  """

  import Ecto.Query, warn: false
  alias FoodOrder.Repo

  alias FoodOrder.Delivers.Deliver

  @doc """
  Returns the list of delivers.

  ## Examples

      iex> list_delivers()
      [%Deliver{}, ...]

  """
  def list_delivers do
    Repo.all(Deliver)
  end

  @doc """
  Gets a single deliver.

  Raises `Ecto.NoResultsError` if the Deliver does not exist.

  ## Examples

      iex> get_deliver!(123)
      %Deliver{}

      iex> get_deliver!(456)
      ** (Ecto.NoResultsError)

  """
  def get_deliver!(id), do: Repo.get!(Deliver, id)

  @doc """
  Creates a deliver.

  ## Examples

      iex> create_deliver(%{field: value})
      {:ok, %Deliver{}}

      iex> create_deliver(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_deliver(attrs \\ %{}) do
    %Deliver{}
    |> Deliver.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a deliver.

  ## Examples

      iex> update_deliver(deliver, %{field: new_value})
      {:ok, %Deliver{}}

      iex> update_deliver(deliver, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_deliver(%Deliver{} = deliver, attrs) do
    deliver
    |> Deliver.changeset(attrs)
    |> Repo.update()
  end

  def update_deliver_and_notify_the_order(%Deliver{} = deliver_old, attrs, order) do
    case update_deliver(deliver_old, attrs) do
      {:ok, deliver} ->
        FoodOrder.Orders.Events.ChangeDeliveringStatus.broadcast(deliver, deliver_old, order.id)
      {:error, changeset} ->
        {:error, changeset}
    end
  end

  @doc """
  Deletes a deliver.

  ## Examples

      iex> delete_deliver(deliver)
      {:ok, %Deliver{}}

      iex> delete_deliver(deliver)
      {:error, %Ecto.Changeset{}}

  """
  def delete_deliver(%Deliver{} = deliver) do
    Repo.delete(deliver)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking deliver changes.

  ## Examples

      iex> change_deliver(deliver)
      %Ecto.Changeset{data: %Deliver{}}

  """
  def change_deliver(%Deliver{} = deliver, attrs \\ %{}) do
    Deliver.changeset(deliver, attrs)
  end
end
