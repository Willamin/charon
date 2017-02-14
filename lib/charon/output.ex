defmodule Charon.Output do
  def stdout(message), do: IO.puts(:stdio, "echo #{message}")
  def change_dir(dir), do: IO.puts(:stdio, "cd #{dir}")
  def make_dir(dir),   do: IO.puts(:stdio, "mkdir #{dir}")
  def git(command),    do: IO.puts(:stdio, "git #{command}")
  def remove(command), do: IO.puts(:stdio, "rm -rf #{command}")
  def stderr(message), do: IO.puts(:stderr, "#{message}")
end
