function [body] = c_Fragment(mass, vi, xi, n, dt, vS)
% function C_FRAGMENT splits the given mass into 2^n randomly sized
% bodies with initial velocities to conserve momentum
%
%   INPUT: [mass, vel, n]
%   'mass' is a SCALAR
%       The total mass of the universe
%   'vi' is a 1x3 VECTOR
%       The initial velocity of the mass
%   'xi' is a 1x3 VECTOR
%       The initial position of the mass
%   'n' is a SCALAR
%       The number of splits (produce's 2^n bodies)
%   'dt' is a SCALAR
%       The discrete timestep of the simulation
%       Used to move the objects forward in time after the explosion to
%       avoid 
%   'vS' is a SCALAR 
%       The "vector scalar"
%       Used to adjust the 'explosiveness' of the fragmentation - larger
%       vector scalar gives each mass a high initial velocity
% 
%   OUTPUT: [body]
%   'body' is a STRUCT
%       The newly initialized bodies are returned in a struct
%
% Split the given mass into 2^n fragments with call to function R_FRAGMENT.
% The velocity of each fragment is calculated to conserve the total momentum of
% the system, which is initially [0,0,0]. Once the mass and velocities are
% determined, the position is found one timestep into the future to avoid
% placing all pieces at the same position. The mass, vel and pos are then
% passed to M_BODY, and the struct containing all bodies is
% returned.

% Fragment mass 2^N times
body = m_BodyStruct(1);
body = r_fragment(body, n, mass, vS);

% Add initial velocity to all elements
% Move body forward one time step to get position and avoid nonzero separation
% distances

% Change to use m_Body
for k = 1:size(body,2)
    newVel = body(k).vel + vi;
    newPos = xi + body(k).vel*dt;
    body(k) = m_Body(body(k), body(k).mass, newPos, newVel);
end

% % Uncomment for Sanity Check: 
% % All mass should be accounted for, momentum of entire system
% % should be conserved (with roundoff errors)
% 
% fprintf('Initial mass of system: %.0f\n', mass);
% fprintf('Initial momentum of the system: ');
% disp(mass*vi)
% 
% % Calculate totalMass and momentum
% totalMass = sum([body.mass]);
% momentum = sum([body.mass].*reshape([body.vel], 3, size(body,2)), 2);
% 
% fprintf('Total mass of system: %.0f\n', totalMass);
% fprintf('Total momentum of the system: ');
% disp(momentum')
end