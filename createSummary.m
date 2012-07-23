function createSummary(varNames)

% Robin Deits <robin.deits@gmail.com>
% August 2010

% Create the summary.txt file to be used by the optimizer to store its
% results.

folder = pwd;
filename = strcat(folder,filesep,'summary.txt');
fid = fopen(filename,'w');
fprintf(fid,'%s','Test number, Cost, [');
for i = 1:length(varNames)
    fprintf(fid,' %s',varNames{i});
end
fprintf(fid,'%s\r\n',']');
fclose(fid);