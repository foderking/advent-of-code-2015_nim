import download
import std/[strscans, strutils, tables]

const
  day = "7"

type
  Oper = enum
    And="AND",
    Or="OR",
    Lshift="LSHIFT",
    Rshift="RSHIFT",
    Not="NOT",
    Null=""
  Source = tuple
    left: string
    op  : Oper
    right: string

proc isDigit(s: string): bool=
  try:
    discard s.parseInt()
    return true
  except:
    return false

proc getOp(line: string): (Source, string)=
  const
    Direct = "$+ -> $+"
    And    = "$+ AND $+ -> $+"
    Or     = "$+ OR $+ -> $+"
    Not    = "NOT $+ -> $+"
    Lsh    = "$+ LSHIFT $+ -> $+"
    Rsh    = "$+ RSHIFT $+ -> $+"
  var
    left: string
    right: string
    dest: string

  if scanf(line, Lsh, left, right, dest):
    result[1] = dest
    result[0] = (left, Oper.Lshift, right)
  elif scanf(line, Rsh, left, right, dest):
    result[1] = dest
    result[0] = (left, Oper.Rshift, right)

  elif scanf(line, And, left, right, dest):
    result[1] = dest
    result[0] = (left, Oper.And, right)
  elif scanf(line, Or, left, right, dest):
    result[1] = dest
    result[0] = (left, Oper.Or, right)

  elif scanf(line, Not, right, dest):
    result[1] = dest
    result[0] = ("", Oper.Not, right)
  elif scanf(line, Direct, right, dest):
    result[1] = dest
    result[0] = ("", Oper.Null, right)

  else:
    raiseAssert("adfa")

proc solve(key: string,
           hashMap: TableRef[string, Source],
           wireValue: TableRef[string, uint16]): uint16=
  var
    tmp: Source
    left: uint16
    right: uint16

  if key.isDigit:
    return key.parseUInt.uint16
  elif wireValue.contains(key):
    return wireValue[key]
  else:
    tmp = hashMap[key]

    case tmp.op
    of Oper.And:
      left = solve(tmp.left, hashMap, wireValue)
      right = solve(tmp.right, hashMap, wireValue)
      wireValue[key] = left and right
      return wireValue[key]

    of Oper.Or:
      left = solve(tmp.left, hashMap, wireValue)
      right = solve(tmp.right, hashMap, wireValue)
      wireValue[key] = left or right
      return wireValue[key]

    of Oper.Null:
      right = solve(tmp.right, hashMap, wireValue)
      wireValue[key] = right
      return wireValue[key]

    of Oper.Not:
      right = solve(tmp.right, hashMap, wireValue)
      wireValue[key] = not right
      return wireValue[key]

    of Oper.Rshift:
      left = solve(tmp.left, hashMap, wireValue)
      right = solve(tmp.right, hashMap, wireValue)
      wireValue[key] = left shr right
      return wireValue[key]

    of Oper.Lshift:
      left = solve(tmp.left, hashMap, wireValue)
      right = solve(tmp.right, hashMap, wireValue)
      wireValue[key] = left shl right
      return wireValue[key]
    else:
      raiseAssert("solve err")


proc main()=
  var
    hashMap = newTable[string, Source]()
    wireValue = newTable[string, uint16]()
    key: string
    val: Source
  for each in lines("input7.txt"):
     (val, key) = getOp(each)
     hashMap[key] = val
  # part 1
  var
    ans: uint16
  ans = solve("a", hashMap, wireValue)
  echo "Part 1 Answer: ", ans
  # part 2
  hashMap["b"].right = $ans
  wireValue.clear

  ans = solve("a", hashMap, wireValue)
  echo "Part 2 Answer: ", ans


when isMainModule:
  discard download(day)
  main()
