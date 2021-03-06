function obj = subobjective(weight, ind, idealpoint, method)
%SUBOBJECTIVE function evaluate a point's objective with a given method of
%decomposition. 

%   Two method are implemented by far is Weighted-Sum and Tchebesheff.
%   weight: is the decomposition weight.(column wise vector).
%   ind: is the individual point(column wise vector).
%   idealpoint: the idealpoint for Tchebesheff decomposition.
%   method: is the decomposition method, the default is 'te' when is
%   omitted.
%   
%   weight and ind can also be matrix. in which have two scenairos:
%   When weight is a matrix, then it's treated as a column wise set of
%   weights. in that case, if ind is a size 1 column vector, then the
%   subobjective is computed with every weight and the ind; if ind is also
%   a matrix of the same size as weight, then the subobjective is computed
%   in a column-to-column, with each column of weight computed against the
%   corresponding column of ind. 
%   A row vector of subobjective is return in both case.

    if (nargin==2)
        obj = ws(weight, ind);
    elseif (nargin==3)
        obj = te(weight, ind, idealpoint);
    else
        if strcmp(method, 'ws')
            obj = ws(weight, ind);
        elseif strcmp(method, 'te')
            obj = te(weight, ind, idealpoint);
        else
            obj = te(weight, ind, idealpoint);
        end
    end
end

function obj = ws(weight, ind)
    obj     = (weight'*ind)';
end

function obj = te(weight, ind, idealpoint)
    [~, s]  = size(weight);
    indsize = size(ind,2);
    
    weight((weight == 0))=1.0E-10;
        
    if indsize==s 
        part2   = abs(ind-idealpoint(:,ones(1, indsize)));
        obj     = max(weight.*part2);
        return;
    end
    
    if indsize ==1 && s > 1
        part2   = abs(ind-idealpoint);
        obj     = max(weight.*part2(:,ones(1, s)));
        return
    end
    
    if indsize > 1 && s == 1
        part2   = abs(ind-idealpoint(:,ones(1, indsize)));
        obj     = max(weight(:,ones(1, indsize)).*part2);
        return;
    end
    
    error('individual size must be same as weight size, or equals 1');
    
    clear s indsize part2;
end