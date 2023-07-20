
tgen:()!();
tgen[`F_VOL]:{[N] N?10 20 50 100 300 500 1000. };
tgen[`F_PRC_1]:{[N] N?2.};
tgen[`F_PRC_2_INCR]:{[PRC_L] PRC_L + (first 1?-1 1) * count[PRC_L]?0.20*avg PRC_L}; //get 20% deviation from average on prices on a vector
tgen[`TS_1]:{[N] asc .z.d+N?.z.t};
tgen[`S]:{[N;INSTR_N] upper N?INSTR_N?`3};
tgen[`S_1]:{[N;INSTR_N] upper N?INSTR_N?`3}[;10];
  tgen[`S_2]:{[N;SRC_S_LIST] N?SRC_S_LIST}; //not consistent
tgen[`J_1]:{[N] til N}; 
tgen[`J_2]:{[N] N# {count[x]<y}[;N]{x,(first 1?4)#1+last x}/0 }; //gen random order id's replicas for versions
tgen[`J_3]:{[N] asc N?til `int$sqrt N}; //take random consecutive
tgen[`SIDE]:{[N] N?`B`A};
tgen[`SIDE_2]:{[N] N#1?`B`A};


gen_timeseries:()!();
/INSTR_N:10; N:1000; COLS:`sym`time`price`size!`S_1`TS_1`F_PRC_1`F_VOL
gen_timeseries[`trade]:{[N;COLS]
 flip key[COLS]!tgen[get COLS]@\:N
 }

/ COLS:`id`version`sym`time`side`limit`start`end!
/limit:tgen[`F_PRC_2_INCR][ 
gen_timeseries[`clientorders]:{[N]
 TRD_SYMS:exec distinct sym from trade;	
 x: flip `id`time`rndprice!(tgen[`J_2`TS_1`F_PRC_1]@\:N);
 r:{ update end:start + count[id]#`second$`int$tgen[`F_VOL][1],limit:count[id]#tgen[`F_PRC_2_INCR][rndprice] by id from x }
   {[x;TRD_SYMS] update sym:count[id]#tgen[`S_2][1;TRD_SYMS], side:tgen[`SIDE_2][count id], version:til count id, start:time + count[id]#`second$`int$tgen[`F_VOL][1] by id from x }[;TRD_SYMS] x;
 delete rndprice from r
 }


writecsv:{
 `:/tmp/trade.csv 0: "," 0: trade: gen_timeseries[`trade][N:1000; COLS:`sym`time`price`size!`S_1`TS_1`F_PRC_1`F_VOL];
 trade
 }

// trade:loadcsv `:/tmp/trade.csv
loadcsv:{[FILE]
 ("SPFF";enlist ",") 0: hsym $[null FILE; `$getenv[`APP_ROOT],"/data/trade.csv" ;FILE]
 };
