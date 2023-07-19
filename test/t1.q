system "l src/T1/t1.api.q";


.t.T 1b;

//set new trade test data source
trade:([] sym:`A`B`A`C`B`A; time: `timestamp$til 6; price:5 2 3 5 2 3.; size:50 20 20 10 50 10.);

.t.E (0;  count .api.get.vwap[`C; `timestamp$0; `timestamp$1] );
.t.E (1;  count R1:.api.get.vwap[`C; `timestamp$0; `timestamp$8] );
.t.E (5.; exec first price from R1 where sym = `C );

.t.E (2; count R2:.api.get.vwap[`A`C; `timestamp$0; `timestamp$8] );

.t.E (5.   ; (1!R2)[`C;`price] );
.t.E (4.25 ; (1!R2)[`A;`price] );


-1 "unit test results:\t ", .Q.s1 .t.R;
exit any not .t.R;
