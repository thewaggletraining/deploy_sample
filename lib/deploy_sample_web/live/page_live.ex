defmodule DeploySampleWeb.PageLive do
  use DeploySampleWeb, :live_view
  alias DeploySampleWeb.Util.Counter
  alias DeploySampleWeb.Util.ErrorCounter
  alias DeploySampleWeb.Util.CsvRead

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, results: %{},
                          word: "開始するを押してください",
                          data: [],
                          count: 0,
                          error: 0,
                          )}
  end

  @impl true
  def handle_event("typing", %{"word" => word, "char" =>  char, "key" => key}, socket) do
    # リストが終了したら、一度 Countを0クリアして、再度 0から開始する
    IO.puts "#{Enum.count(socket.assigns.data)} == #{Counter.value()}"

    new_pid = if Enum.count(socket.assigns.data) == Counter.value() do
      Counter.stop(socket.assigns.pid)
      Counter.start_link(0)
    end

    # wordの文字列が0になったらカウントに1追加して、次のリストの文字列をwordにマッチさせる
      word = if 0 == String.length(word) do
        Counter.increment()
        socket.assigns.data |> Enum.at(Counter.value())
      else
        # wordの最初の１文字とkeyの値が同じなら、wordの先頭の１文字を削除する
        if char == key do
          [_head | tail] = String.graphemes(word)
          List.to_string(tail)
        else
          # keyの値がShiftの時はErrorカウントをしない
          case key do
          "Shift" -> word
          "Enter" -> word
          _Other ->
            ErrorCounter.increment()
            word
          end
        end
      end

    {:noreply, assign(socket, results: %{key: key},
                              word: word,
                              char: char,
                              error: ErrorCounter.value(),
                              pid: new_pid
                              )}
  end

  def handle_event("start", %{}, socket) do
    data = CsvRead.assets
    IO.puts("start")
    pid = Counter.start_link(0)
    epid = ErrorCounter.start_link(0)
    {:noreply, assign(socket, results: %{},
                          word: Enum.at(data, 0),
                          data: data,
                          count: Counter.value(),
                          error: ErrorCounter.value(),
                          epid: epid,
                          pid: pid
                          )}
  end

  def handle_event("restart", %{"data" => data}, socket) do
    IO.puts("-restart-")
    IO.inspect socket.assigns.pid
    IO.inspect socket.assigns.epid

    Counter.stop(socket.assigns.pid)
    ErrorCounter.stop(socket.assigns.epid)

  pid = Counter.start_link(0)
  epid = ErrorCounter.start_link(0)
  {:ok, assign(socket, results: %{},
                        word: Enum.at(data, 0),
                        data: data,
                        count: Counter.value(),
                        error: ErrorCounter.value(),
                        epid: epid,
                        pid: pid
                        )}
  end

  # page-activeの時は何もしない
  def handle_event("page-active", %{}, socket) do
    {:noreply, socket}
  end

  # page-inactiveの時は何もしない
  def handle_event("page-inactive", %{}, socket) do
    {:noreply, socket}
  end


end
