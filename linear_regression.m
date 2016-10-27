% Tristan Née

N = 10; % Amount of training points
N2 = 1000; % New, out of sample points
simulations = 100; % Amount of simulations to run
E_in = 0; % Keep track of amount of misclassified points
E_out = 0; % Keep track of amount of out of sample misclassified points
iterations_sum = 0; % Keep track of total amount of iterations
% axis([-1,1,-1,1]) % Define the axis on which we graph
for s = 1:(simulations)
    % Create two random points to create target function f.
    x1 = -1+2*rand(1,1);
    y1 = -1+2*rand(1,1);
    x2 = -1+2*rand(1,1);
    y2 = -1+2*rand(1,1);
    m = (y2 - y1)/(x2-x1); % slope of line
    b = -m*x1 + y1;
    x = [-1:.00001:1];
    f = m*x+b; % Target function f

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
        if (y_cord > m*x_cord + b)
            % plot(x_cord, y_cord, '+'); hold on;
            sideF(count) = 1;
        else
            % plot(x_cord, y_cord, 'o'); hold on;
            sideF(count) = -1;
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
    
    % Now generate out of sample points
    count = 0;
    misclassified_out = 0;
    for j = 1:(N2)
        count = count + 1;
        x_cord2 = -1+2*rand(1,1); % x coordinate of point
        y_cord2 = -1+2*rand(1,1);% y coordinate of point      
        
        if (y_cord2 > m*x_cord2 + b)
            correct = 1;
        else
            correct = -1;
        end
             
        if (sign(dot([1, x_cord2, y_cord2], W)) ~= correct)
            misclassified_out = misclassified_out + 1;
        end
    end
    E_out = E_out + misclassified_out/N2;
    
    % Now run PLA algorithm and keep track of iterations
    misclassified = 1;
    iterations = 0;
    while(misclassified == 1)
        iterations = iterations + 1;
        misclassified = 0;
        count = 0;
        for i = 1:N
            count = count + 1;
            x2 = X(count, 2); % x coordinate 
            x3 = X(count, 3); % y coordinate
            % Check for misclassified points
            if (sign(dot([W(1), W(2), W(3)], [1, x2, x3])) ~= sideF(count))
                misclassified = 1; 
                W = W + (sideF(count) .* [1, x2, x3]'); % Update W
                break;
            end
        end
    end
    iterations_sum = iterations_sum + iterations;
end
E_in_average = E_in/simulations
E_out_average = E_out/simulations
iterations_average = iterations_sum/simulations
