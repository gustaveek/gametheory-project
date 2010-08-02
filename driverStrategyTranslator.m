clc; clear; clf;

vector = zeros(100,1);
for i = 1:100
    vector(i) = strategyTranslator(i);
end

plot(vector,1:100)
grid on;
axis([0 1 0 100])
