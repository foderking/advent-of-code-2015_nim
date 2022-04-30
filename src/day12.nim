import download
import std/[re, sequtils, strutils,sugar,math,json]
import tables

const
  day = "12"

proc getNo(node: var JsonNode): int=
  var
    tmp : JsonNode
    ans: int
  case node.kind:
    of JObject:
      for k, v in node.mpairs:
        if getStr(v)=="red":
          return 0
        else:
          tmp = v
          result += getNo(tmp)
    of JInt:
      return node.getInt
    of JArray:
      for each in getElems(node):
        tmp  = each
        result += getNo(tmp)
    else:
      return 0

proc part1(input:string)=
  echo "Part 1: ", findAll(input, re"-?\d+").map(parseInt).sum
  var
    obj = parseJson(input)

  echo "Part 2: ", getNo(obj)

  




when isMainModule:
  part1(download(day))
