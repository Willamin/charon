defmodule Charon.Cli do
  import Charon.Extension.{Base,Project, Git}

  def main(args) do
    if length(args) > 0 do
      args
      |> hd
      |> choose_command(tl(args))
    else
      list
    end
  end

  def choose_command(command, args) do
    cond do
      ~r/version/ |> Regex.match?(command) -> version
      ~r/help/    |> Regex.match?(command) -> help
      ~r/debug/   |> Regex.match?(command) -> debug

      ~r/list/    |> Regex.match?(command) -> list(args)
      ~r/new/     |> Regex.match?(command) -> new(args)
      ~r/destroy/ |> Regex.match?(command) -> destroy(args)

      ~r/clone/   |> Regex.match?(command) -> clone(args)
      ~r/init/    |> Regex.match?(command) -> init(args)

      true -> list_or_goto([command] ++ args)
    end
  end
end
