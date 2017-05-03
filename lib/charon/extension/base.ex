defmodule Charon.Extension.Base do
  import Charon.Util
  @project Charon.Mixfile.project()

  def version(_args \\ []), do: stdout "Charon #{@project[:version]}"

  def debug(_args \\ []) do
    stdout "to tmp!"
    change_dir "/tmp"
  end

  def help(_args \\ []), do: stdout "Usage: charon [command] [project name] [options]"

  def commands do
    [{ ~r/version/ , &Charon.Extension.Base.version/0 },
     { ~r/help/    , &Charon.Extension.Base.help/0    },
     { ~r/debug/   , &Charon.Extension.Base.debug/0   }]
  end
end
