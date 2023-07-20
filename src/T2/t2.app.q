system "l src/utils.q"
system "l src/T2/t2.api.q"

-1 "Generating data";
trade:gen_timeseries[`trade][100000;`sym`time`price`volume!`S_1`TS_1`F_PRC_1`F_VOL];

-1 "Trade data loaded with:";
-1 "\t trade: gen_timeseries[`trade][100000;`sym`time`price`size!`S_1`TS_1`F_PRC_1`F_VOL]";

-1 "Clientorders data loaded with:";
-1 "\t clientorders:gen_timeseries[`clientorders][100];";
clientorders:gen_timeseries[`clientorders][100];

-1 "example: \n\t .api.get.order_vwap[1 4;trade]";
