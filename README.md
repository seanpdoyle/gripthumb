# README

Here's an example `curl` to SkateVideoSite for scraping.

In this example, the song we've identified and are searching for is Duster's
_Echo, Bravo_:

```bash
curl 'http://www.skatevideosite.com/songsearch' \
     -H 'Connection: keep-alive' \
     -H 'Pragma: no-cache' \
     -H 'Cache-Control: no-cache' \
     -H 'Upgrade-Insecure-Requests: 1' \
     -H 'Origin: null' \
     -H 'Content-Type: application/x-www-form-urlencoded' \
     -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36' \
     -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8' \
     -H 'Accept-Encoding: gzip, deflate' \
     -H 'Accept-Language: en-US,en;q=0.9' \
     --data 'page=songsearch&select=2&searchterm=duster+echo%2C+bravo&submit=Search+for+artist+or+track' \
     --compressed
```
