function cost = simExample(assignments,varargin)

% Robin Deits <robin.deits@gmail.com>
% August 2010

% This is a sample simulation function to be used with the modified Matlab
% GA optimization program. Any values in it which are not to be set to
% their defaults are passed in as a string of Matlab variable assignments,
% separated by commas. varargin allows the simulation to take in any
% additional parameters that it might need.

% Example of use:
% To run the simulation with all its parameters at their default values:
% >> simExample()
% To run the simulation with the variable 'a' set to 10:
% >> simExample('a = 10,')
% To run the simulation with the variables 'a', 'b', and 'c' set to 10:
% >> simExample('a=10,b=10,c=10,')

% Check the inputs
if nargin == 0
    assignments = '';
elseif nargin > 1
    % This is where we can pass extra parameters to the simulation.
    varargin{1}
end

%% First set all variables to their default values:
a = 1;
b = 2;
c = 3;
d = 4;

%% The evaluate the assignments string to change any variables that are not
% to be at their default values. The eval(myString) function causes Matlab to treat
% myString as a Matlab command, so if we have myString = 'a = 10,', then
% running the eval() command will set the variable 'a' to 10, thus
% overriding the default value of 1 set earlier in the file.
eval(assignments)

%% If there are values which depend on the other values (and which thus
% cannot be independently varied by the GA), we set them here, after the
% assignments string has been evaluated. This makes sure that the current,
% rather than default, values of each variable are used.

% A sample dependent variable
sampleDependentVariable = a+c+d;

%% Now we calculate the cost

% A sample cost function
cost = rastriginsfcn([sampleDependentVariable,b]);

