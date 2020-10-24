function ypop=DE()  
%% Uniform DE
global params population PreAss K  Covariance u ;
ypop = zeros(params.xdim,params.popsize);
nVar = params.xdim;
for i=1:params.popsize
   selection_sign = randi(3);
    %new point generation using genetic operations, and evaluate it.t.
    switch (selection_sign)
        case 1
            ind     = de(population.parameter,i);

        case 2
            ind = population.parameter(:,i);
            ind = bsxfun(@power,ind, 1+rand);   
        case 3
            %Swap
            swap_sign = randi(4);
            ind = population.parameter(:,i);
            pretemp = ind(1:end/2);%set pre-assignment to 1
            pretemp(:,PreAss) = 1;
            [~, index] = sort(pretemp,'descend'); 
            while 1
              first = index(randi(K));
              if isempty(intersect(first, PreAss))
                  break;
              end
            end

        switch (swap_sign)
            case 1  
                swap        = randperm(K);
                first       = index(swap(1));
                I           = index(swap(2));
            case 2
                %Lowest risk
               [~, index]     = sort(diag(Covariance));
                I = index(1);
            case 3
            %Highest return
               [~, index]               = sort(u);
                I = index(1);
            case 4
               index             = setdiff(index(1:K), first);
               %Least covariance
               [~, index]          = sort(sum(Covariance(:,index),2));
                I = index(1);   
        end  
        %Selection of RK
           temp     = ind(first);
           ind(first) = ind(I);
           ind(I) = temp;
        %Allocation of RK   
           temp     = ind(first+nVar/2);
           ind(first+nVar/2) = ind(I+nVar/2);
           ind(I+nVar/2) = temp;
    end
    ypop(:,i) = ind;
end
clear subproblemindex ind obj neighbourhood swap temp seed I index i num first;
end

%%
function ind = de(parameter, index)
global params;
    %parents
    si      = ones(1,3)*index;
    while si(2)==si(1) || si(3)==si(1) || si(3)==si(2)
        si(2:3) = randsample(1:params.popsize, 2);
    end

    %retrieve the individuals.
    selectpoints    = parameter(:, si);


    %generate new trial point
    newpoint        = selectpoints(:,1)+params.F*(selectpoints(:,2)-selectpoints(:,3));

    %repair the new value
    rnds            = rand(params.xdim,1);
    pos             = newpoint>params.xupp(1:end);
    if sum(pos)>0
        newpoint(pos) = selectpoints(pos,1) + rnds(pos,1).*(params.xupp(pos)-selectpoints(pos,1));
    end
    pos             = newpoint<params.xlow(1:end);
    if sum(pos)>0
        newpoint(pos) = selectpoints(pos,1) - rnds(pos,1).*(selectpoints(pos,1)-params.xlow(pos));
    end
    % Crossover of DE
    rnbr = randi(params.xdim);
    index_CR = setdiff(find(rand(params.xdim,1)>params.CR),rnbr);
    newpoint(index_CR) = selectpoints(index_CR,1);
    % realmutate
    ind             = realmutate(newpoint, params.pm);

    clear si selectpoints newpoint pos;
end

%%
function ind = realmutate(ind, rate)
%REALMUTATE Summary of this function goes here
%   Detailed explanation goes here
global params;

    eta_m = params.etam;

    for j = 1:params.xdim
      r = rand();
      if (r <= rate) 
        y       = ind(j);
        yl      = params.xlow(j);
        yu      = params.xupp(j);
        delta1  = (y - yl) / (yu - yl);
        delta2  = (yu - y) / (yu - yl);

        rnd     = rand();
        mut_pow = 1.0 / (eta_m + 1.0);
        if (rnd <= 0.5) 
          xy    = 1.0 - delta1;
          val   = 2.0 * rnd + (1.0 - 2.0 * rnd) * (xy^(eta_m + 1.0));
          deltaq= (val^mut_pow) - 1.0;
        else 
          xy    = 1.0 - delta2;
          val   = 2.0 * (1.0 - rnd) + 2.0 * (rnd - 0.5) * (xy^ (eta_m + 1.0));
          deltaq= 1.0 - (val^mut_pow);
        end

        y   = y + deltaq * (yu - yl);
        if y < yl, y = yl; end
        if y > yu, y = yu; end

        ind(j) = y;        
      end
    end
end