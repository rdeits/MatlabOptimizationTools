function losses = reconstructSim(testNum)

% Robin Deits <robin.deits@gmail.com>
% August, 2010

% This function (meant to be run from within the folder where results.mat
% is stored), reads the data from results.mat to re-run a simulation from a
% run of the optimizer. A particular test number (as numbered in
% summary.txt) can be run with:
% >> reconstructSim(testNum)
% Alternatively, the best test from the run can be found and repeated with:
% >> reconstructSim('best')

load results

if strcmp(testNum,'best')
    % Load the best test from the summary
    [value,ndx] = min([results.cost]);
    testNum = ndx;
    disp(cat(2,'Best test was number ',num2str(testNum)))
end

assignments = results(testNum).assignments

cost = simExample(assignments);
cost
