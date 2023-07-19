/INSTR_N:10; N:1000; COLS:`sym`time`price`size
gen_timeseries:{[INSTR_N;N;COLS]
 flip COLS!(upper N?INSTR_N?`3; asc .z.d+N?.z.t; N?2.; N?10 20 50 100 300 500 1000.)
 }

writecsv:{
 `:/tmp/trade.csv 0: "," 0: trade: gen_timeseries[INSTR_N:10; N:1000; COLS:`sym`time`price`size];
 trade
 }

// trade:loadcsv `:/tmp/trade.csv
loadcsv:{[FILE]
 ("SPFF";enlist ",") 0: hsym $[null FILE; `$getenv[`APP_ROOT],"/data/trade.csv" ;FILE]
 };
