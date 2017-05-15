defmodule Charon.Cli do
  import Charon.Macros
  import Charon.Util
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
      ~r/help/    |> Regex.match?(command) -> help()

      ~r/version/ |> Regex.match?(command) -> Charon.Extension.Base.version()
      ~r/debug/   |> Regex.match?(command) -> Charon.Extension.Base.debug()

      ~r/list/    |> Regex.match?(command) -> Charon.Extension.Project.list(args)
      ~r/new/     |> Regex.match?(command) -> Charon.Extension.Project.new(args)
      ~r/destroy/ |> Regex.match?(command) -> Charon.Extension.Project.destroy(args)

      ~r/clone/   |> Regex.match?(command) -> Charon.Extension.Git.clone(args)
      ~r/init/    |> Regex.match?(command) -> Charon.Extension.Git.init(args)

      ~r/home|~/  |> Regex.match?(command) -> Charon.Extension.Navigation.home()

      true -> list_or_goto([command] ++ args)
    end
  end

  def help(_args \\ []) do
    [ "Usage: charon [command] [project name] [options]",
      "",
      "Base:",
      "├── version",
      "├── help",
      "└── debug"  ,
      "",
      "Projects:",
      "├── list",
      "├── new",
      "└── destroy",
      "",
      "Git:",
      "├── clone",
      "└── init",
      "",
      "Navigation:",
      "└── home"
    ] |> Enum.each(&stdout/1)
  end
end
