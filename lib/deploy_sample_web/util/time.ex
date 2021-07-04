defmodule DeploySampleWeb.Util.Time do

  def count_down(start) do
    Stream.iterate(start, &(&1 - 1))
    |> Enum.map(fn count ->
      IO.puts(count)
      :timer.sleep(1000)
    end)
  end

end
