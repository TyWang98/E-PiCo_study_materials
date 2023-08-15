function lglfh = LgLfh(f,g,h,x,k)
    if k == 0
        lglfh = Lfh(g,h,x,1); % Lgh
    else
        lglfh = jacobian( Lfh(f,h,x,k), x )*g; % L(g)L^k(fh)
    end
end