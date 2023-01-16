alias FoodOrder.Products
alias FoodOrder.Accounts

for _ <- 0..50,
    do:
      Products.create_product(%{
        description: "bla",
        name: "Pizza #{:rand.uniform(10_000)}",
        price: :rand.uniform(10_000),
        size: Enum.random(["SMALL", "MEDIUM", "LARGE"]),
        image_url: "product_#{1..4 |> Enum.random()}.jpeg"
      })

Accounts.register_user(%{
  email: "adm@elxpro.com",
  password: "adm@elxpro.coM1",
  role: "ADMIN"
})

Accounts.register_user(%{
  email: "user@elxpro.com",
  password: "user@elxpro.coM1",
  role: "USER"
})
