function [body] = m_BodyStruct(numBodies)
% function M_BODYSTRUCT creates a structure with 'numBodies' of
% objects stored.
% 
% INPUT: [numBodies]
%   'numBodies' is a SCALAR
%       The number of body objects to create
% OUTPUT: [body]
%   'body' is a STRUCT
%       The struct containing all objects
% 
% STRUCT FIELDS:
%   'pos' is a VECTOR
%       1x3 vector, format [x, y, z]
%       The position of the object
%   'vel' is a VECTOR
%       1x3 vector, format [v_x, v_y, v_z]
%       The velocity of the object
%   'force' is a VECTOR
%       1x3 vector, format [f_x, f_y, f_z]
%       The force to be applied on the object
%   'mass' is a SCALAR
%       the mass of the object
%   'rad' is a SCALAR
%       The radius of the object
%
% ALL FIELDS ARE INITIALIZED EMPTIED, AND ARE FILLED LATER IN SCRIPT WITH
% CALL TO 'M_BODY'
%
% This function outputs a structure 'body' with 'numBodies' number of
% body fields the necessary fields and format for each

% Initialize 1x3 array for storing pos, vel, force
blank1x3 = zeros(1,3);

% Create array of structs
body(1:numBodies) = struct(...
    'pos', blank1x3, 'vel', blank1x3, 'force', blank1x3, ...
    'mass', [], 'rad', [],...
    'Color', blank1x3);

end