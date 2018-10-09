%       Name: Karan Pareek
%       Student ID: kp2218
% This function creates an all-pass filter.
%
% INPUTS : Audio signal (x), Feedfoward gain (g), Delay length (d)
% OUTPUT : Filtered signal (y), Feedforward coefficients (b), Feedforward
%          coefficients (a)

function [y,b,a] = AllpassFilter(x,g,d)

%% Main Function

% Error checking
if g > 1
    error ('Filter gain cannot exceed 1');
end

% Given the amount of delay in samples and the gain factor, we can now 
% define the feedforward and feedback coefficients for the filter

b = [g,zeros(1,d-1),1];
a = [1,zeros(1,d-1),g];

y = filter(b,a,x);

end
