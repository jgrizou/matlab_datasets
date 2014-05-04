

accuracyRange = [0.65, 0.7];
nPointPerClusters = 1000;
nDatasets = 100;

blankClassifier = @() Gaussian_classifier();

dim = 30;
cst = 0.01;
np = 1000;
meanPdfs = {};
meanPdfs{end+1} = @() rand(1,dim) * 0;
meanPdfs{end+1} = @() rand(1,dim) * cst;

covPdfs = {};
covPdfs{end+1} = @() iwishrnd(eye(dim)*np, np);
covPdfs{end+1} = @() iwishrnd(eye(dim)*np, np);

maxTrial = 1000;

for iDataset = 1:nDatasets
    
    fprintf('##### %4d/%4d ##### \n', iDataset, nDatasets);
    
    [X, Y, accuracy] = generate_quality_dataset(blankClassifier, accuracyRange, nPointPerClusters, ...
        meanPdfs, covPdfs, maxTrial);

    disp(accuracy)
%     scatter(X(:,1), X(:,2), 30, Y, 'filled')
%     xlim([-10, 10])
%     axis equal
%     drawnow
%     pause

    [pathstr, ~, ~] = fileparts(mfilename('fullpath'));
    folder = fullfile(pathstr, [num2str(dim), 'D']);

    strAccu = [num2str(accuracyRange(1)*100), '_', num2str(accuracyRange(2)*100)];
    folder = fullfile(folder, strAccu);

    if ~exist(folder, 'dir')
        mkdir(folder)
    end
    filename = generate_available_filename(folder, 'mat', 10);
    save(filename, 'X', 'Y', 'accuracy')

end