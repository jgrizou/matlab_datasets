

names = {'EMBC', 'OT1', 'OT2', 'RL1', 'RL2', 'RL3'};

figure
for iname = 1:length(names)
    
    subplot(2,3,iname)
    l = Logger();
    for i = 1:20
        [filename, valid] = generate_EEG_dataset_path(34, names{iname}, i);
        if valid
            load(filename)
            l.log_field('tot', size(X, 1))
            l.log_field('pos', sum(Y(Y==1)))
            l.log_field('neg', sum(Y(Y==2)))
        end
    end
    
    plot(l.tot)
    hold on
    plot(l.pos, 'g')
    plot(l.neg, 'r')
    ylim([0 max(l.tot)+50])
    
    title(names{iname})
    
    
end