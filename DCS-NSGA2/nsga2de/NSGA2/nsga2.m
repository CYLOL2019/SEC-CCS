%%
function [objective,parameter] = nsga2(mop)
global  params population;
%% Problem Definition
nVar = params.xdim;             % Number of Decision Variables
parameter = zeros(params.xdim,params.popsize);
objective = zeros(params.fdim,params.popsize);
%% NSGA-II Parameters
nPop = params.popsize;        % Population Size
%% Initialization

empty_individual.Position=[];
empty_individual.Cost=[];
empty_individual.Rank=[];
empty_individual.DominationSet=[];
empty_individual.DominatedCount=[];
empty_individual.CrowdingDistance=[];







pop=repmat(empty_individual,nPop,1);

for i=1:nPop
    
    pop(i).Position = population.parameter(:,i);
    pop(i).Cost = population.objective(:,i);

end
   


  
    %% DE
    xpop = DE();
    Weight = decode(xpop);%decode

%% NSGA-II Main Loop 
    popde=repmat(empty_individual,nPop,1);
for i=1:nPop
    
    popde(i).Position = xpop(:, i);
    popde(i).Cost = evaluate(mop, (Weight(:,i)));

end

  
    

   
   %% Merge
    pop=[pop
         popde]; %#ok
 clear popde ;
    % Non-Dominated Sorting
    [pop, F]=NonDominatedSorting(pop);

    % Calculate Crowding Distance
    pop=CalcCrowdingDistance(pop,F);

    % Sort Population
    [pop, F]=SortPopulation(pop);
    
    % Truncate
    pop=pop(1:nPop);
    

for i=1 : nPop
    parameter(:,i) = pop(i).Position;
    objective(:,i) = pop(i).Cost;

end

clear pop ;

%% Results
end

