module Lib
  (run)
where

import System.Directory
import System.Exit
import System.FilePath
import System.IO
import System.Process
import System.Posix.Files
import System.Posix.User

type Hostname = String

dropMnt :: FilePath -> FilePath
dropMnt = dropWhile (\x -> x /= pathSeparator) . tail
  . dropWhile (\x -> x /= pathSeparator)

getAnswer :: IO Bool
getAnswer = do
  ans <- getChar
  case () of _
               | ans == '\n'                  -> return True
               | (ans == 'Y') || (ans == 'y') -> return True
               | (ans == 'N') || (ans == 'n') -> return False
               | otherwise -> putStr "Please answer y of n (Y/n)" >> getAnswer

extractSecret :: IO ()
extractSecret = do
  putStr "Do you know the password? (Y/n) "
  hFlush stdout
  ans <- getAnswer
  if ans then do
    handle <- spawnCommand "gpg -d secret.nix.gpg"
    code <- waitForProcess handle
    case code of
      ExitSuccess -> putStrLn "secret.nix extracted!"
      ExitFailure _ -> do
        putStrLn "Could not extract secret.nix"
        exitFailure
  else
    writeFile "id_rsa = \"\"" "secret.nix"

genConfig :: FilePath -> IO Hostname
genConfig config = do
  putStrLn $ "Creating " ++ config ++ "..."
  createDirectoryIfMissing True . takeDirectory $ config
  putStr "Enter your device name: "
  hFlush stdout
  hostname <- getLine >> getLine
  currdir <- getCurrentDirectory
  let configStr = concat ["import ", currdir, "\"", hostname, "\""]
  writeFile config configStr
  putStrLn "Done!"
  return hostname

installConfig :: FilePath -> Hostname -> IO Bool
installConfig config hostname = do
  putStrLn "Installing..."
  callCommand "nixos-generate-config --root /mnt"
  handle <- spawnCommand "nixos-install"
  code <- waitForProcess handle
  removeFile "/mnt/etc/nixos/hardware-configuration.nix"
  case code of
    ExitSuccess -> do
      user <- getUserEntryForName "smakarov"
      let uid = userID user
      let gid = userGroupID user
      currdir <- getCurrentDirectory
      setOwnerAndGroup currdir uid gid
      putStrLn $ "Fixing path in " ++ config ++ "..."
      let newdir = dropMnt currdir
      let configStr = concat [ "import ", currdir, "\"", hostname, "\"" ]
      writeFile config configStr
      return True
    ExitFailure _ -> do
      putStrLn "Installation failed"
      return False

run :: IO ()
run = do
  putStrLn "SeTSeR's config installation."
  let config = "/mnt/etc/nixos/configuration.nix"
  callCommand "git submodule update --init --recursive"
  genSecret <- not <$> doesFileExist "secret.nix"
  if genSecret then extractSecret
  else return ()
  hostname <- genConfig $ config
  res <- installConfig config hostname
  if res then putStrLn "Done"
  else putStrLn "Installation failed!"
  return ()
