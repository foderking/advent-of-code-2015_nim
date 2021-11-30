include templ
import tables, strutils

const
    day = "6"

type 
    Location = tuple
        x: int
        y: int
    
proc parseLocation(raw: string): array[2, Location] =
    ## parses a string like `887,9 through 959,629` to `[(887, 9), (959, 629)]`
    ## basically an array of tuples with each tuple representing an `x, y` location
    let 
        rand = raw.split(" through ")
        one  = rand[0].split(',')
        two  = rand[1].split(',')
    # echo one
    # let
        locationOne: Location = (x: one[0].parseInt, y: one[1].parseInt)
        locationTwo: Location = (x: two[0].parseInt, y: two[1].parseInt)
    return [locationOne, locationTwo]

proc turnOn(input: string, hashMap: var Table[Location, bool]) =
    # echo "turn on"
    let 
        cutoff = 8
        newInput = input[cutoff..^1]
        loc = parseLocation(newInput)
        one = loc[0]
        two = loc[1]
        (x1, y1) = one
        (x2, y2) = two
    
    for x in countup(x1, x2):
        for y in countup(y1, y2):
            let new_loc: Location = (x, y) 
            hashMap[new_loc] = true

proc turnOff(input: string, hashMap: var Table[Location, bool]) =
    # echo "turn off"
    let 
        cutoff = 9
        newInput = input[cutoff..^1]
        loc = parseLocation(newInput)
        one = loc[0]
        two = loc[1]
        (x1, y1) = one
        (x2, y2) = two
    for x in countup(x1, x2):
        for y in countup(y1, y2):
            let new_loc: Location = (x, y) 
            hashMap[new_loc] = false

proc toggle(input: string, hashMap: var Table[Location, bool]) =
    # echo "toggle"
    let 
        cutoff = 7
        newInput = input[cutoff..^1]
        loc = parseLocation(newInput)
        one = loc[0]
        two = loc[1]
        (x1, y1) = one
        (x2, y2) = two
    for x in countup(x1, x2):
        for y in countup(y1, y2):
            let 
                new_loc: Location = (x, y) 
            if hashMap.hasKey(new_loc):
                let old = hashMap[new_loc]
                hashMap[new_loc] = not old
            else:
                hashMap[new_loc] = true # lights all start turned off, so toggle will turn in on

proc parseInput(input: string, hashMap: var Table[Location, bool]) =
    if input.startsWith("turn on"):
        turnOn(input, hashMap)
    elif input.startsWith("turn off"):
        turnOff(input, hashMap)
    elif input.startsWith("toggle"):
        toggle(input, hashMap)
    else:
        echo "Parse Error: Should not reach here"

proc part1() =
    echo "part 1"
    var # hashMap represents the 2d array, but can access at O(1)
        hashMap = initTable[Location, bool]()

    echo hashMap
    for input in lines("input.txt"):
        parseInput(input, hashMap)
    var count = 0
    for each in hashMap.keys:
        if hashMap[each]:
            count.inc

    echo "Result: ", count

proc newTurnOn(input: string, hashMap: var Table[Location, int]) =
    # echo "turn on"
    let 
        val = 1
        cutoff = 8
        newInput = input[cutoff..^1]
        loc = parseLocation(newInput)
        one = loc[0]
        two = loc[1]
        (x1, y1) = one
        (x2, y2) = two
    
    for x in countup(x1, x2):
        for y in countup(y1, y2):
            let
                new_loc: Location = (x, y) 
            if hashMap.hasKey(new_loc):
                hashMap[new_loc] += val
            else:
                hashMap[new_loc] = val


proc newTurnOff(input: string, hashMap: var Table[Location, int]) =
    # echo "turn off"
    let 
        val = -1
        cutoff = 9
        newInput = input[cutoff..^1]
        loc = parseLocation(newInput)
        one = loc[0]
        two = loc[1]
        (x1, y1) = one
        (x2, y2) = two
    for x in countup(x1, x2):
        for y in countup(y1, y2):
            let 
                new_loc: Location = (x, y) 

            if hashMap.hasKey(new_loc):
                let v = hashMap[new_loc]
                if v >= 1:
                    hashMap[new_loc] += val
                # else
            else:
                hashMap[new_loc] = 0



proc newToggle(input: string, hashMap: var Table[Location, int]) =
    # echo "toggle"
    let 
        val = 2
        cutoff = 7
        newInput = input[cutoff..^1]
        loc = parseLocation(newInput)
        one = loc[0]
        two = loc[1]
        (x1, y1) = one
        (x2, y2) = two
    for x in countup(x1, x2):
        for y in countup(y1, y2):
            let 
                new_loc: Location = (x, y) 
            if hashMap.hasKey(new_loc):
                hashMap[new_loc] += val
            else:
                hashMap[new_loc] = val


proc newParseInput(input: string, hashMap: var Table[Location, int]) =
    if input.startsWith("turn on"):
        newTurnOn(input, hashMap)
    elif input.startsWith("turn off"):
        newTurnOff(input, hashMap)
    elif input.startsWith("toggle"):
        newToggle(input, hashMap)
    else:
        echo "Parse Error: Should not reach here"

proc getCount(map: Table[Location, int]): int =
    var count = 0
    for each in map.values:
        count += each
    return count

proc part2() =
    echo "part 2"
    var # hashMap represents the 2d array, but can access at O(1)
        hashMap = initTable[Location, int]()

    echo hashMap
    for input in lines("input.txt"):
        newParseInput(input, hashMap)
    echo "Result: ", hashMap.getCount

proc testToggle() =
    let 
        one = "toggle 0,0 through 999,999"
    var 
        map = initTable[Location, int]()
    
    newToggle(one, map)
    echo map.getCount

proc testTurnOn() =
    let 
        one = "turn on 0,0 through 0,0"
    var 
        map = initTable[Location, int]()
    
    newTurnOn(one, map)
    echo map.getCount

proc testParseLoc() =
    let
        test1 = "944,498 through 995,928"
        test2 = "521,303 through 617,366"
        test3 = "391,87 through 499,792"
        test4 = "562,527 through 668,935"
        test5 = "815,811 through 889,828"
        test6 = "519,391 through 605,718"
        test7 = "524,349 through 694,791"
        test8 = "68,358 through 857,453"
        test9 = "666,61 through 768,87"
        test0 = "64,253 through 655,960"
        test11= "27,501 through 921,952"
        test12= "953,102 through 983,471"
        test13= "277,552 through 451,723"
        test14= "47,485 through 734,977"
    echo parseLocation(test1)
    echo parseLocation(test2)
    echo parseLocation(test3)
    echo parseLocation(test4)
    echo parseLocation(test5)
    echo parseLocation(test6)
    echo parseLocation(test7)
    echo parseLocation(test8)
    echo parseLocation(test9)
    echo parseLocation(test0)
    echo parseLocation(test11)
    echo parseLocation(test12)
    echo parseLocation(test13)
    echo parseLocation(test14)
    
proc Tests() =
    testParseLoc()
    testToggle()
    testTurnOn()

when isMainModule:
    download(day, Cookie)
    # Tests()
    part1()
    part2()