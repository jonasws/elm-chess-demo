import Html exposing (..)
import Html.Events exposing ( onClick )

import Svg exposing (..)
import Svg.Attributes exposing (..)


import Dict
import List exposing (..)
import Maybe exposing (..)

import Actions exposing (..)

import Components.Board as Board exposing ( Square )
import Components.Position exposing ( initialPosition, Position )
import Pieces exposing ( pieceSvg, Piece )

-- APP
main : Program Never Model Msg
main =
  Html.beginnerProgram { model = model, view = view, update = update }

-- MODEL
type alias Model =
  { selected : Square
  , currentPosition : Position
  , previousPositions : List Position
  , nextPositions : List Position
  }

model : Model
model = Model (-1, -1) initialPosition [] []

getPiece : Square -> Position -> Maybe Piece
getPiece (x1, y1) position =
  Dict.get (y1, x1) position


movePiece : Square -> Square -> Piece -> Position -> Position
movePiece (x1, y1) (x2, y2) piece position =
  Dict.remove (y1, x1) <| Dict.insert (y2, x2) piece position

pieceHasSameColor : Piece -> Maybe Piece -> Bool
pieceHasSameColor piece otherPiece =
    case otherPiece of
        Nothing -> False
        Just op -> piece.color == op.color

-- UPDATE
update : Msg -> Model -> Model
update msg model =
  case msg of
    GoBack ->
      { model |
          currentPosition = withDefault model.currentPosition <| head model.previousPositions
          , previousPositions = drop 1 model.previousPositions
          , nextPositions = model.currentPosition :: model.nextPositions

      }
    GoForward ->
      { model |
          currentPosition = withDefault model.currentPosition <| head model.nextPositions
          , nextPositions = drop 1 model.nextPositions
          , previousPositions = model.currentPosition :: model.previousPositions

      }

    SquareClicked (sx, sy) ->

    if (sx, sy) == model.selected then
      { model |
          selected = (-1, -1)
      }
    else
      let
        selectedPiece = getPiece model.selected model.currentPosition
        clickedPiece = getPiece (sx, sy) model.currentPosition
      in
        case selectedPiece of
          Nothing -> { model |
                       selected = (sx, sy)
                     }
          Just piece ->
              if not <| pieceHasSameColor piece clickedPiece then
                  { model |
                        currentPosition = movePiece model.selected (sx, sy) piece model.currentPosition
                  , previousPositions = model.currentPosition :: model.previousPositions
                  , selected = (-1, -1)
                  }
              else
                  model
-- VIEW
view : Model -> Html Msg
view model =
  div [] [
     svg [width "400", height "400"]
       <| List.concat
       [ Board.squares <| getSelectedSquare model
       , List.map pieceSvg <| Dict.toList model.currentPosition
       ]
     , div [] [
        button [ onClick GoBack ] [
      Html.text "Previous"]
     , button [ onClick GoForward ] [
      Html.text "Next"]
       ]
    ]

getSelectedSquare : Model -> Square
getSelectedSquare = .selected
