function backupMFiles(targetFile)

% Robin Deits <robin.deits@gmail.com>
% August 2010

% This function backs up all the Matlab files in the same directory as a
% given target file to a directory within the current working directory. 
% Though this uses up some extra space, it means that we can easily and
% accurately reconstruct the process and results of a current test at a
% later date.
% This assumes that all the MATLAB files in use are stored in the same
% folder as this file.
folder = fileparts(which(targetFile));
mkdir('matlab_backup')
copyfile(strcat(folder,filesep,'*.m'),strcat(pwd,filesep,'matlab_backup'));
