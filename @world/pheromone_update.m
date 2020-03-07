  % pheromone update

  function pher_update(world,solution) %solutions structure
    %get solutions from each ant
    %Get: Lhc, Lsc and cost from each ant
    Initi_phero_HC = world.Pher_HC; %Pher_HC & CS will not always be zero
    Initi_phero_CS = world.Pher_CS;
    Lhc_combo = ones((world.closure_no*world.elitism_num),world.home_no); %combined Lch from solutions structure
    evapo_constant = world.evap    
    % Homes and Closures
    % For each iteration combine all the Lch matrices i.e. [Lch_ant1;Lch_ant2;Lch_ant3;...Lch_lastant]
    % For each iteration combine ll costs to form one array[cost_ant1;cost_ant2;....cost_lastant]
    pher_all_ants = zeros(size(Lhc_combo));
    sum_pheromones = zeros((world.Lch_matrix)); 
    for a = 1:world.elitism_num %for each elite ant...
      b=a-1;
      lhc_per_ant = Lhc_combo((1+b*world.closure_no):(a*world.closure_no),:); % or pull for each each solution
  ##  lhc_per_ant = solution.solutions{elite_list_index(a)}.Lhc;   %pull from each solution of each elite ant
      ant_update = lhc_per_ant.*(1/ant_cost(a)); %matrix containing pheromone for each existing link
      pher_all_ants((1+b*world.closure_no):(a*world.closure_no),:) = ant_update; %%not necessary
      sum_pheromones = sum_pheromones + ant_update;
    endfor
    elite_ants_update = sum_pheromones
    pher_evaporation = Initi_phero_HC.*(1-evapo_constant)
    total_update = pher_evaporation + elite_ants_update
    
  endfunction

  
  
  
##  clear;
##  clc; 
##  a=[1 0 0;0 0 1;0 1 0];
##  b=[0 0 1;1 1 0;0 0 0];
##  c=[1 1 1;0 0 0;0 0 0];
##  d=[0 1 0;0 0 0;1 0 1];
##  e=[1 0 1;0 1 0;0 0 0];
##  h=[a;b;c;d;e]
##  pher = zeros(3,3)
##  i_pher = ones(3,3)
##  cl=3
##  cost=[50;40;60;20;30]
##  pher_all = zeros(size(h))
##  sum_ants = pher
##  
##  for i=1:5
##    j=i-1
##    per_ant = h((1+j*cl):(i*cl),:).*(1/cost(i))
##    pher_all((1+j*cl):(i*cl),:)= per_ant
##    sum_ants = sum_ants.+per_ant
##  endfor
##  evapo = i_pher.*(1-0.5)
##  total = evapo + sum_ants
##
##
