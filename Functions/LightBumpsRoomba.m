function [Left,FrontLeft,CenterLeft,CenterRight,FrontRight, Right] = LightBumpsRoomba(serPort);


%Initialize preliminary return values
Left = nan;
FrontLeft = nan;
CenterLeft = nan;
CenterRight = nan;
FrontRight = nan;
Right = nan;


try

%Flush Buffer    
N = serPort.BytesAvailable();
while(N~=0) 
fread(serPort,N);
N = serPort.BytesAvailable();
end

warning off
global td

fwrite(serPort, [142]);  fwrite(serPort,106); 
Left = fread(serPort, 1, 'uint16');
FrontLeft = fread(serPort, 1, 'uint16');
CenterLeft = fread(serPort, 1, 'uint16');
CenterRight = fread(serPort, 1, 'uint16');
FrontRight = fread(serPort, 1, 'uint16');
Right = fread(serPort, 1, 'uint16');



pause(td)
catch
    disp('WARNING:  function did not terminate correctly.  Output may be unreliable.')
end