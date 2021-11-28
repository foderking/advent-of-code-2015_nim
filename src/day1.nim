import download
import tables


const
    Cookie = "53616c7465645f5f286233854807ebf2e15e1f6171afd50d75c2bb44570165dbb1da648b9f80588b05066079605f6baf"
    day = "1"

proc getFloors(inputTable: CountTable[char]): int =
    let
        left = inputTable['('] 
        right= inputTable[')']
    return left - right


proc part1() =
    echo "[+] Part 1"
    let
        input = readFile("input.txt")
        counttable = input.toCountTable

    echo "Answer: ", $getFloors(counttable)

proc part2() =
    echo "[+] Part 2"
    let
        input = readFile("input.txt")
        charValue = { '(' : 1, ')' : -1 }.toTable
    var
        count = 0
        ans: int
    for index, each in input.pairs:
        count += charValue[each]

        if count == -1:
            ans = index + 1
            break
    echo "Answer: ", $ans

when isMainModule:
    download(day, Cookie)
    part1()
    part2()