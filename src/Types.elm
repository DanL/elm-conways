module Types exposing (..)


type alias Model =
    { board : List (List Cell)
    , liveCells : List CellAddress
    }


type Msg
    = NoOp


type Cell
    = DeadCell
    | LiveCell


type alias CellAddress =
    ( Coord, Coord )


type alias Coord =
    Int


type CellLocation
    = CellLocationX
    | CellLocationY


type CellLocationX
    = Left
    | Right
    | Center


type CellLocationY
    = Above
    | Below
    | Middle


type alias BoardSize =
    Int
