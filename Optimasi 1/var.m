clc 
clear

%-----------------------------------------------------------------------------------------
% Proto 4.0
VehicleMass = 76; %kg
FrontAxle = 510.7; %mm
RearAxle = 1504.27; %mm
GroundClearance = 98; %mm
FrontArea = 0.42941; %m^2
AirDensity = 1.225; %kg/m
Gravitation = 9.80665;%m/s^2
CD = 0.1495849;
SlipAngle = 0.03; %rad (typical for racing)

% Tire
MassWheel = 1; %kg
RadiusWheel = 0.25; %m  %bisa 0.2515
CRR = 0.0015;

%-----------------------------------------------------------------------------------------
% % Proto 3.0
% VehicleMass = 79; %kg
% FrontAxle = 502.59; %mm
% RearAxle = 1003.1; %mm
% GroundClearance = 296.77; %mm
% FrontArea = 0.3481; %m^2
% AirDensity = 1.225; %kg/m
% Gravitation = 9.80665;
% CD = 0.143;
% SlipAngle = 0.03; %rad (typical for racing)
% 
% % Tire
% MassWheel = 1; %kg
% RadiusWheel = 0.25; %m
% CRR = 0.0015;
%-----------------------------------------------------------------------------------------
% Transmission
FrontGear = 11;
RearGear = 142  ; %lusail 131 or 126 %eprix 142

Vnom = 53; %mohm
RintBat = 130; %mohm

% Specify file name with path
DistancetoGlide = 14801-1500; %meter

%distance max 14801
%TimeMax = 2100; %lusail(30 for safety error)
TimeMax = 1600; %eprix 1620


%Generated Control Array (if optimization already done)
%controlarray1 = readtable('Strategi\strategigr131lusailmindist.csv');
%controlarray1 = table2array(controlarray1)';
%-----------------------------------------------------------------------------------------

%Data Track
%TrackData = readtable('Track\Path\Lusail\mindistfinal_lusail_nonsmoothedgrad.csv');
%TrackData = readtable('Track\Path\Lusail\mincurvfinal_lusail_nonsmoothedgrad.csv');

%TrackData = readtable('Track\Path\ePrix\mindistfinal_ePrix_nonsmoothedgrad.csv');
TrackData = readtable('Track\Path\ePrix\mincurvfinal_ePrix_nonsmoothedgrad.csv');

%Data Gradient
NewData = TrackData(:, {'s', 'gradient_rad'});

%-----------------------------------------------------------------------------------------
%Data State based on Speed
%StateData = readtable('TrackModel\att4.csv');
%finalatt = readtable('TrackModel\finalatt.csv');


%Data State based on Current
SpeedData = readtable('TrackModel\KMHE3Speed.csv');
AttemptData = readtable('TrackModel\410-3.csv');

%SpeedData = readtable('TrackModel\KMHE4Speed.csv');
%AttemptData = readtable('TrackModel\410-4.csv');

save('model_variables.mat');

