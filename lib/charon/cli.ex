defmodule Charon.Cli do
  import Charon.Output
  @project Charon.Mixfile.project()

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
      ~r/list/    |> Regex.match?(command) -> list(args)
      ~r/debug/   |> Regex.match?(command) -> debug
      ~r/clone/   |> Regex.match?(command) -> clone(args)
      ~r/init/    |> Regex.match?(command) -> init(args)
      ~r/destroy/ |> Regex.match?(command) -> destroy(args)
      ~r/new/     |> Regex.match?(command) -> new(args)
      true -> goto_wrapper([command] ++ args)
    end
  end

  def projects_dir do
    projects = System.get_env("CHARON_PROJECT_DIR") || "/Documents/projects/"
    System.user_home() <> projects
  end

  def version(_args \\ []) do
    stdout "Charon #{@project[:version]}"
  end

  def debug(_args \\ []) do
    stdout "to tmp!"
    change_dir "/tmp"
  end

  def help(_args \\ []) do
    stdout "Usage: charon [command] [project name] [options]"
  end

  def find_files(search) do
    search = if (length(search) < 1) do "." else search end
    "#{projects_dir}"
    |> File.ls
    |> elem(1)
    |> Enum.filter(fn(x) ->
      ~r/^#{search}/
      |> Regex.match?(x)
    end)
  end

  def list(search \\ []) do
    find_files(search)
    |> Enum.reduce(0, fn(x, acc) ->
      IO.ANSI.bright() <> IO.ANSI.blue() <> x
      |> stdout
      acc + 1
    end)
  end

  def goto_wrapper(search) do
    projects = find_files(search)
    if (length(projects) == 1) do
      projects |> hd |> goto
    else
      list(search)
    end
  end

  def goto(project) do
    change_dir "#{projects_dir}#{project}"
  end

  def clone(uri) do
    change_dir projects_dir
    git "clone #{uri}"
    change_dir "-"
  end

  def init(name) do
    change_dir projects_dir
    git "init #{name}"
    change_dir "-"
  end

  def destroy(name) do
    remove "#{projects_dir}#{name}"
  end

  def new(project) do
    make_dir "#{projects_dir}#{project}"
  end
end