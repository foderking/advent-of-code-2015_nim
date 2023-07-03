import download, strutils, sequtils, sugar, strscans

#[

y\x | 1    2   3   4   5   6 
----+---+---+---+---+---+---+
 1  |  1   3   6  10  15  21
 2  |  2   5   9  14  20
 3  |  4   8  13  19
 4  |  7  12  18
 5  | 11  17
 6  | 16

let g(x) = 1 + 2 + 3 + 4 + ... + x

-- first row --
 f(x,1) = g(x)

-- first column -- 
 f(1,y) = g(y-1) + 1

-- diagonal --
 diag(x,y) = x + y - 1

-- arbitrary cell --
  f(x,y) = f(1, diag(x,y)) + (x - 1)
         = f(1, x + y - 1) + x - 1
         = g(x + y - 1 - 1) + X - 1 + 1

  f(x,y) = g(x + y - 2) + x
]#

proc g(x: int): int =
  var acc = 0
  for tmp in 1..x:
    acc += tmp
  return acc

proc f(x: int, y: int): int =
  return g(x+y-2) + x

proc generateNextCode(previousCode: int): int =
  return (previousCode * 252533) mod 33554393

proc part1(input: string): int=
  var (row, col) = (1,1)
  if scanf(
    input,
    "To continue, please consult the code grid in the manual.  Enter the code at row $i, column $i.",
    row,
    col
  ):
    echo row, " ", col
    let numIterations = f(col, row)
    var currentCode = 20151125

    for _ in 1..<numIterations:
      currentCode = generateNextCode(currentCode)

    return currentCode
  else:
    raiseAssert("wierd input")

proc part2(input: string): string=
  return input

when isMainModule:
  partOne(part1, "25")
  partTwo(part2, "25")
