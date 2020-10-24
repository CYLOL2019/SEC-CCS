%%
function [objective,parameter] = nsga2(new_ds,new_df)
global population params;
%% NSGA-II Parameters

nPop = params.popsize;        % Population Size
parameter = zeros(params.xdim,params.popsize);
objective = zeros(params.fdim,params.popsize);
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

newpop = repmat(empty_individual,nPop,1);
for i=1:nPop    
    newpop(i).Position = new_ds(:,i);
    newpop(i).Cost = new_df(:,i);
end

% Merging
pop=[pop, newpop];  
%%Non-Dominated Sorting  

% Non-Dominated Sorting
[pop, F]=NonDominatedSorting(pop);

% Calculate Crowding Distance
pop=CalcCrowdingDistance(pop,F);

% Sort Population
[pop, F]=SortPopulation(pop);
for i=1 : nPop
    parameter(:,i) = pop(i).Position;
    objective(:,i) = pop(i).Cost;
end

        


clear pop ;
end

