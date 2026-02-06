function [fitresult, gof] = createFit(a, m)
%CREATEFIT(A,M)
%  Create a fit.
% Data for the 'aexp(-bx)+c' fit:
% X Input: a from a
% Y Output: m from m
% Validation X: a from a
% Validation Y: m from m% Output:
% fitresult: Fit object representing the fit.
% gof: Structure with goodness-of-fit information.


%% 拟合: 'aexp(-bx)+c'。
[xData, yData] = prepareCurveData( a, m );

% Set the fittype and options

ft = fittype( 'a*exp(-b*x)+c', 'independent', 'x', 'dependent', 'y' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.Robust = 'LAR';
opts.StartPoint = [0.668512214253545 0.133503859661312 0.021555887203497];

% Perform model fitting on the data

[fitresult, gof] = fit( xData, yData, ft, opts );

% Compare against the validation data
[xValidation, yValidation] = prepareCurveData( a, m );
residual = yValidation - fitresult( xValidation );
nNaN = nnz( isnan( residual ) );
residual(isnan( residual )) = [];
sse = norm( residual )^2;
rmse = sqrt( sse/length( residual ) );
fprintf( '''%s'' Goodness of fit for validation:\n', 'aexp(-bx)+c' );
fprintf( '    SSE : %f\n', sse );
fprintf( '    RMSE : %f\n', rmse );
fprintf( '    %i points are outside the data domain\n', nNaN );

% Create a viewport for the drawing

figure( 'Name', 'aexp(-bx)+c' );
h = plot( fitresult, xData, yData );
legend( h, 'm vs. a', 'aexp(-bx)+c', 'Lower bound(a and m)', 'Upper bound(a and m)', 'm vs. a', 'Location', 'NorthEast', 'Interpreter', 'none' );
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
legend( h, 'a*exp(-b*x)+c - Residuals', 'Zero Line', 'a and m - Validation residuals', 'Location', 'NorthEast', 'Interpreter', 'none' );
% Label the coordinate axes

xlabel( 'a', 'Interpreter', 'none' );
ylabel( 'm', 'Interpreter', 'none' );
grid on

