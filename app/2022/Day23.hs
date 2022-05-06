module Day23 (day23) where
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

day23 :: Day
day23 = Day 23 2022 solveA solveB expectedRes tests