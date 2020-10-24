function [nVar rngMin rngMax isInt nObj problemCall] = initpro(initProblemStr)
global NoA;
nVar = NoA;
rngMin = zeros(1,NoA);
rngMax = ones(1,NoA);
isInt = zeros(1,NoA);
nObj = 2;
problemCall = @evaluate;
end