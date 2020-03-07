function c= cost(ant,wld)
    %after obtaining the Lch, Lsc, Used_cl and sp matrices, determine cost of solution
  %Prior inputs - cost of equipment and cables
  world = get_vars(wld)
    
  %Costs should be pulled from world
  Cost_per_cl = 100
  Cost_per_sp = 200
  Drop_cable_cost = 10
  Distr_cable_cost = 20
  Used = ant.Used_cl
  Used = solve.Used_cl
  
  c.closure_cost = sum(sum(solve.Used_cl),2)*Cost_per_cl; %should it be ant.Used_cl or used_elements.Used.cl???
  c.splitter_cost = sum(sum(solve.Used_sp),2)*Cost_per_sp; % finds total number of used splitters using sum() then computes cost
  c.dropc_cost = (world.DistHC_matrix'(:)')*(solve.Lhc'(:))*Drop_cable_cost;
  c.distributionc_cost = (world.DistCS_matrix'(:)')*(solve.Lcs'(:))*Distr_cable_cost;
##  c.feederc_cost = (world.DistSE_matrix'(:)')*(used_elements.Used_sp'(:))*feeder_cable_cost; % This is not how the feeder cost is computed, this might not be necessary for the solution
  c.total_cost = c.closure_cost+c.splitter_cost+c.dropc_cost+c.distributionc_cost %+c.feederc_cost
  
endfunction
