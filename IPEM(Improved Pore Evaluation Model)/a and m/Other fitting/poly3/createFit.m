function [fitresult, gof] = createFit(a, m)
%CREATEFIT(A,M)
%  Create a fit.
% Data for the 'poly3' fit:
% X Input: a from a
% Y Output: m from m
% Validation X: a from a
% Validation Y: m from m% Output:
% fitresult: Fit object representing the fit.
% gof: Structure with goodness-of-fit information.

%% Fitting: 'poly3'。
[xData, yData] = prepareCurveData( a, m );

% Set the fittype and options

ft = fittype( 'poly3' );
opts = fitoptions( 'Method', 'LinearLeastSquares' );
opts.Robust = 'LAR';

% Perform model fitting on the data

[fitresult, gof] = fit( xData, yData, ft, opts );

% Compare against the validation data

[xValidation, yValidation] = prepareCurveData( a, m );
residual = yValidation - fitresult( xValidation );
nNaN = nnz( isnan( residual ) );
residual(isnan( residual )) = [];
sse = norm( residual )^2;
rmse = sqrt( sse/length( residual ) );
fprintf( '''%s'' Goodness of fit for validation:\nn', 'poly3' );
fprintf( '    SSE : %f\n', sse );
fprintf( '    RMSE : %f\n', rmse );
fprintf( '    %i points are outside the data domain\n', nNaN );

% Create a viewport for the drawing
figure( 'Name', 'poly3' );

% Plot the data fitting graph

subplot( 2, 1, 1 );
h = plot( fitresult, xData, yData, 'predobs' );
% Add the validation data to the plot

hold on
h(end+1) = plot( xValidation, yValidation, 'bo', 'MarkerFaceColor', 'w' );
hold off
legend( h, 'm vs. a', 'poly3', 'Lower bound(a and m)', 'Upper bound(a and m)', 'm vs. a', 'Location', 'NorthEast', 'Interpreter', 'none' );
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
legend( h, 'poly3 - Residuals', 'Zero Line', 'a and m - Validation residuals', 'Location', 'NorthEast', 'Interpreter', 'none' );
% Label the coordinate axes

xlabel( 'a', 'Interpreter', 'none' );
ylabel( 'm', 'Interpreter', 'none' );
grid on


