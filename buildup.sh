
# FIXME: add params for passing from cli
# can pass filters
# can pass limit
# can pass asc desc
# makes use of tradingtick API
# get long short build-up 
sudo curl 'https://tradingtick.com/futures/longshort.php'    -H 'Content-Type: application/json;charset=UTF-8'    --data '{"type":"highoi"}'   --compressed  | jq '.[]|fromjson | [.[] | {Inst, ooi, volume} | select(.Inst != "IDEA")]| sort_by(.volume) | reverse | [limit(3;.[])]'
