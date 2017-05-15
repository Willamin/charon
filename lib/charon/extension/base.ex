defmodule Charon.Extension.Base do
  import Charon.Util
  @project Charon.Mixfile.project()

  def version(_args \\ []), do: stdout "Charon #{@project[:version]}"

  def debug(_args \\ []) do
    stdout "to tmp!"
    change_dir "/tmp"
  end
end
