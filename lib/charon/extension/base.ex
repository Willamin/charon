defmodule Charon.Extension.Base do
  import Charon.Util
  @project Charon.Mixfile.project()

  def version(_args \\ []), do: stdout "Charon #{@project[:version]}"

  def debug(_args \\ []) do
    stdout "to tmp!"
    change_dir "/tmp"
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
      "└── init"
    ] |> Enum.each(&stdout/1)
  end
end
