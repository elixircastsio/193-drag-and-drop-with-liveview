# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Teacher.Repo.insert!(%Teacher.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Teacher.Products

widgets = [
  %{name: "Widget 1", price: 2999},
  %{name: "Widget 2", price: 2499, sellable: true},
  %{name: "Widget 3", price: 1099},
  %{name: "Widget 4", price: 2099}
]
Enum.each(widgets, fn(widget) -> Products.create_widget(widget) end)
