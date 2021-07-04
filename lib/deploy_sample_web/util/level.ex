defmodule DeploySampleWeb.Util.Level do

  defstruct key: nil , point: nil

  def setup([head | _tail]) do
    %DeploySampleWeb.Util.Level{key: head, point: String.length(head)}
  end

end
