% A and B are the amplitudes, 
% a and b are the frequencies, 
% and p is the phase shift.

function lissajous(A, a, B, b, p)
    t = 0:0.01:2*pi;
    x = A*sin(a*t + p);
    y = B*sin(b*t);
    plot(x, y);
    xlabel('x');
    ylabel('y');
    title('Lissajous Figure');
    grid on;
end

% to get a spiral
% lissajous(1, 1, 1, 4, pi/2)
% lissajous(1, 1, 1, 4, 0)

% to get a figure-eight
% lissajous(1, 1, 1, 2, 0)

% to get a straight line
% lissajous(1, 1, 2, 1, 0)

% to get a vertical oval
% lissajous(1, 1, 2, 1, pi/2)