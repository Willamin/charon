defmodule Charon.Extension.Project do
  import Charon.Util
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

  def list_or_goto(search) do
    projects = find_files(search)
    if (length(projects) == 1) do
      projects |> hd |> goto
    else
      list(search)
    end
  end

  def goto(project), do: change_dir "#{projects_dir}#{project}"
  def destroy(name), do: remove "#{projects_dir}#{name}"
  def new(project), do: make_dir "#{projects_dir}#{project}"
  def remove(command), do: IO.puts(:stdio, "rm -rf #{command}")
  def commands, do: []
end
