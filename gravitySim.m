function [] = gravitySim(body, G, dt, tFinal, activate_frag, activate_stars)
% function GRAVITYSIM runs the gravity simulation with the provided bodies
% and constants
%   INPUT: [body, G, dt, tFinal]
%     'body' is a STRUCT
%         stores all necessary data about each body in simulation
%         initialized with call to m_BodyStruct
%     'G' is a SCALAR
%         represents the gravitational constant in units
%         N*m^2/(kg^2)
%     'dt' is a SCALAR
%         Time step of simulation
%     'tFinal' is a SCALAR
%         Duration of simulation
%     'activate_frag' is a Booleon
%         If true, fragmentation activated; if false fragmentation turned
%         off
%  
% The gravitational forces experienced by each object are calculated, and
% the resulting force is used to calculate each object's acceleration,
% velocity and position. The objects are checked for collisions and either
% accrete or fragment. The simulation then continues at the specified
% time-step for the specified duration.
%
% Body is initialized with a call to 'm_BodyStruct' and values assigned
% with 'm_Body'.
%
% Fragmentation behavior can be toggled on and off using 'activate_frag'
% Starry background can be toggled on and off using 'activate_stars'
% Additional display options can be modified in 'm_Figure'

tSteps = abs(ceil(tFinal/dt));
numBodies = size(body,2);

% Initialize FIGURE
if activate_frag
    numSpheres = numBodies*4; % Four times as many spheres to allow fragmentation
else 
    numSpheres = numBodies;
end
% Set up figure/display settings
[sHandle, sx, sy, sz] = m_Figure(body, numSpheres, activate_stars);

% Begin Gravity simulation
for t = 1:tSteps
    
    % Check for overlap for all bodies, accrete or fragment
    % Done first to prevent dX = 0 -> NaN force/pos/vel
    [body, numBodies] = c_Collision(body, dt, activate_frag);
    
    % Calculate gravitational force between objects
    for k = 1:numBodies-1
        for j = k+1:numBodies
            [body(k), body(j)] = c_GravForce(body(k), body(j), G);
        end
    end
    
    % Update kinematics
    for k = 1:numBodies
        body(k) = c_Kinematics(body(k), dt);
    end
    
    % Display
    sHandle = c_Sphere(sHandle, body, sx, sy, sz);
    drawnow
end