pkg load statistics

clc;
clear all;
close all;

colors = "rbm";

#Question A

lambda = 5;
n_events = 100;
time_diff = exprnd(1/lambda, 1, n_events);

event_func = zeros(1, n_events);
event_func(1) = time_diff(1);

for i = 2:n_events
  event_func(i) = event_func(i-1) + time_diff(i);
endfor

figure(1)
stairs(event_func, 1:n_events);
title("Poisson Enumaration Processes");
xlabel("Time");
ylabel("Events");

#Question B
#Time of last event / number of events = 1 / ë
#ë = number of events / time of last event

dt_values = [200, 300, 500, 1000, 10000];
time_diff = exprnd(1/lambda, 1, 10000);
for i=1:columns(dt_values);
  mean_value = dt_values(i) ./ sum(time_diff(1:dt_values(i)));
  disp(strcat("Events mean value for Dt=", num2str(dt_values(i)), " :"));
  display(mean_value);
endfor


