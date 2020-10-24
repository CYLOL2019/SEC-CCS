%%
function [objective,parameter] = nsga2(fun)
global population archive;
%% Problem Definition
%M = 3;
%CostFunction=@(x) MOP2(x);      % Cost Function

nVar = fun.D;             % Number of Decision Variables




%% NSGA-II Parameters

nPop = fun.NP;        % Population Size




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

%oldpop = repmat(empty_individual,

    % Merging
    pop=[pop];  



  
    

 %%Non-Dominated Sorting  

    % Non-Dominated Sorting
    [pop, F]=NonDominatedSorting(pop);

    % Calculate Crowding Distance
    pop=CalcCrowdingDistance(pop,F);

    % Sort Population
    [pop, F]=SortPopulation(pop);
    
    % Truncate

    %F1=pop(F{1});


for i=1 : length(F{1})
    parameter(:,i) = pop(i).Position;
    objective(:,i) = pop(i).Cost;

end

clear pop ;

%% Results
end

