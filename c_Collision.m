function [body, nB] = c_Collision(body, dt, activate_frag)
% function C_COLLISION checks for overlapping bodies in struct 'body',
% and either accretes or fragments based on the change in kinetic energy.
%
% INPUT: [body]
%   'body' is a STRUCT
%       with 'pos', 'rad', 'vel', 'mass'
%   'dt' is a SCALAR
%       Time step of simulation
%   'activate_frag' is a BOOLEON
%       True activates fragmentation behavior; false has accretion
%       behavior only
% OUTPUT: [body, nB]
%   'body' is a STRUCT
%       with updated 'pos', 'rad', 'vel', 'mass'
%   'nB' is a SCALAR
%       The number of elements in struct vector 'body'
%
% If objects are overlapping, combine their masses and velocities to
% conserve momentum, assuming a perfectly INELASTIC collision. If the
% kinetic energy of the new body is significantly smaller than the
% starting kinetic energy of the starting bodies, fragment the new body.
% Otherwise, accrete the two bodies into a single new body. Delete unused
% body and return updated structure
%
% Fragmentation behavior can be toggled on and off using 'activate_frag'

% Kinetic Energy threshold for fragmentation
KE_Threshold = 0.8;
% Explosiveness scalars
vS = 1; % larger vS (velocity scalar) gives each mass a high initial velocity
n = 3; % 2^n number of fragments created

% Initialize parameters of while loop
k = 1; nB = size(body,2);
j = nB;

% Check for collisions
while k < nB
    while j ~= k
        % calc separation distance
        dx = abs(body(k).pos - body(j).pos);
        sep = norm(dx);
        % calc combined radii
        rad_kj = body(k).rad + body(j).rad;
        
        % If separation distance is smaller than combined radii
        if sep < rad_kj
            % Find combined element's mass, pos, vel, rad
            m_k = body(k).mass;
            m_j = body(j).mass;
            newMass = m_k + m_j;
            newVel = (m_k*body(k).vel + m_j*body(j).vel) / newMass;
            newPos = (m_k*body(k).pos + m_j*body(j).pos) / newMass;
            
            % Calculate kinetic energies
            KE_bodyk  = c_KinEnergy(body(k).mass, body(k).vel);
            KE_bodyj  = c_KinEnergy(body(j).mass, body(j).vel);
            KE_bodykj = c_KinEnergy(newMass, newVel);
            
            KE_lost = 1 - KE_bodykj/(KE_bodyk + KE_bodyj);
            
            % Decide whether to fragment or accrete
            if (activate_frag && KE_lost > KE_Threshold)
                Fragment; % Nested function
                k = 0; % Reset to check for collisions among new bodies
                break;
            else
                Accrete; % Nested function
            end
        end
        % Decrement j
        j = j-1;
    end
    % Update k, nB before reevaluate while statement
    nB = size(body,2);
    j = nB;
    k = k + 1;
end


% Nested functions
    function Accrete
        fprintf('Accrete!\n');
        % Update body(k) to contain large mass
        body(k) = m_Body(body(k), newMass, newPos, newVel);
        % Delete extra body(j)
        body(j) = [];
    end

    function Fragment
        fprintf('Fragment!\n');
        bodyFragments = c_Fragment(newMass, newVel, newPos, n, 10*dt, vS);
        body(k) = bodyFragments(1);
        body(j) = bodyFragments(2);
        body = [body, bodyFragments(3:size(bodyFragments,2))];
    end
end

function [KE] = c_KinEnergy(mass,vel)
% The kinetic energy of the object is determined from KE = 1/2*mass*(vel^2)
KE = 0.5*mass*norm(vel)^2;
end