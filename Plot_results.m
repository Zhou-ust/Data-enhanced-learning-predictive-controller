% clc
% clear
close all


% load('dataset1.mat')
% load('datatest1.mat')
load('dataset2.mat')

figure(1); plot(Omega)

min(U_lqr)
max(U_lqr)

%% LQR
% Plot the results
figure(2);
set(gcf,'Position',[200,50,400,300]);  % for smaller figrues used in the paper.
subplot(2,1,1)
plot(time,X_lqr(2,:),'b-','LineWidth',2); hold on;
plot(time,U_lqr,'k-.','LineWidth',2); hold on
plot(time,-0.8.*ones(size(time,2)),'r--','LineWidth',2);hold off
% title(['Temperature is ',num2str(Temp),' C'])
ylim([-1.05,0.05]);
title('LQR ','fontsize',12)
% ylabel('T (K)')
ylabel('Temperature')
legend('Reactor Temperature x_2','Jacket Temperature u','fontsize',10)
%axis([0 40 285 330])
subplot(2,1,2)
plot(time,X_lqr(1,:));
% ylabel('C_a (mol/m^3)','LineWidth',2)
ylabel('C_a','LineWidth',2)
xlabel('Time t','LineWidth',2)
legend('Reactor Concentration  x_1','fontsize',10)



%% linear mpc
min(U_mpc)
max(U_mpc)

figure(3);
set(gcf,'Position',[200,50,400,300]);  % for smaller figrues used in the paper.
subplot(2,1,1)
plot(time,X_mpc(2,:),'b-','LineWidth',2);
hold on;
plot(time,U_mpc,'k-.','LineWidth',2);
plot(time,-0.8.*ones(size(time,2)),'r--','LineWidth',2);
title('Tube-based linear MPC ','fontsize',12)
% ylabel('T (K)')
ylabel('Temperature')
legend('Reactor Temperature x_2','Jacket Temperature u','fontsize',10)
%axis([0 40 285 330])
subplot(2,1,2)
plot(time,X_mpc(1,:));
% ylabel('C_a (mol/m^3)','LineWidth',2)
ylabel('C_a','LineWidth',2)
xlabel('Time t','LineWidth',2)
legend('Reactor Concentration  x_1','fontsize',10)


%% lbmpc
figure(4);
set(gcf,'Position',[200,50,400,300]);  % for smaller figrues used in the paper.
subplot(2,1,1)
plot(time,X_lbmpc(2,:),'b-','LineWidth',2);
hold on;
plot(time,U_lbmpc,'k-.','LineWidth',2);
plot(time,-0.8.*ones(size(time,2)),'r--','LineWidth',2);
title('Our proposed Algorithm 1','fontsize',12)
% ylabel('T (K)')
ylabel('Temperature')
legend('Reactor Temperature x_2','Jacket Temperature u','fontsize',10)
%axis([0 40 285 330])
subplot(2,1,2)
plot(time,X_lbmpc(1,:));
ylabel('C_a','LineWidth',2)
xlabel('Time t','LineWidth',2)
legend('Reactor Concentration  x_1','fontsize',10)



%% plot the results using plot() or stairs()
% plot uncontrolled response
figure(10);
hold on;
box on;
subplot(2,1,1); plot(time,X_un(1,:),'b-o','markersize',3);
title('No Control');
legend({'No Control, $i=1$'},...
    'interpreter','latex','location','northwest','fontsize',15);
subplot(2,1,2); plot(time,X_un(2,:),'b-*','markersize',3);
xlim([min(time),max(time)]);
xlabel('$t$','interpreter','latex','fontsize',15);
ylabel('$x_i(t)$','interpreter','latex');
legend({'No Control, $i=2$'},...
    'interpreter','latex','location','northwest','fontsize',15);
% legend({'No Control, $i=1$','No Control, $i=2$'},...
%     'interpreter','latex','location','northwest','fontsize',15);
set(gca,'ticklabelinterpreter','latex');


% plot controlled response
figure(11);
hold on;
box on;
plot(time,X_lqr(1,:),'r-.o','markersize',3);   %  stairs plot
plot(time,X_lqr(2,:),'r-*','markersize',3);
plot(time,X_mpc(1,:),'g-.o','markersize',3);
plot(time,X_mpc(2,:),'g-*','markersize',3);
plot(time,X_lbmpc(1,:),'b-.o','markersize',3);
plot(time,X_lbmpc(2,:),'b-*','markersize',3);
xlim([min(time),max(time)]);
xlabel('$t$','interpreter','latex');
ylabel('$x_i(t)$','interpreter','latex');
legend({'LQR, $i=1$','LQR, $i=2$',...
    'MPC, $i=1$','MPC, $i=2$'...
    'LBMPC, $i=1$','LBMPC, $i=2$'},...
    'interpreter','latex','location','southeast','fontsize',15);
set(gca,'ticklabelinterpreter','latex');

figure(12);
subplot(2,1,1)
plot(time,X_lqr(1,:),'r-.o','markersize',3,'LineWidth',1); hold on;
plot(time,X_mpc(1,:),'g-.o','markersize',3,'LineWidth',1); hold on;
plot(time,X_lbmpc(1,:),'b-.o','markersize',3,'LineWidth',1); 
title('Comparison results')
ylabel('C_a (mol/m^3)','LineWidth',2)
legend({'LQR', 'MPC', 'LBMPC'},...
    'interpreter','latex','location','southeast','fontsize',15);
%axis([0 40 285 330])
subplot(2,1,2)
plot(time,X_lqr(2,:),'r-*','markersize',3,'LineWidth',1); hold on;
plot(time,X_mpc(2,:),'g-*','markersize',3,'LineWidth',1); hold on;
plot(time,X_lbmpc(2,:),'b-*','markersize',3,'LineWidth',1); 
ylabel('T (K)')
legend({'LQR', 'MPC', 'LBMPC'},...
    'interpreter','latex','location','southeast','fontsize',15);
hold off


% plot control input
figure(16);
hold on;
box on;
stairs(time,U_lqr,'r-','markersize',3,'linewidth',1.5);
stairs(time,U_mpc,'g-.','markersize',3,'linewidth',1.5);
stairs(time,U_lbmpc,'b--','markersize',3,'linewidth',1.5);
xlim([min(time),max(time)]);
xlabel('$t$','interpreter','latex');
ylabel('$u_i(t)$','interpreter','latex');
legend('LQR','MPC', 'LBMPC','location','northwest','fontsize',15);
set(gca,'ticklabelinterpreter','latex');



% plot state, input, disturbance polytopes
figure(18);
hold on;
X.plot('color','r');
U.plot('color','b');
W.plot('color','g');
grid off;
box on;
xlabel('$x_1$ ($\mathcal{X}$, $\mathcal{W}$) or $u$ ($\mathcal{U}$)',...
    'interpreter','latex');
ylabel('$x_2$','interpreter','latex');
legend({'State Polytope, $\mathcal{X}$',...
    'Input Polytope, $\mathcal{U}$',...
    'Disturbance Polytope, $\mathcal{W}$'},...
    'interpreter','latex','fontsize',15);
set(gca,'ticklabelinterpreter','latex');

% plot control invariant set
figure(20);
Omega.plot('color','r');
grid off;
box on;
xlabel('$x_1$','interpreter','latex');
ylabel('$x_2$','interpreter','latex');
legend({'Control Invariant Polytope, $\Omega$'},...
    'interpreter','latex','fontsize',15);
set(gca,'ticklabelinterpreter','latex');

% plot disturbance tubes
figure(25);
hold on;
k = 2:N+1;
for i = 0:length(k)-1
    RT(N+1-i).plot('color','r');
end
grid off;
box on;
xlabel('$x_1$','interpreter','latex');
ylabel('$x_2$','interpreter','latex');
legend({'Disturbance Tubes, $\mathcal{R}_{k}$, $k\in\{1,2,\dots,N\}$'},...
    'interpreter','latex','fontsize',15);
set(gca,'ticklabelinterpreter','latex');



figure(100)
set(gcf,'Position',[200,50,400,300]);  % for smaller figrues used in the paper.
% set(gcf,'Position',[200,50,800,600]);   % for Larger figrues used in the paper.
subplot(121)
Omega.plot('color','r');
grid off;
box on;
xlabel('$x_1$','interpreter','latex','FontSize',12);
ylabel('$x_2$','interpreter','latex','FontSize',12);
legend({'Control invariant polytope, $\Omega$'},...
    'interpreter','latex','fontsize',10);
set(gca,'ticklabelinterpreter','latex');
subplot(122)
hold on;
k = 2:N+1;
for i = 0:length(k)-1
    RT(N+1-i).plot('color','r');
end
grid off;
box on;
xlabel('$x_1$','interpreter','latex','FontSize',12);
ylabel('$x_2$','interpreter','latex','FontSize',12);
legend({'Robust tubes, $\mathcal{R}_{k}$, $k\in\{1,2,\dots,N\}$'},...
    'interpreter','latex','fontsize',10);
set(gca,'ticklabelinterpreter','latex');
hold off
