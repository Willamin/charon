defmodule Charon.Extension.Git do
  import Charon.Util

  def clone(uri) do
    change_dir projects_dir()
    git "clone #{uri}"
    change_dir "-"
  end

  def init(name) do
    change_dir projects_dir()
    git "init #{name}"
    change_dir "-"
  end

  def git(command), do: IO.puts(:stdio, "git #{command}")
  def commands, do: []

  def help() do
    [ "Git:",
      "├── clone",
      "└── init"
    ]
  end
end
