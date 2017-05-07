defmodule Charon.Extension.Base do
  import Charon.Util
  @project Charon.Mixfile.project()

  def version(_args \\ []), do: stdout "Charon #{@project[:version]}"

  def debug(_args \\ []) do
    stdout "to tmp!"
    change_dir "/tmp"
  end

  def help(_args \\ []) do
    "Usage: charon [command] [project name] [options]" |> stdout
    ""            |> stdout
    "Base:"       |> stdout
    "├── version" |> stdout
    "├── help"    |> stdout
    "└── debug"   |> stdout
    ""            |> stdout
    "Projects:"   |> stdout
    "├── list"    |> stdout
    "├── new"     |> stdout
    "└── destroy" |> stdout
    ""            |> stdout
    "Git:"        |> stdout
    "├── clone"   |> stdout
    "└── init"    |> stdout
  end
end
