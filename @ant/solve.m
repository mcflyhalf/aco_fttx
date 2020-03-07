%%% Methodology of getting the solution to the Lch and Lsc? 
% Given parameters of a world, determine the Links between the homes and closures and splitters
% Apply cosntraints to find viable options using the Dist Matrices (update pheromone_matrix accordingly)

% Compute proabilities to determine links but consider constraints such as;
% Constraint 1 (Lch and Lsc): If Distance within matrix is greater than X, replace corresponding phermone_mat element with zero (before selection)
% Constraint 2 (Lsc and Lch): A closure can only be linked to a maximum number of homes (update pheromone_ after a selection)
% Constraint 3 (Lsc): All homes must be linked to a closure and if a closure is linked to a home it has to be linked to a splitter (generate used_cl)



function s = solve(ant,wld) % abcd needs to be an instance of world
  %Given distance matrix and pheromone matrix, update pheromone matrix
  world = get_vars(wld) %use getvars function to access the variables in the world class
   % Links Between Homes and Closures and Splitters:
  Lhc = ant.Lhc_matrix %zeros(closures by homes)
  Lcs = ant.Lcs_matrix % zeros(splitters by closures
  MaxLinks_CH = 3 % should be pulled from world
  MaxLinks_SC = 2 % should be pulled from world
  MaxDistance_HC = 400 % should be pulled from world
  MaxDistance_CS = 500 % should be pulled from world
  
  
  % Universal Constraints: Max Distance 
  % if an element in the Dist_Mat is greater than a certain value, then equivalent elements in phermone_mat will be equal to zero
  % Viability Matrix:
  Viability_HC = world.DistHC_matrix < MaxDistance_HC
  Viability_CS = world.DistCS_matrix < MaxDistance_CS
  
  %%% have a check so that there is at least one option for each home or consider what to do if a home is placed too far from all closures
  
  Pheromone_HC = Viability_HC.*world.Pher_HC
  Pheromone_CS = Viability_CS.*world.Pher_CS
  
  % Step 1; Check if a home has been linked to a closure, if not, select:
  % Loop through the Lhc_matrix columns(homes), if all values in a column are non-zero elements, select the column index(home_number) 
  % Step 2; Find a closure (with remaining capacity) to link the slected home to:
  % Use Probability Function to select the closure to link the selected home to (Pheromone_value/sum(Pheromone_values))
         
 % Trial 2: With pheromone matrices: stochastic
   for h = 1:world.home_no % for all homes, starting with home 1
     select_home = sum(Lhc) % check if a link exists between the home and any closures
     if select_home (h) == 0 % if no link exists between the home and closures
       display(Lhc)
       closure_links = sum(Lhc,2) % returns number of homes linked to each closure in an array(1*closures)
       available_closures = closure_links < MaxLinks_CH % returns 0/1 values indicating the availability of each closure
       Pheromone_home = Pheromone_HC(:,h).*available_closures % replaces all phrmn_values btn home and cls to 0 for cls with no capacity
       % compute probabiltiies
       p = Pheromone_home
       t = sum(p(:))
       p = p./t
       cum_p = cumsum(p)
       random_no = rand %generate a random number between 0 and 1
       links = cum_p > random_no % returns an array indicating which closure to link the home to
       link_home = zeros(size(links))
       for l=1:length(links)
         if links(l)==1
            link_home(l) = 1
           break
         endif
       endfor
      Lhc(:,h) = link_home
      endif
    endfor
    s.Lhc = Lhc
       
    for c= 1:world.closure_no
      used_cl = any(Lhc,2)'
      if used_cl(c) == 1 % if the closure is used
        splitter_links = sum(Lcs,2) % returns no of closures linked to each splitter
        available_splitters = splitter_links <MaxLinks_SC
        Pheromone_cl = Pheromone_CS(:,c).*available_splitters
        % compute probabilities
        k = Pheromone_cl
        u= sum(k(:))
        k= k./u
        cum_k = cumsum(k)
        randomize = rand
        linksc= cum_k > randomize
        link_closure = zeros(size(linksc))
         for l=1:length(linksc)
           if linksc(l)==1
              link_closure(l) = 1
             break
           endif
         endfor
         Lcs(:,c) = link_closure
       endif
     endfor    
      s.Lcs = Lcs 
      
      s.Used_cl = any(Lhc,2)'
      s.Used_Sp = any(Lcs,2)'
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
