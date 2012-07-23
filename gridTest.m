function gridTest()

% Robin Deits <robin.deits@gmail.com>
% August, 2010

% This function takes two input parameters for the simulation and
% tests them at all points of a (numSteps x numSteps) grid of values for those variables,
% allowing a 3D plot of cost values to be generated. It is meant to be run with no input
% parameters; rather, the parameters should be set directly within the file. This makes it
% easier to see what parameters were used in a give set of tests.

% gridTest also calls makeContourPlot.m, which creates 3D and contour plots
% summarizing its results. 

%% Parameters to be set by user:
varNames = {'a','b'};
% The center of the range
x0 = [0,0];
% The width of the range for each variable
widths = [3,5];
% The number of steps for each variable
numSteps = 11;

extraMessage = 'hello world';
fitnessFunc = @(x) costFunction(x,varNames,extraMessage);

%% Generate the variable ranges
xValues = linspace(x0(1)-widths(1)/2,x0(1)+widths(1)/2,numSteps);
yValues = linspace(x0(2)-widths(2)/2,x0(2)+widths(2)/2,numSteps);

if exist('summary.txt') == 2
    disp('Optimization results already detected in this folder.')
    disp('Previous results and MATLAB files must be deleted before running a new optimization')
    return
end

backupMFiles('gridTest.m');

createSummary(varNames);


%% Perform grid testing

for i = 1:numSteps
    for j = 1:numSteps
        x = [xValues(i),yValues(j)];
        fitness = fitnessFunc(x);
    end
end

makeContourPlot(varNames);
