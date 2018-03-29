module Main exposing (..)

import Html exposing (Html)
import Views exposing (view)
import Types exposing (Model, Msg(..), Board, Cell(DeadCell))


main : Program Never Model Msg
main =
    Html.program
        { view = view
        , init = init
        , update = update
        , subscriptions = always Sub.none
        }


init : ( Model, Cmd Msg )
init =
    { board = initialBoard
    , liveCells = [ ( 5, 5 ), ( 5, 6 ) ]
    }
        ! []


initialBoard : Board
initialBoard =
    let
        boardSize =
            9

        rows =
            List.range 0 boardSize

        cols =
            List.range 0 boardSize

        createCell =
            \n -> DeadCell
    in
        List.map (\n -> List.map createCell cols) rows


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Run ->
            startGame model ! []


startGame : Model -> Model
startGame model =
    model
