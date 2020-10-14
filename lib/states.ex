defmodule States do
  @moduledoc """
  Documentation for `States`.
  """

  def states_more_popular do
    states =
      HTTPoison.get!(
        "https://gist.githubusercontent.com/chronossc/1a010c6968528066acbee6bc03c2aefa/raw/bfbd1f86ed026c935e6b4df365caf0cd054ce947/cities.csv"
      ).body
      |> String.split("\n")
      |> Enum.map(fn citie -> String.slice(citie, -3..-2) end)
      |> Enum.reduce(
        %{},
        fn x, acc ->
          if acc[x] do
            count = acc[x] + 1
            Map.merge(acc, %{x => count})
          else
            Map.merge(acc, %{x => 1})
          end
        end
      )
      |> Enum.sort_by(&elem(&1, 1), :desc)

    first = Enum.join(Tuple.to_list(Enum.at(states, 0)), ": ")
    second = Enum.join(Tuple.to_list(Enum.at(states, 1)), ": ")
    third = Enum.join(Tuple.to_list(Enum.at(states, 2)), ": ")

    IO.puts("#{first}, #{second}, #{third}")
  end
end
