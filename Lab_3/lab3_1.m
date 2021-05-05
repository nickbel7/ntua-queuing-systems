pkg load statistics
pkg load queueing

clc;
clear all;
close all;

total_arrivals = 0; % to measure the total number of arrivals
current_state = 0;  % holds the current state of the system
previous_mean_clients = 0; % will help in the convergence test
index = 0;

lambda = 3; 
mu = 5;
threshold = lambda/(lambda + mu); 

transitions = 0; 
total=0;

while transitions >= 0
  transitions = transitions + 1; % one more transitions step
  
  if mod(transitions,1000) == 0 % check for convergence every 1000 transitions steps
    index = index + 1;
    for i=1:1:length(arrivals)
        P(i) = arrivals(i)/total_arrivals; % calcuate the probability of every state in the system
    endfor
    
    mean_clients = 0; % calculate the mean number of clients in the system
    for i=1:1:length(arrivals)
       mean_clients = mean_clients + (i-1).*P(i);
    endfor
    
    to_plot(index) = mean_clients;
        
    if abs(mean_clients - previous_mean_clients) < 0.0001 || transitions > 1000000 % convergence test
      break;
    endif
    
    previous_mean_clients = mean_clients;
    
  endif
  
  random_number = rand(1); % generate a random number

  if(current_state == 0 || random_number < threshold) 
    total_arrivals = total_arrivals + 1;
    state(transitions) = current_state +1;
    try 
      arrivals(current_state+1 ) =arrivals(current_state+1) + 1;
      state(transitions) = current_state; 
      if (current_state <10)
       current_state = current_state + 1;
      endif
      next_transition(transitions) = 1;
      total = total +1;
    catch
      arrivals(current_state + 1) = 1;
      current_state = current_state + 1;
      next_transition(transitions) = 1;
      total = total +1;
  end

  else % departure
      state(transitions) = current_state+1;
      if current_state != 0 % no departure from an empty system
       current_state = current_state - 1;
       next_transition(transitions) = 0;
       total = total -1;
      endif
  endif
  t_arrivals(transitions)= total;

endwhile

for i=1:1:30
  disp(cstrcat("State No: ", num2str(state(i))));
  if(next_transition(i+1) ==1)
   display("Type of next transition: Arrival");
  else 
   display("Type of next transition: Departure");
  endif
  disp(cstrcat("Total arrivals: ", num2str(t_arrivals(i)), "\n"));
endfor
