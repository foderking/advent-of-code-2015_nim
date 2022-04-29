import download
import std/[tables, strutils, strscans, sugar, sequtils, sets]

const
  day =  "9"
type
  Dir = (string, int)

proc parse(input: string): Table[string, seq[Dir]]=
  var
    source: string
    dest: string
    distance: int
  for each in input.strip.split("\n"):
    if scanf(each, "$w to $w = $i", source, dest, distance):
      if result.hasKey(source):
        result[source].add((dest, distance))
      else:
        result[source] =  @[(dest, distance)]

      if result.hasKey(dest):
        result[dest].add((source, distance))
      else:
        result[dest] =  @[(source, distance)]
    else: raiseAssert("rand")

proc getUniq(input: string): HashSet[string]=
  return input.strip.split("\n").map(each => each.split(" = ")[0].split(" to ")).foldl(a & b).toHashSet

proc bruteforce(tab: Table[string, seq[Dir]],
                current: string, n: int, stack: var seq[string]): int=
  var
    moves: int
  result = high(int)
  echo current
  
  if n<=0:
    return 0
  else:
    stack.add(current)
    for each in tab[current]:
      if each[0] in stack:
        discard
      else:
        moves = each[1]
        echo each
        moves += bruteforce(tab, each[0], n-1, stack)

        result = min(result, moves)
    discard stack.pop()
  echo "final ans for ", current, " ", result


proc bruteforce2(tab: Table[string, seq[Dir]],
                current: string, n: int, stack: var seq[string]): int=
  var
    moves: int
  result = low(int)
  echo current
  
  if n<=0:
    return 0
  else:
    stack.add(current)
    for each in tab[current]:
      if each[0] in stack:
        discard
      else:
        moves = each[1]
        echo each
        moves += bruteforce2(tab, each[0], n-1, stack)

        result = max(result, moves)
    discard stack.pop()
  echo "final ans for ", current, " ", result





proc part1(input: string)=
  var
    parsed =  parse(input)
    uniq = getUniq(input)
    n = uniq.len
    tab: Table[string, seq[Dir]]
    st: seq[string]  = @[]
    ans = high(int)
  for key, val in parsed.mpairs:
    echo key, ": ", val
  for each in uniq:
    ans = min(ans, bruteforce(parsed, each, n-1, st))
  echo "Part 1: ", ans
  
  ans = low(int)
  for each in uniq:
    ans = max(ans, bruteforce2(parsed, each, n-1, st))

  echo "Part 2: ", ans

when isMainModule:
  part1(download(day))



