

%test records:
x_0 = [(0.7 - Ca_ss )/Ca_ss; (300 - T_ss)/T_ss ] 
u_0 = (u_s - u_s)/u_s;
d_min = -0.002;              
d_max = 0.002; 
Q = 0.1.*diag([0.1;1]);       
R = 0.1.*eye(m);             
N = 3; 
lb_X = [-1;-1];       
ub_X = [1;1];             
lb_U = -1;                
ub_U = 1; 

% I have saved the data stored as dataset1. 
% The result is depressing, becuase the bound of the input is not touched
% and the reaction tempeacture does not converges to zero. 
