function [nVar rngMin rngMax isInt nObj problemCall] = initpro(initProblemStr)
global NoA;
nVar = 2*NoA;
rngMin = zeros(1,2*NoA);
rngMax = ones(1,2*NoA);
isInt = zeros(1,2*NoA);
nObj = 2;
problemCall = @evaluate;
end