defmodule Charon.Extension.Navigation do
  import Charon.Util

  def home(), do: change_dir(System.user_home())
  def help() do
    [ "Navigation:",
      "└── home"
    ]
  end
end
