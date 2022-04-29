import download
import
    std/strutils

proc sum(arr: array[3, int]): int

proc getVals(area: string): seq[string] =
    return area.split('x')
    
proc testGetVals()=
    let str = "1x1x10"
    assert getVals(str) == @["1", "1", "10"]
    echo getVals(str)

proc getAreas(vals: seq[string]): array[3, int] =
    let
        area1 = parseInt(vals[0]) * parseInt(vals[1])
        area2 = parseInt(vals[0]) * parseInt(vals[2])
        area3 = parseInt(vals[1]) * parseInt(vals[2])
    
    return [area1, area2, area3]

proc testGetAreas() =
    let 
        val1 = "2x3x4"
        val2 = "1x1x10"
    
    assert getAreas( getVals(val1) ) == [6, 8, 12]
    assert getAreas( getVals(val2) ) == [1,10, 10]
    # echo getAreas(val)

proc getFullArea(arr: array[3, int]): int =
    let
        smallArea = arr.min
        mainArea  = 2 * arr.sum
    
    result = smallArea + mainArea
    # echo result, arr

proc testGetFullArea() =
    assert getFullArea([6, 8, 12]) == 58
    assert getFullArea([1, 10, 10]) == 43

proc sum(arr: array[3, int]): int =
    var ans = 0
    for i in arr:
        ans += i
    
    return ans

# proc sum(arr: seq[int]): int =
#     var ans = 0
#     for i in arr:
#         ans += i
    
#     return ans


proc AreaFromString(str: string): int =
    return str.getVals.getAreas.getFullArea

proc Test() = 
    testGetVals()
    testGetAreas()
    testGetFullArea()
    let 
        val1 = "2x3x4"
        val2 = "1x1x10"
    
    assert val1.AreaFromString == 58
    assert val2.AreaFromString == 43


const
    day = "2"

iterator initFile(): int = 
    for i in lines("input2.txt"):
        yield i.AreaFromString

proc part1(): int =
    echo "[+] Part1"
    var valsum = 0

    for area in initFile():
        valsum += area
    return valsum

proc getRib(val: seq[string]): int =
    let
        val1 = val[0].parseInt + val[1].parseInt
        val2 = val[0].parseInt + val[2].parseInt
        val3 = val[1].parseInt + val[2].parseInt

    result = 2 * min(@[val1, val2, val3])

proc prod(val: seq[string]): int =
    result = 1
    for each in val:
        result *= each.parseInt
    
proc getMainRibbonLen(str: string): int =
    let 
        vals = str.getVals
        mainVal = vals.getRib
        otherVal = vals.prod
        # minVal = areas.min
        # index = areas
    # echo otherVal
    return mainVal + otherVal

proc testGetRibLen() =
    let
        test1 = "2x3x4"
        test2 = "1x1x10"
    # echo test1.getMainRibbonLen
    assert test1.getMainRibbonLen == 34
    assert test2.getMainRibbonLen == 14


iterator initFile2(): int = 
    for i in lines("input2.txt"):
        yield i.getMainRibbonLen


proc part2(): int =
    echo "[+] Part2"
    var valsum = 0

    for area in initFile2():
        valsum += area
    return valsum




when isMainModule:
    discard download(day)
    # Test()
    # testGetRibLen()
    echo part1()
    echo part2()
