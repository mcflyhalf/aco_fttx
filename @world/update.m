function new_world = update(old_world, soln)
  new_world = old_world;
  # A constant that makes pheremone increaments large for humans to see
  #Not set using any particular criteria. Can probably be changed with little effect  
  pic = 10000;
  
  new_world.Pher_HC = ((1/soln.cost)* pic * soln.Lhc) .+ new_world.Pher_HC;
  new_world.Pher_CS = ((1/soln.cost)* pic * soln.Lcs) .+ new_world.Pher_CS; 
  
endfunction
