module Components.Position exposing (..)

import Dict exposing (..)
import Pieces exposing ( .. )

import Components.Board exposing ( Square )

type alias Position = Dict Square Piece

initialPosition : Position
initialPosition =
  fromList [
     ((0, 0), Piece Rook Black)
   , ((0, 1), Piece Knight Black)
   , ((0, 2), Piece Bishop Black)
   , ((0, 3), Piece Queen Black)
   , ((0, 4), Piece King Black)
   , ((0, 5), Piece Bishop Black)
   , ((0, 6), Piece Knight Black)
   , ((0, 7), Piece Rook Black)

   , ((1, 0), Piece Pawn Black)
   , ((1, 1), Piece Pawn Black)
   , ((1, 2), Piece Pawn Black)
   , ((1, 3), Piece Pawn Black)
   , ((1, 4), Piece Pawn Black)
   , ((1, 5), Piece Pawn Black)
   , ((1, 6), Piece Pawn Black)
   , ((1, 7), Piece Pawn Black)

   , ((7, 0), Piece Rook White)
   , ((7, 1), Piece Knight White)
   , ((7, 2), Piece Bishop White)
   , ((7, 3), Piece Queen White)
   , ((7, 4), Piece King White)
   , ((7, 5), Piece Bishop White)
   , ((7, 6), Piece Knight White)
   , ((7, 7), Piece Rook White)

   , ((6, 0), Piece Pawn White)
   , ((6, 1), Piece Pawn White)
   , ((6, 2), Piece Pawn White)
   , ((6, 3), Piece Pawn White)
   , ((6, 4), Piece Pawn White)
   , ((6, 5), Piece Pawn White)
   , ((6, 6), Piece Pawn White)
   , ((6, 7), Piece Pawn White)
   ]
