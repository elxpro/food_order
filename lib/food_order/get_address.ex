defmodule FoodOrder.GetAddress do
  def execute(%{"lat" => lat, "lng" => lng}) do
    location = "#{lat},#{lng}"
    access_key = "YOUR ACCESS KEY"

    Finch.build(
      :get,
      "http://api.positionstack.com/v1/reverse?access_key=#{access_key}&query=#{location}"
    )
    |> Finch.request(FoodOrder.Finch)
    |> build_response()
  end

  def build_response({:ok, %{status: 200, body: body}}) do
    body
    |> Jason.decode!()
    |> then(fn %{"data" => data} ->
      hd(data)["label"]
    end)
  end

  def build_response(_), do: "API ERROR"
end
