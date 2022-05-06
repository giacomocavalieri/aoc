module AOC.Day
    ( -- * Running a day
      runDay
    , evalDay
      -- * Downloading a day's input
    , downloadDay
    ) where

import AOC.Day.Download ( downloadDay )
import AOC.Day.Eval     ( evalDay )
import AOC.Types        ( Configuration(..), Day(..), Report(..) )
import AOC.Utils        ( saveToFile, (>>=/) )
import System.FilePath  ( (<.>), (</>) )

-- | Given a `Day` it produces a `Report` with the result of its
-- execution on both a standard input and its provided tests.
-- The default input is read from a default location in the file system;
-- if the file is not present it will try to download it from the
-- [AOC](https://adventofcode.com/) website.
runDay :: (Alternative m, MonadIO m, MonadReader Configuration m) => Day -> m Report
runDay day = getInputForDay day <&> evalDay day

getInputForDay :: (Alternative m, MonadIO m, MonadReader Configuration m) => Day -> m Text
getInputForDay day = do
    dayPath <- asks inputsDirectory <&> (</> dayRelativePath day)
    readFileText dayPath <|> (downloadDay day >>=/ saveToFile dayPath)

-- | Given a `Day` it produces a relative `FilePath` that indicates where
-- its input might be stored.
dayRelativePath :: Day -> FilePath
dayRelativePath Day{ day, year } = show year </> show day <.> "txt"
