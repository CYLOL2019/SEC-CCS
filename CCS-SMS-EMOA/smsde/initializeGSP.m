function [nVar rngMin rngMax isInt nObj algoCall] = initializeGSP()
nVar = 6;
rngMin = ones(1,nVar).*(-50);
rngMax = ones(1,nVar).*(50);
isInt = zeros(1,nVar);
nObj = 2;
algoCall = 'GSP';