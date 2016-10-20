# CS156
This code comes from an assignment in the CS156 class at Caltech.

- hw2_linear_regression.m
In this MATLAB code, we worked with Linear Regression for classification of points.
A target function and data set were created, with dimension = 2 and the data set
points were restricted to [-1, 1] x [-1, 1] (cartesian coordinates). Then,
a random line was chosen and points on one side of the line mapped to +1 while the
the other points mapped to -1. This file used Linear Regression on N = 100 training
points to evaluate the hypothesis function g and make various measurements. The code
automated 1000 different runs to acheive more reliable measurements.

- hw2_nonlinear_transformation.m
In this code, we applied Linear Regression after a nonlinear transformation of
training points. The transformation applied was f(x1, x2) = sign((x1)^2 + (x2)^2 - 0.6).
Noise was also simulated by flipping the sign of 10% of the points of the traning set.

- hw2_nonlinear_transformation.m
This is similar code to the last file, but this time the transformation applied
corresponded to the nonlinear feature vector: (1, x1, x2, x1x2, (x1)^2, (x2)^2).
In sample and out of sample error was calculated after averaging over 1000 runs.
