module Day11 (day11) where
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

day11 :: Day
day11 = Day 11 2022 solveA solveB expectedRes tests