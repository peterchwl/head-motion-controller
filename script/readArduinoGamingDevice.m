function readArduinoGamingDevice(src, ~)
global mouse
% Read the ASCII data from the serialport object.
% Here I am assuming there is a blank in between two numbers
data1 = readline(src);
numdata1 = str2double(extractBefore(data1," "));
numdata2 = str2double(extractAfter(data1," "));

% Alter this scaling, so that potentiometer range can cross screen
mouse.mouseMove(-(numdata2 / 2) +500 , -(numdata1 / 3 ) + 5000);

% This scaling works for accelerometer control
%mouse.mouseMove(1.5*1920-numdata1/10,1080/2+numdata2/10)
%mouse.mouseMove(2000+data, 200)

end
