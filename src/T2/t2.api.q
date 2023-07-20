
.api.get.order_vwap:{[oids; markettrade]
  suborders: 0!select by id from orders where id in oids;
  f:`sym`time;
  w: exec (start,'end) from suborders;
  res:wj1[w;f;suborders;(markettrade;(::;`price);(::;`volume))];
  res:update w: {[p;c;l] where p $[c~`B;<=;>=]' l}'[price;side;limit] from res;
  fin:update vwap:volume wavg' price from update price:price@'w, volume: volume@'w from res;
  delete w, volume, price from fin
  }

