function [candidates, puzzle] = solve_puzzle( puzzle,candidates)

    for k = 1:1000
        for i = 1:9
            for j = 1:9
            candidates = fill_candidates(puzzle,candidates,i,j); %fill candidates tensor with appropriate values
            end
        end
        [puzzle, flag] = set_certain(puzzle,candidates); %sets the values we are certain of. If none, set a flag.
    
%      if flag == 1
%         puzzle = crook(puzzle,candidates); %implementation of crooks algorithm
%      end
  
        
    end
end

function sol = fill_candidates(puzzle,candidates,i,j)
    
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

function [sol, flag] = set_certain(puzzle, candidates);
    
    flag = 0;
    sol = puzzle;
    count = 0;
    for i = 1:9
        for j = 1:9
          
            if(puzzle(i,j) == 0 && sum(candidates(i,j,:))==8)
                
                sol(i,j) = find(candidates(i,j,:) == 0); %find index with 0.
                count = count +1;
                
            end
        end
    end
    
    
    
    if(count > 0)
        flag = 1; %return flag
    end
    

end

function sol = crook(puzzle,candidates)

    num_candidates = sum(candidates,3) %take the sum across 3rd dimension to get the total number of impossible choices for each cell.
    for i = 1:9
        for j = 1:9  
            if num_candidates(i,j) == 7
                result = find_match(i,j)
            end
              
        end
    end
    
end

function sol = find_match(i,j)

    


end

    