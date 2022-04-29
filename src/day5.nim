import std/tables
import std/strutils
import std/re
import download

let
    day = "5"

proc rule1(str: string): bool =
    let
        c_Table = str.toCountTable
        vowelNo  = c_Table['a'] + c_Table['e'] + c_Table['i'] + c_Table['o'] + c_Table['u']

    return vowelNo > 2

proc testRule1() = 
    let
        test1 = "aeiouaeiouaeiou"
        test2 = "xazegov"
        test3 = "aei"
    
    echo "Testing rule 1"
    assert rule1(test1) and rule1(test2) and rule1(test3)
    
proc rule2(str: string): bool =
    for index, chr in str[0..^2].pairs:
        # echo index, ":", chr
        if chr == str[index+1]:
            return true
    return false

proc testRule2() =
    echo "testing rule 2"
    let
        test1 = "xx"
        test2 = "abcdde" 
        test3 = "aeiouaeiouaeiou"

    assert rule2(test1) == true
    assert rule2(test2) == true
    assert rule2(test3) == false

proc rule3(str: string): bool =
    let
        t1 = "ab" in str
        t2 = "cd" in str
        t3 = "pq" in str
        t4 = "xy" in str

    if t1 or t2 or t3 or t4:
        return false
    else:
        return true

proc testRule3() =
    echo "testing rule 3"
    let
        test1 = "fadsjfdab"
        test2 = "fadsjfdcd"
        test3 = "ieworefie"

    assert rule3(test1) == false
    assert rule3(test2) == false
    assert rule3(test3) == true

proc validateNice(str: string): bool =
    return rule1(str) and  rule2(str) and rule3(str)

proc part1() =
    echo "Part 1.."
    var
        count = 0
    for input in lines("input5.txt"):
        if input.validateNice:
            count.inc

    echo "Result: ", count

proc altRule1(str: string): bool =
    var
        capture: array[1, string]
    discard match(str, re"^.*(\w{2}).*\1", capture)

    return capture[0] != ""


proc testAltRule1() =
    echo "testing alt rule 1"
    let
        one = "faabcdefgaa"
        two = "xyxy"
        thr = "yxy"
        foo = "hmgfqevgdyvisyvs"
    discard altRule1(one) == true
    discard altRule1(two) == true
    discard altRule1(thr) == false

    echo altRule1(foo)

proc altRule2(str: string): bool =
    return find(str, re"(\w)\w\1") != -1

proc testAltRule2() =
    echo "testing alt rule 2"
    let
        one = "xyx"
        two = "abcdefeghi"
        thr = "aacdefghi"
        foo = "avccmveveqwhnjdx"

    assert altRule2(one) == true
    assert altRule2(two) == true
    assert altRule2(thr) == false
    echo altRule2(foo)

proc altValidateNice(str: string): bool =
    return altRule1(str) and altRule2(str)

proc testAltValidateNice() =
    echo "testing altValidateNice"
    let
        one = "qjhvhtzxzqqjkmpb"
        two = "xxyxx"
        thr = "uurcxstgmygtbstg"
        fou = "ieodomkazucvgmuy"
    assert altValidateNice(one) == true
    assert altValidateNice(two) == true
    assert altValidateNice(thr) == false
    assert altValidateNice(fou) == false

proc part2() =
    echo "Part 2.."
    var
        count = 0
    for input in lines("input5.txt"):
        if input.altValidateNice:
            # echo [input]
            count.inc

    echo "Result: ", count


proc Test() =
    testRule1()
    testRule2()
    testRule3()
    testAltRule1()
    testAltRule2()
    testAltValidateNice()


when isMainModule:
    discard download(day)
    # Test()
    part1()
    part2()
