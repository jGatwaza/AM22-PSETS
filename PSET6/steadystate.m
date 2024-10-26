P = [0.7, 0.2; 0.3, 0.8];
x0 = [0.6; 0.4]; % 0.6 for 120 and 0.4 for 80.

num_steps = 10;
x = zeros(2, num_steps+1);
x(:,1) = x0;

% loop to calculate state vectors x1 to x10
for n = 1:num_steps
    x(:,n+1) = P * x(:,n);
end

% plot the components
time = 0:num_steps;
component1 = x(1,:);
component2 = x(2,:);
figure;
plot(time, component1, '-o', 'DisplayName', 'Brand A');
hold on;
plot(time, component2, '-o', 'DisplayName', 'Brand B');
xlabel('time (months)');
ylabel('proportion of users');
title('convergence to steady state');
legend;
grid on;
