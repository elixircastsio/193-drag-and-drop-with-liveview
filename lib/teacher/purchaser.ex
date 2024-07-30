defmodule Teacher.Purchaser do

  def purchase(_widget_id, quantity) do
    cond do
      quantity > 5 -> :error
      true -> :ok
    end
  end

end
