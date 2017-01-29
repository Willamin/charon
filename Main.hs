module Main where

import System.Process
import System.Directory
import System.IO.Unsafe
import System.Environment
import Debug.Trace
import Paths_charon (version)
import Data.Version (showVersion)

(|>) = flip($)

main = do a <- getArgs; parse a |> putStrLn

parse ("version":_) =
  showVersion version
  |> (++) "charon v"
  |> stdout

parse ("clone":[a]) = do
  let part1 = cd "\n"
  let part2 = git "clone" a
  part1 ++ "\n" ++ part2

parse [f] =
  projects_dir
  |> ls
  |> lines
  |> (filter (project_filter f))
  |> choose

parse [] =
  projects_dir
  |> ls
  |> stdout

project_filter "" _ = True
project_filter _ "" = False

project_filter needle haystack =
  if (head needle) == (head haystack)
    then project_filter (tail needle) (tail haystack)
    else False

choose list =
  if (length list > 1)
    then (list |> unlines |> stdout)
    else (list |> unlines |> cd)

stdout message =
  message
  |> lines
  |> map ("echo " ++)
  |> unlines

cd new_dir =
  new_dir
  |> lines |> head
  |> (++) ("cd " ++ projects_dir ++ "/")

git command args =
  "git " ++ command ++ " " ++ args

projects_dir =
  getHomeDirectory
  |> unsafePerformIO
  ++ "/Documents/projects"

ls f =
  readProcess "ls" [f] []
  |> unsafePerformIO
