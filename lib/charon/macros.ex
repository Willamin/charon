defmodule Charon.Macros do
  defmacro import_extensions do
    with {:ok, files} <- File.ls("lib/charon/extension")
    do
      for x <- files do
        modname =
          x
          |> Path.basename(Path.extname(x))
          |> String.capitalize
        mod =
          "Charon.Extension." <> modname
          |> Code.eval_string
          |> elem(0)
        quote do
          import unquote(mod)
        end
      end
    end
  end

  defmacro load_commands do
    quote do
      with {:ok, files} <- File.ls("lib/charon/extension")
      do
        for x <- files do
          modname =
            x
            |> Path.basename(Path.extname(x))
            |> String.capitalize
          mod =
            "Charon.Extension." <> modname
            |> Code.eval_string
            |> elem(0)
          quote do
            list_of_commands = list_of_commands ++ unquote(mod).commands
          end
        end
      end
    end
  end
end
