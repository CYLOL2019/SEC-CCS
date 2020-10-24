function str = get_structure( name )
%STRUCTURE Summary of this function goes here
% 
% Structure used in this toolbox.
% 
% individual structure:
% parameter: the parameter space point of the individual. it's a column-wise
% vector.
% objective: the objective space point of the individual. it's column-wise
% vector. It only have value after evaluate function is called upon the
% individual.
% estimation: Also a structure array of the individual. It's not used in
% MOEA/D but used in MOEA/D/GP. For every objective, the field contains the
% estimation from the GP model. 
% 
%
% subproblem structure:
% weight: the decomposition weight for the subproblem.
% optimal: the current optimal value of the current structure.
% curpoiont: the current individual of the subproblem.
% optpoint: the point that gain the optimal on the subproblem.
%
% testmop structure:
% name: the name of the test problem.
% od: the number of objective.
% pd: the number of variable.
% domain: the domain, which is a pd*2 matrix, with domain(:,1) and
% domain(:,2) to specificy the lower and upper limit on every variable.
%
%

switch name
    case 'individual' 
        str = struct('parameter',[],'objective',[]);
    case 'subproblem' 
        str = struct('weight',[],'weights',[],'curpoint',[], 'neighbour', [], 'neighdis', [], 'state', []);          
    case 'testmop'
        str = struct('name',[],'od',[],'pd',[],'domain',[],'func',[]);      
    otherwise    
	    error('the structure name requried does not exist!');
end
        