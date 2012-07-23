function oneVarTest()

% Robin Deits <robin.deits@gmail.com>
% August 2010

% Similar to gridTest, but only tests one variable at a time. 

varNames = {'a'}
x0 = 4;
width = 2;

numSteps = 21;

values = linspace(x0-width/2,x0+width/2,numSteps);

extraMessage = 'hello world';
fitnessFunc = @(x) costFunction(x,varNames,extraMessage);

%% Save a record of the test
if exist('summary.txt') == 2
    disp('Optimization results already detected in this folder.')
    disp('Previous results and MATLAB files must be deleted before running a new optimization')
    return
end


backupMFiles('oneVarTest.m')

createSummary(varNames)




%% Perform grid testing

for i = 1:numSteps
    x = [values(i)];
    fitness = fitnessFunc(x);
end

load results
figure
plot([results.(varNames{1})],[results.cost])
xlabel(varNames{1})
ylabel('Cost')

