function sorted_solutions = sort_solutions(unsorted_solns)
  sorted_solutions = cell(size(unsorted_solns));
  unsorted_costs = ones(size(unsorted_solns),1);
  
  for s=1:size(unsorted_solns)(1)
    unsorted_costs(s) = unsorted_solns{s}.cost;
  endfor
  
  sorted_costs = sort(unsorted_costs, "ascend");
  
  for i = 1:size(sorted_costs)(1)
    unsorted_idx = find(unsorted_costs == sorted_costs(i));
    sorted_solutions{i} = unsorted_solns{unsorted_idx};
  endfor

endfunction