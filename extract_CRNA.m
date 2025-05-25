%%
load('ERP.mat');
PATH1='/.../EEG_TF/items_1_old/';
PATH2='/.../EEG_TF/ERPCOH_CRNA_real_image_items_1/';
cd(PATH1);
list_ch=[12,18,8,20,10,19,35,39,46,28,45,47];
stimu=[118,597,1075,1553,2033,2510];% pre=60;post=400;
ERP=abs(AA(list_ch,:));
%%% FFC1h, FFC2h, FFC3h,FFC4h,FFC5h,FFC6h;
%%% CPP1h, CPP2h, CPP3h,CPP4h,CPP5h,CPP6h
list2=dir('*.mat');
cd /../EEG_TF/
for s1=1:length(list2)
    load([PATH1,list2(s1).name]);
    DATA=DATA(:,:,:);
    Data=zeros(12,3000);
    for s2=1:12
        A1=reshape(DATA(list_ch(s2),1:27,:),27,3000);
        C1=db(abs(A1));
        data=zeros(61,27,3000);
        for k=1:61
            list1=1:62;
            list1(list_ch(s2))=[];
            A2=reshape(DATA(list1(k),1:27,:),27,3000);
            for k1=1:27
                A3=zeros(1,3000);
                for k2=1:3000
                    sig1=A1(k1,k2);
                    sig2=A2(k1,k2);
                    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                    coherresout=sig1.*conj(sig2);
                    coh1=abs(coherresout);
                    A3(k2)=coh1;
                end
                A3=(A3-mean(A3(1:50)));
                data(k,k1,:)=A3;
            end
        end
        %%%%%%%%%%%%%%%%%%
        labels=ones(1,3000);
        labels(1:7)=0;
        B2=zeros(61,5,3000);
        for k2=1:61
            B4=(reshape(data(k2,1:27,:),27,3000));
            B4(B4<0)=0;
            [w,h] = nnmf(B4,10);
            AA=zeros(10,1);
            try
            for t=1:10
                try
                A2=h(t,:);
                [r,p]=corr(A2',ERP(s2,:)');
                AA(t)=r;
                %%%%%%%%%%%%%%%%%%%%%
                catch
                end
            end
            h(isnan(AA),:)=[];
            AA(isnan(AA))=[];
            [H,E]=sort(AA,'descend');
            mappedX3=h(E(1:5),:)';
            B2(k2,:,:)=mappedX3';
            catch
                
            end
        end
        B1=reshape(B2,61*5,3000);
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        B4=B1;
        B4(B4<0)=0;
        [w,h] = nnmf(B4,20);
        S1=h;
        data=zeros(20,1);
        for t=1:20
            A2=h(t,:);
            [r,p]=corr(A2',ERP(s2,:)');
            data(t)=r;
            %%%%%%%%%%%%%%%%%%%%%
        end
        S1(isnan(data),:)=[];
        data(isnan(data))=[];
        [H,E]=sort(data,'descend');
        S1=S1(E(1:5),:);
        %% %%%%%%%%%%%%%%%%%%%%%%%%%%%  
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        A1=abs(real(reshape(DATA(s2,1:27,:),27,3000)));%-reshape(mean(abs(real(DATA)),1),27,200);
        B31=zeros(27,3000);
        for kk1=1:27
            A2=((A1(kk1,:)));
            B31(kk1,:)=(A2-mean(A2(1:50)));
        end
        C31=zeros(5,27,3000);
        for k1=1:5
            for k2=1:27
                C31(k1,k2,:)=B31(k2,:).*S1(k1,:);
            end
        end
        M=reshape(C31,27*5,3000);
        B4=abs(M);     
        [w,h31] = nnmf(B4,40);
        SS1=h31;
        data=zeros(40,1);
        for t=1:40
            A2=SS1(t,:);
            [r,p]=corr(A2',ERP(s2,:)');
            data(t)=r;
            %%%%%%%%%%%%%%%%%%%%%
        end
        SS1(isnan(data),:)=[];
        data(isnan(data))=[];
        [H,E]=sort(data,'descend');
        SS1=SS1(E(1:20),:);
        %%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        A1=abs(imag(reshape(DATA(s2,1:27,:),27,3000)));%-reshape(mean(abs(real(DATA)),1),27,200);
        B31=zeros(27,3000);
        for kk1=1:27
            A2=((A1(kk1,:)));
            B31(kk1,:)=(A2-mean(A2(1:50)));
        end
        C31=zeros(5,27,3000);
        for k1=1:5
            for k2=1:27
                C31(k1,k2,:)=B31(k2,:).*S1(k1,:);
            end
        end
        M=reshape(C31,27*5,3000);
        B4=abs(M);     
        [w,h32] = nnmf(B4,40);
        SS2=h32;
        data=zeros(40,1);
        for t=1:40
            A2=SS2(t,:);
            [r,p]=corr(A2',ERP(s2,:)');
            data(t)=r;
            %%%%%%%%%%%%%%%%%%%%%
        end
        SS2(isnan(data),:)=[];
        data(isnan(data))=[];
        [H,E]=sort(data,'descend');
        SS2=SS2(E(1:20),:);
        %%
        X=rand(20,1);
        Y=rand(20,1);
        a1=zeros(20,1);
        a2=zeros(20,1);
        a3=zeros(20,1);
        a4=zeros(20,1);
        b1=zeros(20,1);
        b2=zeros(20,1);
        b3=zeros(20,1);
        b4=zeros(20,1);
        a=SS1';
        b=SS2';
        u=0.001;
        [X,Y]=GD_WY66(X,Y,a,b,a1,a2,a3,a4,b1,b2,b3,b4,u,0.001);
        EE=(a*X+b*Y);
        Data(s2,:)=EE;
    end
    save([PATH2,list2(s1).name],'Data');
end