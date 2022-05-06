module Day22 (day22) where
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

day22 :: Day
day22 = Day 22 2022 solveA solveB expectedRes tests