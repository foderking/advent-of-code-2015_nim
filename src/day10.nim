import download
import std/[strutils]

const
  day = "10"

proc solve(input: var string, n: int): string=
  var
    last: char
    x: int
    tmp: string
  for p in 0..<n:
    last = input[0]
    x = 1
    tmp = ""
    for i in 1..<input.len:
      if input[i]==last:
        x.inc
      else:
        tmp &= $x
        tmp &= $last
        last = input[i]
        x = 1
    tmp &= $x
    tmp &= $last
    input = tmp

  return tmp

proc part1(input: string)=
  var
    s = input.strip
  echo "Part 1: ", solve(s, 40).len
  s = input.strip
  echo "Part 2: ", solve(s, 50).len



when isMainModule:
  part1(download(day).strip)
