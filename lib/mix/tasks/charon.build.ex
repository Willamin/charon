defmodule Mix.Tasks.Charon.Build do
  use Mix.Task

  def run(_) do
    IO.puts "Packaging escript..."
    System.cmd("mix", ["escript.build"])

    IO.puts "Renaming escript 'charon' -> 'charon-boat'"
    System.cmd("mv", ["charon", "charon-boat"])

    IO.puts "Making escript executable"
    System.cmd("chmod", ["+x", "charon-boat"])

    IO.puts "Be sure to add an function to your shell:"
    IO.puts "  function charon() {"
    IO.puts "  while read line ; do $line ; done < <(\"#{System.cwd}/charon-boat\" $@)"
    IO.puts "  }"
  end
end
