module Main exposing (..)

import Html exposing (Html)
import Views exposing (view)
import Life exposing (heatDeath, initialBoard, step)
import Task exposing (Task)
import Process
import Time exposing (Time)
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
    , prevLiveCells = []
    }
        ! []


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Step ->
            step model ! []

        Run ->
            if heatDeath model then
                model ! []
            else
                step model ! [ Task.perform (\a -> Run) Time.now ]
