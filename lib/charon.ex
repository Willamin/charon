defmodule Charon do
  def main(args) do
    Charon.Cli.main(args)
  end

  def main do
    main(["version"])
  end
end
