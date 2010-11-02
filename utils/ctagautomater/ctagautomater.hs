{- First version of automatic ctag runner. A very crude version, but
- meant for testing and seeing how an automatic ctag runner fits into
- workflow. -}
import System.INotify
import System.Process
import Control.Concurrent
import System.IO.Unsafe
import System.Directory
import Data.List
import System.Posix.Signals
import Control.Monad
import System.Posix.Process
import System.FilePath
import System.Environment

ctaglock :: MVar ()
ctaglock = unsafePerformIO newEmptyMVar

run :: MVar ()
run = unsafePerformIO newEmptyMVar

-- Inotify sees if tags file is modified and it causes another ctags to
-- be ran, which causes another ctags to be ran ...
-- 
-- Ctags is ran for every other file than tags, which causes extraneous
-- ctags runs. Some method to prevent this in the future would be nice
handler :: IO () -> Event -> IO ()
handler f (Modified _ (Just path)) = 
  unless (path `isSuffixOf` "tags" ) $ cpp
handler _ _ = return ()

cpp :: IO ()
cpp = putStrLn "Running ctags" >> readProcess "ctags" ["-R", "--c++-kinds=+p", "--fields=+iaS", "--extra=+q"] "" >>= putStr

signalHandler :: INotify -> WatchDescriptor -> IO ()
signalHandler i wd = removeWatch i wd >> putStrLn "Signal received" >> putMVar run ()

lockfile :: FilePath
lockfile = "/tmp/ctags.lock"

getDir [] = getCurrentDirectory
getDir (x:_) = return x

main = do
  args <- getArgs
  dir <- getDir args
  putStrLn dir
  lock <- doesFileExist lockfile
  unless lock $ withINotify $ \i -> do
    pid <- getProcessID
    writeFile lockfile $ show pid
    wd <- addWatch i [Modify] dir (handler cpp)
    let set = addSignal sigTERM emptySignalSet
    installHandler sigTERM (Catch (signalHandler i wd)) Nothing
    installHandler sigINT (Catch (signalHandler i wd)) Nothing
    takeMVar run
    removeFile lockfile
