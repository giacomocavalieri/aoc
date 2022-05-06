module Day21 (day21) where
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

day21 :: Day
day21 = Day 21 2022 solveA solveB expectedRes tests