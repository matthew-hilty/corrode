{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE OverloadedStrings #-}

import Control.Monad
import Language.C
import Language.C.System.GCC
import Language.Rust.Corrode.C
import System.Environment
import Text.PrettyPrint.HughesPJClass

main :: IO ()
main = do
    args <- getArgs
    forM_ args $ \ arg -> do
        Right (CTranslUnit decls _node) <- parseCFile (newGCC "gcc") Nothing [] arg
        forM_ decls $ \ decl -> case decl of
            CFDefExt f -> putStrLn (prettyShow (interpretFunction f))
            _ -> print decl
