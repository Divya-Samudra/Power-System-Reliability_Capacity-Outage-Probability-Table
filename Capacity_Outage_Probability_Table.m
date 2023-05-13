%answers to be verified
% Program to generate COPT of n generators without degraded states
clc; clear all;
% input generator data nx3 matrix
display('Input- Generation data:')
display('Column-1: Generator no. Column-2:Capacity(MW) Column-3:FOR')
%gen_data = [1 25 0.02; 
            %2 25 0.02; 
            %3 30 0.02]
gen_data = [1 10 0.08; 2 20 0.08; 3 30 .08; 4 30 .08];
C = gen_data(:,2);
n = length(gen_data(:,1));
FOR = gen_data(:,3);
% gen-1
X1 = [0 C(1)];
P = [1 0 1; 2 C(1) FOR(1)];
for i =2:n
    P_pre =P;
    %gen = i
    X2 = []; % Capacity Outages
    X1 = [X1 X1+C(i)];
    for  j = X1  %removing repetition
        if(~ismember(j,X2))
            X2 = [X2 j];
        end
    end
    X = sort(X2);%ascending order
    for j = 1:length(X)
        X3 = X(j);
        X4 = X3-C(i);
        [a] = Recursive(P_pre,X3);
        [b] = Recursive(P_pre,X4);
        P1 = (1-FOR(i))*a + FOR(i)*b;
        P(j,:) = [j X(j) P1];
    end
end
display('Output- Capacity Outage Probability Table:')
display('Column-1: State no. Column-2:X(MW) Column-3:Probability')
COPT = P