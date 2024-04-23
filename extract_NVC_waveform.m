%%
PATH1='/.../simu_HbO_old3/items_1_old/';
PATH2='/.../HbO_HbR_old_SQI/HbO_items_1_old/';
PATH3='/.../NVC_HbO/frontal/items_1_old/';
% %%%%%%%%%%%%%%%%%%%%5
load('Time_simu_HbO.mat');
t1=Time;
load('Time_fNIRS.mat');
t2=Time(93:1143);
%%%%%%%%%%%%%%%%%%%%%%%
cd(PATH1);
list=dir('*.mat');
cd(PATH2)
list2=dir('*.mat');
for i=1:length(list2)
    A=list2(i).name;
    load([PATH1,A(1:end-13),'_',A(end-12:end-12),'.mat']);
    NIRS=load([PATH2,A]);
    A1=list(i).name;
    data=zeros(28,1051);
    for k1=1:28
        B1=DATA(k1,:);
        Y2=interp1(t1,B1,t2)';
        Y2(1)=Y2(2);
        data(k1,:)=Y2;
    end
    D1=data(1:14,:);
    D3=NIRS.DATA(:,1);
    Data=zeros(14,2101);
    for p1=1:14
        [r,lags] = xcorr(D1(p1,:),D3(193:1243));
        Data(p1,:)=r;
    end
    save([PATH3,A],'Data');
end
%%
PATH1='/.../simu_HbO_old3/items_1_old/';
PATH2='/.../HbO_HbR_old_SQI/HbO_items_1_old/';
PATH3='/.../NVC_HbO/parietal/items_1_old/';
% %%%%%%%%%%%%%%%%%%%%5
load('Time_simu_HbO.mat');
t1=Time;
load('Time_fNIRS.mat');
t2=Time(93:1143);
%%%%%%%%%%%%%%%%%%%%%%%
cd(PATH1);
list=dir('*.mat');
cd(PATH2)
list2=dir('*.mat');
for i=1:length(list2)
    A=list2(i).name;
    load([PATH1,A(1:end-13),'_',A(end-12:end-12),'.mat']);
    NIRS=load([PATH2,A]);
    A1=list(i).name;
    data=zeros(28,1051);
    for k1=1:28
        B1=DATA(k1,:);
        Y2=interp1(t1,B1,t2)';
        Y2(1)=Y2(2);
        data(k1,:)=Y2;
    end
    D1=data(15:28,:);
    D3=NIRS.DATA(:,2);
    Data=zeros(14,2101);
    for p1=1:14
        [r,lags] = xcorr(D1(p1,:),D3(193:1243));
        Data(p1,:)=r;
    end
    save([PATH3,A],'Data');
end






