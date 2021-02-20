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
  % Ensure that ants >= elite_ants >= alltime_best_num
  % The above is something that makes coding easy and fixing it is an unnecessary headache
    ants = 10; #10;   # Number of ants
    elite_ants = 5; # 5;
    alltime_best_num = 3;
    
    max_iterations = 15;
    evap = 0.5; %evaporation constant
    
    % Data Inputs:
    HC_DistMat = "HC_DistMat.csv";
    CS_DistMat = "CS_DistMat.csv";
    


  % Create World
    fttx_world = world(HC_DistMat,CS_DistMat,ants,elite_ants,evap);
    #return;
    
  %for max_iterations
      #iter = 1
    for iter=1:max_iterations
      %Create ants
       ant_agent = ant(fttx_world);
       printf("Ant %d coming online . . .\n\n", iter);
      
      %Let each ant find a solution
       solutions = cell(ants,1);
       elite_solutions = cell(elite_ants,1);
       all_costs = zeros(ants,1);
       for a = 1:ants
         ant_soln = solve(ant_agent,fttx_world); #This line only works if both ant_agent and fttx_world are objects of their respective classes!
         solution_cost = cost(ant_agent,fttx_world,ant_soln);
         solutions{a} = solution(ant_agent,ant_soln,solution_cost);
         all_costs(a) = solutions{a}.cost;
       endfor

      %Compare all ants' solutions and rank
      %Also pick top n ants, store in elite_list
      copy_list = all_costs;
      sort_list = sort(copy_list,"ascend");
      elite_costs = sort_list(1:elite_ants);
     
      ranked_solutions = sort_solutions(solutions);
      elite_solutions = ranked_solutions(1:elite_ants); 
      
      for e= 1:elite_ants    
        %Update pheromones using elite ants' solutions
        elite_soln = elite_solutions{e};
        fttx_world = update(fttx_world,elite_soln);   #Pheromone update, no evaporation
      endfor
      
      if (iter == 1)
        alltime_best_solutions = elite_solutions(1:alltime_best_num);
      else
        #concatenate alltime_best solns and elite solns
        #Then rank and take the top n to get your new alltime best
        tgs = size(elite_solutions)(1) + size(alltime_best_solutions)(1);   #Total number of good solutions to consider
        alltime_best_temp = cell(tgs,1);
        
        #Swap the next 2 lines (logically) for better performance
        #Because alltimebest is already sorted and is usually better than elite solns
        alltime_best_temp(1:size(elite_solutions)(1)) = elite_solutions;
        alltime_best_temp(size(elite_solutions)(1)+1:end) = alltime_best_solutions;
        alltime_best_temp = sort_solutions(alltime_best_temp);
        alltime_best_solutions = alltime_best_temp(1:alltime_best_num);
      endif
    endfor
    alltime_best_solutions
      
      
      return;
      
      %Pheromone Evaporation (Needs Work)
      #Initial_pheromone = get_vars(fttx_world)
      #pheromone_evaporation_hc = Initial_pheromone.Pher_HC *(1-evap)
      #pheromone_evaporation_cc = Initial_pheromone.Pher_CS *(1-evap)
      #Pheromone_update_lhc = pheromone_evaporation_hc + pheromone_ant_total_lhc
      #Pheromone_update_lcs = pheromone_evaporation_cs + pheromone_ant_total_lcs
      
      #fttx_world = set_vars(fttx_world,'Pher_HC',Pheromone_update_lhc, 'Pher_CS', Pheromone_update_lcs)
      
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