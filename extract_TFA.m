%%
cd /../EEG_TF
load('matlab_block.mat');
PATH1='/.../EEG_block_data/items_1_old/';
PATH2='/.../EEG_TF/items_1_old/';
cd(PATH1);
list=dir('*.set');
for i=1:length(list)
    EEG = pop_loadset('filename',list(i).name,'filepath',PATH1);
    [ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );
    DATA=zeros(62,42,3000);
    for k=1:62
        data=EEG.data(k,:)';
        [alltfX freqs timesout R] = timefreq(data, g.srate, tmioutopt{:}, ...
                'winsize', 128, 'tlimits', g.tlimits, 'detrend', g.detrend, ...
                'itctype', g.type, 'wavelet', g.cycles, 'verbose', g.verbose, ...
                'padratio', 8, 'freqs', g.freqs, 'freqscale', g.freqscale, ...
                'nfreqs', g.nfreqs, 'timestretch', {g.timeStretchMarks', g.timeStretchRefs}, timefreqopts{:});
        DATA(k,:,:)=alltfX;
    end
    A=list(i).name;
    A1=A(1:end-4);
    save([PATH2,A1,'.mat'],'DATA');
    STUDY = []; CURRENTSTUDY = 0; ALLEEG = []; EEG=[]; CURRENTSET=[];
end






