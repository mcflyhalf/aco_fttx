function LHC2conn_list(LHC)
 
  home_conn2closure = [];
  home_id =[];
  
  %Find closures that all homes are connected to
  %for each home in LHC
  for homes = 1:size(LHC)(1)
    %for each home find the closure to which the home is connceted (non-zero index)
    home_conn2closure(homes) = find(LHC'(:,homes));
    home_id(homes) = homes;
  endfor
  
  %Column vector containing closures assigned to each home
  home_conn2closure = home_conn2closure';
  
 %Creates a CSV file containing/showing home to closure connection/assignment
  
  HC_Headers = [111 222];
  csvwrite('HC_Connections.csv',HC_Headers);
  csvwrite('HC_Connections.csv',[home_id',home_conn2closure],'-append');
  
  
endfunction