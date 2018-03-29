module Main exposing (..)

import Html exposing (Html)
import Views exposing (view)
import Types exposing (Model, Msg(..))


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
    {} ! []


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    model ! []
