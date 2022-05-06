{-# LANGUAGE QuasiQuotes #-}

module Main where
import Data.String.Interpolate ( __i )
import System.FilePath         ( takeDirectory, (<.>), (</>) )
import UnliftIO.Directory      ( createDirectoryIfMissing )

main :: IO ()
main = do
    year <- parseArgs
    mapM_ (uncurry saveToFile . generateDay year) [1..25]
    saveToFile ("app" </> show year </> "Main.hs") generateMain
    appendFileText "aoc.cabal" $ generateCabalStanza year

-- TODO: In the future switch to optparse applicative for nice help messages
-- and better error handling
parseArgs :: IO Int
parseArgs = do
    [year] <- map readMaybe <$> getArgs
    case year of
      Nothing -> error "Cannot parse year"
      Just y  -> pure y

generateDay :: Int -> Int -> (FilePath, Text)
generateDay year n = (completePath, dayBody year n)
    where completePath = "app" </> show year </> ("Day" <> show n) <.> "hs"

dayBody :: Int -> Int -> Text
dayBody year n = [__i|
    module Day#{n} (day#{n}) where
    import AOC.Types ( Day(Day), Result(..), Test(..) )

    type Input = Text

    parse :: Text -> Input
    parse = id

    solveA :: Text -> Text
    solveA = const $ parse "TODO"

    solveB :: Text -> Text
    solveB = const $ parse "TODO"

    expectedRes :: Maybe Result
    expectedRes = Nothing

    tests :: [Test]
    tests = []

    day#{n} :: Day
    day#{n} = Day #{n} #{year} solveA solveB expectedRes tests
|]

generateCabalStanza :: Int -> Text
generateCabalStanza year = [__i|
    executable #{year}
        import:         default-build
        hs-source-dirs: app/#{year}
        main-is:        Main.hs
        other-modules:  Day1  Day2  Day3  Day4  Day5
                        Day6  Day7  Day8  Day9  Day10
                        Day11 Day12 Day13 Day14 Day15
                        Day16 Day17 Day18 Day19 Day20
                        Day21 Day22 Day23 Day24 Day25
        build-depends:  aoc
|] <> "\n\n"

generateMain :: Text
generateMain = [__i|
    module Main where
    import AOC.App   ( Mode(CommandLineArgs, CustomArgs, Today), appMain )
    import AOC.Types ( Day )
    import Day1      ( day1 )
    import Day2      ( day2 )
    import Day3      ( day3 )
    import Day4      ( day4 )
    import Day5      ( day5 )
    import Day6      ( day6 )
    import Day7      ( day7 )
    import Day8      ( day8 )
    import Day9      ( day9 )
    import Day10     ( day10 )
    import Day11     ( day11 )
    import Day12     ( day12 )
    import Day13     ( day13 )
    import Day14     ( day14 )
    import Day15     ( day15 )
    import Day16     ( day16 )
    import Day17     ( day17 )
    import Day18     ( day18 )
    import Day19     ( day19 )
    import Day20     ( day20 )
    import Day21     ( day21 )
    import Day22     ( day22 )
    import Day23     ( day23 )
    import Day24     ( day24 )
    import Day25     ( day25 )

    days :: [Day]
    days = [ day1 , day2 , day3 , day4 , day5
           , day6 , day7 , day8 , day9 , day10
           , day11, day12, day13, day14, day15
           , day16, day17, day18, day19, day20
           , day21, day22, day23, day24, day25]

    main :: IO ()
    main = appMain CommandLineArgs days

    run :: Int -> IO ()
    run n = appMain (CustomArgs n) days

    runToday :: IO ()
    runToday = appMain Today days

|]

-- TODO: Copy pasted from Lib utils, export the module?
-- Or make a second shared library just for the utility functions,
-- the second option may also be useful to share code between different years!
saveToFile :: MonadIO m => FilePath -> Text -> m ()
saveToFile filePath content =
       createDirectoryIfMissing True (takeDirectory filePath)
    >> writeFileText filePath content
