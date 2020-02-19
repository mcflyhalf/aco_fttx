##fid = fopen("HC_DistMat.csv")
##HC_vector_Array= textscan(fid,"%s,%s,%f" ,"headerlines",2,"delimiter", ",")
##
function w = world(HC_csv_file, CS_csv_file, SE_scv_file, num_ants, elitism_num)

  %Read Distance values from the csv files; Output - A list of distances betweeen each home/closure/splitter/Exchange
  HC_vector_Array= csvread(HC_csv_file,1,3); 
  CS_vector_Array= csvread(CS_csv_file,1,3); 
  SE_vector_Array= csvread(SE_csv_file,1,3);
  
% ??? get home, closre, splitter sizes from list

  DistHC_matrix = (reshape(HC_vector_Array,home_size,closure_size))';
  DistCS_matrix = (reshape(CS_vector_Array,closure_size,splitter_size))';
  DistSE_matrix = SE_vector_Array;
  
  Pher_HC = ones(home_size,closure_size);
  Pher_CS = ones(closure_size,splitter_size);

  w=class(w,"world");
endfunction
