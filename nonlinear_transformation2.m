% Tristan Née

N = 1000; % Amount of training points
N2 = 1000; % New, out of sample points
simulations = 100; % Amount of simulations to run
E_out = 0; % Keep track of amount of out of sample misclassified points
iterations_sum = 0; % Keep track of total amount of iterations
misclassified_average = 0;
% axis([-1,1,-1,1]) % Define the axis on which we graph
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
    
    newX = ones(N, 6); % Create matrix for nonlinear feature vector
    count = 0;
    for j = 1:(N)
        count = count + 1;
        x1 = X(count, 2);
        x2 = X(count, 3);
        newX(count, 1) = 1;
        newX(count, 2) = x1;
        newX(count, 3) = x2;
        newX(count, 4) = x1*x2;
        newX(count, 5) = x1^2;
        newX(count, 6) = x2^2;
    end
    pX = pinv(newX);
    W = pX*sideF;
    
    sideG = zeros(N, 1); % Keep track of results from hypothesis g
    
    count = 0;
    for j = 1:(N)
        count = count + 1;
        x1 = X(count, 2);
        x2 = X(count, 3);
        % Test out hypotheses from problem set. Keep one that gives us best
        % misclassified_average value.
        sideG(count) = sign(-1-(.05*x1)+(.08*x2)+(.13*x1*x2)+(1.5*(x1^2))+(1.5*(x2^2)));
    end
    
    %misclassified = 0;
    count = 0;
    for j = 1:(N)     
        count = count + 1;
        if (sideF(count) ~= sideG(count))
            misclassified = misclassified + 1;
        end
    end
    
    % Now generate out of sample points
    count = 0;
    misclassified_out = 0;
    for j = 1:(N2)
        count = count + 1;
        x1 = -1+2*rand(1,1); % x coordinate of point
        y2 = -1+2*rand(1,1);% y coordinate of point
        
        % Classify the newly generated points
        if (x1^2 + x2^2 > .6)
            correct = 1;
        else
            correct = -1;
        end
        
        % Find how the hypothesis deals with the new points and calculate
        % E_out based on that
        if (sign(-1-(.05*x1)+(.08*x2)+(.13*x1*x2)+(1.5*(x1^2))+(1.5*(x2^2))) ~= correct)
            misclassified_out = misclassified_out + 1;
        end
    end
    E_out = E_out + misclassified_out/N2;
    
end
misclassified_average = misclassified/simulations
E_out_average = E_out/simulations
