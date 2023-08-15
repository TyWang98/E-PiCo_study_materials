
%  Title: oocLabTutorial.m
%
%  Other files required: none
%  Included subfuntions: none
%  Specific data required (.mat,.csv): none
%
%  Author: Dirk Siebelts, Simon Helling
%  Email: {disi,sh}@tf.uni-kiel.de
%  Website: https://www.control.tf.uni-kiel.de
%  Creation date: 19.11.2020
%  Last revision: 19.11.2019
%  Last revision author: Simon Helling
%
%  Copyright (c) 2019, ACON Kiel
%  All rights reserved.

% Optimization and optimal control exercise tutorial
%
% Introduction:
%  This demonstrates the general functionality of Matlab
%

clear all % clears all variables in the workspace
close all % closes all figures
clc       % clears the command window output




fprintf(['This is the Matlab tutorial for the optimization\n' ...
         'and optimal control exercise!\n'])
fprintf(['In order to understand the tutorial the user should read the \n'...
         'source code and the program output simultaneously!\n'])

fprintf('==================== Basic math functionality ====================\n')
fprintf('The result of a = 1 + 1 is:\n');
a = 1 + 1

fprintf('The result of b = 1 + 1.5 is:\n');
b = 1 + 1.5

fprintf('The result of c = 2/5 is:\n');
c = 2/5

fprintf('==================== Linear algebra operations ====================\n')
fprintf('In Matlab, everything is a matrix!\n')
fprintf('For example, a the scalar "b" from above is a 1-by-1 matrix\n')
sizeb = size(b)
fprintf('Even a string array is a matrix!')
sizeString = size('This is a 1-by-36 character "matrix"\n')

fprintf('A column vector v can be defined using\n')
v=[1; 2; 3]

fprintf('Or, equivalently, using the transpose of a row vector:\n')
v=[1 2 3]';

fprintf('You can verify that is indeed a column vector with size()\n')
sizev = size(v)

fprintf('A 3-by-3 matrix M can be defined using\n')
M = [10 3 2;
     3 54 5;
     6 7  8.3]

fprintf('The transpose of M is given by\n')
Mt = M'

fprintf('The result of Mv can be calculated using\n')
e = M*v

fprintf('The result of M*M^T is\n')
N = M*M'

fprintf('Element-wise multiplication (Hadamard product) of M with M is done with\n')
L = M.*M

fprintf('The result of 0.5*v is\n')
g = 0.5*v

fprintf('The result of  0.5*M is\n')
H = 0.5*M

fprintf('The result of v^T*M is\n')
j = v'*M

fprintf('The solution of the linear system of equations Mx = v is given by\n')
x = M\v

fprintf('==================== Conditions, loops ====================\n')
% If condition
fprintf('If 2^2 is equal to 4, result1 should be correct!\n')
fprintf('Note, that using ";", you can suppress the output in the console.\n')
if 2^2 == 4
    result1 = 'Correct';
end
result1

% If, else, elseif
fprintf('If tmp is equal to 1, result2 should be 1.\n')
fprintf('Or if tmp is qual to 2, result2 should be 2.\n')
fprintf('If neither of the cases hold, result2 should be "Not Found!"\n')

tmp = 10
if tmp == 1
    result2 = '1';
elseif tmp == 2
    result2 = '2';
else
    result2 = 'Not Found!';
end
result2

% For
fprintf(['Loop over ervery element of the [0 1 2 3]\n' ...
      'and fprintf the element number:\n'])
for ii = 1:4
   ii
end

fprintf('==================== Function definitions ====================\n')
fprintf(['There are three ways in Matlab to define a function:\n'...
      '\t 1. Anonymous functions\n'...
      '\t 2. functions defined in a matlab script file\n'...
      '\t 3. separate .m-file functions\n'])
fprintf('=========== 1. anonymous functions\n')
fprintf('A function that calculates the square of its input:\n')
mySquareFun = @(x_) x_^2; % the "@(x_)" makes it a function depending on "x_"

fprintf(['The anonymous function mySquareFun is a function handle that\n'...
    'you can evaluate using'])
mySquareFun(2)

fprintf(['You can also use local parameters from the Matlab\n'...
      'workspace in anonymous functions, e.g.,\n'])
myVecTimesMatTimesVecFun = @(x_) x_'*M*v;
myVecTimesMatTimesVecFun([3;4;1])

fprintf(['In order to supply additional parameters for any type of function\n'...
      'a struct is a convenient way to do so, e.g.\n'])
s.a = 3;
s.Q = rand(3,3); % this produces a random 3-by-3 matrix
s

fprintf('Which you can pass as an argument to a function\n')
myScaledMatVecProductFun = @(x_,param_) param_.a*param_.Q*x_;
myScaledMatVecProductFun([3;4;2],s)

fprintf(['You can also use anonymous functions to wrap other functions\n'...
      'and pass workspace variables to it, e.g.,\n'])
myWrapperFun=@(x_)deal(mySquareFun(x_(1)),myScaledMatVecProductFun(x_,s));% deal() maps the outputs of its inputs to the wrapper function's output
[squareOfx1,saTimessQtimesX] = myWrapperFun([1 2 3]')

fprintf('=========== 2. functions defined in script files\n')
fprintf(['You can also define a function in a script m-file such as this\n'...
      'one, see "myInScriptWrapperFun" at the end (Matlab)\n'...
      'of this script. This is usually done if the function\n'...
      'is more complex than an anonymous function and is not needed in\n'...
      'other function or script files.\n'])
handles.mySquareFun              = mySquareFun;
handles.myScaledMatVecProductFun = myScaledMatVecProductFun;
[squareOfx12,saTimessQtimesX2] = myInScriptWrapperFun([1 2 3]',s,handles)

fprintf(['Most of the properties of anonymous functions apply to in-script-\n'...
      'defined functions aswell. Therefore, you can pass a structure of\n'...
      'additional parameters, input arguments, wrap other functions, etc.\n'...
      'But be aware that these functions have their own local workspace\n'...
      'and can therefore not access the global (script) workspace. You have\n'...
      'to pass the desired parameters/function handles yourself!\n'...
      'Also, they cannot be accessed by other script or functions from\n'...
      'other files than the one where they are defined!\n'])

fprintf('=========== 3. function defined in separate m files\n')
fprintf(['Lastly, you can define a function in a separate m-file,\n'...
      'see "mySqrtFun". This is usually done if the function is more\n'...
      'complex than an anonymous function and needs to be accessible \n'...
      'by other functions/scripts. Note that the file name should \n'...
      'match the function name. Execution works exactly the same as with \n'...
      'anonymous functions:\n'])
mySqrtFun(2)
fprintf(['All the properties of anonymous functions apply to separately-\n'...
      'defined functions aswell. Therefore, you can pass a structure of\n'...
      'additional parameters, wrap other functions, etc.\n'...
      'But be aware that separately-defined functions have their own local workspace\n'...
      'and can therefore not acces the global (script) workspace. You have\n'...
      'to pass the desired parameters yourself!\n'])
  
  
  
function [a_,b_] = myInScriptWrapperFun(x_,param_,handles_)
    mySquareFun              = handles_.mySquareFun;
    myScaledMatVecProductFun = handles_.myScaledMatVecProductFun;

    a_ = mySquareFun(x_(1));
    b_ = myScaledMatVecProductFun(x_,param_);
end
