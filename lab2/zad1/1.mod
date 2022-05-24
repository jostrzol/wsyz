set products;

param throughputs {p in products};
param prices {p in products};
param week_limits {p in products};

param h_per_week;

var harmonogram {h in 1..h_per_week, p in products}, binary;
var harmonogram_masses {h in 1..h_per_week, p in products} >=0;

subject to max_2_in_one_hour {h in 1..h_per_week}:
	sum {p in products} harmonogram[h, p] <= 2;


subject to con_hourly_production {h in 1..h_per_week, p in products}:
	harmonogram_masses[h, p] <= harmonogram[h, p] * throughputs[p]; 

var masses_per_week {p in products} = sum {h in 1..h_per_week} harmonogram_masses[h, p];
subject to con_week_limits {p in products}:
	masses_per_week[p] <= week_limits[p];

maximize profit:
	sum {p in products} masses_per_week[p] * prices[p];
