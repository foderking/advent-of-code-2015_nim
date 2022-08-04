import download
import strutils, strscans


proc calc(active, passive, total, speed: int): int=
  let
    fact = total div (active+passive)
    rem  = total mod (active+passive)

  return speed * (fact*active + min(rem, active))

proc part1(input: string) =
    echo "[+] Part 1"
    let tot = 2503
    var
      pers: string
      speed, active, passive: int
      mxm = low(int32).int
    for line in input.split('\n'):
      if scanf(line, "$+ can fly $i km/s for $i seconds, but then must rest for $i seconds.",
               pers, speed, active, passive):
        let ans = calc(active, passive, tot, speed)
        mxm = max(mxm,  ans)
        #echo pers, " ", ans

      else:
        echo line
        raiseAssert("")

    echo mxm
when isMainModule:
    let d =  download("14")
    part1(d)
    #part2()
