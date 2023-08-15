function lfh = Lfh(f,h,x,k)
    lfh = h; % k=0
    for i = 1:k
        lfh = jacobian( lfh, x )*f;
    end
end