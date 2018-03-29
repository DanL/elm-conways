module Main exposing (..)

import Html exposing (Html)
import Views exposing (view)
import Life exposing (initialBoard, step)
import Types exposing (Model, Msg(..), Board, Cell(DeadCell), CellAddress)


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
    , liveCells =
        [ ( 5, 5 )
        , ( 6, 5 )
        , ( 7, 5 )
        ]
    }
        ! []


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Step ->
            step model ! []
