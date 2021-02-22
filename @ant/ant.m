function a = ant(world)
  #An ant simply represents a solution
  
  % define variables
  a.Lhc_matrix = zeros(size(get_vars(world).DistHC_matrix)); % same size as the equivalent Distance Matrix
  a.Lcs_matrix = zeros(size(get_vars(world).DistCS_matrix)); % same size as the equivalent Distance Matrix

  % a vector with length equal to number of closures or splitters
  a.Used_cl = zeros(1,size(a.Lhc_matrix)(2)); 
  a.Used_sp = zeros(1,size(a.Lcs_matrix)(2));
  
%  a.solution =  vector/matrix containing  Lch_Matrix + Lsc_Matrix + Used_cl + Used_sp
    a=class(a,"ant"); %an object of the class ant
endfunction
