defmodule Charon.Util do
  def projects_dir, do: System.get_env("CHARON_PROJECT_DIR") || Application.get_env(:charon, :projects_dir)

  def stdout(message), do: IO.puts(:stdio, "echo #{message}")
  def change_dir(dir), do: IO.puts(:stdio, "cd #{dir}")
  def make_dir(dir),   do: IO.puts(:stdio, "mkdir #{dir}")
  def stderr(message), do: IO.puts(:stderr, "#{message}")
end
