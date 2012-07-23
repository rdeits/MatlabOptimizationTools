function optimizeGA()

% Robin Deits <robin.deits@gmail.com>
% August, 2010

% This function actually executes the genetic algorithm optimization. Once
% the parameters within the 'User Variables' section of this file are set
% up, the optimization can be started with:
% >> optimizeGA()


%% User Variables
%These are the variables meant to be changed by the user when setting up
%the optimization. 

% The number of individuals in the GA population
popSize = 20;

% The specific names (as used in simExample.m) of the variables being
% optimized
varNames = {'a','b','c'};

% Initial variable values. Each row is one set of parameters which will
% become an individual in the initial GA population. Possible values:
%   empty: 
%       no initial population, all initial values generated randomly by GA
%   row vector of same length as varNames:
%       one individual with those parameters in initial population, all
%       other individuals generated randomly by GA
%   matrix with height from 1 to popSize and width = length(varNames):
%       each row in the matrix defines one individual in the initial
%       population. Any remaining individuals not defined in x0 are
%       generated randomly by the GA
x0 = [5,4,3];

% The minimum values of the variables, again in the same order as the
% names.
mins = [0,0,0];

% The maximum values of the variables in order.
maxs = [15,15,15];

% An extra message to display, in order to show how we pass extra
% parameters to the simulation:
extraMessage = 'hello world';

% The actual function to be optimized
fitnessFunc = @(x) costFunction(x,varNames,extraMessage);

% Other options for the GA
options = gaoptimset('PopulationSize',popSize,...
	'InitialPopulation',x0,...
	'StallGenLimit',50,...
	'StallTimeLimit',Inf,...
	'Generations',100,...
	'EliteCount',2,...
	'MutationFcn',{@mutationuniform, .1},...
	'Display','iter',...
	'PlotFcns',@gaplotbestf,...
	'CrossoverFcn',@crossoverintermediate);


%% MATLAB file backup
% Ensure that we don't overwrite a previous data set
if exist('summary.txt') == 2
    disp('Optimization results already detected in this folder.')
    disp('Previous results and MATLAB files must be deleted before running a new optimization')
    return
end

backupMFiles('optimizeGA.m');

createSummary(varNames);

%% Running the optimization
nvars = length(varNames);
A = [];
b = [];
Aeq = [];
Beq = [];
LB = mins;
UB = maxs;
nonlcon = [];
[x fval exitflag output population scores] = ga(fitnessFunc,nvars,A,b,Aeq,Beq,LB,UB,nonlcon,options);
    
