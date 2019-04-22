Gravity Simulation
  Copyright Catherine Paulson 2018

This simulation demonstrates the effects of gravitational force between objects (referred to here as bodies) in the system.

To jump right into using this simulation, start with 'StartHere.m'

*******************************************************************************
Background
*******************************************************************************
Gravity is an attractive force between two objects, j and k, as described by the equation:
	F_k,j = G*m_j*m_k / ||dx||^3
	||dx|| = (dx^2 + dy^2 + dz^2)^1/2

where F_k,j is the force of attraction between body k and body j, G is the universal gravitational constant, m_k is the mass of the first object, m_j is the mass of the second object and dx is the separation vector between the two bodies. The ||...|| notation denotes the Euclidean norm of a vector. 

To calculate the total force on arbitraty body k, the gravitational force between body k and all other bodies in the system are calculated and summed.

Once we know the force (and thus acceleration, since F = ma) on a given body, we can then use semi-implicit euler to calculate the velocity and position of each body at the given time step. We then repeat the gravitational force calculations on the bodies at their new positions, and continue at the desired time-step and for the desired duration.

If the bodies collide, they either accrete (an inelasitc collision, where the masses combine and the new velocity and position conserve momentum) or fragment (split the combined masses into pieces and calculate their velocities to conserve momentum)

*******************************************************************************
Outline
*******************************************************************************
Initialization function: Use the one's provided (StartHere.m, RandomBodies.m) or create your own. Set up the struct to store each body's data using m_BodyStruct.m, and fill it in specific values with m_Body.m; Set the simulation constants and settings (see below). Then call gravitySim
	m_BodyStruct: Creates a struct to store each body's data
	m_Body: Fills in a single body's data

gravitySim.m : The simulation engine; sets up the figure with m_Figure.m, then calculates the gravitational force between each body and updates their position and velocity. Calls the following:
	m_Figure: set figure and visualization options
	c_Collision: check for collisions between bodies and either accrete or fragment, depending on the simulation settings
		c_Fragment: use recursion (r_fragment) to split the mass into pieces and calculate their velocities to conserve momentum
	c_GravForce: calculate the gravitional force between each pair of bodies
	c_Kinematics: use semi-implicit Euler to update the velocity and position of each body
	c_Sphere: update the spheres in the figure to reflect the changes to the system

More in-depth descriptions of each function is available by typing "help FUNCTION" in the command window (without the quotes, and with the given function's name instead of FUNCTION i.e. "help gravitySim")

*******************************************************************************
Simulation constants/settings
*******************************************************************************
Values/settings for the simulation; the heading indicates which function sets each. See the given function for more info

GRAVITYSIM
  Constants:
	G: Gravity constant, units N*m^2/kg^2
	dt: Differential time step
	tFinal: Simulation Duration
	numBodies: Number of bodies initially in the system
  Settings:
	activate_frag: Fragmentation behavior enabled (if false, objects will only accrete if collision (see c_Collision.m) )
	activate_stars: Starmap background enabled (if false, the default display options will be used (see m_Figure.m) )

M_BODY:
  Constants:
	rho: Density, used to scale radius 
	cmap: Colormap, used to color each body scaled by mass

M_FIGURE:
	All display options are set here
  Settings:
	activate_stars: If true, a starmap background is used to visualize the objects in space. The camera can be rotated to follow the objects as they move in space.

C_COLLISION:
  Constants:
	KE_Threshold = 0.8; If more than this percent of kinetic energy is lost in a collision, the bodies fragment
	Explosiveness constants: Controls how 'explosive' the fragmentation is
		vS: A larger vS (velocity scalar) gives each mass a high initial velocity
		n: 2^n number of fragments created
  Settings:
	activate_frag: If true, the objects will fragment if the percent of kinetic energy lost is above the specified threshold, 'KE_Threshold'. Otherwise, the objects will only accrete


*******************************************************************************
Common Errors
*******************************************************************************
As errors are reported, their solutions will be added here
1. Unrecognized property 'Visible' for class 'matlab.graphics.GraphicsPlaceholder'.

There are not enough sphere objects to display all the bodies in the system. Try increasing 'numSpheres' to initialize more spheres to accommadate (See 'gravitySim.m', line 37)
* A more elegant solution is planned for version 2 

Report issues by commenting on the github page