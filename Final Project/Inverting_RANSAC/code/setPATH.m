function [pthHere,pthData] = setPATH()
pthHere = fileparts(mfilename('fullpath'));
addpath(pthHere)
addpath(fullfile(pthHere,'mex'))
addpath(fullfile(pthHere,'helpers'))
pthRoot = fileparts(pthHere);
pthData = fullfile(pthRoot,'data');
end
