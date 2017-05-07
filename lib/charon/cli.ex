defmodule Charon.Cli do
  import Charon.Macros
  import_extensions()

  def main(args) do
    if length(args) > 0 do
      args
      |> hd
      |> choose_command(tl(args))
    else
      list()
    end
  end

  def choose_command(command, args) do
    cond do
      ~r/version/ |> Regex.match?(command) -> Charon.Extension.Base.version()
      ~r/help/    |> Regex.match?(command) -> Charon.Extension.Base.help()
      ~r/debug/   |> Regex.match?(command) -> Charon.Extension.Base.debug()

      ~r/list/    |> Regex.match?(command) -> Charon.Extension.Project.list(args)
      ~r/new/     |> Regex.match?(command) -> Charon.Extension.Project.new(args)
      ~r/destroy/ |> Regex.match?(command) -> Charon.Extension.Project.destroy(args)

      ~r/clone/   |> Regex.match?(command) -> Charon.Extension.Git.clone(args)
      ~r/init/    |> Regex.match?(command) -> Charon.Extension.Git.init(args)

      true -> list_or_goto([command] ++ args)
    end
  end
end
