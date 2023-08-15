function out_ = lineSearch(handles_, param_)
  % general parameters
  xk      = param_.xStart;
  maxIter = param_.maxIter; 
  tol     = param_.tol;
  % step length method
  stepLengthMethod = param_.alphak.method;
  % search direction method
  searchDirectionMethod = param_.sk.method;
  % betaMethod
  betaMethod = param_.betak.method;

  % local function handles
  fFun      = handles_.fFun;
  gradfFun  = handles_.gradfFun;
  hessianFun = handles_.hessianFun;
  
  % initialize
  k         = 0;
  fDist     = 1e5;
  xIter     = xk;
  alphaIter = [];
  fk        = fFun(xk);
  gradfk    = gradfFun(xk);
  gradfkm1  = gradfFun(xk);
  hessianfk = hessianFun(xk);
  Hk = eye(2,2);
    
  % Main loop
  while ( k < maxIter && fDist > tol ) % <<<<<<= This is your task in exercise 1 (vi)!!!!!!!!!!
  % while ( k < maxIter && norm(alphak*sk) > tol )
    %%================== Search direction ==================%%
    switch searchDirectionMethod
      case 'steepestDescent'
        sk = -gradfk;

      case 'conjugatedGradient'
        if k == 0
            sk = -gradfk;
            betak = 0;
        else
            switch betaMethod
                case 'FR'
                    betak = (transpose(gradfk)*gradfk)/(transpose(gradfkm1)*gradfkm1);
                case 'PR'
                    betak = (transpose(gradfk)*(gradfk-gradfkm1))/(transpose(gradfkm1)*gradfkm1);
            end
        end
        sk = -gradfk + betak*sk;

      case 'newton' 
        sk = -hessianfk\gradfk;
      case 'quasiNewton'
        sk = -Hk*gradfk;          
      otherwise
        error('Not implemented line search method!')
    end

    %%================== Step length ==================%%
    switch stepLengthMethod
      case 'wolfe'
        alphak = wolfe(fFun, xk, sk, fk, gradfk, param_);
      case 'quadraticInterpolation'
        % !!!!!!!!!!The rest your task in exercise 1 (iii)!!!!!!!!!!
      otherwise
        error('Not implemented step length method!')
    end
        
    %%================== Iterate ==================%%     
    switch searchDirectionMethod
        case 'newton'
            xkp1 = xk + alphak*sk;
        otherwise
            xkp1 = xk + alphak*sk;
    end

    %%================== Update values ==================%%
    fkp1      = fFun(xkp1);
    gradfkp1  = gradfFun(xkp1);
    hessianfkp1 = hessianFun(xkp1);
    fDist     = abs(fkp1);
    xIter     = [xIter xkp1];
    alphaIter = [alphaIter alphak];
    if searchDirectionMethod == 'quasiNewton'
        pk = xkp1 - xk;
        qk = gradfkp1 - gradfk;
        Hkp1 = Hk + (pk*pk')/(pk'*qk)-(Hk*(qk*qk')*Hk)/(qk'*Hk*qk);
        Hk = Hkp1;
    end
    
    %%================== Shift iteration count k ==================%%
    k      = k + 1;
    xk     = xkp1;
    fk     = fkp1;
    gradfkm1 = gradfk;
    gradfk = gradfkp1;
    hessianfk = hessianfkp1;
  end
  
  % Write solution to output
  if maxIter == k
    out_.converged = false;
  else
    out_.converged = true;
  end
  out_.iterations = k;
  out_.fDist      = fDist;
  out_.xOpt       = xk;
  out_.iter.x     = xIter;
  out_.iter.alpha = alphaIter;
end