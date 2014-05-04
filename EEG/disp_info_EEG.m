function disp_info_EEG(EEGfilename)
%GET_INFO_EEG

load(EEGfilename)
disp(['Nb of signals: ', num2str(size(X, 1))])
disp(['Nb of positive: ', num2str(sum(Y(Y==1)))])
disp(['Nb of negative: ', num2str(sum(Y(Y==2)))])

disp(['Nb dimension: ', num2str(size(X, 2))])