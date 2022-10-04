%%
clc,close all,clear all
%% Load data from file

%file_path = './In_CH03+_lab1-2022.txt';

file_path_inwgs84 = './In_WGS84_lab1-2022.txt';

[header_cell_inwgs84, data_inwgs84]  = read_file(file_path_inwgs84);

%% Convert cell to matrix and degrees to radians

number_data_inwgs84 = size(data_inwgs84,1);
for k = 1:number_data_inwgs84
     temp_mat = cell2mat(data_inwgs84{k,1})'; % convert the cell to matrix
     temp_mat(1:2) = deg2rad(temp_mat(1:2)); % convert the degrees to radians
     data_ellip_inwgs84{k,1} = temp_mat; % units: [rad,rad,m] per line
end

%% Exercice 1 : convert coordonees CHTRS95 elliptiques en cartesiannes

% define the GRS80 ellipsoid ( used by wgs84 )
ellip_GRS80.a = 6378137.0; % demi grand axe
ellip_GRS80.b = 6356752.3142; % demi petit axe
ellip_GRS80.f = 1/(298.257223563); % aplatissement
ellip_GRS80.e = sqrt((ellip_GRS80.a^2)-(ellip_GRS80.b^2))/ellip_GRS80.a; % excentricite

for k = 1:number_data_inwgs84
    [x,y,z] = ellip_2_cart(data_ellip_inwgs84{k,1}(1),data_ellip_inwgs84{k,1}(2),data_ellip_inwgs84{k,1}(3),ellip_GRS80);
    data_cart_inwgs84{k,1} = [x,y,z];
end

%% Exercice 2 : 
