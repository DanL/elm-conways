module Life exposing (initialBoard, step)

import Set exposing (Set)
import Types
    exposing
        ( Model
        , Board
        , BoardSize
        , Cell(..)
        , CellAddress
        , CellLocation
        , CellLocationX(..)
        , CellLocationY(..)
        )


step : Model -> Model
step model =
    let
        newLiveCells =
            List.filterMap (cellStatus model.liveCells) allCellAddresses
    in
        { model | liveCells = newLiveCells }


allCellAddresses : List CellAddress
allCellAddresses =
    let
        rows =
            List.range 0 boardSize

        cols =
            List.range 0 boardSize

        createRow row =
            List.map (createCell row) cols

        createCell row col =
            ( col, row )
    in
        List.concatMap createRow rows


cellStatus : List CellAddress -> CellAddress -> Maybe CellAddress
cellStatus liveCells currentCell =
    let
        cell =
            cellAddressToCell liveCells currentCell

        neighbors =
            liveNeighborCount boardSize currentCell liveCells
    in
        case cell of
            DeadCell ->
                if neighbors == 3 then
                    Just currentCell
                else
                    Nothing

            LiveCell ->
                if neighbors < 2 || neighbors > 3 then
                    Nothing
                else
                    Just currentCell


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
            Just (locationToAddress ( cellX, cellY ) ( locX, locY ))
        else
            Nothing


locationToAddress : CellAddress -> ( CellLocationX, CellLocationY ) -> CellAddress
locationToAddress ( cellX, cellY ) ( locX, locY ) =
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


boardSize : Int
boardSize =
    9


initialBoard : Board
initialBoard =
    let
        rows =
            List.range 0 boardSize

        cols =
            List.range 0 boardSize

        createRow row =
            List.map createCell cols

        createCell col =
            DeadCell
    in
        List.map createRow rows
