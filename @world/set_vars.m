%Function to change variables in a world. Currently only able to change pheromone matrices
%Note that the function doesnt confirm that the sizes of the new pheromone matrices are appropriate
%%At this point, this responsibility is left to you
% It could be changed later though
%Pher_HC;
%Pher_CS;

function new_world = set_vars(old_world,varargin)
  if (numel (varargin) < 2 || rem (numel (varargin), 2) != 0)
    error ("@world/set: expecting PROPERTY/VALUE pairs");
  endif

  new_world = old_world;
  while (numel (varargin) > 1)
    prop = varargin{1};
    val  = varargin{2};
    varargin(1:2) = [];
    if (! ischar (prop) || ! (strcmp (prop, "Pher_HC") || (strcmp (prop, "Pher_CS")))) %Prop can only be Pher_HC or Pher_CS
      error ("@world/set: invalid PROPERTY for world class");
    %elseif (! (isreal (val) && isvector (val)))
     % error ("@polynomial/set: VALUE must be a real vector");  Check for dimensions and data_type skipped (dangerous)
    endif
    
    if (strcmp (prop, "Pher_HC"))
      new_world.Pher_HC = val;
     elseif (strcmp (prop, "Pher_CS"))
      new_world.Pher_CS = val;
    endif  
  endwhile

endfunction

%w=get_vars(fttx_world)
%new_wrld = set_vars(fttx_world,'Pher_HC',2*w.Pher_HC)
