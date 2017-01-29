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

parse ("version":[]) =
  showVersion version
  |> (++) "charon v"
  |> stdout

parse [] =
  projects_dir
  |> ls
  |> stdout

parse [f] =
  projects_dir
  |> ls
  |> lines
  |> (filter (project_filter f))
  |> choose


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

projects_dir =
  getHomeDirectory
  |> unsafePerformIO
  ++ "/Documents/projects"

ls filter =
  readProcess "ls" [filter] []
  |> unsafePerformIO
