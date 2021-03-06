function makeContourPlot(varNames)

% Robin Deits <robin.deits@gmail.com>
% August, 2010

% Uses the results generated by gridTest to make a contour plot of the
% results. xVar and yVar are the exact variable names (as used in simExample)
% which were varied during the grid testing.

xVar = varNames{1};
yVar = varNames{2};

load results
numSteps = sqrt(length([results.cost]));
X = reshape([results.(xVar)],numSteps,numSteps);
Y = reshape([results.(yVar)],numSteps,numSteps);
Z = reshape([results.cost],numSteps,numSteps);

figure
subplot 211
contour(X,Y,Z,20)
colorbar
xlabel(xVar)
ylabel(yVar)
title('Cost')

subplot 212
surf(X,Y,Z)
colorbar
xlabel(xVar)
ylabel(yVar)
zlabel('Cost')


set(gcf,'OuterPosition',[400,50,550,850],'PaperPositionMode','auto')
print -dpdf 'contourPlot'

