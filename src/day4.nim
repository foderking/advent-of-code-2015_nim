import std/md5
import std/strutils
import download

let
    day = "4"

proc getInput(): string =
    return readFile("input4.txt").strip

proc bruteForce(input: string): int =
    var
        count = 0

    while true:
        let
            stringConcat = input & $count
            md5hash = getMD5(stringConcat)

        if md5hash[0..4] == "00000":
            echo "hash: ", md5hash
            return count

        inc count

proc bruteForce2(input: string): int =
    var
        count = 0

    while true:
        let
            stringConcat = input & $count
            md5hash = getMD5(stringConcat)

        if md5hash[0..5] == "000000":
            echo "hash: ", md5hash
            return count

        inc count
 

proc part1() =
    echo "[+] part 1"
    let
        input =  getInput()
        
    echo "Result: ", input.bruteForce
 
proc part2() =
    echo "[+] part 2"
    let
        input =  getInput()
        
    echo "Result: ", input.bruteForce2
       

proc testBruteForce() =
    assert bruteForce("abcdef") == 609043
    assert bruteForce("pqrstuv") == 1048970

    echo "bruteForce passed all tests"


when isMainModule:
    discard download(day)
    # echo getMD5("abcdef609043")
    # testBruteForce()
    part1()
    part2()
