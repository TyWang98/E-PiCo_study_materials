% 3 hp Machine
hp1 = 3;
Pn1 = hp1 *0.746 *1e3;
Vn1 = 220; % line-to-line
fn1 = 60;
Rs1 = 0.435;
Lls1 = 0.754/(2*pi*fn1);
Rr1 = 0.816;
Llr1 = Lls1;
Lm1 = 26.13/(2*pi*fn1);
J1 = 0.089;
F1 = 0;
p1 = 4/2;

% 50hp Machine
hp2 = 50;
Pn2 = hp2 *0.746 *1e3;
Vn2 = 460; % line-to-line
fn2 = 60;
Rs2 = 0.087;
Lls2 = 0.302/(2*pi*fn2);
Rr2 = 0.228;
Llr2 = Lls2;
Lm2 = 13.08/(2*pi*fn2);
J2 = 1.662;
F2 = 0;
p2 = 4/2;

% 500hp Machine
hp3 = 500;
Pn3 = hp3 *0.746 *1e3;
Vn3 = 2300; % line-to-line
fn3 = 60;
Rs3 = 0.262;
Lls3 = 1.206/(2*pi*fn3);
Rr3 = 0.187;
Llr3 = Lls3;
Lm3 = 54.02/(2*pi*fn3);
J3 = 11.06;
F3 = 0;
p3 = 4/2;

% 2250hp Machine
hp4 = 2250;
Pn4 = hp4 *0.746 *1e3;
Vn4 = 2300; % line-to-line
fn4 = 60;
Rs4 = 0.029;
Lls4 = 0.0226/(2*pi*fn4);
Rr4 = 0.022;
Llr4 = Lls4;
Lm4 = 13.04/(2*pi*fn4);
J4 = 63.87;
F4 = 0;
p4 = 4/2;