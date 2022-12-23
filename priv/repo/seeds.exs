alias FoodOrder.Products

for _ <- 0..100,
    do:
      Products.create_product(%{
        description: "bla",
        name: "Pizza #{:rand.uniform(10_000)}",
        price: :rand.uniform(10_000),
        size: Enum.random(["SMALL", "MEDIUM", "LARGE"]),
        image_url: "product_#{1..4 |> Enum.random()}.jpeg"
      })
