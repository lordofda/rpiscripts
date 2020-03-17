curl -XPOST 'http://localhost:8086/query?db=telegraf' --data-urlencode 'q=select non_negative_derivative(mean(uptime)) from "system" where time > now() - 10m group by host ,time(15m) fill(0)' | jq -r '. | .results[].series[].tags[]'

