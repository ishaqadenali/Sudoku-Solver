function [candidates, puzzle, breaker] = solve_puzzle( puzzle,candidates)

    breaker = 0;
    while(game_complete(puzzle) == 0)
                       
        %fill candidates tensor with appropriate values
        candidates = fill_candidates(puzzle,candidates);

        %sets the values we are certain of. If none, set a flag.
        [puzzle, flag_candidates] = set_certain(puzzle,candidates);
  
        %try place finding method
        if(flag_candidates == 0) 
            
            [puzzle, flag_place] = place_finding(candidates, puzzle);

            %if both candidate checking and place finding methods fail, GG.
            if(flag_place == 0)
                
                disp('I cant solve this puzzle sorry');
                break; 
                
            end
            
        end   
        
        breaker = breaker + 1;
        
        if(breaker == 1000)
            break;
        end
    end
end

%check the horizontal, vertical and square possibilities for each place
function sol = fill_candidates(puzzle,candidates,)
    
    sol = candidates;
    %horizontal check
    for hor = 1:9
        
        if puzzle(hor,j) == 0
            continue;
        
        else
           sol(i,j,puzzle(hor,j)) = 1;
            
        end
    
    end
    
    %verticle check
    for ver = 1:9
        
        if puzzle(i,ver) == 0
            continue;
        else
            sol(i,j,puzzle(i,ver)) = 1;
        end
    end
    %3X3 box check
    
     if(i<4) %%gets the correct box dimensions
         a = 1;
     elseif(i>3 && i<7)
         a = 4;
     else
         a = 7;
     end
     
     if(j<4) %%gets the correct box dimensions
         b = 1;
     elseif(j>3 && j<7)
         b = 4;
     else
         b = 7;
     end
    
    for ii = a:a+2
        for jj = b:b+2
            
            if puzzle(ii,jj) == 0
                continue;
        
            else
                sol(i,j,puzzle(ii,jj)) = 1;
            end
        end
    end

end

%set the values that we are certain about
function [sol, flag] = set_certain(puzzle, candidates)
    
    flag = 0;
    sol = puzzle;
    for i = 1:9
        for j = 1:9
          
            if(puzzle(i,j) == 0 && sum(candidates(i,j,:))==8)
                
                sol(i,j) = find(candidates(i,j,:) == 0); %find index with 0.
                flag = 1; %we have solved at least one cell in puzzle
                
            end
        end
    end
end

%implement crooks algorithm (educated guessing and higher level logic)

%{
function sol = crook(puzzle,candidates)

    num_candidates = sum(candidates,3) %take the sum across 3rd dimension to get the total number of impossible choices for each cell.
    for i = 1:9
        for j = 1:9  
            if num_candidates(i,j) == 7
                result = find_match(i,j);
            end
              
        end
    end
    
end
%}

function [puzzle, flag2] = place_finding(candidates, puzzle)

    flag2 = 0;
    %third dimension. Check the viablilty of each subsquare, row and column
    %for each value
    for k = 1:9
        %find the candidates for all numbers i.e row k =1 are the
        %candidates/viability of each index being 1
        values = candidates(:,:,k);

        horizontal = sum(values,1);
        vertical = sum(values,2);
        
        for n = 1:9 
 
            if(horizontal(n) == 8)
                
                x_value = find(candidates(:,n,k) == 0);
                puzzle(x_value,n) = k;
                flag2 = 1;
                
            end
            
            if(vertical(n) == 8)
                
                y_value = find(candidates(n,:,k) == 0);
                puzzle(n,y_value) = k;
                flag2 = 1;
                
            end
            
        end
        
    end
    
end

function status = game_complete(puzzle)
   
    status = 1;
    temp = puzzle < 1; %find indices that are not solved
     

    if (sum(sum(temp)) > 0)
        
        status = 0; %incomplete game continue on

    end

end
    