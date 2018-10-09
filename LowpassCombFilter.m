%       Name: Karan Pareek
%       Student ID: kp2218
% This function creates an feedback comb filter with a lowpass filter in
% the feedback loop.
%
% INPUTS : Audio signal (x), Feedback gain of the lowpass filter (g1),
%          Feedback gain of the comb filter (g2), Delay length (d)
% OUTPUT : Filtered signal (y), Feedforward coefficients (b), Feedforward
%          coefficients (a)

function [y,b,a] = LowpassCombFilter(x,g1,g2,d)

%% Main Function

% Error Checking
if g1 > 1
    error('Feedback gain cannot exceed 1');
end   

if g2 > 1
    error('Feedback gain cannot exceed 1');
end   

% Given the amount of delay in samples and the gain factors, we can now 
% define the feedforward and feedback coefficients for the filter

b = [zeros(1,d),1,-g1];
a = [1,-g1,zeros(1,d-2),-g2*(1-g1)];

y = filter(b,a,x);

end
