%Isabelle Lai 919259175

%   BINOMIAL
%%%%%%%%%%%%%%%% Task 1 = find pairs where no walls will be hit given 9 spots, 7 levels
spots = 9;
levels = 7;
pegs = 2*(levels-1);
boardPairs = zeros(spots, spots);     %index is p[i, j] = 1 if it is a pair, 0 if not a pair

%currSpot = current i value
for currSpot = 2:(spots-1)
    lowerLimOfPair = 1;     %biggest j where left wall is hit
    upperLimOfPair = spots;     %smallest j where right wall is hit
    %remainingLevels = levels;

    % find lower limit of j in pairs with i
    remainingLevels = levels - currSpot;
    lowerLimOfPair = lowerLimOfPair+remainingLevels;
    if remainingLevels <= 0
        lowerLimOfPair = currSpot - levels;
    end 

    % find upper limit of j in pairs with i
    remainingLevels = levels - ((spots+1)- currSpot);
    upperLimOfPair = upperLimOfPair - remainingLevels;

    if remainingLevels <= 0
        upperLimOfPair = spots + remainingLevels + 1;
    end
    
    % display pairs
    for pairs = (lowerLimOfPair+1):(upperLimOfPair-1)
        boardPairs(currSpot, pairs) = 1;
    end

end
%%%% DISPLAY TASK 1
fprintf("\nTask 1: \n\nPairs displayed in a board where index [i=row, j=col] shows 1 \non the board if i and j are a pair; \n i = starting position \n j = final position \n\n")
disp(boardPairs);


%%%%%%%%%%%%%%%%%% Task 2
boardProb = zeros(spots, spots);

for i=1:spots
    for j=1:spots
        
        %given that the pair doesn't hit a wall, calculate the binomial
        if boardPairs(i, j) > 0

            kSuccess = j - i + (pegs / 2);
            b = nchoosek(pegs, kSuccess);
            binom = b*(0.5^kSuccess)*(0.5^(12-kSuccess));
            boardProb(i, j) = binom;
      
        end
    end
end

fprintf("\nTask 2: \n\n")
disp(boardProb)



%   MARKOV CHAIN
%%%%%%%%%%%%%%%%% Task 3
transitionM = zeros(spots, spots);

%interested only at the current spot and the spots next to it
for start = 1:spots
    for fin = 1:spots
        
        %spots on either side of the current spot
        Lpeg = fin-1;
        Rpeg = fin+1;

        if start == fin
            transitionM(start, fin) = .5;

            if Lpeg<1       %starting in spot 1
                transitionM(start, Rpeg) = .5;
            elseif Rpeg > spots     %starting in last spot
                transitionM(start, Lpeg) = .5;
            else        %spots not next to a wall
                transitionM(start, Rpeg) = .25;
                transitionM(start, Lpeg) = .25;
            end
        end

    end
end

%%%% DISPLAY TASK #
fprintf("Task 3: \n\n")
disp(transitionM)


%%%%%%%%%%%%%%%%% Task 4
MarkovP = transitionM;
for i=2:levels-1
    MarkovP = transitionM*MarkovP;
end

fprintf("Task 4: \n")
disp(MarkovP)
% 
% 
% 
