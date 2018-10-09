%       Name: Karan Pareek
%       Student ID: kp2218
% This function simulates a delay tap line wherein the user can input an
% audio file and generate a delay line, with each tap having gain, g.
%
% INPUTS : Audio signal (x), Number of taps (n), Gain of each tap (g), 
%          Delay length (d)
% OUTPUT : Filtered signal (y), Feedforward coefficients (b), Feedforward
%          coefficients (a)

function [y,b,a] = PreDelay(x,n,d)

%% Main function

% INCLUDE FORMULA!

% Creating an array (l) whose sum equals the total delay time (d) with the
% requried number of taps (n)
m = 1:d;
a = m(sort(randperm(d,n)));
l = diff(a);
l(end+1) = d - sum(l);

% Here, l denotes an array with random tap delay times

% Now, we need to create an array with random gain parameters (g) that has
% length n i.e. the number of delay taps specified by the user, arranged in
% descending order
g = rand(1,n);
g = sort(g,'descend'); % 

%find the maximum delay length
maxd=max(l);

%Set the b and a coefficients of the transfer function depending on g and d.
b=[1 zeros(1,maxd)];
a=[1];

for k = 1:n
   b = b + [zeros(1,l(k)), g(k), zeros(1,maxd-l(k))];
end      

%filter the input signal 
y=filter(b,a,x);

end