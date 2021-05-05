pkg load statistics
pkg load queueing

clc;
clear all;
close all;

lambda = 5;
mu = 10;
states = [0, 1, 2, 3, 4]; 
initial_state = [1, 0, 0, 0, 0];

births = lambda ./ (1+states) (:,[1:4]);
deaths = [mu, mu, mu, mu];

#I
transition_matrix = ctmcbd(births, deaths);
display(transition_matrix);

#II
P = ctmc(transition_matrix);
display(P);

figure(1);
hold on;
bar(states, P, "r", 0.5);
title("Probability of state");
xlabel("States");
ylabel("Probability");
axis([-0.5 4.5 0 0.62]);
hold off;

#III
avrg = sum(P.*states);
display(avrg);

#IV
display("Blocking Probability =");
display(P(5));

#V 
index = 0;
for T = 0 : 0.01 : 60
  index = index + 1;
  P0 = ctmc(transition_matrix, T, initial_state);
  Prob0(index) = P0(1);
  Prob1(index) = P0(2);
  Prob2(index) = P0(3);
  Prob3(index) = P0(4);
  Prob4(index) = P0(5);
  if (P0 - P) < 0.01
    break;
  endif
endfor

T = 0 : 0.01 : T;
figure(2);
hold on;
plot(T, Prob0, "r", "linewidth", 1.3);
plot(T, Prob1, "b", "linewidth", 1.3);
plot(T, Prob2, "c", "linewidth", 1.3);
plot(T, Prob3, "k", "linewidth", 1.3);
plot(T, Prob4, "g", "linewidth", 1.3);
title("State probability for \\lambda = 5, m = 10 across time");
xlabel("Time (s)");
ylabel("Probability");
axis([0 0.5]);
legend (" State : 0"," State : 1"," State : 2"," State : 3"," State : 4");
grid on;
hold off;

#VI
#l = 5, m = 1
lambda = 5;
mu = [1 5 20];

for i = 1 : columns(mu)
  index = 0;
  deaths = [mu(i), mu(i), mu(i), mu(i)];
  transition_matrix = ctmcbd(births, deaths);
  P = ctmc(transition_matrix);
  for T = 0 : 0.01 : 50
    index = index + 1;
    P0 = ctmc(transition_matrix, T, initial_state);
    Prob0(index) = P0(1);
    Prob1(index) = P0(2);
    Prob2(index) = P0(3);
    Prob3(index) = P0(4);
    Prob4(index) = P0(5);
    if (P0 - P)./P < 0.01
      break;
    endif
  endfor
  Tmax = T;
  T = 0 : 0.01 : Tmax;
  figure(i+2);
  hold on;
  plot(T, Prob0, "r", "linewidth", 1.3);
  plot(T, Prob1, "b", "linewidth", 1.3);
  plot(T, Prob2, "c", "linewidth", 1.3);
  plot(T, Prob3, "m", "linewidth", 1.3);
  plot(T, Prob4, "g", "linewidth", 1.3);
  title_string = strcat("State probability for \\lambda=5 and m=",
  num2str(mu(i))," across time");
  title(title_string);
  xlabel("Time (s)");
  ylabel("Probability");
  legend (" State : 0"," State : 1"," State : 2"," State : 3"," State : 4");
  grid on;
  hold off;
  clear Prob0;
  clear Prob1;
  clear Prob2;
  clear Prob3;
  clear Prob4;
endfor
