% Vanishing Points detection algorithm.
% IPOL SUBMISSION "Vanishing Point Detection in Urban Scenes Using Point Alignments"
% 
% Version 0.9, June 2017
%
% This version includes the optional use the algorithm by Figueiredo and 
% Jain, Unsupervised learning of finite mixture models, to quickly obtain 
% cluster candidates.
%
% Copyright (c) 2013-2017 Jose Lezama <jlezama@gmail.com>
% 
% This program is free software: you can redistribute it and/or modify
% it under the terms of the GNU Affero General Public License as
% published by the Free Software Foundation, either version 3 of the
% License, or (at your option) any later version.
% 
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
% GNU Affero General Public License for more details.
% 
% You should have received a copy of the GNU Affero General Public License
% along with this program. If not, see <http://www.gnu.org/licenses/>.


addpath lib

clear
close all

manhattan = 0;
acceleration = 1;
focal_ratio = 1.08;
params.PRINT = 1;
params.PLOT = 1;

input_dir = 'image';
subdir = dir(input_dir);
for i = 1: length(subdir)
    if( isequal( subdir( i ).name, '.' )||...
        isequal( subdir( i ).name, '..')||...
        ~subdir( i ).isdir)
        continue;
    end
    subdirpath = fullfile( input_dir, subdir( i ).name);
    subsubdir = dir(subdirpath);
    for j = 1: length(subsubdir)
        if( isequal( subsubdir( j ).name, '.' )||...
            isequal( subsubdir( j ).name, '..'))
            continue;
        end
        img_in = fullfile(subdirpath, subsubdir( j ).name);
        save_dir = strsplit(img_in, '.');
        save_dir2 = char(save_dir(1));
        save_dir3 = strsplit(save_dir2, '/');
        save_dir3{1} = 'results';
        folder_out = strjoin(save_dir3, '/');
        mkdir(folder_out);
        horizon = detect_vps(img_in, folder_out, manhattan, acceleration, focal_ratio, params);
    end
end    

