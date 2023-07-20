
tgen:()!();
tgen[`F_VOL]:{[N] N?10 20 50 100 300 500 1000. };
tgen[`F_PRC_1]:{[N] N?2.};
tgen[`F_PRC_2_INCR]:{[PRC_L] PRC + (first 1?-1 1) * count[PRC]?0.20*avg PRC}; //get 20% deviation from average on prices on a vector
tgen[`TS_1]:{[N] asc .z.d+N?.z.t};
tgen[`S]:{[N;INSTR_N] upper N?INSTR_N?`3};
tgen[`S_1]:{[N;INSTR_N] upper N?INSTR_N?`3}[;10];
  tgen[`S_2]:{[N;SRC_S_LIST] N?SRC_S_LIST}; //not consistent
tgen[`J_1]:{[N] til N}; 
tgen[`J_2]:{[N] asc N?til `int$sqrt N}; //take random consecutive
tgen[`SIDE]:{[N] N?`B`A};


gen_timeseries:()!();
/INSTR_N:10; N:1000; COLS:`sym`time`price`size!`S_1`TS_1`F_PRC_1`F_VOL
gen_timeseries[`trade]:{[N;COLS]
 flip key[COLS]!tgen[get COLS]@\:N
 }

/ COLS:`id`version`sym`time`side`limit`start`end!
/limit:tgen[`F_PRC_2_INCR][ 
gen_timeseries[`clientorders]:{[N;COLS]
 TRD_SYMS:exec distinct sym from trade;	
 { update 
       end:start + `second$`int$tgen[`F_VOL][count id] 
		 by id,sym from x }
     update 
       start:time + `second$`int$tgen[`F_VOL][count id], 
       version:til count id, sym:tgen[`S_2][count id;TRD_SYMS], rndprice:tgen[`F_PRC_1][count id], side:tgen[`SIDE][count id]  by id from flip `id`time!(tgen[`J_2] N; tgen[`TS_1])
 }


writecsv:{
 `:/tmp/trade.csv 0: "," 0: trade: gen_timeseries[`trade][N:1000; COLS:`sym`time`price`size!`S_1`TS_1`F_PRC_1`F_VOL];
 trade
 }

// trade:loadcsv `:/tmp/trade.csv
loadcsv:{[FILE]
 ("SPFF";enlist ",") 0: hsym $[null FILE; `$getenv[`APP_ROOT],"/data/trade.csv" ;FILE]
 };
