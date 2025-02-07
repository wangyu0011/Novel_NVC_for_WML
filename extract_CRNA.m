%%
PATH1='/.../EEG_TF/items_1_old/';
PATH2='/.../EEG_TF/EEG_TF_01_27/wPLI_CRNA_ERSP_items_1/';
cd(PATH1);
list_ch=[12,18,8,20,10,19,35,39,46,28,45,47];
stimu=[118,597,1075,1553,2033,2510];% pre=60;post=400;
%%% FFC1h, FFC2h, FFC3h,FFC4h,FFC5h,FFC6h;
%%% CPP1h, CPP2h, CPP3h,CPP4h,CPP5h,CPP6h
list2=dir('*.mat');
for s1=1:length(list2)
    load([PATH1,list2(s1).name]);
    DATA=DATA(:,:,:);
    Data=zeros(12,3000);
    for s2=1:12
        A1=reshape(DATA(list_ch(s2),1:27,:),27,3000);
        C1=db(abs(A1));
        data=zeros(61,42,3000);
        for k=1:61
            list1=1:62;
            list1(list_ch(s2))=[];
            A2=reshape(DATA(list1(k),1:27,:),27,3000);
            for k1=1:27
                A3=zeros(1,3000);
                for k2=1:3000
                    sig1=A1(k1,k2);
                    sig2=A2(k1,k2);
                    %%%%%%% cross-spectral density
                    cdd = sig1.*conj(sig2);
                    cdi = imag(cdd);
                    % weighted phase-lag index (eq. 8 in Vink et al. NeuroImage 2011)
                    A3(k2)=abs(cdi).*sign(cdi);
                end
                A3=(A3-mean(A3(1:50)));
                data(k,k1,:)=A3;
            end
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
                    r1=(A2(stimu(1)-80:stimu(1)+300));
                    r2=(A2(stimu(2)-80:stimu(2)+300));
                    r3=(A2(stimu(3)-80:stimu(3)+300));
                    r4=(A2(stimu(4)-80:stimu(4)+300));
                    r5=(A2(stimu(5)-80:stimu(5)+300));
                    r6=(A2(stimu(6)-80:stimu(6)+300));
                    rr=[r1;r2;r3;r4;r5;r6];
                    [r,p]=corr(rr');
                    rr=reshape(r,1,6*6);
                    rr(rr==1)=NaN;
                    AA(t)=nanmean(rr);
                catch
                end
            end
            h(isnan(AA),:)=[];
            AA(isnan(AA))=[];
            [H,E]=sort(AA,'descend');
            mappedX3=h(E(1:5),:)';
            B2(k2,:,:)=mappedX3(:,1:5)';
            catch
                
            end
        end
        B1=reshape(B2,61*5,3000);
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        B4=B1;
        B4(B4<0)=0;
        [w,h] = nnmf(B4,20);
        S1=h;
        data=zeros(20,1);
        for t=1:20
            A2=h(t,:);
            r1=(A2(stimu(1)-80:stimu(1)+300));
            r2=(A2(stimu(2)-80:stimu(2)+300));
            r3=(A2(stimu(3)-80:stimu(3)+300));
            r4=(A2(stimu(4)-80:stimu(4)+300));
            r5=(A2(stimu(5)-80:stimu(5)+300));
            r6=(A2(stimu(6)-80:stimu(6)+300));
            rr=[r1;r2;r3;r4;r5;r6];
            [r,p]=corr(rr');
            rr=reshape(r,1,6*6);
            rr(rr==1)=NaN;
            data(t)=nanmean(rr);
            %%%%%%%%%%%%%%%%%%%%%
        end
        S1(isnan(data),:)=[];
        data(isnan(data))=[];
        [H,E]=sort(data,'descend');
        S1=S1(E(1:10),:);
        %% %%%%%%%%%%%%%%%%%%%%%%%%%%%
        B3=zeros(27,3000);
        for k1=1:27
            A2=(abs(A1(k1,:)));
            B3(k1,:)=(A2-mean(A2(1:50)));%/std(A2(1:7));
        end
        B4=abs(B3);     
        [w,h] = nnmf(B4,10);
        S2=h;
        data=zeros(10,1);
        for t=1:10
            A2=S2(t,:);
            r1=(A2(stimu(1)-80:stimu(1)+300));
            r2=(A2(stimu(2)-80:stimu(2)+300));
            r3=(A2(stimu(3)-80:stimu(3)+300));
            r4=(A2(stimu(4)-80:stimu(4)+300));
            r5=(A2(stimu(5)-80:stimu(5)+300));
            r6=(A2(stimu(6)-80:stimu(6)+300));
            rr=[r1;r2;r3;r4;r5;r6];
            [r,p]=corr(rr');
            rr=reshape(r,1,6*6);
            rr(rr==1)=NaN;
            data(t)=nanmean(rr);
            %%%%%%%%%%%%%%%%%%%%%
        end
        S2(isnan(data),:)=[];
        data(isnan(data))=[];
        [H,E]=sort(data,'descend');
        S2=S2(E(1:5),:);
        %%
        X=ones(10,1);
        Y=ones(5,1);
        a1=zeros(10,1);
        a2=zeros(10,1);
        a3=zeros(5,1);
        a4=zeros(5,1);
        b1=zeros(10,1);
        b2=zeros(10,1);
        b3=zeros(5,1);
        b4=zeros(5,1);
        a=S1';
        b=S2';
        u=0.001;
        [X,Y]=GD_WY55(X,Y,a,b,a1,a2,a3,a4,b1,b2,b3,b4,u,0.0001);
        EE=(a*X+b*Y);
        Data(s2,:)=EE;
    end
    save([PATH2,list2(s1).name],'Data');
end


