%Some tests
clc;
clear;

##test_world = world('HC_DistMat.csv','CS_DistMat.csv',6,3) %create a new instance of world
##world_vars = get_vars(test_world) %
##
##test_ant = ant(test_world);
##%cost(test_ant,test_world);
##solutions = cell(6,1);
##for a=1:6
##  
##  s = solve(test_ant, test_world);
##
##
##  %Uncomment after getting solve to work satisfactorily
##  tot_cost = cost(test_ant,test_world,s);
##
##  solutions{a} = solution(test_ant,s,tot_cost);
##endfor 



  % Procedure for ACO


  %Relevant Variables 
  % num_ants, input_csv_file, top_n (elitism) others
  % num_ants, input_csv_file, top_n (elitism) others
    % Total Number of ants:
    ants = 10;
    elite_ants = 5;
    max_iterations = 3;
    evap = 0.5; %evaporation constant
    
    % Data Inputs:
    HC_DistMat = "HC_DistMat.csv";
    CS_DistMat = "CS_DistMat.csv";
    


  % Create World
    fttx_world = world(HC_DistMat,CS_DistMat,ants,elite_ants,evap);
    
  %for max_iterations
      %for i=1:max_iterations
      %Create ants
       ant_agent = ant(fttx_world);
      
      %Let each ant find a solution
       solutions = cell(ants,1);
       all_costs = zeros(ants,1);
       for a= 1:ants
         ant_solve = solve(ant_agent,fttx_world);
         solution_cost = cost(ant_agent,fttx_world,ant_solve);
         solutions{a} = solution(ant_agent,ant_solve,solution_cost);
         all_costs(a) = solutions{a}.cost;
       endfor
      %Compare all ants' solutions and rank
      %Also pick top n ants
      copy_list = all_costs;
      sort_list = sort(copy_list,"ascend");
      elite_list = sort_list(1:elite_ants); 
      
      %find index of elite ants from the array
      elite_list_index = zeros(elite_ants,1);
      for e= 1:elite_ants
        elite_index = find(copy_list==elite_list(e));
        elite_list_index(e) = elite_index; %%is problematic when more than 1 ant provides a similiar solution
        %form Lhc and Lcs combo?   
      endfor
      
      
      
##        
##      
##      %Update pheromones
##      % Determine which ants are linked to the least costs and from them:
##      % Get: DistHC, DistSC, Lhc, Lsc and cost from each ant
##      
##     ###################### Use of set_vars to update pheromones#############
##      %Example of changing Pher_CS and Pher_HC
##      new_Pher_HC = eye(4)
##      new_Pher_CS = eye(6)
##      fttx_world = set_vars(fttx_world,'Pher_HC',4*new_Pher_HC, 'Pher_CS', new_Pher_CS)
##      %test
##      get_vars(fttx_world)
##     #######################################################################
##
##      %Save the top n ants from each iteration
##      % 



      %kill all ants
      
      
      
  %endfor

  %print top n solutions