function LCS2conn_list(solution)
##  solution
    LCS =solution.Lcs
    Used_cl=solution.Used_cl
    
    closure_conn2splitter = [];
    closure_id = [];
  
  for closures = 1:size(LCS)(1)
    closure_id (closures) = closures;
    if Used_cl(1,closures)==1  
      closure_conn2splitter(closures) = find(LCS'(:,closures));
    else
      closure_conn2splitter(closures) = 0;
    endif
  endfor
  
  closure_conn2splitter = closure_conn2splitter'
  
   %Creates a CSV file containing/showing home to closure connection/assignment
  CS_Headers = [222 333];
  csvwrite('CS_Connections.csv',CS_Headers);
  csvwrite('CS_Connections.csv',[closure_id',closure_conn2splitter],'-append');

endfunction