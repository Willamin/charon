defmodule Charon do
  @project Charon.Mixfile.project()

  def projects_dir do
    "#{System.user_home()}/Documents/projects/"
  end

  def main(args) do
    if length(args) > 0 do
      args
      |> hd
      |> choose_command(tl(args))
    else
      help
    end
  end

  def stdout(message) do
    IO.puts(:stdio, "echo #{message}")
  end

  def change_dir(dir) do
    IO.puts(:stdio, "cd #{dir}")
  end

  def stderr(message) do
    IO.puts(:stderr, "#{message}")
  end

  def choose_command(command, args) do
    cond do
      ~r/version/ |> Regex.match?(command) -> version
      ~r/help/    |> Regex.match?(command) -> help
      ~r/list/    |> Regex.match?(command) -> list(args)
      ~r/debug/   |> Regex.match?(command) -> debug
      true -> goto_wrapper([command] ++ args)
    end
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

  def list(search) do
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
end
