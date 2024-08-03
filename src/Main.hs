module Main (main) where

import System.Random(newStdGen, mkStdGen)
import System.Random.Shuffle(shuffle')
import Data.List (intercalate)

--Foi pego como referencia dos trabalhos de exemplo do site (Tetris_2)
shuffleList :: [Int] -> IO [Int]
shuffleList [] = return []
shuffleList list = fmap (shuffle' list (length list)) newStdGen

shuffleListPure :: [Int] -> Int -> [Int]
shuffleListPure list seed = shuffle' list (length list) (mkStdGen seed)

replaceWithZero :: [Int] -> Int -> [Int]
replaceWithZero [] _ = []
replaceWithZero xs idx = y ++ [0] ++ drop 1 ys
  where
    (y:ys) = splitAt idx xs

--buildSudokuBoard :: [Int] -> [Int] -> [[Int]]
--buildSudokuBoard [] _ = []
--buildSudokuBoard (x:xs) ys = buildSudokuBoardY x ys : buildSudokuBoard xs ys
--  where 
--    buildSudokuBoardY :: Int -> [Int] -> [Int]
--    buildSudokuBoardY _ [] = []
--    buildSudokuBoardY x' (y':ys') = patternSudoku x' y' : buildSudokuBoardY x' ys'

-- Constrói o tabuleiro Sudoku utilizando rotações da linha base
buildSudokuBoard :: IO [[Int]]
buildSudokuBoard = do
    let base = 3
    let side = base * base

    let rows = [g * base + r | g <- shuffleListPure [0..base-1] 42, r <- shuffleListPure [0..base-1] 105]
    let cols = [g * base + c | g <- shuffleListPure [0..base-1] 202, c <- shuffleListPure [0..base-1] 205]
    nums <- shuffleList [1..side]
    let pattern r c = (base * (r `mod` base) + r `div` base + c) `mod` side
    let board = [[nums !! pattern r c | c <- cols] | r <- rows]
    return board

buildEmptySudokuBoard :: [Int] -> [[Int]] -> [[Int]]
buildEmptySudokuBoard [] board = board
buildEmptySudokuBoard (x:xs) board = buildEmptySudokuBoard xs (reshapeList (replaceWithZero (reshapeBoard board) x))
  where
    reshapeBoard :: [[Int]] -> [Int]
    reshapeBoard [] = []
    reshapeBoard board' = concat board'

    reshapeList :: [Int] -> [[Int]]
    reshapeList [] = []
    reshapeList lista =
      let (before, after) = splitAt 9 lista
      in before : reshapeList after


--patternSudoku :: Int -> Int -> Int
--patternSudoku row col = (((base * (row `mod` base)) + (row `div` base) + col) `mod` side) + 1
--  where 
--    base = 3 :: Int
--    side = 9 :: Int

chunksOf :: Int -> [a] -> [[a]]
chunksOf _ [] = []
chunksOf n xs = take n xs : chunksOf n (drop n xs)

-- Função para formatar uma linha do Sudoku
formatRow :: [Int] -> String
formatRow row = intercalate " | " (map (unwords . map showCell) (chunksOf 3 row))
  where
    showCell :: Int -> String
    showCell 0 = "_"  -- Representa células vazias como "."
    showCell n = show n

-- Função para adicionar divisórias entre os blocos 3x3
formatSudoku :: [[Int]] -> String
formatSudoku board = intercalate "\n" (concatMap formatBlock (chunksOf 3 board))
  where
    formatBlock blockRows = map formatRow blockRows ++ ["------+-------+------"]

-- Função principal para imprimir o Sudoku
printSudoku :: [[Int]] -> IO ()
printSudoku board = putStrLn $ formatSudoku board

main :: IO ()
main = do
  --lista <- shuffleList [0..8]
  lista_remove <- shuffleList [0..80]
  sudoku <- buildSudokuBoard
  --print lista
  --print sudoku
  --print (take 10 lista_remove)
  printSudoku  (buildEmptySudokuBoard (take 50 lista_remove) sudoku)