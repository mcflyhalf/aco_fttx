function c= cost(ant,wld,solution)
  %after obtaining the Lch, Lsc, Used_cl and sp matrices, determine cost of solution
  %Prior inputs - cost of equipment and cables
  world = get_vars(wld);
    
  %Costs should be pulled from world
  Cost_per_cl = 100;
  Cost_per_sp = 200;
  Drop_cable_cost = 10;
  Distr_cable_cost = 20;

  
  c.closure_cost = sum(sum(solution.Used_cl),2)*Cost_per_cl; 
  c.splitter_cost = sum(sum(solution.Used_sp),2)*Cost_per_sp; % finds total number of used splitters using sum() then computes cost
  #sum(sum(M)) Finds the sum of all elements in M where M is a 2 dimensional matrix 
  c.dropc_cost = sum(sum(world.DistHC_matrix .* solution.Lhc * Drop_cable_cost));
  c.distric_cost = sum(sum(world.DistCS_matrix .* solution.Lcs * Distr_cable_cost));
##  c.feederc_cost = (world.DistSE_matrix'(:)')*(used_elements.Used_sp'(:))*feeder_cable_cost; % This is not how the feeder cost is computed, this might not be necessary for the solution
  c.total_cost = c.closure_cost+c.splitter_cost+c.dropc_cost+c.distric_cost; %+c.feederc_cost
  
endfunction
