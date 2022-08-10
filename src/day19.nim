import download, strutils, sequtils, sugar, strscans, tables,sets
import deques

proc parse(input: string): Table[string, seq[string]]=
  var
    k,v: string
    dict: Table[string, seq[string]]
  for line in input.split('\n'):
    if scanf(line, "$+ => $+", k,v):
      #echo k, " ", v
      dict[k] = dict.getOrDefault(k, @[])
      dict[k].add(v)
    elif line=="":
      return dict
    else:
      raiseAssert("")

proc replace(key: string, vals: seq[string], s: string): HashSet[string]=

  for c_ind in 0..<s.len:
    var flag = true

    for r_ind in c_ind..<(c_ind+key.len):

      if r_ind>=s.len or s[r_ind]!=key[r_ind-c_ind]:
        flag = false
        break

    if flag:
      for v in vals:
        result.incl(s[0..<c_ind] & v & s[min(s.len, c_ind+key.len)..^1])

proc part1(input: string): int=
  let
    dict = parse(input)
    s = input.split('\n')[^1]
  var h_s: HashSet[string]

  for k in dict.keys():
    h_s.incl(replace(k, dict[k], s))
        
  return h_s.len

proc part2(input: string): int=
  let
    dict = parse(input)
    s = input.split('\n')[^1]
  var
    q: Deque[(string, int)]
    hs: HashSet[string]
    memo: Table[string, int]

  proc solve(s: string): int=
    if s=="e": return 0
    elif s in memo: return memo[s]

    var mnm = high(int)-1
    var newhs: HashSet[string]

    for k, v in dict.pairs():
      for vv in v:
        newhs.incl(replace(vv, @[k], s))

    #echo s
    #echo newhs

    for rr in newhs:
      mnm = min(mnm, solve(rr)+1)
      if mnm < high(int)-10: break # greedy. assumes theres only one path to "e"

    memo[s] = mnm
    hs.incl(newhs)
    return memo[s]
  #[
  q.addLast(("e", 0))
  while q.len>0:
    let (tmp, kkk) = q.popFirst()
    for k in dict.keys():
      for each in replace(k, dict[k], tmp):
        if each==s: return kkk+1
        #echo each
        q.addLast((each, kkk+1))
      ]#
  return solve(s)

when isMainModule:
  doPart1(part1, "19")
  doPart2(part2, "19")
