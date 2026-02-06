function [fitresult, gof] = createFit(p1, kps1)
%CREATEFIT(P1,KPS1)
%  Create a fit.
%
%  Data for the 'p and kps m=1.6' fit:
%      X Input: p1
%      Y Output: kps1
%  Output:
%      fitresult: Fit object representing the fit.
%      gof: Structure containing goodness-of-fit information.
%
%  See also FIT, CFIT, SFIT

%% Fit: 'p and kps m=1.6'。
[xData, yData] = prepareCurveData( p1, kps1 );

% Set the fittype and options
ft = fittype( 'exp1' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.Robust = 'LAR';
opts.StartPoint = [0.333660513385291 2.47448147915087];

% Perform model fitting on the data
[fitresult, gof] = fit( xData, yData, ft, opts );

% Plot the data fitting graph
figure( 'Name', 'p and kps m=1.6' );
h = plot( fitresult, xData, yData );
legend( h, 'kps1 vs. p1', 'p and kps m=1.6', 'Location', 'NorthEast', 'Interpreter', 'none' );
% Label the coordinate axes
xlabel( 'p1', 'Interpreter', 'none' );
ylabel( 'kps1', 'Interpreter', 'none' );
grid on


