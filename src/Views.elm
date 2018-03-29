module Views exposing (view)

import Html exposing (Html, text, div, h1, img)
import Html.Attributes exposing (src)
import Types exposing (Model, Msg(..))


view : Model -> Html Msg
view model =
    div []
        [ img [ src "/logo.svg" ] []
        , h1 [] [ text "Your Elm App is working!" ]
        ]
