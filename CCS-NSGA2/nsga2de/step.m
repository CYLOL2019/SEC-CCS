function step(mop)

path('NSGA2',path); 

path('../problem',path);
path('../public',path);
global params population;



   [population.objective,population.parameter] = nsga2(mop);


    params.fes     = params.fes + params.popsize;
  % disp(params.fes);
end
