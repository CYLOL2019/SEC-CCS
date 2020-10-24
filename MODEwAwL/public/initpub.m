function initpub(varargin)
global params population PreAss K archive concentration;

    %Set up the initial setting for the MOEA/D
    %the initial population size.
    params.popsize      = 100;
    %init fitness evaluation
    params.fes  = 0;
    
    %handle the parameters, mainly about the popsize
    varargin = varargin{1};
    for k=1:2:length(varargin)
        name = varargin{k};
        value= varargin{k+1};
        switch name
            case 'problem'
                mop             = value;
            case 'popsize'
                params.popsize  = value;
            case 'niche'
                params.niche    = value;
            case 'method'
                params.dmethod  = value;
            case 'updatesize'
                params.updatesize= value;
            case 'pns'
                params.pns      = value;
            case 'F'
                params.F        = value;
            case 'CR'
                params.CR       = value;
            case 'etam'
                params.etam     = value;
            case 'pm'
                params.pm       = value;
        end
    end
    
    params.name     = mop.name;
    params.fdim     = mop.od;
    params.xdim     = mop.pd;
    % search domain
    params.xupp     = mop.domain(:,2);
    params.xlow     = mop.domain(:,1);
      
    % initialize the population
    temp_Selection          = zeros(mop.pd/2,params.popsize);
    temp                    = rand(mop.pd/2, params.popsize);
    temp(PreAss,:)          = 1;
    [~, I] = sort(temp,1,'descend');

    for i = 1 : params.popsize
        temp_Selection(I(1:K,i),i) = 1;       
    end
    temp_Weight             = rand(mop.pd/2, params.popsize);
    temp_parameter          = [temp_Selection;temp_Weight]; 
    
    population.parameter	= temp_parameter;
    population.Weight       = decode(population.parameter);



    
    population.objective	= evaluate(mop, population.Weight);
    params.fes = params.fes + params.popsize;
    %% Non-Dominated Sorting For Archive
   [archive.df,archive.ds] = nsga2_archive();
    %% Concentration Score    
    concentration = sum(archive.ds(1:params.xdim/2,:),2)./size(archive.ds,2);

    clear v temp temp_Selection temp_Weight temp_parameter;
end
