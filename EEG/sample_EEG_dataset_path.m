function [path, isValid] = sample_EEG_dataset_path(nFeatures, expNames, maxSubject)
%SAMPLE_EEG_DATASET_PATH

warning('off', 'generate_EEG_dataset_path:FileDoesNotExist')

if nargin < 3
    maxSubject = 12;
end

isValid = 0;
while ~isValid
    name = expNames{randi(length(expNames))};
    subject = randi(maxSubject);
    [path, isValid] = generate_EEG_dataset_path(nFeatures, name, subject);
end