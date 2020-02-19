% from the solution, determine Used_cl and Used_sp

function u=used_elements(solve)
  % checks Lch and Lsc matrices to dtermine whuch closures and splitters were used_elements
  % any() functions checks for non-zero elements in columns of a matrix; any(Matrix,2) checks for non-zero elements in rows
  %% Be sure to confirm whether to pick row or column
  u.Used_cl= any(solve.Lhc_Matrix,2)'  
  u.Used_sp= any(solve.Lcs_Matrix,2)'
endfunction

% How do I link these to the variables created in the ant class?
% I'm a bit lost as to how all these things work together
