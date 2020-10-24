function step(mop)

global params population PreAss K archive concentration u Covariance;
%%Algorithm Framework
new_ds = zeros(params.xdim,params.popsize);
new_df = zeros(params.fdim,params.popsize);
new_Weight = zeros(params.xdim/2,params.popsize);
for i = 1:params.popsize
%% Selection of Assets
    selection_sign = randi(4);
    index = zeros(K,1);
    switch (selection_sign)
        %roulette wheel selection
        case 1
           index                  = Roulette(K,PreAss,concentration);
          
        %selected by concentration
        case 2
           [~, index]                 = sort(concentration,'descend');
          
           if ~ismember(PreAss,index(1:K))              
               index(K) = PreAss;
           end
            index = index(1:K);
        %%selected by expected return
        case 3
            [~, index]                = sort(u,'descend');
            if ~ismember(PreAss,index(1:K))
                index(K) = PreAss;
            end
            index = index(1:K);
            
        %selected random & hybrid method
        case 4
            [~, index]                 = sort(concentration,'descend');
           n = randi(K-length(PreAss));
            if ~ismember(PreAss,index(1:n+length(PreAss)))
               index(n+length(PreAss)) = PreAss;
            end
           selected = index(1:n+length(PreAss));
           
            S4_sign   = randi(3);
           temp_risk = diag(Covariance);
               switch (S4_sign)
                    %lowest risk
                   case 1
                       [~, index]                  = sort(temp_risk,'ascend');
                       temp = setdiff(index,selected,'stable');
                       index = [selected;temp(1:K-n-length(PreAss))];

               %highest return value
                   case 2
                       [~, index]                = sort(u,'descend');
                       temp = setdiff(index,selected,'stable');
                       index = [selected;temp(1:K-n-length(PreAss))];

                   case 3
               %lowest correlation risk
                       temp_risk= sum(Covariance(:,index(1:length(PreAss)+n)),2);
                       [~, index]                = sort(temp_risk,'ascend');
                       temp = setdiff(index,selected,'stable');
                       index = [selected;temp(1:K-n-length(PreAss))];
                       otherwise 
                        error('Undefined S4 scheme'); 
               end
    end     
    new_ds(index,i) = 1;
%% Allocation of Assets
    %parents
    si      = ones(3,1);
    while si(2)==si(1) || si(3)==si(1) || si(3)==si(2)
        si(1:3) = randsample(1:params.popsize, 3);
    end
    allocate_sign   =  randi(3);
    selectpoints = population.parameter(params.xdim/2+1:end,si);
    switch (allocate_sign)
        case 1
            newpoint = selectpoints(:,1) + rand()*(selectpoints(:,2)-selectpoints(:,3));
        case 2
            %F=0.3
            newpoint = selectpoints(:,1) + params.F*(selectpoints(:,2)-selectpoints(:,3));
        case 3
            %rank p1, p2 and p3 by dominance and crowding distance measure 
            %directing away from p3 and towards the middle between p1 and p2
            newpoint = get_weight_from_nsga2(si);
    end
    %repair the new value
    rnds            = rand(params.xdim,1);
    pos             = newpoint>params.xupp(1:end/2);
    if sum(pos)>0
        newpoint(pos) = selectpoints(pos,1) + rnds(pos,1).*(params.xupp(pos)-selectpoints(pos,1));
    end
    pos             = newpoint<params.xlow(1:end/2);
    if sum(pos)>0
        newpoint(pos) = selectpoints(pos,1) - rnds(pos,1).*(selectpoints(pos,1)-params.xlow(pos));
    end
    % Crossover of DE
    rnbr = randi(params.xdim/2);
    index_CR = setdiff(find(rand(params.xdim/2,1)>params.CR),rnbr);
    newpoint(index_CR) = selectpoints(index_CR,1);
    
    new_ds(params.xdim/2+1:end,i) = newpoint;

end

%relaxed boundary
new_Weight       = decode(new_ds);
new_df	        = evaluate(mop, new_Weight);
params.fes  = params.fes + params.popsize;
   %% Selection by Non-Dominated Sorting
   [population.objective, population.parameter] = nsga2(new_ds, new_df);
   [archive.df,archive.ds] = nsga2_archive();
 %% Get concentration score  
    concentration = sum(archive.ds(1:params.xdim/2,:),2)./size(archive.ds,2);
end