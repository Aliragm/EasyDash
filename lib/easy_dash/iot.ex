defmodule EasyDash.Iot do
  @moduledoc """
  The Iot context.
  """

  import Ecto.Query, warn: false
  alias EasyDash.Repo

  alias EasyDash.Iot.Leitura

  @doc """
  Returns the list of leituras.

  ## Examples

      iex> list_leituras()
      [%Leitura{}, ...]

  """
  def list_leituras do
    Repo.all(Leitura)
  end

  @doc """
  Gets a single leitura.

  Raises `Ecto.NoResultsError` if the Leitura does not exist.

  ## Examples

      iex> get_leitura!(123)
      %Leitura{}

      iex> get_leitura!(456)
      ** (Ecto.NoResultsError)

  """
  def get_leitura!(id), do: Repo.get!(Leitura, id)

  @doc """
  Creates a leitura.

  ## Examples

      iex> create_leitura(%{field: value})
      {:ok, %Leitura{}}

      iex> create_leitura(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_leitura(attrs) do
    %Leitura{}
    |> Leitura.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a leitura.

  ## Examples

      iex> update_leitura(leitura, %{field: new_value})
      {:ok, %Leitura{}}

      iex> update_leitura(leitura, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_leitura(%Leitura{} = leitura, attrs) do
    leitura
    |> Leitura.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a leitura.

  ## Examples

      iex> delete_leitura(leitura)
      {:ok, %Leitura{}}

      iex> delete_leitura(leitura)
      {:error, %Ecto.Changeset{}}

  """
  def delete_leitura(%Leitura{} = leitura) do
    Repo.delete(leitura)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking leitura changes.

  ## Examples

      iex> change_leitura(leitura)
      %Ecto.Changeset{data: %Leitura{}}

  """
  def change_leitura(%Leitura{} = leitura, attrs \\ %{}) do
    Leitura.changeset(leitura, attrs)
  end

  def list_leituras_por_sensor(sensor_id) do
    query = from l in Leitura,
      where: l.sensor_id == ^sensor_id,
      order_by: [desc: l.inserted_at],
      limit: 100  #Aqui talvez tenha que mudar no futuro, talvez isso seja muito pouco

    Repo.all(query)
  end
end
