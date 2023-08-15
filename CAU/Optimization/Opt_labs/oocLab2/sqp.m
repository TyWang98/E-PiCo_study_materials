function out_ = sqp(handles_, param_)
  % local function handles
  gradfFun = handles_.gradfFun;
  hessfFun = handles_.hessfFun;
  gFun     = handles_.gFun;
  gradgFun = handles_.gradgFun;
  hessgFun = handles_.hessgFun;
  
  % general parameters
  maxIter = param_.maxIter; 
  tol     = param_.tol;
  xk      = param_.xStart; 
  lamk    = param_.lamStart;
  
  % initialize
  xIter   = xk;
  lamIter = lamk;
  k       = 0;
  gk      = gFun(xk);
  n       = length(xk);
  p       = length(gk);
  gradfk  = gradfFun(xk);
  hessfk  = hessfFun(xk);
  gradgk  = gradgFun(xk);
  hessgk  = hessgFun(xk);
  rk      = inf*ones(n,1);
  
  % Main loop
  while ( k < maxIter && norm(rk) > tol ) 
    %%================== Hessian of Lagrangian L(xk,lamk) ==================%%
    % !!!!!!!!!!The rest is your task in exercise 1 (ii) and (iv)!!!!!!!!!!
    L = hessfk + hessgk*lamk;
    %%================== \nabla_w F(wk) ==================%%
    % !!!!!!!!!!The rest is your task in exercise 1 (ii)!!!!!!!!!!
    KKT = [ L, gradgk;
            gradgk', 0 ];
    %%================== F(wk) ==================%%     
    % !!!!!!!!!!The rest is your task in exercise 1 (ii)!!!!!!!!!!
    F = [ gradfk + gradgk*lamk;
          gk ];
    %%================== Newton Iteration ==================%%     
    % !!!!!!!!!!The rest is your task in exercise 1 (ii)!!!!!!!!!!
    rk = -KKT\F;
    %%================== Update values ==================%%
    % !!!!!!!!!!The rest is your task in exercise 1 (ii)!!!!!!!!!!
    xkp1 = xk + rk(1:n);
    lamkp1 = lamk + rk(n+1:n+p);
    gkp1      = gFun(xkp1);

    gradfkp1  = gradfFun(xkp1);
    hessfkp1  = hessfFun(xkp1);
    gradgkp1  = gradgFun(xkp1);
    hessgkp1  = hessgFun(xkp1);

    xIter = [xIter, xkp1];
    lamIter = [lamIter, lamkp1];
    %%================== Damped BFGS update ==================%%
    % !!!!!!!!!!The rest is your task in exercise 1 (iv)!!!!!!!!!!

    
    %%================== Shift iteration count k ==================%%
    k      = k + 1;
    xk     = xkp1;
    lamk   = lamkp1;
    gk     = gkp1;
    gradfk = gradfkp1;
    gradgk = gradgkp1;
    hessfk = hessfkp1;
    hessgk = hessgkp1;
  end
  
  % Write solution to output
  if maxIter == k
    out_.converged = false;
  else
    out_.converged = true;
  end
  out_.iterations  = k;
  out_.normStep    = norm(rk);
  out_.xOpt        = xk;
  out_.lamOpt      = lamk;
  out_.iter.x      = xIter(:,1:k);
  out_.iter.lam    = lamIter(:,1:k);
end
