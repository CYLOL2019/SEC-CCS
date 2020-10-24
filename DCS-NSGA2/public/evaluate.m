function objs = evaluate( prob, xs)

objs = [];

for i=1:size(xs,2)
    v   = evaluate_ind( prob, xs(:,i));
    objs= [objs, v];
 
end

end

%%
function v = evaluate_ind( prob, x )
%EVALUATE function evaluate an individual structure of a vector point with
%the given multiobjective problem.

%   Detailed explanation goes here
%   prob: is the multiobjective problem.
%   x: is a vector point, or a individual structure.
%   v: is the result objectives evaluated by the mop.
%   x: if x is a individual structure, then x's objective field is modified
%   with the evaluated value and pass back.

%   TODO, need to refine it to operate on a vector of points.
    if isstruct(x)
        v           = prob.func(x.parameter);
    else
        v           = prob.func(x);
    end

end
    