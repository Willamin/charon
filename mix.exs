defmodule Charon.Mixfile do
  use Mix.Project

  def project do
    [app: :charon,
     version: "0.2.0",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     escript: escript_config,
     deps: deps()]
  end

  def application do
    [applications: [:logger]]
  end

  defp deps do
    []
  end

  defp escript_config do
    [main_module: Charon]
  end
end
