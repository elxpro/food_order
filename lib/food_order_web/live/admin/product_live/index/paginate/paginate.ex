defmodule FoodOrderWeb.Admin.ProductLive.Index.Paginate do
  use FoodOrderWeb, :live_component

  def render(assigns) do
    ~H"""
    <div id={@id} class="flex pr-4">
      <div class="h-8 w-8 mr-1 flex justify-center items center cursor-pointer">
        <a href="">
          <Heroicons.backward solid class="h-6 w-6 text-orange-500 stroke-current" />
        </a>
      </div>

      <div class="flex h-8 font-medium">
        <div class="w-8 md:flex justify-center items-center hidden cursor-pointer leading-5 transition duration-150 ease-in border-b-2 border-orange-500">
          <a href="">1</a>
        </div>

        <div class="w-8 md:flex justify-center items-center hidden cursor-pointer leading-5 transition duration-150 ease-in border-b-2 border-transparent">
          <a href="">2</a>
        </div>
      </div>

      <div class="h-8 w-8 mr-1 flex justify-center items center cursor-pointer">
        <a href="">
          <Heroicons.forward solid class="h-6 w-6 text-orange-500 stroke-current" />
        </a>
      </div>
    </div>
    """
  end
end
