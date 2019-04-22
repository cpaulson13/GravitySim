function [body] = r_fragment(body, n, mass, vecScalar)
% function R_FRAGMENT recursively fragments the mass into two unequal pieces
% with random velocities such that mass and momentum are conserved.
% 
% INPUT: [body, n, mass, vecScalar]
%   'body' is a STRUCT
%       with 'pos', 'rad', 'vel', 'mass'
%   'n' is a SCALAR
%       The number of times to split the mass, so 2^n fragments are created
%    'mass' is a SCALAR
%       The amount of mass to fragment 
%    'vecScalar' is a SCALAR
%       Used to scale the initial velocities of the fragments
%
% OUTPUT: [body]
%   'body' is a STRUCT
%       with updated 'mass' and 'vel'

%% Exit condition
if n == 0
    pos = [0,0,0];
    vel = [0,0,0];
    % Initialize particle at origin in it's own inertial frame of
    % reference, where velocity is 0
    body = m_Body(body, mass, pos, vel);
    return
end

%% Recursive Splitting
% Randomly split mass
massSplit = rand(1);
m1 =    massSplit *mass;
m2 = (1-massSplit)*mass; % Conserve mass

% Randomly choose nonzero scalar
vSign = randi([0 1], 1,3); % vSign entries are either 0,1; need nonzero scalar
vSign = vSign - ~vSign; % Converts 1 -> 1, 0 -> -1

% Randomly decide vector
v1 = rand(1,3).*vSign*vecScalar;
v2 = -(m1 / m2)*v1; % Conserve momentum

% Create structs to pass into nFragment
body1 = m_BodyStruct(1);
body2 = m_BodyStruct(1);

% Call split function on new masses
body1 = r_fragment(body1, n-1, m1, vecScalar);
body2 = r_fragment(body2, n-1, m2, vecScalar);

% Calling r_fragment recursively steps into a new inertial frame of
% reference for new mass. Therefore, the velocity of this inertial frame
% needs to be added to ALL mass in this frame
for k = 1:size(body1,2)
    body1(k).vel = body1(k).vel + v1;
    body2(k).vel = body2(k).vel + v2;
end

% Concatonate elements and return
body = [body1, body2];