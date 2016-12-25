import Html exposing (..)

import Svg exposing (..)
import Svg.Attributes exposing (..)

import Dict
import List

import Components.Board as Board exposing ( Square )
import Components.Position exposing ( initialPosition, Position )
import Pieces exposing ( pieceSvg, Piece)

-- APP
main : Program Never Model Msg
main =
  Html.beginnerProgram { model = model, view = view, update = update }

-- MODEL
type alias Model =
    { selected : Square
    , position : Position
    }

model : Model
model = Model (-1, -1) initialPosition

getPiece : Square -> Position -> Maybe Piece
getPiece (x1, y1) position =
    Dict.get (y1, x1) position


movePiece : Square -> Square -> Piece -> Position -> Position
movePiece (x1, y1) (x2, y2) piece position =
    Dict.remove (y1, x1) <| Dict.insert (y2, x2) piece position


-- UPDATE
type alias Msg = Square
update : Msg -> Model -> Model
update (sx, sy) model =
    if (sx, sy) == model.selected then
        { model |
              selected = (-1, -1)
        }
    else
        let
            selectedPiece = getPiece model.selected model.position
        in
            case selectedPiece of
                Nothing -> { model |
                                 selected = (sx, sy)
                           }
                Just piece -> { model |
                                   position = movePiece model.selected (sx, sy) piece model.position,
                                   selected = (-1, -1)
                             }
-- VIEW
-- Html is defined as: elem [ attribs ][ children ]
-- CSS can be applied via class names or inline style attrib
view : Model -> Html Msg
view model =
    svg [width "400", height "400"]
        <| List.concat
            [ Board.squares <| getSelectedSquare model
            , List.map pieceSvg <| Dict.toList model.position
            ]


getSelectedSquare : Model -> Square
getSelectedSquare = .selected
