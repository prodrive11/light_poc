.api.get.vwap:{[st;et]
  select size wavg price by sym from quote where time within (st;et)  
 }

.core.vwap:{[p;s]  sum[p*s]%sum[s] }

