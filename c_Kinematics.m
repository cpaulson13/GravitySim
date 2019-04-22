function [obj] = c_Kinematics(obj, dt)
% function C_KINEMATICS calculates the new position and veloctiy of the
% object using semi-implicit Euler discretization
%
% INPUT: [obj, dt]
%   'obj' is a  STRUCT
%       with fields 'pos', 'vel', 'force'
%   'dt' is a SCALAR
%       Differential time step used in the differentiation
% OUTPUT: [obj]
%   'obj' is a  STRUCT
%       With fields updated 'pos', 'vel', 'force'
% 
% The velocity of the object is calculated based on the force on the object
% using explicit Euler discretization. This newly calculated velocity is
% used to update the position of the object. The force is reset to [0 0 0]
% and the 'obj' struct is returned.

% Update velocity (explicit)
obj.vel = obj.vel + (obj.force ./ obj.mass) * dt;

% Update position (implicit)
obj.pos = obj.pos + obj.vel*dt;

% Need to reset forces!
obj.force = [0,0,0];
end