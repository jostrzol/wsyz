set breweries;
set warehouses;

param brew_throughputs {b in breweries};
param warehouses_needs {w in warehouses};

param transport_costs {b in breweries, w in warehouses};

var transport_table {b in breweries, w in warehouses} >= 0, integer;

subject to con_warehouses_needs {w in warehouses}:
	sum {b in breweries} transport_table[b, w] = warehouses_needs[w];

subject to con_brew_throughputs {b in breweries}:
	sum {w in warehouses} transport_table[b, w] <= brew_throughputs[b];

minimize costs:
	sum {b in breweries, w in warehouses} transport_costs[b, w] * transport_table[b, w];