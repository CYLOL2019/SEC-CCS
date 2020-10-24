%%
function [mean_weight] = get_weight_from_nsga2(si)

global population params;


%% NSGA-II Parameters

nPop = params.popsize;        % Population Size

empty_individual.Position=[];
empty_individual.Cost=[];
empty_individual.Rank=[];
empty_individual.DominationSet=[];
empty_individual.DominatedCount=[];
empty_individual.CrowdingDistance=[];
nPop = length(si);

pop    = repmat(empty_individual,nPop,1);
for i=1:nPop
    
    pop(i).Position = population.parameter(:,si(i));
    pop(i).Cost = population.objective(:,si(i));

end        


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

temp_ds = [pop(1).Position,pop(2).Position];
mean_weight = mean(temp_ds(params.xdim/2+1:end,:),2);


        

clear pop ;
end

