import std/[httpclient, os, strutils]
import std/[strformat]



proc download*(day: string): string =
    ##
    ## Params
    ## =========
    ## 
    ## day: day of input to download
    ## 
    ## cookie: session cookie value
    ##
    
    let
      filename = "input"&($day)&".txt"
      cookie = readFile("cookie.txt").strip()

    if fileExists(filename):
      echo "[+] Retrieving file.."
      return readFile(filename).strip

    else:
      echo "[+] Downloading file..."
      let 
        client = newHttpClient()
        cook   = "session=" & cookie
        url    = "https://adventofcode.com/2015/day/" & day & "/input"
      client.headers = newHttpHeaders({ "Cookie": cook })
      let content = client.getContent(url)

      writeFile(filename, content)
      echo "[-] File Downloaded..."
      return content.strip

proc testDownload() =
    const day = "1"
    echo download(day)

template doPart1*(fn, day: untyped, submit=false)=
  echo "[+] Part 1: "&($fn(download(day)))

template doPart2*(fn, day: untyped, submit=false)=
  echo "[+] Part 2: "&($fn(download(day)))

proc partOne*[T](partFunc: proc(input: string): T, day: string) =
  echo "[+] Part 1: ", $(partFunc(download(day)))

proc partTwo*[T](partFunc: proc(input: string): T, day: string) =
  echo "[+] Part 2: ", $(partFunc(download(day)))

when isMainModule:
    testDownload()
