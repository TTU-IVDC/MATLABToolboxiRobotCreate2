%{
This example demonstrates two of the ways to control the Create's wheels
using feedback from the Create's encoders
1) travelDist([Serial Port],[Speed], [Distance])
   - Serial Port: Serial port object defined in RoombaInit
   - Speed: Desired Speed between .025 and .5 m/s
   - Distance: Desired Distance in meters. Negative distance is reverse

2) turnAngle([Serial Port],[Speed],[Turn Angle])
   - Serial Port: Serial port object defined in RoombaInit
   - Speed: Desired turning speed between 0 and .2 in Radians/second
   - Turn Angle: Desired target angle.
Note: (taken from pg 25 of MTIC Documentation)
turnAngle attempts to turn the shortest way around the circle. 
For example a turnAngle of 350 degrees will result in the robot actually
turning -10 degrees. So, positive turnAngle up to 180 degrees and negative
turnAngle from-180 to-360 degrees turns theCreate counterclockwise.
Negative turnAngle up to-180 degrees and positive turnAngle from 180 to 360
degrees turns the Create clockwise. 

Note:
travelDist and turnAngle use scripting from the Create Open Interface.
This means that these functions are blocking. The Create waits and will not
accept any new commands (e.g. requests for sensor data or commands to STOP!!)
until it has traveled the desired distance. For this reason, use of these
functions should be limited to small distances.

Note: Set Serial Port to port connected to Create
%}

%This adds the Roomba2 Toolbox to the load path for this session
%Be sure to change this to match the correct path
addpath (genpath('C:\Users\Grad Student\Documents\MATLAB\Toolboxes\MatlabToolboxiRobotCreate2'))


% Initialize communication: Change to match appropriate Serial Port
[serialObject] = RoombaInit(6)
% Read distance sensor (provides baseline)
InitDistance = DistanceSensorRoomba(serialObject);

% Travel forward at .2 m/s for .1 m
travelDist(serialObject, .2, .1)
% read the distance sensor.
% returns dist since last reading in meters
Distance = DistanceSensorRoomba(serialObject)
% Counter-clockwise angles are positive and Clockwise angles are negative.
Angle = AngleSensorRoomba(serialObject)  %radians

pause(2)

% turn at .2m/s for 180 degrees
turnAngle(serialObject, .2, 180)
% read the distance sensor.
% returns dist since last reading in meters
Distance = DistanceSensorRoomba(serialObject)
% Counter-clockwise angles are positive and Clockwise angles are negative.
Angle = AngleSensorRoomba(serialObject)  %radians
