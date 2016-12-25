module Components.Board exposing ( squares, Square )

import List
import Tuple exposing (..)
import Char
import Svg exposing (..)
import Svg.Attributes exposing (..)

import Html.Events exposing ( onClick )

type alias Square = (Int, Int)

squares : Square -> List (Svg (Int, Int))
squares (sx, sy) = List.map squareSvg <| List.concatMap (\y -> List.map (\x -> ((x, y), x == sx && y == sy)) <| List.range 0 7) <| List.range 0 7


squareSvg : (Square, Bool)  -> Svg (Int, Int)
squareSvg (square, selected) =
    rect [x <| toString <| 50 * first square
         , y <| toString <| 50 * second square
         , width "50"
         , height "50"
         , fill <| if selected then "yellow" else if isDarkSquare square then "green" else "lightblue"
         , onClick square
         ] []

yToFile : Int -> Char
yToFile = Char.fromCode << (+) 97

xToRank : Int -> Int
xToRank = (+) 1

isDarkSquare : Square -> Bool
isDarkSquare (x, y) = xor (isEven x) (isEven y)

isEven : Int -> Bool
isEven n = n % 2 == 0
