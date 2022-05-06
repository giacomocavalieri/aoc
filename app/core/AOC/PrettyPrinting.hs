module AOC.PrettyPrinting (showReport) where

import AOC.Types              ( DefaultReport(DefaultExpectedGot, DefaultGot), Report(Report), Result(Result),
                                TestReport(TestExpectedGot) )
import AOC.Utils              ( ifThenElse )
import Data.Text              ( unpack )
import Text.PrettyPrint.Boxes ( Box, emptyBox, left, punctuateV, render, text, vcat, (//), (<+>) )

showReport :: Report -> String
showReport r = render $ reportBox r

reportBox :: Report -> Box
reportBox (Report defaultReport testsReports) = case testsReports of
    (_:_) -> vcat left [base, spacer, tests]
    []    -> base
    where base   = vcat left ["DEFAULT INPUT", defaultReportBox defaultReport]
          spacer = vcat left [emptyBox 1 1, "-------------", emptyBox 1 1]
          tests  = vcat left ["TESTS", punctuateV left (emptyBox 1 1) $ zipWith testReportBox [1..] testsReports]

defaultReportBox :: DefaultReport -> Box
defaultReportBox (DefaultExpectedGot (Result ea eb) (Result ga gb)) = comparisonBox 1 (ea, ga) (eb, gb)
defaultReportBox (DefaultGot (Result a b)) = boxA // boxB
    where boxA = text "a)" <+> text (unpack a)
          boxB = text "b)" <+> text (unpack b)

testReportBox :: Int -> TestReport -> Box
testReportBox n (TestExpectedGot (Result ea ga) (Result eb gb)) = comparisonBox n (ea, ga) (eb, gb)

comparisonBox ::  Int -> (Text, Text) -> (Text, Text) -> Box
comparisonBox n (ea, ga) (eb, gb) = labels <+> resColumn <+> gotColumn <+> expColumn
    where labels    = text (show n <> ")") // vcat left ["a)", "b)"]
          resColumn = text "Res" // vcat left (map (ifThenElse "OK" " ") [ea == ga, eb == gb])
          gotColumn = text "Got" // vcat left [text $ unpack ea, text $ unpack eb]
          expColumn = text "Expected" // vcat left [text $ unpack ga, text $ unpack gb]
