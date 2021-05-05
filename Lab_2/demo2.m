pkg load statistics

% system M/M/1/4
% when there are 3 clients in the system, the capability of the server doubles.

clc;
clear all;
close all;

lambda = 4;
mu = 5;
states = [0, 1, 2, 3, 4]; % system with capacity 4 states
% the initial state of the system. The system is initially empty.
initial_state = [1, 0, 0, 0, 0];

% define the birth and death rates between the states of the system.
births_B = [lambda, lambda, lambda, lambda];
deaths_D = [mu, mu, 2 * mu, 2 * mu];

% get the transition matrix of the birth-death process
transition_matrix = ctmcbd(births_B, deaths_D);
% get the ergodic probabilities of the system
P = ctmc(transition_matrix);

% plot the ergodic probabilities (bar for bar chart)
figure(1);
bar(states, P, "r", 0.5);

% transient probability of state 0 until convergence to ergodic probability. Convergence takes place P0 and P differ by 0.01
index = 0;
for T = 0 : 0.01 : 50
  index = index + 1;
  P0 = ctmc(transition_matrix, T, initial_state);
  Prob0(index) = P0(1);
  if P0 - P < 0.01
    break;
  endif
endfor

T = 0 : 0.01 : T;
figure(2);
plot(T, Prob0, "r", "linewidth", 1.3);