system "l src/T2/t2.api.q";


.t.T 1b;

orders:([]id:til 3; sym:3#`ibm;time:10:01:01 10:01:04 10:01:08;side:`B`B`A;limit:100 101 105; start:10:01:00 10:01:03 10:01:04; end:10:01:04 10:01:06 10:01:09);
p:99 101 103 104 103 107 108 107 108;
markettrade:([]sym:`ibm; time:10:01:01+til 9; price:p; volume:20*p);
f:`sym`time;
suborders: 0!select by id from orders where id in 0 2
w: exec (start,'end) from suborders;
res:wj1[w;f;suborders;(markettrade;(::;`price);(::;`volume))];
res:update w: {[p;c;l] where p $[c~`B;<=;>=]' l}'[price;side;limit] from res
fin:update vwap:volume wavg' price from update price:price@'w, volume: volume@'w from res


out:.api.get.order_vwap[0 2;markettrade];

.t.E (delete w, volume, price from fin; out);

show out;

-1 "unit test results:\t ", .Q.s1 .t.R;
exit any not .t.R;

