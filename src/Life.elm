module Life exposing (cellStatus)

import Set exposing (Set)
import Types
    exposing
        ( BoardSize
        , Cell(..)
        , CellAddress
        , CellLocation
        , CellLocationX(..)
        , CellLocationY(..)
        )


cellStatus : BoardSize -> CellAddress -> List CellAddress -> Cell
cellStatus boardSize currentCell liveCells =
    let
        cell =
            cellAddressToCell liveCells currentCell

        neighbors =
            liveNeighborCount boardSize currentCell liveCells
    in
        case cell of
            DeadCell ->
                if neighbors == 3 then
                    LiveCell
                else
                    DeadCell

            LiveCell ->
                if neighbors < 2 || neighbors > 3 then
                    DeadCell
                else
                    LiveCell


cellAddressToCell : List CellAddress -> CellAddress -> Cell
cellAddressToCell liveCells cell =
    if List.member cell liveCells then
        LiveCell
    else
        DeadCell


liveNeighborCount : BoardSize -> CellAddress -> List CellAddress -> Int
liveNeighborCount boardSize currentCell liveCells =
    let
        cellNeighbors =
            neighbors boardSize currentCell

        intersection =
            Set.intersect
                (cellNeighbors |> Set.fromList)
                (liveCells |> Set.fromList)
    in
        Set.size intersection


neighbors : BoardSize -> CellAddress -> List CellAddress
neighbors boardSize cellAddress =
    let
        combinations =
            [ ( Left, Above )
            , ( Center, Above )
            , ( Right, Above )
            , ( Left, Middle )
            , ( Right, Middle )
            , ( Left, Below )
            , ( Center, Below )
            , ( Right, Below )
            ]
    in
        combinations |> List.filterMap (parseLocation boardSize cellAddress)


parseLocation : BoardSize -> CellAddress -> ( CellLocationX, CellLocationY ) -> Maybe CellAddress
parseLocation boardSize ( cellX, cellY ) ( locX, locY ) =
    let
        xIsValid =
            case locX of
                Left ->
                    cellX > 0

                Right ->
                    cellX < boardSize

                Center ->
                    True

        yIsValid =
            case locY of
                Above ->
                    cellY > 0

                Below ->
                    cellY < boardSize

                Middle ->
                    True

        isValid =
            xIsValid && yIsValid
    in
        if isValid then
            Just ( 0, 0 )
        else
            Nothing


locationToAddress : ( CellLocationX, CellLocationY ) -> CellAddress -> CellAddress
locationToAddress ( locX, locY ) ( cellX, cellY ) =
    let
        newX =
            case locX of
                Left ->
                    cellX - 1

                Right ->
                    cellX + 1

                Center ->
                    cellX

        newY =
            case locY of
                Above ->
                    cellY - 1

                Below ->
                    cellY + 1

                Middle ->
                    cellY
    in
        ( newX, newY )
