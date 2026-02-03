clc 
clear

% Vehicle Parameters
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
MassWheel = 0.7; %kg
RadiusWheel = 0.255; %m
CRR = 0.0010;

% Transmission
FrontGear = 11;
RearGear = 142;

% Specify file name with path
TrackData = readtable('TrackModel\racing_line_gaussian_final.csv');

NewData = TrackData(:, {'s', 'gradient_rad'});

StateData = readtable('TrackModel\att3KMHE2024edited.csv');
finalatt = readtable('TrackModel\finalatt.csv');
