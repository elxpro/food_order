defmodule FoodOrder.GetAddress do
  def execute(%{"lat" => lat, "lng" => lng}) do
    location = "#{lat},#{lng}"
    access_key = "c3a90d72173d15d905ec987a7391ddab"

    Finch.build(
      :get,
      "http://api.positionstack.com/v1/reverse?access_key=#{access_key}&query=#{location}"
    )
    |> Finch.request(FoodOrder.Finch)
    |> handle_reponse()
  end

  def handle_reponse({:ok, %{status: 200, body: body}}) do
    body
    |> Jason.decode!()
    |> then(fn %{"data" => addresses} ->
      hd(addresses)["label"]
    end)
  end

  def handle_reponse(_), do: "Error to get the address"
end
