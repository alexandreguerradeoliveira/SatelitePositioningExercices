function [header_cell, data] = read_file(file_path)
%read_file reads a .txt file of given format
%   The function takes a file_path of a .txt file of given a coordinates
%   format, ignoring headers (#) and storing the data in an array of cells
%   which is returned as an output.
%
%   To access the data, use the following syntax:
%   i is the line number from the input file (i.e. a set of coordinates)
%   data{i}{1}, data{i}{2} and data{i}{3} return 
%   the X, Y and Z coordinates as doubles in CH1903+
%   or the phi, lambda and H in the case of CHTRS95 (WGS84) coordinates
%
%   If no path is given, you can manually select the input file thanks to uigetfile 
   

%% Choose input file if not given
 if ~exist('file_path','var')
     % path not defined, choose a file
     [fich_to_open, file_path] = uigetfile('*.txt', 'Choisir le fichier de coordonnées à ouvrir:');
     if ~fich_to_open
        error('Aucun fichier n''a été désigné !')
     end
     file_path = strcat(file_path,fich_to_open);
 end

%% Check if file exists
if ~exist(file_path,'file')
    error('File %s does not exist.',path)
else
    fprintf('[reader]: reading file: %s ...\n', file_path);
end

%Prepare variables
ignored_char = '#';

fid = fopen(file_path,'r');

header_line_counter = 0;

data_line_counter = 0;

%% read data
while ~feof(fid)
    tline = fgets(fid);
    
    if ~strcmp(ignored_char,tline(1,1))
        data_line_counter = data_line_counter + 1;
        data{data_line_counter,:} = textscan(tline, '%f %f %f')';
        
    else
        header_line_counter = header_line_counter + 1;
        header_cell{header_line_counter} = tline;
        
    end
    
end

fclose(fid);

end

