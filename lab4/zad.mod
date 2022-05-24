set tasks;
set dependencies within {tasks, tasks};

param nominal_duration {tasks};
param minimal_duration {tasks};
param n_employees {tasks};

param maximal_budget;
param overtime_cost_per_day_employee;

# duration
var duration {t in tasks} integer <= nominal_duration[t];
s.t. con_min_duration {t in tasks}:
	duration[t] >= minimal_duration[t];
var shortened_by {t in tasks} =
	nominal_duration[t] - duration[t];

# cost
var cost {t in tasks} =
	shortened_by[t] * n_employees[t] * overtime_cost_per_day_employee;
var total_cost = sum {t in tasks} cost[t];
s.t. con_meet_maximal_budget:
	total_cost <= maximal_budget;

# start, end time
var start_time {tasks} >= 0;
s.t. con_meet_dependencies {(t_p, t_n) in dependencies}:
	start_time[t_n] >= start_time[t_p] + duration[t_p];
var end_time {t in tasks} = start_time[t] + duration[t];

# total time
var total_time;
s.t. con_total_time_greatest {t in tasks}:
	total_time >= end_time[t];

# target
minimize q_minimize_total_time:
	total_time;