
minRange = linspace(0.5, 1, 11);
maxRange = minRange(2:end);
minRange = minRange(1:end-1);

blankClassifier = @() Gaussian_classifier();
nPointPerClusters = 1000;
nDatasets = 100;

dimToSample = [2, 5, 10, 30];
cstToSample = [4, 2.5, 1.5, 1]*1.5;
nSlice = 20;
slice = cstToSample ./ nSlice;
nLoopPerSlice = 250;

checkFreq = 10;
cnt = 0;

for iSlice = 1:nSlice
    cstToSample = cstToSample - slice;
    
    for iLoopPerSlice = 1:nLoopPerSlice
        
        if isempty(dimToSample)
            return
        end
        cnt = cnt + 1;
        
        %%
        idx = randi(length(dimToSample));
        dim = dimToSample(idx);
        cst = cstToSample(idx);
        
        meanPdfs = {};
        meanPdfs{end+1} = @() rand(1,dim) * cst;
        meanPdfs{end+1} = @() rand(1,dim) * cst;
        
        covPdfs = {};
        covPdfs{end+1} = @() eye(dim);
        covPdfs{end+1} = @() eye(dim);
        
        %%
        
        [X, Y, accuracy] = generate_quality_dataset(blankClassifier, ...
            [0.5, 1], ...
            nPointPerClusters, ...
            meanPdfs, ...
            covPdfs, ...
            1000);
        
        minmin = minRange <= accuracy;
        maxmax = maxRange >= accuracy;
        segment = find(minmin == maxmax);
        accuracyRange = [minRange(segment), maxRange(segment)];
        
        [pathstr, ~, ~] = fileparts(mfilename('fullpath'));
        folder = fullfile(pathstr, [num2str(dim), 'D']);
        
        strAccu = [num2str(accuracyRange(1)*100), '_', num2str(accuracyRange(2)*100)];
        folder = fullfile(folder, strAccu);
        if ~exist(folder, 'dir')
            mkdir(folder)
        end
        
        fprintf('%d -> %4f \n', dim, accuracy)
        
        if length(getfilenames(folder, 'refiles', '*.mat')) < nDatasets
            filename = generate_available_filename(folder, 'mat', 10);
            save(filename, 'X', 'Y', 'accuracy')
        end
        
        if mod(cnt, checkFreq) == 0
            cnt = 0;
            disp(' ')
            disp('////////////////////')
            dimFull = zeros(1, length(dimToSample));
            for iDim = 1:length(dimToSample)
                dim = dimToSample(iDim);
                disp(' ')
                disp(['##### ', num2str(dim), ' #####'])
                full = 1;
                for iSegment = 1:length(maxRange)
                    
                    [pathstr, ~, ~] = fileparts(mfilename('fullpath'));
                    folder = fullfile(pathstr, [num2str(dim), 'D']);
                    
                    accuracyRange = [minRange(iSegment), maxRange(iSegment)];
                    strAccu = [num2str(accuracyRange(1)*100), '_', num2str(accuracyRange(2)*100)];
                    folder = fullfile(folder, strAccu);
                    
                    fprintf('%s : ', strAccu)
                    if exist(folder, 'dir')
                        nDtset = length(getfilenames(folder, 'refiles', '*.mat'));
                        if nDtset < nDatasets
                            full = 0;
                        end
                    else
                        full = 0;
                        nDtset = 0;
                    end
                    disp([num2str(nDtset), '/', num2str(nDatasets)])
                    
                    
                end
                dimFull(iDim) = full;
            end
            dimToSample(dimFull == 1) = [];
            disp(' ')
            disp('////////////////////')
            disp(' ')
        end
    end
end