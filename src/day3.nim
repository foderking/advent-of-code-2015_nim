import download
import std/tables

const
    Cookie = "53616c7465645f5f286233854807ebf2e15e1f6171afd50d75c2bb44570165dbb1da648b9f80588b05066079605f6baf"
    day = "3"
type
    Location = tuple
        x: int
        y: int

proc getInput(): string =
    return readLines("input.txt")[0]


proc moveNorth(current: Location): Location =
    ## Changes new location to a position north of previous location
    let (currentX, currentY) = current

    return (x: currentX, y: currentY+1)

proc moveSouth(current: Location): Location =
    ## Changes new location to a position South of previous location
    let (currentX, currentY) = current

    return (x: currentX, y: currentY-1)

proc moveEast(current: Location): Location =
    ## Changes new location to a position East of previous location
    let (currentX, currentY) = current

    return (x: currentX+1, y: currentY)

proc moveWest(current: Location): Location =
    ## Changes new location to a position West of previous location
    let (currentX, currentY) = current

    return (x: currentX-1, y: currentY)

proc trasverse(input: string): Table[Location, int] =
    echo "[+] Traversing"
    var
        locationTable = initTable[Location, int]() # table storing location and count for each houses
        currentLocation: Location

    currentLocation = (0, 0)
    locationTable[currentLocation] = 1

    for move in input:
        case move

        of '<':
            currentLocation = moveWest(currentLocation)
        of '>':
            currentLocation = moveEast(currentLocation)
        of '^':
            currentLocation = moveNorth(currentLocation)
        of 'v':
            currentLocation = moveSouth(currentLocation)
        else:
            echo "ignoring"

        if not locationTable.hasKey(currentLocation):
           locationTable[currentLocation] = 1
        else:
           locationTable[currentLocation] += 1
    
    return locationTable

proc trasverseBoth(input: string): int =
    echo "[+] Traversing"
    var
        santaTable = initTable[Location, int]() # table storing location and count for each houses
        roboTable  = initTable[Location, int]() # table storing location and count for each houses
        santaLocation: Location
        roboLocation:  Location

    santaLocation = (0, 0)
    roboLocation = (0, 0)
    santaTable[santaLocation] = 1
    # roboTable[roboLocation]   = 1

    var count = 1
    for move in input:
        if (count mod 2) == 0:
            case move

            of '<':
                roboLocation = moveWest(roboLocation)
            of '>':
                roboLocation = moveEast(roboLocation)
            of '^':
                roboLocation = moveNorth(roboLocation)
            of 'v':
                roboLocation = moveSouth(roboLocation)
            else:
                echo "ignoring"

            if not roboTable.hasKey(roboLocation):
                roboTable[roboLocation] = 1
            else:
                roboTable[roboLocation] += 1

        else:
            case move

            of '<':
                santaLocation = moveWest(santaLocation)
            of '>':
                santaLocation = moveEast(santaLocation)
            of '^':
                santaLocation = moveNorth(santaLocation)
            of 'v':
                santaLocation = moveSouth(santaLocation)
            else:
                echo "ignoring"

            if not santaTable.hasKey(santaLocation):
                santaTable[santaLocation] = 1
            else:
                santaTable[santaLocation] += 1

        inc count
    
    echo "Santa: ", santaTable.len
    echo "Robo : ", roboTable.len
    
    # hacky solution. add all mutually exclusive keys from santaTable to roboTable
    for i in santaTable.keys:
        discard roboTable.hasKeyOrPut(i, santaTable[i])

    return roboTable.len


proc testTrasverse() =
    let
        input1 = ">"
        input2 = "^>v<"
        input3 = "^v^v^v^v^v"

    assert trasverse(input2) == {(x: 0, y: 1): 1, (x: 0, y: 0): 2, (x: 1, y: 0): 1, (x: 1, y: 1): 1}.toTable
    assert trasverse(input1) == {(x: 0, y: 0): 1, (x: 1, y: 0): 1 }.toTable
    assert trasverse(input3) == {(x: 0, y: 0): 6, (x: 0, y: 1): 5 }.toTable

proc testTrasverseBoth() =
    let
        input1 = "^v"
        input2 = "^>v<"
        input3 = "^v^v^v^v^v"

    echo trasverseBoth(input1)
    echo trasverseBoth(input2)
    echo trasverseBoth(input3)


proc testMoving() =
    var currentLocation: Location
    currentLocation = (0, 0)

    assert moveNorth(currentLocation) == (x:  0, y:  1)
    assert moveSouth(currentLocation) == (x:  0, y: -1)
    assert moveEast(currentLocation)  == (x:  1, y:  0)
    assert moveWest(currentLocation)  == (x: -1, y:  0)

    echo $currentLocation

proc part1() =
    let
        input =  getInput()
    
    let ans = trasverse(input)

    echo "Length: ", ans.len

proc part2() =
    let
        input =  getInput()
    
    let ans = trasverseBoth(input)
    echo "Length: ", ans




    

when isMainModule:
    echo "Day 3"
    download(day, Cookie)
    part1()
    echo "Part 2"
    part2()
    # testMoving()
    # testTrasverse()
    # testTrasverseBoth()