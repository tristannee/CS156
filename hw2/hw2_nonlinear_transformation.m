% Tristan Née
% CS 156 Problem Set 2
% Questions 8

N = 100; % Amount of training points
N2 = 1000; % New, out of sample points
simulations = 10; % Amount of simulations to run
E_in = 0; % Keep track of amount of misclassified points
axis([-1,1,-1,1]) % Define the axis on which we graph
for s = 1:(simulations)
    % Construct matrix X.
    % First column of matrix X will be all ones, for all x0
    % Seond column will contain x coordinate of points
    % Third column will contain y coordinate of points
    X = ones(N, 3);
    count = 0;
    sideF = zeros(N, 1); % Points above line will be +1, below are -1
    for j = 1:(N)
        count = count + 1;
        x_cord = -1+2*rand(1,1); % x coordinate of point
        y_cord = -1+2*rand(1,1);% y coordinate of point
        X(count, 2) = x_cord; % Set x2 to x coordinate of point
        X(count, 3) = y_cord; % set x3 to y coordinate of point
        if ((x_cord^2) + (y_cord^2) > .6)            
            sideF(count) = 1;
        else
            sideF(count) = -1;
        end
    end
    random_list = ones(1, N/10);
    count = 0;
    for j = 1:(N/10)        
        count = count + 1;
        % Select random point to flip sign
        random = 1 + floor((N)*rand(1,1));
        sideF(random) = sideF(random) * -1; % Swap the sign
    end
    
    count = 0;
    for j = 1:(N)
        count = count + 1;
        if (sideF(count) == 1)
            plot(X(count, 2), X(count, 3), '+'); hold on;
        else
            plot(X(count, 2), X(count, 3), 'o'); hold on;
        end
    end
    
    pX = pinv(X); % Calculate pseudo inverse of X
    W = pX*sideF; % Weight vector

    count = 0;
    misclassified = 0;
    for j = 1:(N)
        count = count + 1;
        if (sign(dot([X(count, 1), X(count, 2), X(count, 3)], W)) ~= sideF(count))
            misclassified = misclassified + 1;
        end
    end
    E_in = E_in + misclassified/N;
    
end
E_in_average = E_in/simulations
