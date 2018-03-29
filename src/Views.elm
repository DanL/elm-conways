module Views exposing (view)

import Html exposing (Html, Attribute, div)
import Html.Attributes exposing (..)
import Types exposing (Model, Msg(..), Board, Cell(..))


view : Model -> Html Msg
view model =
    div [ id "board" ] [ renderBoard model.board ]


renderBoard : Board -> Html Msg
renderBoard board =
    let
        cellClass col =
            case col of
                DeadCell ->
                    "cell-dead"

                LiveCell ->
                    "cell-live"

        rowHtml row =
            List.map (\col -> div [ class (cellClass col) ] []) row

        html =
            List.map (\row -> div [ class "row" ] (rowHtml row)) board
    in
        div [] html
