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

dataset_name = 'YUD';
if strcmp(dataset_name, 'YUD')
    datapath = '/n/fs/vl/xg5/Datasets/YUD/YorkUrbanDB';
    savepath = 'dataset/YUD/output';
    img_type = 'jpg';
elseif strcmp(dataset_name, 'scannet')
    datapath = '/n/fs/vl/xg5/Datasets/neurodata/scannet-vp';
    savepath = 'dataset/scannet-vp/output';
    img_type = 'png';
end

mkdir(folder_out)
dirs = dir(datapath);

for i = 3:size(dirs,1)
    dir_name = dirs(i).name;
    dirpath = [datapath, '/', dir_name];
    if isdir(dirpath)
        image_list = dir([dirpath, '/*.', img_type]); % struct
        for j = 1: size(image_list,1)
            img_name = image_list(j).name;
            img_in = [dirpath, '/', img_name];
            save_img_dir = strsplit(img_name, '.'); % cell
            folder_out = [savepath, '/', dir_name, '/', save_img_dir{1}];
            mkdir(folder_out)
            horizon = detect_vps(img_in, folder_out, manhattan, acceleration, focal_ratio, params);
        end
    end
end


