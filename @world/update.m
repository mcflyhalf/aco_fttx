function new_world = update(old_world, cost)
  new_world = old_world;
  new_world.x = new_world.x + cost;
  new_world.y = new_world.y -cost;
endfunction
