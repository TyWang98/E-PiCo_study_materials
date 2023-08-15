%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Introduction in Matlab/Simulink
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% This sample file is used to learn the basic Matlab commands. It is a so-called 
% m-file, in which the code can be combined to a file and executed directly. 
% Besides this m-file the code can also be entered and executed directly in the 
% Command Window behind the ">>" prompt. 

% The percent sign is used in Matlab for embedding comments. Furthermore it is 
% possible to divide the source code into sections by two successive percent 
% signs. The file is executed either by entering the file name in the Command 
% Window or by pressing the F5 key. Individual sections can be executed by the 
% combination CTRL+Enter. Individual lines in the program code can still be 
% marked and executed by pressing the F9 key.  

% The result of the evaluations appears in the Command Window. It is evaluated 
% line by line. If the program line ends with a semicolon, the output is 
% suppressed.

%%

% When starting a new program, all old variables should be deleted and all open
% windows should be cleared


clear all   % All variables are deleted
close all   % All additional windows are closed
clc         % Resets the Command Window

%%

% Matlab Help: There is a help for all Matlab commands, which is displayed  
% either directly in the command window or in an additional help window (the  
% help also contains very good tutorial examples

help sqrt  % Help in Command Window
%doc sqrt  % Help in documentation (mostly more detailed)

%%

% Assignments in Matlab: Matlab uses floating point numbers by default
% (double: 64 Bit).

variable_1 = 2;    % The semicolon suppresses the output
variable_2 = 2.0;  % No difference to before
variable_3 = 4e5   % By omitting the semicolon, the result of the line is output
variable_3  = variable_1 % Overwriting of variables             
                   
% Some variables are predefined

variable_4 = pi    % Pi
variable_5 = i     % Complex unit
variable_6 = j     % Complex unit
variable_7 = eps   % Floating point accuracy
variable_8 = NaN   % Not a number, invalid result

% Assigning string variables

variable_9 = 'Hello World'  % Input of names with quotation marks
variable_10 = strcat('Hello', ' World') % Joining strings

%%

% Mathematical functions and operators 

v1 = 2;
v3 = 3;

v1+v3   % Addition
v1*v3   % Multiplication
v1-v3   % Subtraction
v1/v3   % Division

mod(v1,v3)  % Modulodivision
rem(v1,v3)  % Rest of Division

sqrt(v1)    % Square root
exp(v1)     % Exponential function
log(v1)     % Natural logarithm
log10(v1)   % Decadic logarithm

abs(v1)     % Absolute value
sign(v1)    % Signum
round(v1)   % Rounding (commercial, half away from zero)
ceil(v1)    % Rounding up
floor(v1)   % Rounding down

real(2+i)   % Real part
imag(2+i)   % Imaginary part
conj(2+i)   % Complex conjugation
angle(2+i)  % Phase of a complex number

sin(v1)     % Sine
cos(v1)     % Cossine
tan(v1)     % Tangent
cot(v1)     % Cotangen


%%

% Input of vectors and matrices

zv  = [1,2,3]   % Row vector 
sv  = [1;2;3]   % Column vector
zv2 = 1:1:5     % Row vector [1 2 3 4 5]  
                % Usage start:(step:)end
                % The parameter step is optional
zv3 = 1:2:5     % Row vector [1 3 5]
zv4 = linspace(1,2,0.1)  

zv5 = [zv zv3]  % Joining vectors

% Input of matrices

matr1 = [1 2;3 4] % 2x2 Matrix
matr2 = ones(3)   % 3x3 One matrix
matr3 = zeros(4,2)% 4x2 Zero matrix
matr4 = randn(4)  % 4x4 Random matrix (Gaussian distribution)
matr5 = rand(4)   % 4x4 Random matrxi with values between 0 and 1 
                  % (uniform distribution)
matr6 = eye(3)    % 3x3 Identity matrix 

% More predefined numbers, matrices and vectors can be found here
% doc elmat              

% Access to entries of vectors and matrices

zv(2)           % Second element of zv
zv(end)         % Last element of zv
matr1(2,2)      % Element of the second row and second column
length(zv)      % Lenght of the vector zv (Number of elements)
size(matr1)     % Size of the matrix matr1
matr2(1:2,2:3)  % Accessing certain submatrices

% Calculations with matrices and vectors

det(matr1)      % Determinant of the matrix
rank(matr1)     % Rank of the matrix
eig(matr1)      % Eigenvalues of the matrix
inv(matr1)      % Inverse of the matrix
matr1'          % Transpose of the matrix

zv*zv'          % Scalar product
zv'*zv          % Outer product
zv.*zv          % Executing the multiplication element wise

matr1*[1;2]     % Matrix vector product
matr1^2         % Matrix square

[min1,min2] = min(zv) % Minimum and position of the minimum of a vector
[max1,max2] = max(zv) % Maximum and position of the maximum of a vector
mean(zv)        % Mean value of a vector
std(zv)         % Standard deviation from the mean value of a vector
sum(zv)         % Sum of the vector elements
prod(zv)        % Product of the vector elements

%%

% Structures and cells

% In order to manage complex related data in a clear way, the use of structures
% is recommended. The fields are accessed by using the "." operator 

% Create a structure

stru1 = struct('name','Albert','age',21)    % With the struct function
stru2.name = 'Albert'                       % With the dot operator
stru2.age = 129

% The access to the structure is analog

% Nested structure

stru3.name.vorname = 'Albert'
stru3.name.nachname = 'Einstein'
stru3.age = 129

% Create a second entry in the structure

stru3(2).name.vorname = 'Isaac'
stru3(2).name.nachname = 'Newton'
stru3(2).age = 366


% Cell arrays: Mostly used to store different data

zell1 = cell(2,2)      % Create a cell with the cell command
zell1{1,1} = 1         % Access to the elements with curly brackets
zell1{1,2} = [1;2]
zell1{2,1} = 'Hello World'
zell1{2,2} = date

zell2{1,1} = 1         % Direct creation without prior declaration
zell2{1,2} = [1;2]
zell2{2,1} = 'Hello World'
zell2{2,2} = date



%%

% Branches and loops

% If-Branch

var = 3;

if var > 1 
    sprintf('The variable is larger than 1') % Output in Command Window
else
    sprintf('The variable is smaller or equal to 1')
end

% Nested conditions

if ((var > 1) && (var<3))
    sprintf('The variable is between 1 and 3')
elseif (var > 3)
    sprintf('The variable is larger than 3')
else
    sprintf('The variable is smaller than 1')
end

% Case instruction

switch var case 1; a=1, case{3,4,5}; a=5, otherwise a=10, end

% Loops

for i=1:2:10
    sprintf(strcat('The current index is: ',num2str(i))) 
    % Converting numbers to strings with the num2str command
    pause(1)     % Introducing pauses in the output
end

k=0;

while k<5
    sprintf(strcat('The current index is: ',num2str(k))) 
    % Converting numbers to strings with the num2str command
    pause(1)     % Introducing pauses in the output
    k=k+2;
end

% Canceling loops (and m-code in general) is possible with the break command


while k>0
    sprintf(strcat('The current index is: ',num2str(k))) 
    % Converting numbers to strings with the num2str command
    pause(1)     % Introducing pauses in the output
    if k>10
        sprintf('Loop cancelled')
        break
    end
    k=k+2;
end

% Note:      If an endless loop has been created unintentionally (or does not 
%            terminate another calculation), it can be interrupted with CTRL+C

%%

% Matlab functions:
% These are special m-files, which can be passed parameters and then return the 
% result of the function. The name of the function must always be the same as 
% the name of the m-files Syntax: function [out] = name(in) End of function 
% with end

help mean_value   % Output of the help

mean_value(2,3)   % Output of the result

% Note: Variables in a function are local unless otherwise declared. 
% However, this should be avoided if possible.

%% 

% Data export:
% Data is exported in Matlab by default as so-called mat-file

vasa = [1 2 3];

save sav_dat vasa % Saving the vector vasa in the file sav_dat.mat

vasa2 = [4 5 6];

save sav_dat -append vasa2  % Append the vector vasa2 to the existing file

clear all

load sav_dat.mat   % Load a mat-Datei
vec = load('sav_dat.mat') % Direct assignment to a variable

% Further data exports and imports

vasa = [1 2 3];

save sav_dat_asc.txt -ascii vasa   % Save in an ascii file (e.g. txt)
clear all
load -ascii sav_dat_asc.txt  % Loading the ascii file

%%

% Final note: Some additional features

% Create a stop watch to output the calculation time

tic
toc

tic
pause(1)
toc

% Specification of the variables in the working memory

who 
whos  % Output of variable type


% Deleting single variables

a = 1;
clear a
