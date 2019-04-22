function [sHandle, sx, sy, sz] = m_Figure(body, numSpheres, activate_stars)
% function M_FIGURE creates the figure, plots all surfaces, and
% sets up all other visualization settings.
%   INPUT: (body, numSpheres, activate_stars)
%   'body' is a STRUCT
%       The structure storing the object's parameters
%   'numSpheres' is a SCALAR
%       The number of spheres to initialize
%   'activate_stars' is a BOOLEON
%       True enables starry background; False enables default display
%       options
%
%   OUTPUT: (sHandle, sx, sy, sz)
%   'sHandle' is a GOBJECT HANDLE
%       The graphic object containing the handles for all the bodies
%   'sx', 'sy', 'sx' are MATRICES
%       The output of the 'SPHERE' function, used for updating spheres
%
% All visualization features are set up here, including the axes,
% background, camera, etc.

% FIGURE
% Create current figure and axes
fig = figure('Name','Gravity Simulation','NumberTitle','off');
% Change figure size [left bottom width height] (pixels)
fig.Position = [100 50 650 650];
ax = axes(fig);

% PLOT PLANETS
[sx, sy, sz] = sphere; % Create the 3 arrays of spherical points
sHandle = gobjects(1, numSpheres); % Create sphere container

for k = 1:numSpheres
    % Plot the surface
    sHandle(k) = surf(ax, sx, sy, sz);
    sHandle(k).Visible = 'off';
    hold on
end
% Plot each sphere
[sHandle] = c_Sphere(sHandle, body, sx, sy, sz);

% BACKGROUND/CAMERA
if activate_stars
    % STARMAP BACKGROUND
    R = 100;
    s = surf(ax, R*sx, R*sy, R*sz);
    hold off
    
    s.FaceColor = 'texturemap';
    s.FaceLighting = 'none';
    s.CData = imread('starmap_4k.jpg');
    s.EdgeColor = 'none';
    
    cameratoolbar;
    camva(70);
    campos([-30, 0, 0]);
    camtarget([0, 0, 0]);
    camproj('perspective');
    material dull
else
    % DEFAULT DISPLAY
    fig.Color = [0.05 0.05 0.15]; % dark grey background
    camproj('perspective');
    axis(20*[-1, 1, -1, 1, -1, 1]);
    ax.Color = 'none'; % transparent axes
    ax.XColor = 'none'; % transparent gridlines/labels
    ax.YColor = 'none';
    ax.ZColor = 'none';
    ax.Clipping = 'off';
end

% LIGHTING
light
lighting gouraud