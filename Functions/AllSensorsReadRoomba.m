function [BumpRight, BumpLeft, BumpFront, Wall, CliffLft, ...
    CliffRgt, CliffFrntLft, CliffFrntRgt, virtWall, SideBrushCurr, Reserved, ...
    MainBrushCurr, RightWheelCurr, LeftWheelCurr, ...
    Dirt, Unused16, RemoteCode, ButtonClean, ButtonSpot, ButtonDock, ...
    ButtonMinute, ButtonHour, ButtonDay, ButtonSchedule, ButtonClock, ...
    Dist, Angle, ChargeState, Volts, Current, Temp, Charge, Capacity, ...
    pCharge, WallSignal, CliffLeftSig, CliffFrontLeftSig, CliffFrontRightSig, ...
    CliffRightSig, Unused32, Unused33, ChargeSource, OIMode, SongNumber, ...
    SongPlaying, NumberStreamPackets, RequestedVel, RequestedRadius, ...
    RequestedRightVel, RequestedLeftVel, LeftEncoderCounts, ...
    RightEncoderCounts, LtbumpLeft, LtbumpFrontLeft, LtbumpCenterLeft, ...
    LtbumpCenterRight, LtbumpFrontRight, LtbumpRight, LightBumpLeftSig, ...
    LightBumpFrontLeftSig, LightBumpCenterLeftSig, LightBumpCenterRightSig, ...
    LightBumpFrontRightSig, LightBumpRightSig, Unused52, Unused53, ...
    LeftMotorCurrent, RightMotorCurrent, MainBrushMotorCurrent, ...
    SideBrushMotorCurrent, Stasis ] =  AllSensorsReadRoomba(serPort);




%{
function [BumpRight, BumpLeft, BumpFront, Wall, virtWall, CliffLft, ...
    CliffRgt, CliffFrntLft, CliffFrntRgt, LeftCurrOver, RightCurrOver, ...
    DirtL, DirtR, ButtonPlay, ButtonAdv, Dist, Angle, ...
    Volts, Current, Temp, Charge, Capacity, pCharge]   = AllSensorsReadRoomba(serPort);

%}
%[BumpRight, BumpLeft, BumpFront, Wall, virtWall, CliffLft, ...
%   CliffRgt, CliffFrntLft, CliffFrntRgt, LeftCurrOver, RightCurrOver, ...
%   DirtL, DirtR, ButtonPlay, ButtonAdv, Dist, Angle, ...
%   Volts, Current, Temp, Charge, Capacity, pCharge]   = AllSensorsReadRoomba(serPort)
% Reads Roomba Sensors
% [BumpRight (0/1), BumpLeft(0/1), BumpFront(0/1), Wall(0/1), virtWall(0/1), CliffLft(0/1), ...
%    CliffRgt(0/1), CliffFrntLft(0/1), CliffFrntRgt(0/1), LeftCurrOver (0/1), RightCurrOver(0/1), ...
%    DirtL(0/1), DirtR(0/1), ButtonPlay(0/1), ButtonAdv(0/1), Dist (meters since last call), Angle (rad since last call), ...
%    Volts (V), Current (Amps), Temp (celcius), Charge (milliamphours), Capacity (milliamphours), pCharge (percent)]
% Can add others if you like, see code
% Esposito 3/2008
% initialize preliminary return values
% By; Joel Esposito, US Naval Academy, 2011
BumpRight = nan;
BumpLeft = nan;
BumpFront = nan;
Wall = nan;
virtWall = nan;
CliffLft = nan;
CliffRgt = nan;
CliffFrntLft = nan;
CliffFrntRgt = nan;
LeftCurrOver = nan;
RightCurrOver = nan;
DirtL = nan;
DirtR = nan;
ButtonPlay = nan;
ButtonAdv = nan;
Dist = nan;
Angle = nan;
Volts = nan;
Current = nan;
Temp = nan;
Charge = nan;
Capacity = nan;
pCharge = nan;



try

%Flush buffer
N = serPort.BytesAvailable();
while(N~=0) 
fread(serPort,N);
N = serPort.BytesAvailable();
end

warning off
global td
sensorPacket = [];
% flushing buffer - I'm not sure why this was here, but it cuases a hangup
% with the Create2
% confirmation = (fread(serPort,1));
% while ~isempty(confirmation)
%     confirmation = (fread(serPort,26));
% end


%% Get (142) ALL(0) data fields. This has changed to 100
fwrite(serPort, [142 100]);

%% Read data fields
BmpWheDrps = dec2bin(fread(serPort, 1),8);  %

BumpRight = bin2dec(BmpWheDrps(end));  % 0 no bump, 1 bump
BumpLeft = bin2dec(BmpWheDrps(end-1));
if BumpRight*BumpLeft==1
    BumpRight =0;
    BumpLeft = 0;
    BumpFront =1;
else
    BumpFront = 0;
end
%Packet 8
Wall = fread(serPort, 1);  %0 no wall, 1 wall
%Packet 9-12
CliffLft = fread(serPort, 1); % no cliff, 1 cliff
CliffFrntLft = fread(serPort, 1);
CliffFrntRgt = fread(serPort, 1);
CliffRgt = fread(serPort, 1);

%Packet 13
virtWall = fread(serPort, 1);%0 no wall, 1 wall

%Packet 14
motorCurr = dec2bin( fread(serPort, 1),8 );
SideBrushCurr = motorCurr(end);  % 0 no over curr, 1 over Curr
Reserved = motorCurr(end-1);  % 0 no over curr, 1 over Curr
MainBrushCurr = motorCurr(end-2);  % 0 no over curr, 1 over Curr
RightWheelCurr = motorCurr(end-3);  % 0 no over curr, 1 over Curr
LeftWheelCurr = motorCurr(end-4) ; % 0 no over curr, 1 over Curr

%Packet 15
Dirt = fread(serPort, 1);
%Packet 16
Unused16 = fread(serPort, 1);
%Packet 17
RemoteCode =  fread(serPort, 1); % coudl be used by remote or to communicate with sendIR command
%Packet 18
Buttons = dec2bin(fread(serPort, 1),8);
ButtonClean = Buttons(end);
ButtonSpot = Buttons(end-1);
ButtonDock = Buttons(end-2);
ButtonMinute = Buttons(end-3);
ButtonHour = Buttons(end-4);
ButtonDay = Buttons(end-5);
ButtonSchedule = Buttons(end-6);
ButtonClock = Buttons(end-7);

%Packets 19,20
%Distance is the wrong sign for some reason. 
Dist = -1*fread(serPort, 1, 'int16')/1000; % convert to Meters, signed, average dist wheels traveled since last time called...caps at +/-32
Angle = fread(serPort, 1, 'int16')*pi/180; % convert to radians, signed,  since last time called, CCW positive

%Packet 21-26
ChargeState = fread(serPort, 1);
Volts = fread(serPort, 1, 'uint16')/1000;
Current = fread(serPort, 1, 'int16')/1000; % neg sourcing, pos charging
Temp  =  fread(serPort, 1, 'int8') ;
Charge =  fread(serPort, 1, 'uint16'); % in mAhours
Capacity =  fread(serPort, 1, 'uint16');
pCharge = Charge/Capacity *100;  % May be inaccurate
%checksum =  fread(serPort, 1)

%--------------------------------------------------------------------
%Below is added for the create 2
%1/27/2015 Matthew Powelson

%Packet 27
WallSignal = fread(serPort, 1, 'uint16');
%Packet 28-31
CliffLeftSig = fread(serPort, 1, 'uint16'); %0-4095
CliffFrontLeftSig = fread(serPort, 1, 'uint16');
CliffFrontRightSig = fread(serPort, 1, 'uint16');
CliffRightSig = fread(serPort, 1, 'uint16');

%Packet 32-33
Unused32 = fread(serPort, 1, 'int8');
Unused33 = fread(serPort, 1, 'uint16');

%Packet 34
ChargeSource = fread(serPort, 1, 'uint8');

%Packet 35
OIMode = fread(serPort, 1, 'uint8');
%Packet 36-37
SongNumber = fread(serPort, 1, 'uint8');
SongPlaying = fread(serPort, 1, 'uint8');
%Packet 38
NumberStreamPackets = fread(serPort, 1, 'uint8');
%Packet 39-42
RequestedVel = fread(serPort, 1, 'int16');
RequestedRadius = fread(serPort, 1, 'int16');
RequestedRightVel = fread(serPort, 1, 'int16');
RequestedLeftVel = fread(serPort, 1, 'int16');

%Packet 43-44
LeftEncoderCounts = fread(serPort, 1, 'uint16');
RightEncoderCounts = fread(serPort, 1, 'uint16');

%Packet 45
LightBumper = fread(serPort, 1, 'uint8');
LightBumper = dec2bin(LightBumper,8);
LtbumpLeft = LightBumper(end);
LtbumpFrontLeft = LightBumper(end - 2);
LtbumpCenterLeft = LightBumper(end - 3);
LtbumpCenterRight = LightBumper(end - 4);
LtbumpFrontRight = LightBumper(end - 5);
LtbumpRight = LightBumper(end - 6);

%Packet 46-51
LightBumpLeftSig = fread(serPort, 1, 'uint16');
LightBumpFrontLeftSig = fread(serPort, 1, 'uint16');
LightBumpCenterLeftSig = fread(serPort, 1, 'uint16');
LightBumpCenterRightSig = fread(serPort, 1, 'uint16');
LightBumpFrontRightSig = fread(serPort, 1, 'uint16');
LightBumpRightSig = fread(serPort, 1, 'uint16');

%Packets 52-53
Unused52 = fread(serPort, 1, 'uint8');
Unused53 = fread(serPort, 1, 'uint8');

%Packets 54-57
LeftMotorCurrent = fread(serPort, 1, 'int16');
RightMotorCurrent = fread(serPort, 1, 'int16');
MainBrushMotorCurrent = fread(serPort, 1, 'int16');
SideBrushMotorCurrent = fread(serPort, 1, 'int16');

%Packets 58 
Stasis = fread(serPort, 1, 'uint8');

%May need to disable this depending on application
%pause(td)

catch
    disp('WARNING:  function did not terminate correctly.  Output may be unreliable.')
end