function alpha_ = wolfe(fFun_, xk_, sk_, fk_, gradfk_, param_)
    alphak   = param_.alphak.wolfe.alpha0;
    epsilon0 = param_.alphak.wolfe.epsilon0;
    rho      = param_.alphak.wolfe.rho;
    
    gk    = fFun_(xk_ + alphak * sk_);
    while (gk > fk_ + epsilon0*alphak*sk_'*gradfk_)
        alphak = rho*alphak;
        gk     = fFun_(xk_ + alphak * sk_);
    end
    alpha_ = alphak;
end