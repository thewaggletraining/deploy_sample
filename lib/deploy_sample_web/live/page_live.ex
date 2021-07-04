defmodule DeploySampleWeb.PageLive do
  use DeploySampleWeb, :live_view
#  alias DeploySampleWeb.Util.Level
#  alias DeploySampleWeb.Util.CsvRead

  @impl true
  def mount(_params, _session, socket) do
    data = ["list", "enum", "Enum.at"]
    {:ok, assign(socket, results: %{}, word: Enum.at(data, 0), length: data |> Enum.at(0) |> String.length, data: data, count: 0)}
  end

  @impl true
  def handle_event("typing", %{"word" => word, "char" =>  char, "key" => key}, socket) do
    word = if 0 == String.length(word) do
        socket = update(socket, :count, &(&1 + 1))
        socket.assigns.data |> Enum.at(socket.assigns.count)
      else
        if char == key do
          [_head | tail] = String.graphemes(word)
          List.to_string(tail)
        end
    end
    {:noreply, assign(socket, results: %{key: key}, word: word, char: char, length: String.length(word))}
  end

end
