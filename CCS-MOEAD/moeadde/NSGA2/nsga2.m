%%
function [objective,parameter] = nsga2()
%fun = 1 and si = 0: sorting for archive
%fun = 1 and si = 1: sorting for population
%fun = 2 : Ranking in Allocation
global population archive params non_dominated_size;

%% Problem Definition
%M = 3;
%CostFunction=@(x) MOP2(x);      % Cost Function

%nVar = params.xidm;             % Number of Decision Variables




%% NSGA-II Parameters

nPop = params.popsize;        % Population Size




%if params.fes == 0    
%% initialize the probability vector

%xpop      = (rand(nPop,nVar))';


%end

%if params.fes ~= 0
    
%% sample initial population

%xpop      = population.parameter';

%end
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



pop_Archive = repmat(empty_individual,nPop,1);

for i = 1 : nPop
    pop_Archive(i).Position = archive.ds(:,i);
    pop_Archive(i).Cost = archive.df(:,i);
end


%oldpop = repmat(empty_individual,

    % Merging
    pop=[pop pop_Archive];  
 %%Non-Dominated Sorting  

    % Non-Dominated Sorting
    [pop, F]=NonDominatedSorting(pop);

    % Calculate Crowding Distance
    pop=CalcCrowdingDistance(pop,F);

    % Sort Population
    [pop, F]=SortPopulation(pop);
    
    % Truncate

    %F1=pop(F{1});
% if size(F{1}, 2)>nPop
%     F{1}=[1:nPop];
% end
non_dominated_size = length(F{1});
for i=1 : nPop
    parameter(:,i) = pop(i).Position;
    objective(:,i) = pop(i).Cost;
end
end

