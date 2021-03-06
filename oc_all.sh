curl 'https://www.nseindia.com/api/option-chain-indices?symbol=BANKNIFTY' \
  -H 'authority: www.nseindia.com' \
  -H 'cache-control: max-age=0' \
  -H 'upgrade-insecure-requests: 1' \
  -H 'user-agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.58 Safari/537.36' \
  -H 'accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9' \
  -H 'sec-gpc: 1' \
  -H 'sec-fetch-site: none' \
  -H 'sec-fetch-mode: navigate' \
  -H 'sec-fetch-user: ?1' \
  -H 'sec-fetch-dest: document' \
  -H 'accept-language: en-GB,en-US;q=0.9,en;q=0.8'  --compressed | jq '.records.data[]? | select(.PE.openInterest !=null and .CE.openInterest !=null) | { (.strikePrice | tostring): { spot: .PE.underlyingValue, expiry: .expiryDate, oi: {put: .PE.openInterest , call: .CE.openInterest, diff: (.PE.openInterest - .CE.openInterest ) } , chng: { callOIChng: .CE.changeinOpenInterest, callOIChngPct: .CE.pchangeinOpenInterest, putOIChng: .PE.changeinOpenInterest, putOIChngPct: .PE.pchangeinOpenInterest } , iv: { call: .CE.impliedVolatility , put: .PE.impliedVolatility} , ltp: {call: .CE.lastPrice, put: .PE.lastPrice}, change: { call: .CE.change, put: .PE.change, diff: ((.CE.change - .PE.change)) }, qty: { pcr: (.PE.totalSellQuantity / .CE.totalSellQuantity), callSell: .CE.totalSellQuantity, putSell: .PE.totalSellQuantity, callBuy: .CE.totalBuyQuantity, putBuy: .PE.totalBuyQuantity }, pctChange: { call: .CE.pChange, put: .PE.pChange, diff: ((.CE.pChange - .PE.pChange))}}}'
