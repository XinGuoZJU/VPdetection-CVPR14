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

manhattan = 1;
acceleration = 1;

focal_ratio = 1.08;

params.PRINT = 0;
params.PLOT = 0;


img_in =  'demo_data/imgs/test.jpg'; % input image
folder_out = 'demo_data/output/test'; % output folder
mkdir(folder_out)

datapath = '/n/fs/vl/xg5/Datasets/YUD/YorkUrbanDB';
savepath = 'dataset/YUD/output';
dirs = dir(datapath);

for i = 3:size(dirs,1)
    dir_name = dirs(i).name;
    dirpath = [datapath, '/', dir_name];
    if isdir(dirpath)
        img_in = [dirpath, '/', dir_name, '.jpg'];
        folder_out = [savepath, '/', dir_name];
        mkdir(folder_out)
        horizon = detect_vps(img_in, folder_out, manhattan, acceleration, focal_ratio, params);
    end
end


