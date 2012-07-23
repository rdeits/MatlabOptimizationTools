function plotOptimization(varargin)

% Robin Deits <robin.deits@gmail.com>
% August, 2010

% This function plots the results of running the optimization. It takes
% data from the results.m file and produces a plot of cost vs. test number.

% To produce the plot, first change the MATLAB current directory to the
% folder in which the results.mat file is stored. Then run:
% >> plotOptimization();
% or 
% >> plotOptimization(1);
% to create the plot in a new figure. 
% Or run:
% >> plotOptimization(0);
% to create the plot in the currently active figure

if nargin == 1
    newFig = varargin{1};
else
    newFig = 1;
end

load results
costs = [results.cost];
testNums = 1:length(costs);
minCosts = [];
for i = 1:length(costs)
    minCosts(i) = min(costs(1:i));
end


if newFig == 1
    figure
end

hold on
plot(testNums,minCosts)
xlabel('Test number')
ylabel('Lowest cost achieved')
hold off 
