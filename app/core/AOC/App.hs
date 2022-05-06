module AOC.App
    ( appMain
    , Mode(..)
    ) where

import AOC.App.Configuration ( defaultConfiguration )
import AOC.Day               ( runDay )
import AOC.PrettyPrinting    ( showReport )
import AOC.Types             ( Day(day) )
import AOC.Utils             ( dayOfMonth )
import Data.Time             ( getCurrentTime, utctDay )

defaultDay :: MonadIO m => m Int
defaultDay = liftIO getCurrentTime <&> utctDay <&> dayOfMonth

data Mode
  = CommandLineArgs
  | CustomArgs Int
  | Today

appMain :: Mode -> [Day] -> IO ()
appMain mode days = do
    argDay   <- case mode of
        CommandLineArgs -> getArgs <&> (viaNonEmpty head >=> readMaybe)
        CustomArgs n    -> pure $ Just n
        Today           -> pure Nothing
    dayToRun <- maybe defaultDay pure argDay
    conf     <- defaultConfiguration
    case find ((== dayToRun) . day) days of
        Just d  -> runReaderT (runDay d) conf >>= putStrLn . showReport
        Nothing -> putStrLn $ "No day with number " <> show dayToRun
