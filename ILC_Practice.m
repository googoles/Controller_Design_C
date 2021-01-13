% uk_1(t) = uk(t) + gamma*e_k(t+1) 
% A Typical ILC Algorithm
function [ ] = ILC()
s = tf('s');
A = [-0.8 -0.22;
    1 0];
B = [0.5;
    1];
C = [1 0.5];
D = [0];
Ts = 1/100;

sys = ss(A,B,C,D);
sys_d = c2d(sys,Ts,'zoh')

% Track the reference trajectory

% Y_d = sin(8.0/100);
x0 = 0; % initial condition
t = 0:Ts:1; % time range
n0 = 0; % pure time delay
r = 1; % relative degree
N = length(t); % matrix size

U = [zeros(1,10) 10*ones(1,10) zeros(1,10) 10*ones(1,11)];
Rj = [zeros(1,10) 20*ones(1,10) zeros(1,10) 20*ones(1,11)];

% G0 is not generated on the initial condition
% Generate G

Gvec = zeros(N,1);
rvec = ((r-1):(N-n0-1))';

for ii = 1:length(rvec)
    ApowVec = A^rvec(ii);
    Gvec(ii) = C*ApowVec*B;% Gain
end

jmax = 25;
l0 = 0.95;
q0 = 1;
Y_dj = sin(8.0*t/100);
L = l0 * eye(N,N);
Q = q0 * eye(N,N);
I = eye(N);
Uj = zeros(N,1); Ujold = Uj;
Ej = zeros(N,1); Ejold = Ej;
e2k = zeros(jmax,1);

for ii = 1:jmax
  Uj = Q*Ujold + L*Ejold;
  Yj = G*Uj;
  Ej = Rj - Yj; Ej(1) = 0;
  Ejold = Ej;
  Ujold = Uj;
  plotter(ii,t,Ej,Yj,Uj,Rj,U)
%   plot(t,y_dj)
  e2k(ii) = Ej'*Ej;
end

end

function [] = plotter(ii,t,Ej,Yj,Uj,Rj,U)
  figure(1)
  % Plot the error Ej of the current itteration
  subplot(1,3,1);
  plot(t,Ej,'LineWidth',1.5);
  title('Error, Ej','FontSize',16);
  ylabel('Error Response','FontSize',16);
  % Plot the input Uj of the current itteration
  subplot(1,3,2);
  plot(t,Uj,t,U,'-k','LineWidth',1.5);
  title({['Iteration: ', num2str(ii)],'Input, Uj'},'FontSize',16);
  xlabel('Time (s)','FontSize',16);
  ylabel('Input Response','FontSize',16);
  % Plot the output Yj of the current itteration
  subplot(1,3,3);
  plot(t,Yj,t,Rj,'-k','LineWidth',1.5);
  title('Output, Yj','FontSize',16);
  ylabel('Output Response','FontSize',16);
  pause(0.1);
end
