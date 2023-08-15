function adfg_k = adfg(f,g,x,k)
    adfg_k = g; % k=0
    for i = 1:k
        adfg_k = jacobian( adfg_k, x )*f - jacobian(f, x)*adfg_k;
    end
end