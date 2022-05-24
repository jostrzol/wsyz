set products;
set machines;

param demand {p in products};
param throughputs {p in products, m in machines};
param energy_per_machine {m in machines};

param min_runtime;

var time {p in products, m in machines} >= 0;

subject to con_min_time {m in machines}:
	sum {p in products} time[p,m] >= 10;

var producted {p in products, m in machines} = time[p, m] / throughputs[p, m];
subject to con_demand {p in products}:
	sum {m in machines} producted[p, m] = demand[p];

# a
var energy = sum {p in products, m in machines} energy_per_machine[m] * producted[p, m];

# b
var machine_times {m in machines} = sum {p in products} time[p, m];
var total_time = sum {m in machines} machine_times[m];

# c
var longest_running_machine >= 0;

subject to longest {m in machines}:
	sum {p in products} time[p, m] <= longest_running_machine;

# d
param desired_runtime;

var eplus {m in machines} >= 0;
var eminus {m in machines} >= 0;

subject to con_delta {m in machines}:
	eplus[m] - eminus[m] + machine_times[m] = desired_runtime;

var delta_abs = sum {m in machines} (eplus[m] + eminus[m]);