function [sHandle] = c_Sphere(sHandle, body, sx, sy, sz)
% function C_SPHERE uses each sphere's plot handle to update its
% position in the figure
%   INPUT: [sHandle, body, sx, sy, sz]
%   'sHandle' is a GRAPHIC OBJECT
%       The handle for all the spheres
%   'body' is a STRUCT
%       The structure storing the object's parameters
%   'sx' 'sy', 'sz' are MATRICES
%       The output of the 'SPHERE' built-in function
%
%   OUTPUT: [sHandle]
%   'sHandle' is a GRAPHIC OBJECT
%       The updated handle for all the spheres
% 
% The position of all bodies in the figure are updated. Deleted bodies are
% not displayed

nB = size(body,2);

for k = 1:nB
    %for k = 1:size(sHandle)
    sHandle(k).Visible = 'on';
    % Shift and scale the points
    xpts = body(k).pos(1) + body(k).rad*sx;
    ypts = body(k).pos(2) + body(k).rad*sy;
    zpts = body(k).pos(3) + body(k).rad*sz;
    
    % Update the surface
    sHandle(k).XData = xpts;
    sHandle(k).YData = ypts;
    sHandle(k).ZData = zpts;
    
    % Set face/edge color
    sHandle(k).FaceColor = body(k).Color;
    sHandle(k).EdgeColor = 'none';
end

% If not in the body struct, then don't display
% Avoid checking all by only toggling handles that are on
k = nB+1;
sH_size = size(sHandle,2);
while k <= sH_size && strcmp(sHandle(k).Visible, 'on')
    % turn off
    sHandle(k).Visible = 'off';
    k = k+1;
end