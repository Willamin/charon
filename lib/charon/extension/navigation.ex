defmodule Charon.Extension.Navigation do
  import Charon.Util

  def home(), do: change_dir(System.user_home())
  def docs(), do: change_dir(System.user_home() <> "/Documents")
  def down(), do: change_dir(System.user_home() <> "/Downloads")
  def help() do
    [ "Navigation:",
      "├── home",
      "├── docs",
      "└── down"
    ]
  end
end
