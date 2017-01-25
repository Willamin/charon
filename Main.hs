module Main where

import System.Process
import System.Directory
import System.IO.Unsafe

(|>) = flip($)

main =
  "/Users/will"
  |> ls
  |> stdout

stdout message =
  message
  |> lines
  |> map ("echo " ++)
  |> foldl (\a b -> a ++ b ++ "\n") ""
  |> putStrLn

cd new_dir =
  "cd "
  |> (++) new_dir
  |> putStrLn

projects_dir =
  getHomeDirectory
  |> unsafePerformIO
  |> (++) "/Documents/projects"

ls filter =
  readProcess "ls" [filter] []
  |> unsafePerformIO
