defmodule Charon.Macros do
  defmacro import_extensions do
    quote do
      unquote do
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
    end
  end
end
