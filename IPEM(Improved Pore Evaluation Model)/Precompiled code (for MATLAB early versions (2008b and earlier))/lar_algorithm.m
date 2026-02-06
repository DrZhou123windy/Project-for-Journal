function [beta, path, steps] = lar_algorithm(a, m)
% LAR_ALGORITHM  Implement the Least Angle Regression (LAR) algorithm
% Input:
%   a - Independent variable, 1D/multi-dimensional column vector (n×1 or n×p, n is the number of samples, p is the number of independent variables)
%   m - Dependent variable, 1D column vector (n×1)
% Output:
%   beta - Final regression coefficients (p×1, p is the number of independent variables)
%   path - Regression coefficient path (p×k, k is the number of iteration steps, each column corresponds to the coefficients of one step)
%   steps - Number of iteration steps
%
% Step 1: Data preprocessing (centralization, eliminate the influence of constant term, LAR defaults to processing centralized data)
n = length(m);          % Number of samples
a = a - mean(a, 1);     % Centralize independent variables (calculate mean by column, adapt to multi-dimensional independent variables)
m = m - mean(m);        % Centralize dependent variables

% Step 2: Initialize parameters (adapt to 1D/multi-dimensional independent variables)
[p, ~] = size(a');      % Number of independent variables p (p=1 for 1D, p is the number of columns for multi-dimensional)
beta = zeros(p, 1);     % Initialize regression coefficients (final result)
path = beta;            % Initialize coefficient path
residual = m;           % Initialize residual (initial residual = centralized dependent variable)
active_set = [];        % Initialize active set (indices of selected independent variables)
steps = 0;              % Initialize number of iteration steps

% Step 3: Core iteration logic of LAR
while true
    % 3.1 Calculate the correlation coefficient between current residual and all independent variables
    corr = a' * residual;  % Correlation coefficient (approximate by vector inner product, omitting normalization does not affect the direction)
    abs_corr = abs(corr);
    max_corr = max(abs_corr);
    
    % 3.2 Convergence judgment (no correlation between residual and all independent variables, stop iteration)
    if max_corr < 1e-10  % Numerical stability threshold to avoid floating-point errors
        break;
    end
    
    % 3.3 Update active set (add the independent variable with the highest correlation with residual)
    candidate = find(abs_corr >= max_corr - 1e-10);  % Find the indices of independent variables corresponding to the maximum correlation coefficient
    active_set = unique([active_set, candidate]);    % Remove duplicates and update active set
    p_active = length(active_set);                   % Size of current active set
    
    % 3.4 Calculate the direction vector of active independent variables
    a_active = a(:, active_set);                    % Extract active independent variable matrix
    G_active = a_active' * a_active;                 % Gram matrix of active independent variables
    w = ones(p_active, 1) / sqrt(ones(1, p_active) * inv(G_active) * ones(p_active, 1));
    direction_active = inv(G_active) * ones(p_active, 1) * w;  % Coefficient update direction within the active set
    direction = zeros(p, 1);
    direction(active_set) = direction_active;        % Complete direction vector (0 for non-active set)
    
    % 3.5 Calculate step size (maximum step size for advancing along the least angle direction without introducing new independent variables)
    a_direction = a' * (a * direction);
    gamma = (max_corr - corr) ./ (a_direction - corr + 1e-10);  % Candidate step sizes
    gamma(active_set) = inf;  % Set the step size of independent variables in the active set to infinity (no restriction)
    gamma(gamma < 0) = inf;   % Discard negative step sizes (meaningless)
    min_gamma = min(gamma);   % Select the minimum step size (avoid introducing new independent variables)
    
    % 3.6 Update regression coefficients and residuals
    beta = beta + min_gamma * direction;
    residual = residual - min_gamma * (a * direction);
    
    % 3.7 Update coefficient path and number of iteration steps
    path = [path, beta];
    steps = steps + 1;
    
    % 3.8 Early termination for 1D scenario (optimization to avoid meaningless iteration)
    if p == 1
        break;
    end
end

% Step 4: Supplement constant term (optional, if a complete regression model (including intercept) is needed)
% Note: LAR itself outputs coefficients of centralized data. To restore the regression model of original data, the intercept needs to be calculated.
% intercept = mean(m_original) - mean(a_original, 1) * beta;
end