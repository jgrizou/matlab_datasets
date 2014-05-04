function [path, isValid] = generate_EEG_dataset_path(nFeatures, name, subject)
%GENERATE_EEG_DATASET_FILENAME Genearate the complete path for an EEG dataset
%
%   Syntax:  path = generate_EEG_dataset_path(nFeatures, subject, name)
%
%   Inputs:
%       nFeatures - number of features, will correspond to the feature folder name
%       name - the experiment name
%       subject - subject number, will correspond to the subject folder name
%
%   Outputs:
%       path - absolute path of the dataset
%
%   Examples:
%       path = generate_EEG_dataset_path(34,'OT1',1)
isValid = 1;
[pathstr, ~, ~] = fileparts(mfilename('fullpath'));
feature_folder = [num2str(nFeatures), '_features'];
name_folder = name;
path = fullfile(pathstr, feature_folder, name_folder, ['s', num2str(subject), '.mat']);
if ~exist(path, 'file')
    isValid = 0;
    warning('generate_EEG_dataset_path:FileDoesNotExist', [path, ' does not link to a dataset matfile'])
end