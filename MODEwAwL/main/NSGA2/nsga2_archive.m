%%
function [objective,parameter] = nsga2_archive()
global population archive params;
%% NSGA-II Parameters

nPop = params.popsize;        % Population Size
% parameter = zeros(params.xdim,params.popsize);
% objective = zeros(params.fdim,params.popsize);
%% Initialization

empty_individual.Position=[];
empty_individual.Cost=[];
empty_individual.Rank=[];
empty_individual.DominationSet=[];
empty_individual.DominatedCount=[];
empty_individual.CrowdingDistance=[];

pop    = repmat(empty_individual,nPop,1);

for i=1:nPop
    
    pop(i).Position = population.parameter(:,i);
    pop(i).Cost = population.objective(:,i);

end

if isempty(archive)
    pop_Archive = [];
else
    nArchive = size(archive.ds,2);
    pop_Archive = repmat(empty_individual,nArchive,1);
    for i = 1 : nArchive
        pop_Archive(i).Position = population.parameter(:,i);
        pop_Archive(i).Cost = population.objective(:,i);
    end
end

    pop=[pop;pop_Archive];  
 %%Non-Dominated Sorting  

    % Non-Dominated Sorting
    [pop, F]=NonDominatedSorting(pop);

    % Calculate Crowding Distance
    pop=CalcCrowdingDistance(pop,F);

    % Sort Population
    [pop, F]=SortPopulation(pop);
    
    % Truncate
if size(F{1},2)>nPop
    F{1}=[1:nPop];
end

for i=1 : length(F{1})
    parameter(:,i) = pop(i).Position;
    objective(:,i) = pop(i).Cost;
end

clear pop ;
end




