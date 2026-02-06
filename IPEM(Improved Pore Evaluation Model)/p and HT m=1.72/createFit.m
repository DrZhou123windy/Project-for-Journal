function [fitresult, gof] = createFit(p2, HT2)
%CREATEFIT(P2,HT2)
%  Create a fit.
%
%  Data for the 'p and HT m=1.72' fit:
%      X Input: p2
%      Y Output: HT2
%  Output:
%      fitresult: Fit object representing the fit.
%      gof: Structure containing goodness-of-fit information.
%
%  See also FIT, CFIT, SFIT

%% Fit: 'p and HT m=1.72'
[xData, yData] = prepareCurveData( p2, HT2 );

% Set the fittype and options
ft = fittype( 'exp1' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.Robust = 'LAR';
opts.StartPoint = [0.00117770955644244 2.15215026932835];

% Perform model fitting on the data
[fitresult, gof] = fit( xData, yData, ft, opts );

% Plot the data fitting graph
figure( 'Name', 'p and HT m=1.72' );
h = plot( fitresult, xData, yData );
legend( h, 'HT2 vs. p2', 'p and HT m=1.72', 'Location', 'NorthEast', 'Interpreter', 'none' );
% Label the coordinate axes
xlabel( 'p2', 'Interpreter', 'none' );
ylabel( 'HT2', 'Interpreter', 'none' );
grid on


