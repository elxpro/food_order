alias FoodOrder.Accounts
alias FoodOrder.Products
alias FoodOrder.Orders.Order
alias FoodOrder.Repo

products =
  for _ <- 0..50 do
    {:ok, product} =
      Products.create_product(%{
        description: "bla",
        name: "Pizza #{:rand.uniform(10_000)}",
        price: :rand.uniform(10_000),
        size: Enum.random(["SMALL", "MEDIUM", "LARGE"]),
        image_url: "/uploads/product_#{1..4 |> Enum.random()}.jpeg"
      })

    product
  end

1..4
|> Enum.each(fn i ->
  product_path = "product_#{i}"
  dest = Path.join("priv/static/uploads", "#{product_path}.jpeg")
  path = "priv/static/images/#{product_path}.jpeg"
  File.cp!(path, dest)
end)

Accounts.register_user(%{
  email: "adm@elxpro.com",
  password: "adm@elxpro.coM1",
  role: "ADMIN"
})

{:ok, user} =
  Accounts.register_user(%{
    email: "user@elxpro.com",
    password: "user@elxpro.coM1",
    role: "USER"
  })

[product | _rest] = products

order_attrs = %{
  phone_number: "123",
  address: "123213",
  user_id: user.id,
  items: [%{quantity: 1, product_id: product.id}],
  total_quantity: 1,
  total_price: product.price
}

%Order{}
|> Order.changeset(order_attrs)
|> Repo.insert()
