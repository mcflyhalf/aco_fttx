 % pheromone evaporation

function new_world = evaporate_pher(old_world)
  new_world = old_world;
  # A constant that makes pheremone increaments large for humans to see
  #Not set using any particular criteria. Can probably be changed with little effect  
  pic = 10000;
  
  new_world.Pher_HC = new_world.Pher_HC * (1-new_world.evap);
  new_world.Pher_CS = new_world.Pher_CS * (1-new_world.evap); 
  
endfunction