%Some tests
clc;
clear;

test_world = world('HC_DistMat.csv','CS_DistMat.csv',6,3) %create a new instance of world
world_vars = get_vars(test_world) %

test_ant = ant(test_world);
%cost(test_ant,test_world);

s = solve(test_ant, test_world);


%Uncomment after getting solve to work satisfactorily
tot_cost = cost(test_ant, test_world);



% Procedure for ACO


%Relevant Variables 
% num_ants, input_csv_file, top_n (elitism) others
% num_ants, input_csv_file, top_n (elitism) others



% Create World


%for max_iterations
    %Create ants



    %Let each ant find a solution



    %Compare all ants' solutions and rank
    %Also pick top n ants



    %Update pheromones



    %Save the top n ants



    %kill all ants
    
    
    
%endfor

%print top n solutions