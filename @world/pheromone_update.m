  % pheromone update

  function new_world=update(world,solution) %ant solution scalar structure
    %get solutions from each ant
    %Get: Lhc, Lsc and cost from each ant
    Initi_pher_HC = world.Pher_HC; %Pher_HC & CS will not always be zero
    Initi_pher_CS = world.Pher_CS;
    
    lhc_per_ant = solution.Lhc;
    ant_cost = solution.cost;
    lhc_pher_update = lhc_per_ant.*(1/ant_cost(a)); 
    
    lcs_per_ant = solution.Lcs;
    lcs_pher_update = lcs_per_ant.*(1/ant_cost(a)); 
    
    %update world
    
    
    
    %Takes in solution
    
    %Multiplies LHC and LCS by 1/cost
    
    %Add these to the current world PherH_C and _CS
    
    
    
    
        
##    Lhc_combo = ones((world.closure_no*world.elitism_num),world.home_no); %combined Lch from solutions structure
##       
##    % Homes and Closures
##    % For each iteration combine all the Lch matrices i.e. [Lch_ant1;Lch_ant2;Lch_ant3;...Lch_lastant]
##    % For each iteration combine all costs to form one array[cost_ant1;cost_ant2;....cost_lastant]
##    pher_all_ants = zeros(size(Lhc_combo));
##    sum_pheromones = zeros((world.Lch_matrix)); 
##    for a = 1:world.elitism_num %for each elite ant...
##      b=a-1;
##      lhc_per_ant = Lhc_combo((1+b*world.closure_no):(a*world.closure_no),:); % or pull for each each solution
##  ##  lhc_per_ant = solution.solutions{elite_list_index(a)}.Lhc;   %pull from each solution of each elite ant
##      ant_update = lhc_per_ant.*(1/ant_cost(a)); %matrix containing pheromone for each existing link
##      pher_all_ants((1+b*world.closure_no):(a*world.closure_no),:) = ant_update; %%not necessary
##      sum_pheromones = sum_pheromones + ant_update;
##    endfor
##    elite_ants_update = sum_pheromones
##    pher_evaporation = Initi_pher_HC.*(1-evapo_constant)
##    total_update = pher_evaporation + elite_ants_update
##    
    
  endfunction
