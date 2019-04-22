function [obj1, obj2] = c_GravForce(obj1, obj2, G)
% function C_GRAVFORCE calculates the gravitational force between two
% objects, and sums it with the forces currently experienced by that object
%
% INPUT: [obj1, obj2, G]
%   'obj1' and 'obj2' are STRUCTS
%       with fields 'pos', 'mass', 'force'
%   'G' is a SCALAR
%       represents the gravitational constant in units
%       N*m^2/(kg^2)
%
% OUTPUT: [obj1, obj2]
%   'obj1' and 'obj2' are STRUCTS
%       with updated 'force' field
%
% The gravitational force between object1 and object2 is calculated and
% is summed with the object's 'force' field.

% Calculate the gravitational force between the two given objects
dx = obj2.pos - obj1.pos;
magdx = norm(dx);
force = G*(obj2.mass*obj1.mass / (magdx^3))*dx;

% Update forces for both objects
% Must be summed with previously determined forces
% And repeated force calculations must be avoided to prevent doubling
obj1.force = obj1.force + force;
obj2.force = obj2.force - force;
end