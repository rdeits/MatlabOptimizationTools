function randomSearch()

% Robin Deits <robin.deits@gmail.com>
% August, 2010

% This function is meant to be a control for other optimization methods. It
% generates random parameters for a cost function within a given set of
% limits and passes those parameters to the simulation program. It is
% otherwise identical to optimizeGA and optimizeFMinSearch.

%% User Variables
%These are the variables meant to be changed by the user when setting up
%the optimization. 

% The specific names (as used in simExample.m) of the variables being
% optimized
varNames = {'a','b','c'};
% The minimum values of the variables, again in the same order as the
% names. 
mins = [0,0,0];
% The maximum values of the variables in order.
maxs = [10,10,10];

extraMessage = 'hello world';

%% MATLAB file backup
% Ensure that we don't overwrite a previous data set
if exist('summary.txt') == 2
    disp('Optimization results already detected in this folder.')
    disp('Previous results and MATLAB files must be deleted before running a new optimization')
    return
end


backupMFiles('randomSearch.m');

createSummary(varNames);

%% Generate the random parameters

for i = 1:1000 % do 1000 tests
    x = rand(1,length(varNames));
    x = x.*(maxs-mins) + mins;
    cost = costFunction(x,varNames,extraMessage);
end
