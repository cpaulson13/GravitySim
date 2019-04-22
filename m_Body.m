function [body] = m_Body(body, mass, pos, vel)
% function M_BODY populates the object's mass, position, and
% velocity based on given input. Then based on mass input and preset rho,
% set the radius of the object.
%
%   INPUT: [body, mass, pos, vel]
%   'body' is a STRUCT
%       The structure storing a single object's parameters
%   'mass' is a SCALAR
%       the mass of the object
%   'pos' is a VECTOR
%       1x3 vector, format [x, y, z]
%       The position of the object
%   'vel' is a VECTOR
%       1x3 vector, format [v_x, v_y, v_z]
%       The velocity of the object
%
%   OUTPUT: [body]
%   'body' is a STRUCT
%       The updated structure with initialize parameters
%
% Store the mass, position, and velocity in the appropriate field in 'body'
% The object's radius and color are calculated based on the object's mass
% and stored in the appropriate fields

% Initialize mass, position, velocity
body.mass = mass;
body.pos = pos;
body.vel = vel;

% Set radius based on mass and density (rho)
rho = 1;
body.rad = ((3*mass) / (4*pi*rho))^(1/3);

% Set the color based on mass
max_mass = 20; % Num of values in colormap
cmap = summer(max_mass); % get colormap values

% If body is bigger than max mass, set as max color
if mass >= max_mass
    c_mass = max_mass;
else
    c_mass = ceil(mass);
end
body.Color = cmap(c_mass, :);

% Currently, mass is rounded up to nearest integer to serve as index
% May change to allow intermediate mass values to have a unique color by
% interpolating the value onto the colormap
end