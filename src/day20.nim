import download, strutils, sequtils, sugar, strscans
import math, tables

proc fact(nn: int): Table[int,int]=

  var
    ans: Table[int, int]
    n  = nn

  while (n mod 2)==0:
      ans[2] = ans.getOrDefault(2, 0) + 1
      n = n div 2
  var x = 3
  while x*x <= n:
      while (n mod x)==0:
          ans[x] = ans.getOrDefault(x, 0) + 1
          n = n div x
      x += 2
  if n>1:
    ans[n] = ans.getOrDefault(n, 0) + 1
  return ans

proc sumF(nn: int): int=
  ## https://web.archive.org/web/20171122110435/http://mathforum.org/library/drmath/view/71550.html
  let rand = fact(nn)
  var prod = 1
  echo rand
  for k, v in rand.pairs():
    var tmp = 0
    for p in 0..v:
      tmp += k ^ p
    #echo k
    #echo tmp
    prod *= tmp
  #echo prod
  return prod

proc getPoint(n: int, p: int): int=
  for x in 1..n:
    if n mod x == 0:
      result += x * p

proc part1(input: string): int=
  let n = parseInt(input) div 10

  #return sumF(786240)
  for x in 1..n:
    if x.sumF>=n: return x
    echo x
  return 0

proc part2(input: string): int=
  let n = parseInt(input) div 11

  #return sumF(786240)
  for x in 1..n:
    if x.sumF>=n: return x
    echo x
  return 0


when isMainModule:
  #doPart1(part1, "20")
  doPart2(part2, "20")
