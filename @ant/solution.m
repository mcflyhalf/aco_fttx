% Solution: a structured solution that contains Link matrices, Used_equipment vectors and the cost 

function n = solution(ant,soln,cost)
  
    n.Lhc = soln.Lhc;
    n.Lcs = soln.Lcs;
    n.Used_cl = soln.Used_cl;
    n.Used_sp = soln.Used_sp;
    n.cost = cost.total_cost;
endfunction
