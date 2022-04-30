import std/[httpclient, os, strutils]



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
      return content.strip

proc testDownload() =
    const day = "1"
    echo download(day)

when isMainModule:
    testDownload()
