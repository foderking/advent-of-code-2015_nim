import download
import std/strutils

const
  day = "11"

proc checkValid(pass: string, d=false): bool=
  var
    bad = ['i', 'o', 'l']
    inc_str: bool
    diff = 0
    n = pass.len
  for i in 0..<n-2:
    if bad.contains(pass[i]):
      if d:echo "bad: ", pass[i]
      return false
    if ord(pass[i+1])-ord(pass[i])==ord(pass[i+2])-ord(pass[i+1]) and ord(pass[i+2])-ord(pass[i+1])==1:
      if d:echo "inc str: ", pass[i]
      inc_str = true
    if pass[i]==pass[i+1] and pass[i+1]!=pass[i+2]:
      if d:echo "diff: ", pass[i]
      diff.inc


    if d:echo pass[i]

  if pass[n-1]==pass[n-2]:
    if d:echo "last"
    diff.inc
  if bad.contains(pass[n-1]) or bad.contains(pass[n-2]):
    if d:echo "bad: "
    return false

  return diff>1 and inc_str

proc t_add(input: string, ind: int): string=
  var
    tmp = input
    bad = ['i', 'o', 'l']

  if tmp[ind]=='z':
    tmp[ind] = 'a'
    tmp = t_add(tmp, ind-1)
  else:
    tmp[ind] = chr(ord(tmp[ind])+1)
    #[
    if bad.contains(tmp[ind]):
      tmp[ind] = chr(ord(tmp[ind])+1)
      ]#
  return tmp

proc part1(input: string)=
  var
    s = input.strip
    #s = "abcdefgh"
  echo checkValid("abbcegjk", true)
  echo s.len

  while not checkValid(s):
    stdout.write(s&'\r')
    s = t_add(s, len(s)-1)
  echo "Part 1: ", s
  s = t_add(s, len(s)-1)

  while not checkValid(s):
    stdout.write(s&'\r')
    s = t_add(s, len(s)-1)
  echo "Part 2: ", s


part1(download(day))
#part1("abbcegjk")
