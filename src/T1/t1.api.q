.q.vwap:{[s;p]  sum[p*s]%sum[s] }

.api.get.vwap:{[SYM; ST; ET]
  0!select size vwap price by sym from trade where sym in SYM, time within (ST; ET)
  }


