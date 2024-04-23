%%
PATH1='/.../NVC_HbO/frontal/items_1_old/';
PATH2='/.../NVC_HbO_feature/';
load('Time_NVC_new.mat');
AA=Time(200:1900);
cd(PATH1);
list=dir('*.mat');
DATA=zeros(3,14,length(list));
for k=1:length(list)
    load([PATH1,list(k).name]);
    A=reshape(Data,14,2101);
    for k1=1:14
        [B,I]=max(A(k1,200:1900));
        M=sum(A(k1,1000:1100));
        DATA(1,k1,k)=B;
        DATA(2,k1,k)=AA(I);
        DATA(3,k1,k)=M;
    end
end



