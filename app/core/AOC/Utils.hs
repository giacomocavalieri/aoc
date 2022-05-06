module AOC.Utils
    ( (>>=/)
    , dayOfMonth
    , ifThenElse
    , saveToFile
    ) where

import Data.Time          ( Day )
import Data.Time.Calendar ( toGregorian )
import System.FilePath    ( takeDirectory )
import UnliftIO.Directory ( createDirectoryIfMissing )

-- | Same as `>>=` but returns the result of the first monadic action
-- ignoring the second one's.
(>>=/) :: Monad m => m a -> (a -> m b) -> m a
ma >>=/ f = ma >>= (\a -> f a >> pure a)

-- | Saves a file to the given FilePath creating all the necessary
-- directories if not already present.
saveToFile :: MonadIO m => FilePath -> Text -> m ()
saveToFile filePath content =
       createDirectoryIfMissing True (takeDirectory filePath)
    >> writeFileText filePath content

-- | Extracts the day of month from a date
dayOfMonth :: Day -> Int
dayOfMonth = (\(_y, _m, d) -> d) . toGregorian

ifThenElse :: a -> a -> Bool -> a
ifThenElse a _ True  = a
ifThenElse _ a False = a
