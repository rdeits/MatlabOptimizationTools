function cost = costFunction(x,varNames,varargin)

% Robin Deits <robin.deits@gmail.com>
% August, 2010

% This is the cost function which is called by the genetic algorithm. It
% serves as a wrapper for the actual simulation function, since it calls
% the simulation, then saves the results in summary.txt and results.mat.

% INPUTS: 
%	x: a vector of numeric values to be passed to the simulation
%   varNames: the names of the variables whose values are contained in x,
%       in the same order as the vlaues in x
%	varargin: any number of additional parameters to be passed to the
%       simulation

% OUTPUTS:
%	cost: the value of the cost function (lower values are better)



%% Run the test and calculate cost
disp('Running a test with :')
x


% Construct the assignments string. In order to make it easy to pass arbitrary
% configurations to the simulation program, simExample is designed to set all of
% its variables to their default values, then execute a string of Matlab 
% instruction before actually running the simulation. This creates a flexible
% interface between optimizer and simulation, but it requires that the variable
% names passed in varNames must exactly match those used in simExample, since the
% execution of the assignments string must overwrite the default values of those
% variables with their new values.
assignments = '';
for i = 1:length(x)
    assignments = strcat(assignments,varNames{i},'=',num2str(x(i),10),', ');
end
disp(horzcat('The new assignments string is: ',assignments))

if exist('results.mat')
    load results
else
    results = [];
end

% Check if we've already evaluated this set of parameters. The GA tends to
% repeat tests occasionally. This can be very annoying if the cost function
% takes a long time to evaluate, so we check each set of inputs against
% those that have already been run, and we avoid running the same
% simulation twice.
alreadyDone = 0;
for i = length(results):-1:1
    if strcmp(results(i).assignments, assignments)
        cost = results(i).cost;
        alreadyDone = 1;
        disp('Repeated test detected. Using previously calculated value.')
        break
    end
end
if alreadyDone == 0     
    % If we haven't tried these parameters already, we run the simulation.
    % This is whre the actual simulation function is called.
    cost = simExample(assignments,varargin);
end
% 
% 
%% Update the results.mat file with the detailed results.

results(end+1).cost = cost;
results(end).assignments = assignments;
for i = 1:length(varNames)
    results(end).(varNames{i}) = x(i);
end


save('results','results');


%% Update the summary.txt file with the basic data
formatString = '%d, %d, [';
for i = 1:length(x)
    formatString = strcat(formatString,' %d');
end
formatString = strcat(formatString,']\r\n');
folder = pwd;
filename = strcat(folder,filesep,'summary.txt');
% We read the summary file to extract the last test number in order to
% keep the numbering sequential.
summaryData = textread(filename,'%s','delimiter',',');
if length(summaryData) == 3
    % if this is the first test, the number it as such
    testNum = 1;
else
    testNum = str2num(summaryData{end-2})+1;
end

fid = fopen(filename,'a');
fprintf(fid,formatString,testNum,cost,x);
fclose(fid);

% Print the cost
cost
