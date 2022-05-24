set tasks;
set dependencies within {tasks, tasks};

param maximal_budget;

param nominal_duration {tasks};
param minimal_duration {tasks};
param shorten_cost {tasks};

# duration
var duration {t in tasks} <= nominal_duration[t];
s.t. con_min_duration {t in tasks}:
	duration[t] >= minimal_duration[t];

# cost
var cost {t in tasks} =
	(nominal_duration[t] - duration[t]) * shorten_cost[t];
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