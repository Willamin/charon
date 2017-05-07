defmodule Charon.Extension.Base do
  import Charon.Util
  @project Charon.Mixfile.project()

  def version(_args \\ []), do: stdout "Charon #{@project[:version]}"

  def debug(_args \\ []) do
    stdout "to tmp!"
    change_dir "/tmp"
  end

  def help(_args \\ []) do
    "Usage: charon [command] [project name] [options]"
    |> newline
    |> newline |> concat("Base:")
    |> newline |> concat("  version")
    |> newline |> concat("  help")
    |> newline |> concat("  debug")
    |> newline
    |> newline |> concat("Projects:")
    |> newline |> concat("  list")
    |> newline |> concat("  new")
    |> newline |> concat("  destroy")
    |> newline
    |> newline |> concat("Git: ")
    |> newline |> concat("  clone")
    |> newline |> concat("  init")
    |> stdout
  end

  def newline(s), do: s ++ "\n"
  def concat(s1,s2), do: s1 ++ s2
end
