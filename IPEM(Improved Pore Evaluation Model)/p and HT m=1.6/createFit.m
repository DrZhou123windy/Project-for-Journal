function [fitresult, gof] = createFit(p1, HT1)
%CREATEFIT(P1,HT1)
%  Create a fit.
%
%  Data for the 'p and HT m=1.6' fit:
%      X Input: p1
%      Y Output: HT1
%  Output:
%      fitresult: Fit object representing the fit.
%      gof: Structure containing goodness-of-fit information.
%
%  See also FIT, CFIT, SFIT

%% Fit: 'p and HT m=1.6'
[xData, yData] = prepareCurveData( p1, HT1 );

% Set the fittype and options
ft = fittype( 'exp1' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.Robust = 'LAR';
opts.StartPoint = [0.00171379182313435 1.88785214906544];

% Perform model fitting on the data
[fitresult, gof] = fit( xData, yData, ft, opts );

% Plot the data fitting graph
figure( 'Name', 'p and HT m=1.6' );
h = plot( fitresult, xData, yData );
legend( h, 'HT1 vs. p1', 'p and HT m=1.6', 'Location', 'NorthEast', 'Interpreter', 'none' );
% Label the coordinate axes
xlabel( 'p1', 'Interpreter', 'none' );
ylabel( 'HT1', 'Interpreter', 'none' );
grid on


