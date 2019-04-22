% Gravity Simulation: StartHere Demo
% Demonstrates basic gravitational attraction force between two objects
% and accretion when the objects collide. 
%
% Copyright Catherine Paulson 2018

% % Welcome to the simulation! This demo is a basic two-body system, meant
% % to show explicitly how to set up the starting mass, position, and 
% % velcity of the bodies in a given system. For a sample of a more 
% % interesting initialization, see 'RandomBodies.m'. More samples are
% % planned for version 2.
% % See 'Readme.txt' for more information on the physics behind this
% % simulation, as well as a list of the simulation settings

% Clean up the MATLAB workspace
clear, close, clc;

% Seed random number generator, save seeding in 's'
s = rng('shuffle');

% SIMULATION CONTANTS
% % WE'LL KEEP THESE VALUES UNCHANGED FOR NOW. These values work well as
% % starting points, but can be adjusted as needed for future simulations
G = 1; % Gravity constant, set as one to scale masses into intuitive range
dt = 0.1; % Differential time step
tFinal = 15; % Simulation duration

% SIMULATION SETTINGS
% % SEE README.TXT FOR A MORE IN-DEPTH DESCRIPTION OF THESE SETTINGS. Or 
% % just change each to true to see how they affect the simulation
frag = false; % Fragmentation disabled 
stars = false; % Starry background disabled

% INITIALIZE BODIES IN SYSTEM
% % THE INTERESTING PART. This is were you control each body's mass and
% % initial position and velocity. Experiment with different starting values
% % and observe how they affect the system
numBodies = 2; % Total number of bodies in the system
body =  m_BodyStruct(numBodies); % Create data struct to track bodies

% % Here we set the first body's mass, initial position, and initial velocity
m_1= 40; % Body1 size
pos_1 = [0 10 0]; % Distance from origin [x y z]
vel_1 = [0 0 0]; % Start at rest
body(1) = m_Body(body(1), m_1, pos_1, vel_1); % Store in first slot

% % Here we start the second body with an equal size and opposite positions
% % and velocities from body1
m_2 = m_1; % Equal magnitude
pos_2 = -pos_1; % Equal magnitude, opposite direction
vel_2 = -vel_1; % Equal magnitude, opposite direction
body(2) = m_Body(body(2), m_2, pos_2, vel_2); % Store in second slot

% % Start the simulation by clicking the 'Run' button
gravitySim(body, G, dt, tFinal, frag, stars);

% % See 'RandomBodies.m' for another example of how to set up the bodies
% % in a system
% %     RandomBodies.m is a chaotic system with bodies randomly created 
% %
% % Or use the given examples as an outline to set up your own system
% %
% % To further understand how the simulation runs, look through "Outline"
% % section of 'Readme.txt', or read through 'gravitySim.m' and the 
% % function it calls.
% % A description of any function used here can be view by typing
% %  help FUNCTION
% % into the command window, where FUNCTION is the name of the
% % function
