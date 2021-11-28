import std/httpclient



proc download*(day: string, cookie: string) =
    ##
    ## Params
    ## =========
    ## 
    ## day: day of input to download
    ## 
    ## cookie: session cookie value
    ##
    let 
        client = newHttpClient()
        cook   = "session=" & cookie
        url    = "https://adventofcode.com/2015/day/" & day & "/input"
    # echo url, " ", cook
    client.headers = newHttpHeaders({ "Cookie": cook })

    let content = client.getContent(url)
    echo "Input download success!"
    writeFile("input.txt", content)


proc testDownload() =
    const Cookie = "53616c7465645f5f286233854807ebf2e15e1f6171afd50d75c2bb44570165dbb1da648b9f80588b05066079605f6baf"
    const day = "1"

    download(day, Cookie)

when isMainModule:
    testDownload()