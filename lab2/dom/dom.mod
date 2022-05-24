set products;

param throughputs {i in products};
param prices {i in products};
param week_limits {i in products};

param h_per_week;

var times_per_week {i in products} >=0;
var masses_per_week {i in products} = times_per_week[i] * throughputs[i];

subject to con_week_limits {i in products}:
	masses_per_week[i] <= week_limits[i];

subject to con_h_per_week:
	sum {i in products} times_per_week[i] <= h_per_week;

maximize profit:
	sum {i in products} masses_per_week[i] * prices[i];

