%%% Methodology of getting the solution to the Lhc and Lcs? 
% Given parameters of a world, determine the Links between the homes and closures and splitters
% Apply cosntraints to find viable options using the Dist Matrices (update pheromone_matrix accordingly)

% Compute proabilities to determine links but consider constraints such as;
% Constraint 1 (Lhc and Lcs): If Distance within matrix is greater than X, replace corresponding pheromone_mat element with zero (before selection)
% Constraint 2 (Lhc and Lcs): A closure can only be linked to a maximum number of homes (update pheromone_ after a selection)
% Constraint 3 (Lsc): All homes must be linked to a closure and if a closure is linked to a home it has to be linked to a splitter (generate used_cl)



function s = solve(ant,wld) % wld needs to be an instance of world
#function s = solve(ant,world) % wld needs to be an instance of world
  %Given distance matrix and pheromone matrix, update pheromone matrix <- Doesnt make sense. Needs to be in update fxn??
  world = get_vars(wld); %use getvars function to access the variables in the world class
   % Links Between Homes and Closures and Splitters:
  Lhc = ant.Lhc_matrix; %zeros(homes by closures)
  Lcs = ant.Lcs_matrix; % zeros(closures by splitters)
  MaxLinks_CH = 4; % should be pulled from world
  MaxLinks_SC = 3; % should be pulled from world
  MaxDistance_HC = 400; % should be pulled from world
  MaxDistance_CS = 500; % should be pulled from world
  
  
  % Universal Constraints: Max Distance 
  % if an element in the Dist_Mat is greater than a certain value, then equivalent elements in phermone_mat will be equal to zero
  % Viability Matrices (only checks for max distance constraints):
  Viability_HC = world.DistHC_matrix < MaxDistance_HC;
  Viability_CS = world.DistCS_matrix < MaxDistance_CS;
  
  %%% TODO: have a check so that there is at least one option for each home or consider what to do if a home is placed too far from all closures
  
  %Set pheromones for unviable links to 0 permanently 
  %(Currently doing this each time a solution is sought)
  % TODO In future, do it only once during initialisation
  Pheromone_HC = Viability_HC.*world.Pher_HC;
  Pheromone_CS = Viability_CS.*world.Pher_CS;
  
  % Step 1; Check if a home has been linked to a closure, if not, select:
  % Loop through the Lhc_matrix columns(homes), if all values in a column are non-zero elements, select the column index(home_number) 
  % Step 2; Find a closure (with remaining capacity) to link the slected home to:
  % Use Probability Function to select the closure to link the selected home to (Pheromone_value/sum(Pheromone_values))
         
 % Trial 2: With pheromone matrices: stochastic
 %TODO: Select homes at random and not sequentially each time
 printf("Connecting homes to closures . . .\n")
   for h = 1:world.home_no % for each home, starting with home 1
     printf("Finding solution for home %d \n",h)
     select_home = sum(Lhc,2)'; % check if a link exists between the home and any closures
     #display(sum(Lhc,2));  Delete this line
     if select_home (h) == 0; % if no link exists between the home and closures
       #display(Lhc);
       closure_links = sum(Lhc); % returns number of homes linked to each closure in an array(1*closures)
       #display(sum(Lhc)); Delete this line
       available_closures = closure_links < MaxLinks_CH; % returns 0/1 values indicating the availability of each closure
       
       #Pheromone_HC'(:,h)' #Pheromone values btn home h and all closures

       %Get the pheromone values btn this home and all closures in order to select a closure
       Pheromone_home = Pheromone_HC'(:,h)'.*available_closures; % replaces all phrmn_values btn home and cls to 0 for cls with no capacity
       #display(Pheromone_home);
       % compute probabiltiies
       p = Pheromone_home;
       t = sum(p(:)); #Sum of all individual pheromone values, sum([1 2 3]) = 6
       p = p./t;  #P is now the probability (scale of 0-1) of each path being selected
       cum_p = cumsum(p); #Get cumulative sum of probabilities
       random_no = rand; %generate a random number between 0 and 1
       links = cum_p > random_no; % returns an array indicating which closure to link the home to
       link_home = zeros(size(links));
       #find the first  link where the random number was greater than the cumsum
       #This is equivalent to rolling a probabilistic roulette wheel with the probabilities
       #in the vector p
       for l=1:length(links)
         if links(l)==1
            link_home(l) = 1;
           break
         endif
       endfor
      #The next 3 lines are a hack to set row h of Lhc to the value of link_home
      #IT is a thing I couldn't think of how to do natively in Octave
      Lhc = Lhc';
      Lhc(:,h) = link_home';
      Lhc = Lhc';
      endif
    endfor
    s.Lhc = Lhc;
    printf("Connected all homes\n");
    
    printf("Connecting closures to splitters . . .\n")   
    for c= 1:world.closure_no
      printf("Connecting closure %d \n",c)
      used_cl = any(Lhc); #Check which closures are connected to homes
      if used_cl(c) == 1 % if the closure is used
        splitter_links = sum(Lcs); % returns no of closures linked to each splitter
        available_splitters = splitter_links <MaxLinks_SC;
        Pheromone_cl = Pheromone_CS'(:,c)'.*available_splitters;
        % compute probabilities
        p = Pheromone_cl;
        t = sum(p(:));
        p = p./t;
        cum_p = cumsum(p);
        linksc= cum_p > rand; #rand is a var that gives a num btn 0-1
        link_closure = zeros(size(linksc));
         for l=1:length(linksc)
           if linksc(l)==1
              link_closure(l) = 1;
             break
           endif
         endfor
       #The next 3 lines are a hack to set row h of Lhc to the value of link_home
      #IT is a thing I couldn't think of how to do natively in Octave
      Lcs = Lcs';
      Lcs(:,c) = link_closure';
      Lcs = Lcs';
         #Lcs(:,c) = link_closure;  Delete this line
       endif
     endfor    
      s.Lcs = Lcs;
      printf("Connected all Closures\n");
      
      s.Used_cl = any(Lhc); #Might need to transpose this and the one below
      s.Used_sp = any(Lcs);
endfunction



##    DistCS_matrix =[
##        80.318   549.569   254.268;
##       429.471   603.947   501.530;
##       171.861   352.700   379.540]
##       
##        DistCS_matrix =[
##        80.318   549.569   254.268;
##       429.471   603.947   501.530;
##       171.861   352.700   379.540]
##        
##        Pher_HC =[
##       1   1   1   1   1   1   1;
##       1   1   1   1   1   1   1;
##       1   1   1   1   1   1   1]
##
##    Pher_CS =[
##       1   1   1;
##       1   1   1;
##       1   1   1]


######  Trial 1: Simple Code , not probabilistic
######  for h = 1:home_no
######    for c = 1:closure_no
######      select_home = any(Lhc) % create a 1*h matrix showing if any links exist between each home and any closure
######      if select_home(h) == 0 
######        check_closure = sum(Lhc,2) % checks the number of links to a closure
######        if check_closure(c)< MaxLinks_CH % Checks if links to closure is less than the maximum
######          Lhc(c,h) = 1
######         else
######          Lhc(c,h)= 0
######         end if
######       else 
######         Lhc(c,h) = 0
######       endif
######    endfor
######  endfor

##Lhc= zeros(3,7)
##home_no = 7
##MaxLinks_CH = 3
##Pheromone_HC = ones(3,7)
##
##
## % Trial 2: With pheromone matrices: stochastic
##   for h = 1:home_no % for all homes, starting with home 1
##     select_home = sum(Lhc) % check if a link exists between the home and any closures
##     if select_home (h) == 0 % if no link exists between the home and closures
##       closure_links = sum(Lhc,2) % returns number of homes linked to each closure in an array(1*closures)
##       available_closures = closure_links < MaxLinks_CH % returns 0/1 values indicating the availability of each closure
##       Pheromone_home = Pheromone_HC(:,h).*available_closures % replaces all phrmn_values btn home and cls to 0 for cls with no capacity
##       % compute probabiltiies
##       p = Pheromone_home
##       t = sum(p(:))
##       p = p./t
##       cum_p = cumsum(p)
##       random_no = rand %generate a random number between 0 and 1
##       links_home = cum_p > random_no % returns an array indicating which closure to link the home to
##       links_homecpy = zeros(size(links_home))
##       for l=1:length(links_home)
##         if links_home(l)==1
##           links_homecpy(l) = 1
##           break
##         endif
##       endfor
##       Lhc(:,h) = links_homecpy
##      endif
##    endfor


%%Test implementation - to discard
##
##function s = solve(ant,wld)
##  s.Lch = ant.Lhc_matrix;
##  s.pher_cs = get_vars(wld).Pher_CS
##endfunction
