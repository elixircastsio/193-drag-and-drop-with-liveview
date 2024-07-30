defmodule Teacher.Products.Widget do
  use Ecto.Schema
  import Ecto.Changeset

  schema "widgets" do
    field :name, :string
    field :price, :integer
    field :sellable, :boolean

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(widget, attrs) do
    widget
    |> cast(attrs, [:name, :price, :sellable])
    |> validate_required([:name, :price, :sellable])
  end
end
