function cost = fminParser(x,varargin)

% Robin Deits <robin.deits@gmail.com>
% August 2010

% This function properly unwraps the varargin produced by fminsearchbnd,
% which doesn't follow the convention that the GA uses.

cost = costFunction(x,varargin{1}{1},varargin{1}{2});