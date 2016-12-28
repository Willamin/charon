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
    IO.puts(:stdio, message)
  end

  def stderr(message) do
    IO.puts(:stderr, message)
  end

  def choose_command(command, args) do
    cond do
      ~r/version/ |> Regex.match?(command) -> version
      ~r/help/    |> Regex.match?(command) -> help
      ~r/list/    |> Regex.match?(command) -> list(args)
      true -> IO.puts("bad command: #{command}")
    end
  end

  def version(_args \\ []) do
    stdout "Charon #{@project[:version]}"
  end

  def help(_args \\ []) do
    stdout "Usage: charon [command] [project name] [options]"
  end

  def list([search | _args]) do
    search = if !search do "." else search end
    "#{projects_dir}"
    |> File.ls
    |> elem(1)
    |> Enum.filter(fn(x) ->
      ~r/^#{search}/
      |> Regex.match?(x)
    end)
    |> Enum.reduce(0, fn(x, acc) ->
      IO.ANSI.bright() <> IO.ANSI.blue() <> x
      |> stdout
      acc + 1
    end)
  end
end
