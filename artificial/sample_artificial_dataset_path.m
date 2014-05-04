function [path, isValid] = sample_artificial_dataset_path(dim, samplingAccuracyRnd)
%SAMPLE_ARTIFICIAL_DATASET

isValid = 1;
[pathstr, ~, ~] = fileparts(mfilename('fullpath'));
dimFolder = fullfile(pathstr, [num2str(dim), 'D']);

if ~exist(dimFolder, 'dir')
    error('sample_artificial_dataset_path:DimNotAvailable', [num2str(dim) 'D dataset are not generated'])
end

path = '';
desiredAccuracy = samplingAccuracyRnd();
segmentsFolder = getfilenames(dimFolder);
for iSegment = 1:length(segmentsFolder)
    [~, fname, ~] = fileparts(segmentsFolder{iSegment});
    bounds = strsplit(fname, '_');
    lower = str2double(bounds{1}) / 100;
    upper = str2double(bounds{2}) / 100;
    
    if desiredAccuracy > lower && desiredAccuracy <= upper 
        datasets = getfilenames(segmentsFolder{iSegment}, 'refiles', '*.mat');
        path = datasets{randi(length(datasets))};
        break
    end
end

if ~exist(path, 'file')
    isValid = 0;
    warning('sample_artificial_dataset_path:noPathFound', ['No dataset found for accuracy ', num2str(desiredAccuracy)])
end




