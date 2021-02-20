%Returns all Variables from world
% wrld is a structure that contains all variables in the world related to it
function wrld = get_vars(world)
  wrld.DistHC_matrix = world.DistHC_matrix;
  wrld.DistCS_matrix = world.DistCS_matrix; 
  wrld.Pher_HC = world.Pher_HC;
  wrld.Pher_CS = world.Pher_CS;
  wrld.home_no = world.home_no;
  wrld.closure_no = world.closure_no;
  wrld.splitter_no = world.splitter_no;
  
endfunction
