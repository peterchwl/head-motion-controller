% This code is attributed to the GATI x BEAM program
import java.awt.Robot;
global mouse;
% This is designed to work with the callback function
% readArduinoGamingDevice.m
disp('If you stop this program and the mouse control is still on')
disp('You can type clear in the command window to stop the mouse control');
disp('This works by clearing the callback function');
stopLoop_p = 0;
mouseControlOn_p = 1;
mouseSetUp_p = 1;
while(stopLoop_p == 0)
    if (mouseSetUp_p == 1)
        mouse = Robot;
        arduinoObj = serialport("COM3",9600);
        configureTerminator(arduinoObj,"CR/LF");
        flush(arduinoObj);
        
        %Uncomment this is you want to store the Arduino data.
        %The Data field of the struct can be used to save the read values
        %and the Count field can be used to saves the sample number.
        %arduinoObj.UserData = struct("Data",[],"Count",1)
        
        %Set the BytesAvailableFcnMode property to "terminator" and
        %the BytesAvailableFcn property to @readArduinoGamingDevice.
        %The callback function readArduinoGamingDevice is triggered when data
        %(with the terminator) is available to be read from the Arduino.
        configureCallback(arduinoObj,"terminator",@readArduinoGamingDevice);
        
        mouseSetUp_p = 0;
    end;
    if mouseControlOn_p == 1
        x = input('Arduino mouse control ON (Hit return to stop, ctrl-c to quit)');
        clear;
        stopLoop_p = 0;
        mouseControlOn_p = 0;
        mouseSetUp_p = 0;
    else
        x = input('Arduino mouse control OFF (Hit return to start, ctrl-c to quit)');
        stopLoop_p = 0;
        mouseControlOn_p = 1;
        mouseSetUp_p = 1;
    end
end

