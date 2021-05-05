pkg load statistics
pkg load queueing

clc;
clear all;
close all;

lambda = 5
U=[0,50]; #utiliaztion 
R=[0,50]; #server responce time
Q=[0,50]; #average number of requests
X=[0,50]; #server throughput

mu = [5.1:0.1:10];
display(mu)
for i=1:columns(mu)
    [U(i),R(i),Q(i),X(i)] = qsmm1(lambda, mu(i));
endfor
# Utiliaztion
figure(1);
hold on;
plot(mu,U,"linewidth", 1);
title("Utilization","fontsize",12);
xlabel("Parameter \\mu","fontsize",12);
ylabel("Utilization","fontsize",12);
#saveas (1, "figures/figure1.png")
hold off;
# Server responce time
figure(2);
hold on;
plot(mu,R,"linewidth", 1);
title("Response Time","fontsize",12);
xlabel("Parameter \\mu","fontsize",12);
ylabel("Response time","fontsize",12);
#saveas (2, "figures/figure2.png")
hold off;
# Average number of requests
figure(3);
hold on;
plot(mu,Q,"linewidth", 1);
title(" Average number of requests","fontsize",12);
xlabel("Parameter \\mu","fontsize",12);
ylabel("Average Number of requests","fontsize",12);
#saveas (3, "figures/figure3.png")
hold off;
# Server throughput
figure(4);
hold on;
plot(mu,X,"linewidth", 1);
title("Throughput","fontsize",12);
xlabel("Parameter \\mu","fontsize",12);
ylabel("Throughput","fontsize",12);
#saveas (4, "figures/figure4.png")
hold off;
