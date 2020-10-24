function initpub(varargin)

global params population;

    %Set up the initial setting for the MOEA/D
    %the initial population size.
    params.popsize      = 100;
    %the probability to search in neighborhood
    params.pns          = 0.9;
    %the parameter for mutation
    params.etam         = 20;
    %mutation probability
    params.pm           = 1/params.popsize;
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
    population.parameter	= rand(mop.pd, params.popsize);
    population.Weight       = decode(population.parameter);

    population.objective	= evaluate(mop, population.Weight);
    
    params.fes = params.fes + params.popsize;
    clear v;
end
