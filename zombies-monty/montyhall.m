% ------------------------
% Solution to Question 2
% ------------------------
%
%
% ----------------------
% Brief description: Program accepts an integer and then returns either the 
% value '1' if you win or '0' if you lose. The integer determines whether the
% contestant decides to change doors or remain with the initial door. If '1' 
% is chosen, then the contestant will change. If any other integer is chosen, 
% then the contestant will remain with the same door. If the person using the 
% code wants to determine what the chances are of winning over 10 000 times, 
% then they will replace 'result' in the function line with 'wonperc'. If they 
% want to see the chances of winning with a different number of doors, then they 
% will change the value of 'doors' to however many doors they desire in the game
% ----------------------
%
%%% MONTY HALL PROBLEM %%%


% 2.1

% change = 1, switch doors. change ~= 1, remain with inital choice.

% to find percentage of winning over nsteps amount of time 
% without changing or if it does change every time, replace 'result' with 
% 'wonperc' in function line.

function result = montyhall(change)
lost = 0; % initial count
doors = 3; % number of doors in the game
won = 0; % initial count
nsteps = 1e4;  % choose how many times you want to play the game.
for i = 1:nsteps
choose = randi([1,doors]);  % door you choose
y = floor(rand(1,doors));  % Vector of 1's equal to the number of doors
car = randi([1,doors]);   % Choosing random door which car is behind
y(car) = 1;   % Differentiating from the other vector numbers. (The car)
%change = randi([1,2]); %  50% chance of changing doors. 
                       %   1 = change, 2 = stay.
%change = 2; % 1, 2;   For fixed calculations.                       
goats = find(y==0);    % finds where all the goats are located
goathold = goats;     % saves the original position of the goats.
% door is opened
if choose == car
        missinggoatgeneral = goathold(randi([1,length(goathold)]));
        y(missinggoatgeneral) = []; % Removes this goat from the game. Leaves 2 options to choose from

        if  car > missinggoatgeneral
            car = car - 1;
            choose = choose - 1;
        end
end
if choose ~= car
    %goatreveal = goats;
    missinggoat = goathold(goathold~=choose);    
    missinggoatgeneral = missinggoat(randi([1,length(missinggoat)]));  % chooses a random goat which isn't your goat no matter how many doors.
    y(missinggoatgeneral) = [];   % Removes a goat from the game which isn't behind your door.
    if car > missinggoatgeneral     
        car = car - 1;
    end
    if choose > missinggoatgeneral
        choose = choose - 1;
    end
end
% Keeps both "choose" and "car" to stay within bound of the indices.

% Deciding whether to change doors or not

indices = find(y>=0);
%chooseoriginal = choose;
if change == 1 %  change doors
           indices2 = find(indices~=choose);     
           choose = indices2(randi([1,length(indices2)]));     % this line could still end up on the original choose.
end

if choose == car
    won = won + 1;
    result = 1; % disp('1 - You are a WINNER');
elseif choose ~= car
    result = 0; % disp('0 - You are a LOSER');
end
hold(i) = change;   % holds whether the person changed doors or not.
end
wonperc = won/nsteps;
lostperc = 1 - wonperc;
end


% 2.2

% If the contestant never switches, then they win roughly 33% of the time,
% but if they alway switch,then they win roughly 66% of the time.

% 2.3

% If the number of doors is increased to 100, then the odds of winning
% begin to converge no matter if you choose to switch or remain. If you
% stay, the odds of winning are 1%, while if you change they only increase
% to 1.01%. This is because the change in chance of winning from changing
% doors can be represented as 1/n -> 1/(n-1). As n increases, the
% difference in the values begins to converge and have no noticable effect
% on the final outcome.

