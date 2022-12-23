defmodule FoodOrder.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create_query = "CREATE TYPE sizes as ENUM('SMALL', 'MEDIUM', 'LARGE')"
    drop_query = "DROP TYPE sizes"
    execute(create_query, drop_query)

    create table(:products, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :image_url, :string
      add :price, :integer
      add :size, :sizes, default: "SMALL", null: false
      add :description, :text

      timestamps()
    end
  end
end
