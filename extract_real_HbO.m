%%
load('fNIRS_average.mat');
fNIRS=DATA';
PATH1='/.../HbO_items_1_old/';
PATH2='/.../HbR_items_1_old/';
PATH3='/.../items_1_old/';
%%%%%%%%%%%%%%%%%%%%%%%
cd(PATH1);
list=dir('*.mat');
for i=1:length(list)
    load([PATH1,list(i).name]);
    load([PATH2,list(i).name]);
    A1=list(i).name;
    A1(end-3:end)=[];
    A2=list(i).name;
    A2(end-10:end)=[];
    %%%%%%%%%%%%%%%%
    BB1=HbO(1:9,:);
    [sci_HbO_F,p]=corr(BB1',fNIRS(1,:)');
    BB1=HbO(10:18,:);
    [sci_HbO_P,p]=corr(BB1',fNIRS(2,:)');
    BB1=HbR(1:9,:);
    [sci_HbR_F,p]=corr(BB1',fNIRS(3,:)');
    BB1=HbR(10:18,:);
    [sci_HbR_P,p]=corr(BB1',fNIRS(4,:)');
    %%%%%%%%%%%%%%%%%
    [B,I_HbO_F]=sort(sci_HbO_F,'descend');
    [B,I_HbO_P]=sort(sci_HbO_P,'descend');
    [B,I_HbR_F]=sort(sci_HbR_F,'descend');
    [B,I_HbR_P]=sort(sci_HbR_P,'descend');
    %%%%%%%%%%%%%%%%%
    HbO_F=nanmean(HbO(I_HbO_F(1:5),:));
    HbO_P=nanmean(HbO(9+I_HbO_P(1:5),:));
    HbR_F=nanmean(HbR(I_HbR_F(1:5),:));
    HbR_P=nanmean(HbR(9+I_HbR_P(1:5),:));
    %%%%%%%%%%%%%%%%%%%
    DATA=[HbO_F',HbO_P',HbR_F',HbR_P'];
    save([PATH3,A1,'_items_1','.mat'],'DATA');
end
%%















