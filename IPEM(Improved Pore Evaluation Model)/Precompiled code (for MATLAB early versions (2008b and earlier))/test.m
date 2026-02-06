% 1. Generate simulated test data (1D column vector a for independent variable, m for dependent variable, with a small amount of noise)
rng(123);  % Fix random seed for reproducible results
n = 50;    % 50 samples
a = randn(n, 1);  % Independent variable a: 1D column vector (normally distributed random numbers)
m = 2 * a + 0.5 * randn(n, 1);  % Dependent variable m: y=2x+noise, 1D column vector

% 2. Call the LAR algorithm function
[beta_lar, beta_path, lar_steps] = lar_algorithm(a, m);

% 3. Output results
fprintf('Final regression coefficient of LAR algorithm: %.4f\n', beta_lar);
fprintf('Number of iteration steps of LAR algorithm: %d\n', lar_steps);
fprintf('----------------------------------------\n');

% 4. Comparison with Ordinary Least Squares (OLS) (verify the correctness of the results)
beta_ols = (a' * a) \ (a' * m);
fprintf('Regression coefficient of Ordinary Least Squares (OLS): %.4f\n', beta_ols);

% 5. Plot results (regression coefficient path + original data fitting plot)
figure;

% Subplot 1: LAR coefficient path (only 1 straight line for 1D independent variable)
subplot(1,2,1);
plot(0:lar_steps, beta_path', 'b-', 'LineWidth', 1.5);
xlabel('Number of Iteration Steps');
ylabel('Regression Coefficient');
title('LAR Algorithm Regression Coefficient Path');
grid on;

% Subplot 2: Original data and LAR fitting results
subplot(1,2,2);
plot(a, m, 'ro', 'MarkerSize', 4, 'DisplayName', 'Original Data');
hold on;
% Generate fitting line
a_fit = linspace(min(a), max(a), 100);
m_fit = beta_lar * a_fit;  % Fitting result of centralized data (intercept can be supplemented if needed)
plot(a_fit, m_fit, 'b-', 'LineWidth', 1.5, 'DisplayName', 'LAR Fitting Line');
xlabel('Independent Variable a');
ylabel('Dependent Variable m');
title('LAR Algorithm Fitting Results (1D Data)');
legend;
grid on;
hold off;