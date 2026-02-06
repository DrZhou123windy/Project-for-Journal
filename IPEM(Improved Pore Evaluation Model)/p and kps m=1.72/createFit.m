function [fitresult, gof] = createFit(p2, kps2)
%CREATEFIT(P2,KPS2)
%  Create a fit.
%
%  Data for the 'p and kps m=1.72' fit:
%      X Input: p2
%      Y Output: kps2
%  Output:
%      fitresult: Fit object representing the fit.
%      gof: Structure containing goodness-of-fit information.
%
%  See also FIT, CFIT, SFIT

%% Fit: 'p and kps m=1.72'。
[xData, yData] = prepareCurveData( p2, kps2 );

% Set the fittype and options
ft = fittype( 'exp1' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.Robust = 'LAR';
opts.StartPoint = [0.266939669332167 2.87224930791658];

% Perform model fitting on the data
[fitresult, gof] = fit( xData, yData, ft, opts );

% Plot the data fitting graph
figure( 'Name', 'p and kps m=1.72' );
h = plot( fitresult, xData, yData );
legend( h, 'kps2 vs. p2', 'p and kps m=1.72', 'Location', 'NorthEast', 'Interpreter', 'none' );
% Label the coordinate axes
xlabel( 'p2', 'Interpreter', 'none' );
ylabel( 'kps2', 'Interpreter', 'none' );
grid on


