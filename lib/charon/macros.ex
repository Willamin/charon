defmodule Charon.Macros do
  defmacro require_extensions do
    for_extensions(fn(mod) ->
      IO.puts "Expanding macro for require_extensions for #{mod}"
      quote do
        require unquote(mod)
      end
    end)
  end

  def for_extensions(block) do
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
        block.(mod)
      end
    end
  end
end
