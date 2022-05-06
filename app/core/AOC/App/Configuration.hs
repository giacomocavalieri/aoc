module AOC.App.Configuration (defaultConfiguration) where

import AOC.Types           ( Configuration(Configuration) )
import Network.HTTP.Client ( Cookie(..) )
import Relude.Unsafe       ( read )
import System.FilePath     ( (</>) )
import UnliftIO.Directory  ( getHomeDirectory )

defaultConfiguration :: MonadIO m => m Configuration
defaultConfiguration = Configuration <$> inputsDirectory <*> readCookie

inputsDirectory :: MonadIO m => m FilePath
inputsDirectory = getHomeDirectory <&> (</> "aoc")

cookiePath :: MonadIO m => m FilePath
cookiePath = getHomeDirectory <&> (</> "aoc" </> ".aoc-cookie")

readCookie :: MonadIO m => m Cookie
readCookie = do
    cookieValue <- cookiePath >>= readFileBS
    pure $ Cookie { cookie_name             = "session"
                  , cookie_value            = cookieValue
                  , cookie_expiry_time      = read "2032-04-22 20:10:13 UTC"
                  , cookie_domain           = "adventofcode.com"
                  , cookie_path             = "/"
                  , cookie_creation_time    = read "2012-09-30 00:00:00 UTC"
                  , cookie_last_access_time = read "2012-09-30 00:00:00 UTC"
                  , cookie_persistent       = True
                  , cookie_host_only        = True
                  , cookie_secure_only      = True
                  , cookie_http_only        = True
                  }
