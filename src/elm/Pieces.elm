module Pieces exposing (..)

import Svg exposing (..)
import Svg.Attributes exposing (..)

import Html.Events exposing ( onClick )

import Components.Board exposing ( Square )

type PieceType = Pawn | Knight | Bishop | Rook | Queen | King
type Color = White | Black

type alias Piece = { pieceType : PieceType, color : Color }

pieceIcon : Piece -> String
pieceIcon piece =
    case piece.color of
        White ->
            case piece.pieceType of
                Pawn -> "♙"
                Knight -> "♘"
                Bishop -> "♗"
                Rook -> "♖"
                Queen -> "♕"
                King -> "♔"
        Black ->
            case piece.pieceType of
                Pawn -> "♟"
                Knight -> "♞"
                Bishop -> "♝"
                Rook -> "♜"
                Queen -> "♛"
                King -> "♚"


pieceSvg : (Square, Piece) -> Svg Square
pieceSvg ((x1, y1), piece) =
    text_
        [ x <| toString  <| y1 * 50
        , y <| toString <|  (x1 + 1) * 50
        , fontSize "5rem"
        , Svg.Attributes.cursor "pointer"
        , Svg.Attributes.style "padding-bottom: 5px;"
         , onClick (y1, x1)
        ]
        [ text <| pieceIcon piece
        ]
