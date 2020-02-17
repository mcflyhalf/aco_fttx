function w = world(csv_filename, csv_filename2, num_ants, elitism_num)

  num_ants = 10;
  elitism_num = 5;
  csv_filename = "HC_DistMat.csv";
  csv_filename2 = "CS_DistMat.csv";

  %Read Distance values from the csv files
  HC_vector_Array= csvread('HC_DistMat.csv',1,5);  
  CS_vector_Array= csvread('CS_DistMat.csv',1,5);  

  % Find a way of determining size of homes, closures and splitters
  % Homes=7 Closures=3 Splitters=3

  DistHC_matrix = (reshape(HC_vector_Array,7,3))';
  DistCS_matrix = (reshape(CS_vector_Array,3,3))';
  
  Pher_HC = ones(7,3);
  Pher_CS = ones(3,3);


  w.file = csv_filename;
  w.x = num_ants;
  w.y = elitism_num;
  w=class(w,"world");
endfunction
