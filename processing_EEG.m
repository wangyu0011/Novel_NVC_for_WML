%%
PATH1='/.../EEG_dataset/ST_old/';
PATH2='/.../EEG_ICA_data/ICA_ST_old/';
cd(PATH1);
for i1=1:30
    for i2=1:3
        EEG = pop_loadset('filename',[num2str(i1),'-',num2str(i2),'.set'],'filepath',PATH1);
        [ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );
        EEG = pop_eegfiltnew(EEG, 0.5,45,6600,0,[],1);
        [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'gui','off'); 
        EEG = eeg_checkset( EEG );
        EEG = pop_reref( EEG, [33 43] );
        [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 2,'gui','off'); 
        EEG = eeg_checkset( EEG );
        EEG = pop_select( EEG,'point',[EEG.event(2).latency-20000 EEG.event(end).latency+2000] );
        [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 3,'comments',[],'gui','off'); 
        EEG = eeg_checkset( EEG );
        EEG = pop_runica(EEG, 'extended',1,'interupt','on');
        [ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
        EEG = eeg_checkset( EEG );
        EEG = pop_saveset( EEG, 'filename',[num2str(i1),'-',num2str(i2),'.set'],'filepath',PATH2);
        [ALLEEG EEG] = eeg_store(ALLEEG, EEG, CURRENTSET);
        STUDY = []; CURRENTSTUDY = 0; ALLEEG = []; EEG=[]; CURRENTSET=[];
    end
end





