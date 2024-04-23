%%
% list_ch=[7,13,6,14,9,11,12,18,8,20,10,19,17,21,43,49,42,50,48,35,44,38,35,39,46,28,45,47];
%%% F5, F6, F7, F8, AFF1h, AFF2h, FFC1h, FFC2h, FFC3h,FFC4h,FFC5h,FFC6h,FC4, FC6;
%%% P5, P6, P7, P8, PPO1h, PPO2h, PPO5, PPO6, CPP1h, CPP2h, CPP3h,CPP4h,CPP5h,CPP6h
list_ch=1:28;
PATH1='/.../CRNA/data1/items_1_old/';
PATH2='/.../CRNA/data1/simu_items_1_old/';
RT=0.0145;
P(1)=6;
P(2)=16;
P(3)=1;
P(4)=1;
P(5)=6;
P(6)=0;
P(7)=32;
%%%%%%%%%%%%%%%%%%%%%%%  
[hrf,p1] = spm_hrf(RT,P);
cd(PATH1);
list=dir('*.mat');
for i=1:length(list)
    load([PATH1,list(i).name]);
    EEG51=Data(list_ch,:);
    DATA=zeros(28,3499);
    A1=list(i).name;
    for k=1:28
        Y1=conv(EEG51(k,:),hrf);
        DATA(k,:)=Y1(1:3499);
    end
    save([PATH2,A1],'DATA');
end






