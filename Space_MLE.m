%                          Optimization
% =========================================================================
function [ParamNew, AICNew]=Space_MLE(u,param0,fai,HandelName,iter)
fprintf('================================================ \n')
if isempty(param0)
    param0=[1  0.1  0.8  0.5  1.2 0.05 1.5 0.8];
    disp('Notice Initial parameters are not given!');
end

if nargin < 5
    iter='iter';
end
if (iter)
    iter='iter';
else
    iter='off';
end
Opt = optimoptions('fmincon', ...
    'Algorithm', 'interior-point', ...
    'Display',iter , ...
    'MaxIterations', 250, ...
    'StepTolerance', 1e-5, ...
    'ConstraintTolerance', 1e-5);
switch HandelName
    case 'finite'
        % Version 1 >> Finite space and Finite time
        FuncHandel = @(param) Space_AICValue(u, param,fai);
        % mu,A,alpha,c,p,d,q,gama
        lb = [1e-4 1e-4 1e-4 1e-6  1.001  1e-8  1.001  1e-5];
        ub = [ 5   10   10   1     2.5   10   10     10];
    case 'infinite1'
        % Version 2 >> Infinite space and Finite time
        FuncHandel = @(param) Space_AICValue_Inf1(u,param);
        % mu,A,alpha,c,p,d,q,gama
        lb = [1 1e-4 1e-4 1e-4 1.001 1e-4 1.01 1e-4];
        ub = [1   10   10   1     2.5   5   10     5];
    case 'infinite2'
        % Version 2 >> Infinite space and Finite time
        FuncHandel = @(param) Space_AICValue_Inf2(u,param);
        % mu,A,alpha,c,p,d,q,gama
        lb = [1 1e-4 1e-4 1e-4 1.001 1e-4 1.01 1e-4];
        ub = [1   10   10   1     2.5   5   10     5];
end


tic;
[ParamNew,AICNew,exitflag,~]=fmincon(FuncHandel,param0,[],[],[],[],lb,ub,[],Opt);
toc;
fprintf(['The New Parameter should be \n', num2str(ParamNew)]);
fprintf('\n');
fprintf(['The New AIC value should be \n', num2str(AICNew)]);
fprintf('\n');
end