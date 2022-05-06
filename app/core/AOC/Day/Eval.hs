module AOC.Day.Eval (evalDay) where

import           AOC.Types ( Day(..), DefaultReport(..), Report(..), Result(..), TestReport(..) )
import qualified AOC.Types as Test ( Test(..) )

-- | Given a `Day` it runs both solvers with the provided input.
-- A `Report` is produced with the result obtained from the given input
-- and all tests.
evalDay :: Day    -- ^ The day to evaluate
        -> Text   -- ^ The default input to run the day solvers on
        -> Report -- ^ A `Report` with the obtained results
evalDay day input = Report { def = defaultReport day input
                           , tests = testsReports day }

defaultReport :: Day -> Text -> DefaultReport
defaultReport Day{ .. } input = case expectedResult of
    Just er -> DefaultExpectedGot er result
    Nothing -> DefaultGot result
    where result = Result <$> solveA <*> solveB $ input

testsReports :: Day -> [TestReport]
testsReports Day{ .. } = zipWith TestExpectedGot expectedResults results
    where runOn           = Result <$> solveA <*> solveB
          results         = map (runOn . Test.input) tests
          expectedResults = map Test.expectedResult tests
