import download
import std/[re,strutils]

const 
  day = "8"

proc part1(input: string)=
  let
    one = findAll(input, re"\\\\|""").len
    three= findAll(input, re"\\x[0-9a-f]{2}").len
  echo "[+] Answer 1: ", $(one + 3*three)

proc part2(input: string)=
  let
    one = findAll(input, re"\\|""").len
    two = input.strip.split("\n").len
  echo "[+] Answer 2: ", $(one + 2*two)


when isMainModule:
  part1(download(day))
  part2(download(day))

