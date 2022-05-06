{-# LANGUAGE DataKinds #-}

module AOC.Day.Download (downloadDay) where

import AOC.Types           ( Configuration(cookie), Day(Day, day, year) )
import Network.HTTP.Client ( Cookie, createCookieJar )
import Network.HTTP.Req    ( BsResponse, GET(GET), NoReqBody(NoReqBody), Req, Scheme(Https), Url, bsResponse, cookieJar,
                             defaultHttpConfig, https, req, responseBody, runReq, (/:), (/~) )

dayURL :: Day -> Url 'Https
dayURL Day{ day, year } = https "adventofcode.com" /~ year /: "day" /~ day /: "input"

buildRequest :: Day -> Cookie -> Req BsResponse
buildRequest day cookie = req GET url NoReqBody bsResponse cookies
    where url     = dayURL day
          cookies = cookieJar $ createCookieJar [cookie]

-- | Downloads the input text for a given AOC `Day` and returns it.
downloadDay :: (MonadIO m, MonadReader Configuration m) => Day -> m Text
downloadDay day =
        asks cookie
    <&> buildRequest day
    >>= runReq defaultHttpConfig
    <&> responseBody
    <&> decodeUtf8
