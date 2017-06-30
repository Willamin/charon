defmodule Charon.Cli do
  import Charon.Macros
  import Charon.Util
  require_extensions()

  def main(args) do
    if length(args) > 0 do
      args
      |> hd
      |> choose_command(tl(args))
    else
      Charon.Extension.Project.list()
    end
  end

  def choose_command(command, args) do
    cond do
      ~r/help/    |> Regex.match?(command) -> help()

      ~r/version/ |> Regex.match?(command) -> Charon.Extension.Base.version()
      ~r/debug/   |> Regex.match?(command) -> Charon.Extension.Base.debug()

      ~r/list/    |> Regex.match?(command) -> Charon.Extension.Project.list(args)
      ~r/new/     |> Regex.match?(command) -> Charon.Extension.Project.new(args)
      ~r/edit/    |> Regex.match?(command) -> Charon.Extension.Project.edit(args)
      ~r/destroy/ |> Regex.match?(command) -> Charon.Extension.Project.destroy(args)

      ~r/clone/   |> Regex.match?(command) -> Charon.Extension.Git.clone(args)
      ~r/init/    |> Regex.match?(command) -> Charon.Extension.Git.init(args)

      ~r/home|~/  |> Regex.match?(command) -> Charon.Extension.Navigation.home()
      ~r/docs|~/  |> Regex.match?(command) -> Charon.Extension.Navigation.docs()
      ~r/down|~/  |> Regex.match?(command) -> Charon.Extension.Navigation.down()

      true -> Charon.Extension.Project.list_or_goto([command] ++ args)
    end
  end

  def help(_args \\ []) do
    [ "Usage: charon [command] [project name] [options]" ] ++ [""] ++
      Charon.Extension.Base.help() ++ [""] ++
      Charon.Extension.Project.help() ++ [""] ++
      Charon.Extension.Git.help() ++ [""] ++
      Charon.Extension.Navigation.help()
    |> Enum.each(&stdout/1)
  end
end
