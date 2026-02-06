function [fitresult, gof] = createFit(a, m)
%CREATEFIT(A,M)
%  Create a fit.
% Data for the 'exp2' fit:
% X Input: a from a
% Y Output: m from m
% Validation X: a from a
% Validation Y: m from m% Output:
% fitresult: Fit object representing the fit.
% gof: Structure with goodness-of-fit information.

%% Fitting: 'exp2'。
[xData, yData] = prepareCurveData( a, m );

% Set the fittype and options

ft = fittype( 'exp2' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.Robust = 'LAR';
opts.StartPoint = [1.26541222919868 -0.00569035463255186 0.00359795550997569 0.111153423819818];

% Perform model fitting on the data

[fitresult, gof] = fit( xData, yData, ft, opts );

% Compare against the validation data

[xValidation, yValidation] = prepareCurveData( a, m );
residual = yValidation - fitresult( xValidation );
nNaN = nnz( isnan( residual ) );
residual(isnan( residual )) = [];
sse = norm( residual )^2;
rmse = sqrt( sse/length( residual ) );
fprintf( '''%s'' Goodness of fit for validation:\n', 'exp2' );
fprintf( '    SSE : %f\n', sse );
fprintf( '    RMSE : %f\n', rmse );
fprintf( '    %i points are outside the data domain\n', nNaN );

% Create a viewport for the drawing

figure( 'Name', 'exp2' );

% Plot the data fitting graph

subplot( 2, 1, 1 );
h = plot( fitresult, xData, yData, 'predobs' );
% Add the validation data to the plot

hold on
h(end+1) = plot( xValidation, yValidation, 'bo', 'MarkerFaceColor', 'w' );
hold off
legend( h, 'm vs. a', 'exp2', 'Lower bound(a and m)', 'Upper bound(a and m)', 'm vs. a', 'Location', 'NorthEast', 'Interpreter', 'none' );
% Label the coordinate axes

xlabel( 'a', 'Interpreter', 'none' );
ylabel( 'm', 'Interpreter', 'none' );
grid on

% Plot the residual plot

subplot( 2, 1, 2 );
h = plot( fitresult, xData, yData, 'residuals' );
% Add the validation data to the plot

hold on
h(end+1) = plot( xValidation, yValidation - fitresult( xValidation ), 'bo', 'MarkerFaceColor', 'w' );
hold off
legend( h, 'exp2 - Residuals', 'Zero Line', 'a and m - Validation residuals', 'Location', 'NorthEast', 'Interpreter', 'none' );
% Label the coordinate axes

xlabel( 'a', 'Interpreter', 'none' );
ylabel( 'm', 'Interpreter', 'none' );
grid on


