module Types exposing (..)


type alias Model =
    { board : Board
    , liveCells : List CellAddress
    , prevLiveCells : List CellAddress
    }


type Msg
    = Step
    | Run


type alias Board =
    List (List Cell)


type alias BoardSize =
    Int


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
