% ------------------------
% Solution to Question 1
% ------------------------
%
%
% ----------------------
% Brief description: The first part sets the parameters the world
% (40x40 grid) and the simulation (max number of days, number of people,
% remission rate). It also sets the initial locations of people and
% a random person to be a zombie. The second part selects a random integer
% between 1 and 5 to correspond to the 5 possible movements for a single
% person. It also accounts for if that person moves off the grid and moves
% them in the opposite direction. Part 3 first looks through the people
% structure vector and finds the indicies of zombies and nonzombies. It
% then uses two for loops and an if loop to compare the coordinates of the
% zombies indexing off the people vector. If it finds the coordinates are
% exactly equal then it converts a nonzombie to a zombie. Part 4 plots the
% simulation. We included notes to show when code is included for purpose
% of the written questions.
% 
% ----------------------

%% Set parameters (Part 1.1)
clear
sidelength = 40;
maxtime = 1000;
npeople = 100;
remission = 0.01;

%% Initialize people (Part 1.2)
people = struct();
for p = 1:npeople
    people(p).x = randi([1,sidelength]);
    people(p).y = randi([1,sidelength]);
    people(p).zombie = 0;
end
people(randi([1,npeople])).zombie = 1;

%% Run loop (Part 2)
for t = 1:maxtime
    % Movement
    for p = 1:npeople
        movement = randi([1,5]);
        if movement == 1 %Stay still
            people(p).x = people(p).x;
            people(p).y = people(p).y;
        elseif movement == 2 %Move up
            people(p).x = people(p).x;
            people(p).y = people(p).y + 1;
        elseif movement == 3 %Move right
            people(p).x = people(p).x + 1;
            people(p).y = people(p).y;
        elseif movement == 4 %Move down
            people(p).x = people(p).x;
            people(p).y = people(p).y - 1;
        elseif movement == 5 %Move left
            people(p).x = people(p).x - 1;
            people(p).y = people(p).y;
        end
        
        if people(p).x > sidelength %For people who move off grid
            people(p).x = people(p).x - 2;
        elseif people(p).x < 1
            people(p).x = people(p).x + 2;
        elseif people(p).y > sidelength
            people(p).y = people(p).y - 2;
        elseif people(p).y < 1
            people(p).y = people(p).y + 2;
        else
        end
    end
 
    %% Count Zombies and Find Indices (Part 3.1)
    zombies = find([people.zombie]);
    nonzombies = find([people.zombie] == 0);
    
    %% Update Zombies (Part 3.2)
    for z = zombies
        for nz = nonzombies
            if people(z).x == people(nz).x && people(z).y == people(nz).y
                people(nz).zombie = 1; %Set nonzombie to zombie if above
            else                       %condition satisfied.
            end
        end
    end
    
    %To implement spontaneous recovery. Question (1.4)
    recover = rand(); 
    if recover <= remission && ~isempty(zombies)
        people(zombies(randi([1,length(zombies)]))).zombie = 0;
    else
    end
    
    %% Plotting (Part 4)
    clf
    hold on
    scatter([people.x], [people.y], 'filled')
    scatter([people(zombies).x], [people(zombies).y], 'filled', 'r') %zombies in red
    title(sprintf('DAYS = %i BRAIN EATING ZOMBIES = %i', t, length(zombies)))
    xlim([1, sidelength])
    ylim([1, sidelength])
    pause(.01)
    
    %if length(zombies) == 100 
    %   break %This to see how many days until last infection. Question (1.1)
    %end
    
    infect_day(t) = (length(zombies)/(sidelength^2))*length(nonzombies);
    prevalence(t) = length(zombies)/length(people);
    num_zombies(t) = length(zombies); % These 3 are for Question (1.2)
end

figure()
t = 1:maxtime; %To plot number of zombies as a function of time. Question (1.2)
plot(t, num_zombies)
title('Number of Zombies as a Function of Time')

figure()
plot(prevalence, infect_day)%To plot infections per day vs prevalence for (1.2)
title('Theoretical Number of Infections Per Day vs Zombie Prevalence')
