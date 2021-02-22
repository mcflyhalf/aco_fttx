function w = world(HC_csv_file, CS_csv_file, num_ants, elitism_num,evap)
##  HC_csv_file = 'HC_DistMat.csv'
##  CS_csv_file = 'CS_DistMat.csv'
   
  %Read Distance values from the csv files; Output - A list of distances betweeen each home/closure/splitter/Exchange
  HC_vector_Array= csvread(HC_csv_file,1,2); % 1;skip headerline, 2;Only pick values in 3rd column (index 2)
  CS_vector_Array= csvread(CS_csv_file,1,2); 
##  SE_vector_Array= csvread(SE_csv_file,1,2);
  
  % Determine index_size/number of homes, closures and splitters
  % Note that in the csv file, the last row must be the distance between the last HC/SC
  % Otherwise this section raises an error
  %e.g. with 12 homes, 6 Closure locations and 4 splitter locations, th last rows should be:
  % HC => [H12 C6] CS => [S4 C6]
  [hid,cid,d] =textread(HC_csv_file,"%s,%s,%f" ,"headerlines",1,"delimiter", ",");
  [sid,ciid,d] =textread(CS_csv_file,"%s,%s,%f" ,"headerlines",1,"delimiter", ",");
  last_h= hid(end);
  last_c= cid(end);
  last_c2= ciid(end);
  last_s= sid(end);
  w.home_no= sscanf(last_h{},'H%d%d%d%d');
  w.closure_no= sscanf(last_c{},'C%d%d%d%d');
  closure_no_check= sscanf(last_c2{},'C%d%d%d%d');
  w.splitter_no= sscanf(last_s{},'S%d%d%d%d');

  %Quirky difference btn the next 2 lines caused by different presentation in
  % the CS and HC Dist mat csv files
  %For CS, S comes before C and HC, H comes before C. This needs to be fixed 
  %eventually for consistency
  w.DistHC_matrix = (reshape(HC_vector_Array,w.closure_no,w.home_no))';
  w.DistCS_matrix = (reshape(CS_vector_Array,w.closure_no,w.splitter_no));
##  DistSE_matrix = SE_vector_Array;
  
  % Initial pheromone values. Eventually should be pulled from the update function
  w.Pher_HC = ones(w.home_no, w.closure_no); % Initial pheromone values
  w.Pher_CS = ones(w.closure_no, w.splitter_no); % Initial pheromone values

  w=class(w,"world"); %an object of the class world
endfunction
