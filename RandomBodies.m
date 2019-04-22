% Gravity Simulation: Random-Body Demo
% Demonstrates gravitational force in a chaotic system; bodies accrete or
% fragment when they collide. N-Bodies initialized with random position,
% mass and velocities, within a specified range
%
% Copyright Catherine Paulson 2018

% Clean up the MATLAB workspace
clear, close, clc;

% Seed random number generator, save seeding in 's'
s = rng('shuffle');

% INITIALIZE SIMULATION CONTANTS
G = 5; % Gravity constant, large to increase attraction force
dt = 0.1; % Differential time step
tFinal = 40; % Simulation Duration
frag = true; % Fragmentation enabled
stars = true; % Starry background enabled

numBodies = 25; % Number of bodies initially in system
massRange = [1,4]; % Size range of bodies
posRange = [-1 1]*15; % Range the same for all 3 axes
velRange = [-1 1].*2; % Range the same for all 3 axes
body = initializeRandomBodies(numBodies, massRange, posRange, velRange);

% Save a version of the initialization before we start changing stuff in
% case we want to run the same simulation again. i_Body can be saved and
% loaded in, and the simulation can be repeated 
i_Body = body;

% Run simulation
gravitySim(body, G, dt, tFinal, frag, stars);

% Initialization function
function [body] = initializeRandomBodies(nB, massRange, posRange, velRange)
% Check that input is valid
if massRange(1) <= 0 || massRange(2) <= 0
    error('fn initializeRandomBodies: Error. Mass must be positive and nonzero');
elseif (massRange(2) < massRange(1) || ...
        posRange(2) < posRange(1) || ...
        velRange(2) < velRange(1) )
    error('fn initializeRandomBodies: Error. Range of input must be sequential');
end

% Initialize Struct
body = m_BodyStruct(nB);

% Calculate random values
randMass = randi(massRange, nB, 1);
randPos  = randi(posRange,  nB, 3);
randVel  = randi(velRange,  nB, 3);

for k = 1:nB
    % Store values in struct
    body(k) = m_Body(body(k), randMass(k), randPos(k,:), randVel(k,:));
end
end