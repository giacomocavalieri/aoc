module AOC.Types
    ( -- * AOC Day
      -- ** Base Day type
      Day(..)
    , Result(..)
    , Test(..)
      -- ** Reporting results
    , Report(..)
    , DefaultReport(..)
    , TestReport(..)
      -- * App configuration
    , Configuration(..)
    ) where

import Network.HTTP.Client ( Cookie )

-- | Represents an AOC day for a given year, it must specify
-- how to solve both parts of the problem.
--
-- An expected result
-- may be provided to perform a sort of regression test when
-- the problem has already been solved and its correct answer
-- is known.
-- Additionally, one can specify a list of simpler tests.
--
-- To run a day see the "Day" module
data Day
  = Day { day            :: Int
          -- ^ The number of the day
        , year           :: Int
          -- ^ The AOC year the given day refers to
        , solveA         :: Text -> Text
          -- ^ Solver for part A of the day's problem
        , solveB         :: Text -> Text
          -- ^ Solver for part B of the day's problem
        , expectedResult :: Maybe Result
          -- ^ The expected result for the default input
        , tests          :: [Test]
          -- ^ A list of tests to try the solvers on
        }

-- | Holds the results for both parts of an AOC `Day`.
data Result
  = Result { a :: Text
           , b :: Text
           }
  deriving (Eq)

-- | Is a test for an AOC `Day`, it specifies both the
-- input to run the day's solvers on and the expected
-- result.
data Test
  = Test { input          :: Text
         , expectedResult :: Result
         }

-- | Represents a report containing the results of
-- running a given `Day`'s solvers both on the
-- default and test inputs.
data Report
  = Report { def   :: DefaultReport
           , tests :: [TestReport]
           }

-- | A report obtained from running the `Day`'s solvers on
-- its default input. May not specify the expected result as
-- it may not be known before solving the problem.
data DefaultReport
  = DefaultExpectedGot Result Result
  | DefaultGot Result

-- | A report obtained from running the `Day`'s solvers on
-- its provided tests.
data TestReport
  = TestExpectedGot Result Result

-- | Holds all the app configuration data
data Configuration
  = Configuration { inputsDirectory :: FilePath
                    -- ^ The path to the base directory where all inputs will be stored
                  , cookie          :: Cookie
                    -- ^ The cookie used to perform GET requests on the AOC website
                  }


{-
USARE boxes

DEFAULT INPUT
   Res Expected    Got
a) OK  1233212434  134234234
b)     2342342342  23423423423

TESTS
1) Res Expected Got
a)
b)

2) Res Expected Got
a)
b)

-}
