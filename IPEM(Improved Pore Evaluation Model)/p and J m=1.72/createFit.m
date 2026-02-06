function [fitresult, gof] = createFit(p2, J2)
%CREATEFIT(P2,J2)
%  Create a fit.
%
%  Data for the 'p and J m=1.72' fit:
%      X Input: p2
%      Y Output: J2
%  Output:
%      fitresult: Fit object representing the fit.
%      gof: Structure containing goodness-of-fit information.
%
%  See also FIT, CFIT, SFIT

%% Fit: 'p and J m=1.72'
[xData, yData] = prepareCurveData( p2, J2 );

% Set the fittype and options
ft = fittype( 'exp1' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.Robust = 'LAR';
opts.StartPoint = [2.07075173105018 -1.48957739933115];

% Perform model fitting on the data
[fitresult, gof] = fit( xData, yData, ft, opts );

% Plot the data fitting graph
figure( 'Name', 'p and J m=1.72' );
h = plot( fitresult, xData, yData );
legend( h, 'J2 vs. p2', 'p and J m=1.72', 'Location', 'NorthEast', 'Interpreter', 'none' );
% Label the coordinate axes
xlabel( 'p2', 'Interpreter', 'none' );
ylabel( 'J2', 'Interpreter', 'none' );
grid on


