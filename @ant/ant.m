function a = ant(world)
  % define variables
  
  a.Lhc_matrix = zeros(size(world.DistHC_matrix)); % same size as the equivalent Distance Matrix
  a.Lcs_matrix = zeros(size(world.DistCS_matrix)); % same size as the equivalent Distance Matrix

  % a vector with length equal to number of closures or splitters
  a.Used_cl = zeros(1,size(a.Lch_Matrix)(1)); 
##  a.Used_cl = zeros(1,world.closure_size);
  a.Used_sp = zeros(1,size(a.Lsc_Matrix)(1));
##  a.Used_cl = zeros(1,world.splitter_size);
  
%  a.solution =  vector/matrix containing  Lch_Matrix + Lsc_Matrix + Used_cl + Used_sp
  
endfunction
