function optimizeFMinSearch()

% Robin Deits <robin.deits@gmail.com>
% August, 2010

% This function is very similar to optimizeGA.m, but it uses the
% fminsearchbnd optimizer, which implements a Nelder-Mead Simplex
% algorithm, rather than a GA.


%% User Variables
%These are the variables meant to be changed by the user when setting up
%the optimization. 


% The specific names (as used in simExample.m) of the variables being
% optimized
varNames = {'a','b','c'};
% Initial variable values, in the same order as the variable names. This
% must be a row vector of the same length as varNames.
x0 = [5,4,3];
% The minimum values of the variables, again in the same order as the
% names. Use -inf for variables with no minimum.
mins = [0,0,0];
% The maximum values of the variables in order. Use inf for variables with
% no maximum.
maxs = [15,15,15];
% Options for the optimizer
searchOptions = struct(...
        'Display','iter',...
        'FunValCheck','off');

extraMessage = 'hello world';

% The function to be optimized. fMinParser.m just properly unwraps the
% variable argument format used by fminsearch and passes the variables to
% costFunction.m
optFn = @fMinParser


%% MATLAB file backup
% Ensure that we don't overwrite a previous data set
if exist('summary.txt') == 2
    disp('Optimization results already detected in this folder.')
    disp('Previous results and MATLAB files must be deleted before running a new optimization')
    return
end


backupMFiles('optimizeFMinSearch.m');

createSummary(varNames);

%% Running the optimization
[outX,fval,exitflag,output] = fminsearchbnd(optFn, x0, mins, maxs, ...
    searchOptions,varNames,extraMessage);

    
