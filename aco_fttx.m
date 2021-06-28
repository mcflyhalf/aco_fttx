%Some tests
clc;
clear;

  % Procedure for ACO

  %Relevant Variables 
  % num_ants, input_csv_file, top_n (elitism) others
  % Ensure that ants >= elite_ants >= alltime_best_num
  % The above is something that makes coding easy and fixing it is an unnecessary headache
    ants = 10; #10;   # Number of ants
    elite_ants = 5; # 5;
    alltime_best_num = 3;
    
      max_iterations = 10;
    evap = 0.5; %evaporation constant(ec) 0<ec<=1
    
    %Structures to store data to be plotted
    best_soln_per_iteration = cell(max_iterations,1);
    alltime_best_soln_per_iteration = cell(max_iterations,1);    
    
    % Data Inputs:
##    HC_DistMat = "templates\\HC_DistMat_template_short.csv";
##    CS_DistMat = "templates\\CS_DistMat_template_short.csv";

##    HC_DistMat = "templates\\HC_DistMat_Ridgeways_50h.csv";
##    CS_DistMat = "templates\\CS_DistMat_Ridgeways_50h.csv";

  % Create World
    fttx_world = world(HC_DistMat,CS_DistMat,ants,elite_ants,evap);
    
    %For each iteration:    
    for iter=1:max_iterations
      %Create ants
      %There is actually only 1 ant that finds #ants solutions
      %Candidate for multiprocessing!!!
       ant_agent = ant(fttx_world);
       printf("Ant %d coming online . . .\n\n", iter);
      
      %Structures to store multiple solutions
       solutions = cell(ants,1);
       elite_solutions = cell(elite_ants,1);
       
       all_costs = zeros(ants,1);

      %There is actually only 1 ant that finds #ants solutions
      %Candidate for multiprocessing!!!
       %Let the ant find #ant solutions
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
      
      %Perform pheromone evaporation
      fttx_world = evaporate_pher(fttx_world);
    
    
    best_soln_per_iter(iter) = elite_solutions{1,1};
    alltime_best_soln_per_iter(iter) = alltime_best_solutions{1,1}; 
    
    #End of iteration 
    endfor
    alltime_best_solutions;
    
%A few plots of importance
      
      %See how the cost and alltime best cost changes per iteration
      best_soln_cost_per_iter = zeros(size(best_soln_per_iter));
      alltime_best_soln_cost_per_iter = zeros(size(alltime_best_soln_per_iter));
      
      for i =1:max_iterations
        best_soln_cost_per_iter(i) = best_soln_per_iter(i).cost;
        alltime_best_soln_cost_per_iter(i) = alltime_best_soln_per_iter(i).cost;
      endfor
      
      plot(1:max_iterations, best_soln_cost_per_iter,'color','b',
           1:max_iterations, alltime_best_soln_cost_per_iter,'color','r');
    
##    An error sometimes appears in the next section. This usually happens when,
##    because of the choices that have been made prior, a particular home/closure
##    does not have a suitable closure/splitter to be connected to.
##    
##    An example of this would happen when a home may have 3 options of closures 
##    %to be connected to, however, 2 of them are too far off and the remiaing one
##    has no remaining capacity. The system can't flag this as it currently does
##    not check for viability of solutions.
##    Decided not to implement this as it will take too much time and we dont 
##    have much capacity.
##    
##    A first step to solving this would be to allocate homes to closures stochastically
##    i.e. do not always start by allocating home 1 then 2 then 3 etc. Shuffle the 
##    homes around and allocate them in different orders. This should make this 
##    problem less common (but it will still happen sometimes.
    LHC2conn_list(alltime_best_solutions{1,1}.Lhc)
    LCS2conn_list(alltime_best_solutions{1,1})
          
    return;
