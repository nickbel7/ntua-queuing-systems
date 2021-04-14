pkg load statistics

clc;
clear all;
close all;

#Question A
# TASK: In a common diagram, design the Probability Mass Function of exponential processes
# with parameters 1/ë = {0.5,1,3}. In the horizontal axes, choose k parameters 
# between 0 and 8. 

k = 0:0.001:8;
lambda = [0.5, 1, 3];

for i=1:columns(lambda)
exponential(i,:) = exppdf(k, lambda(i));
endfor

colors = "rbm";
figure(1);

hold on;
for i=1:columns(lambda)
plot(k,exponential(i,:),colors(i), "linewidth", 1.0);
endfor
hold off;

title("Probability Density Function of Exponential Processes");
xlabel("k values");
ylabel("Probability");
legend("lambda=0.5", "lambda=1", "lambda=3");


#Question Â
for i=1:columns(lambda)
exponential(i,:) = expcdf(k, lambda(i));
endfor

colors = "rbm";
figure(2);

hold on;
for i=1:columns(lambda)
plot(k,exponential(i,:),colors(i), "linewidth", 1.0);
endfor
hold off;

title("Cumulative Distribution Function of Exponential Processes");
xlabel("k values");
ylabel("Probability");
legend("lambda=0.5", "lambda=1", "lambda=3");

#Question C
lambda = 2.5;
pos_3 = 3;
p1 = 1 - expcdf(pos_3, lambda);
display(" P(X > 3)= ");
display(p1);
pos_5 = 5;
pos_2 = 2;
p2 = 1 - expcdf(pos_5, lambda)
p3 = 1 - expcdf(pos_2, lambda)
if (p3!=0)
pf = p2/p3;
elseif
pf = p2;
endif
display(" P(X > 5 | X > 2)= ");
display(pf);
