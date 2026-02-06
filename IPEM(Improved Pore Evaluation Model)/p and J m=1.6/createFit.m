function [fitresult, gof] = createFit(p1, J1)
%CREATEFIT(P1,J1)
%  Create a fit.
%
%  Data for the 'p and J m=1.6' fit:
%      X Input: p1
%      Y Output: J1
%  Output:
%      fitresult: Fit object representing the fit.
%      gof: Structure containing goodness-of-fit information.
%
%  See also FIT, CFIT, SFIT

%% Fit:  'p and J m=1.6'
[xData, yData] = prepareCurveData( p1, J1 );

% Set the fittype and options
ft = fittype( 'exp1' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.StartPoint = [2.00263896123266 -1.39683275549179];

% Perform model fitting on the data
[fitresult, gof] = fit( xData, yData, ft, opts );

% Plot the data fitting graph
figure( 'Name', 'p and J m=1.6' );
h = plot( fitresult, xData, yData );
legend( h, 'J1 vs. p1', 'p and J m=1.6', 'Location', 'NorthEast', 'Interpreter', 'none' );
% Label the coordinate axes
xlabel( 'p1', 'Interpreter', 'none' );
ylabel( 'J1', 'Interpreter', 'none' );
grid on


