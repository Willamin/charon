defmodule Charon.Extension.Project do
  import Charon.Util

  def find_files(search) do
    search = if (length(search) < 1) do "." else search end
    prefix = projects_dir()

    prefix
    |> File.ls
    |> elem(1)
    |> Enum.filter(fn(x)->
      ~r/^.DS_Store/
      |> Regex.match?(x)
      |> Kernel.not
    end)
    |> Enum.filter(fn(x) ->
      ~r/^#{search}/
      |> Regex.match?(x)
    end)
    |> Enum.sort(fn(one, two) ->
      File.stat!(prefix <> one, time: :posix).mtime > File.stat!(prefix <> two, time: :posix).mtime
    end)
  end

  def take_ellipsis(list, count) when list |> length > count do
    ( list
      |> Enum.take(count)
    ) ++ ["..."]
  end

  def take_ellipsis(list, _count), do: list

  def list(search \\ []) do
    find_files(search)
    |> take_ellipsis(15)
    |> Enum.reduce(0, fn(x, acc) ->
      IO.ANSI.bright() <> IO.ANSI.blue() <> x <> IO.ANSI.reset()
      |> stdout
      acc + 1
    end)
  end

  def list_or_goto(search) do
    projects = find_files(search) |> take_ellipsis(15)
    if (length(projects) == 1) do
      projects |> hd |> goto
    else
      list(search)
    end
  end

  def goto(project), do: change_dir "#{projects_dir()}#{project}"
  def destroy(name), do: remove "#{projects_dir()}#{name}"
  def new(project), do: make_dir "#{projects_dir()}#{project}"
  def remove(command), do: IO.puts(:stdio, "rm -rf #{command}")
  def edit(project) do
    change_dir "#{projects_dir()}#{project}"
    sh "atom -a ."
  end
  def commands, do: []

  def help() do
    [ "Projects:",
      "├── list",
      "├── new",
      "├── edit",
      "└── destroy"
    ]
  end
end
