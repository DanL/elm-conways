module Views exposing (view)

import Html exposing (Html, Attribute, div, text, button)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Types exposing (Model, Msg(..), Board, Cell(..), CellAddress)


view : Model -> Html Msg
view model =
    div []
        [ div [ id "board" ] [ renderBoard model.board model.liveCells ]
        , div [ id "start" ]
            [ button [ onClick Step ] [ text "Step!" ]
            , button [ onClick Run ] [ text "Run!" ]
            ]
        ]


renderBoard : Board -> List CellAddress -> Html Msg
renderBoard board liveCells =
    let
        cellType x y =
            case List.member ( x, y ) liveCells of
                False ->
                    DeadCell

                True ->
                    LiveCell

        cellClass x y =
            case cellType x y of
                DeadCell ->
                    "cell-dead"

                LiveCell ->
                    "cell-live"

        cellHtml rowIndex cellIndex col =
            div [ class (cellClass cellIndex rowIndex) ] []

        mapCells rowIndex row =
            List.indexedMap (cellHtml rowIndex) row

        rowHtml rowIndex row =
            div [ class "row" ] (mapCells rowIndex row)

        html =
            List.indexedMap rowHtml board
    in
        div [] html
