%%
PATH1='/media/wangyu/新加卷2/王宇范式预实验_old/EEG_TF/items_1_old/';
PATH2='/media/wangyu/新加卷2/王宇范式预实验_old/EEG_TF/CRNA/data1/items_1_old/';
cd(PATH1);
cd(PATH1);
list_ch=[7,13,6,14,9,11,12,18,8,20,10,19,17,21,43,49,42,50,48,35,44,38,35,39,46,28,45,47];
stimu=[118,597,1075,1553,2033,2510];% pre=60;post=400;
%%% F5, F6, F7, F8, AFF1h, AFF2h, FFC1h, FFC2h, FFC3h,FFC4h,FFC5h,FFC6h,FC4, FC6;
%%% P5, P6, P7, P8, PPO1h, PPO2h, PPO5, PPO6, CPP1h, CPP2h, CPP3h,CPP4h,CPP5h,CPP6h
list2=dir('*.mat');
for s1=1:length(list2)
    load([PATH1,list2(s1).name]);
    DATA=DATA(:,:,:);
    Data=zeros(28,3000);
    for s2=1:28
        A1=reshape(DATA(list_ch(s2),1:27,:),27,3000);
        C1=db(abs(A1));
        data=zeros(127,42,3000);
        for k=1:61
            list1=1:62;
            list1(list_ch(s2))=[];
            A2=reshape(DATA(list1(k),1:27,:),27,3000);
            for k1=1:27
                A3=zeros(1,3000);
                for k2=1:3000
                    sig1=A1(k1,k2);
                    sig2=A2(k1,k2);
                    coherresout=sig1.*conj(sig2);
                    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                    coh1=abs(coherresout);
                    A3(k2)=coh1;
                end
                A3=(A3-mean(A3(1:50)));%/std(A3(1:7));
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
                r1=(A2(stimu(1):stimu(1)+400));
                r2=(A2(stimu(2):stimu(2)+400));
                r3=(A2(stimu(3):stimu(3)+400));
                r4=(A2(stimu(4):stimu(4)+400));
                r5=(A2(stimu(5):stimu(5)+400));
                r6=(A2(stimu(6):stimu(6)+400));
                AA(t)=1/std([std(r1);std(r2);std(r3);std(r4);std(r5);std(r6)]);
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
        %%%%%%%%%%%%%%%%%%
        B3=zeros(27,3000);
        for k1=1:27
            A2=(abs(A1(k1,:)));
            B3(k1,:)=(A2-mean(A2(1:50)));%/std(A2(1:7));
        end
        t=0;
        AA1=zeros(60,3000);
        for k1=1:26
            for k2=k1+1:27
                A1=B3(k1,:);
                A2=B3(k2,:);
                t=t+1;
                AA1(t,:)=A1.*A2;
            end
        end
        B3=abs(AA1);
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        B4=B1;
        B4(B4<0)=0;
        [w,h] = nnmf(B4,40);
        S1=h;
        data=zeros(40,1);
        for t=1:40
            A2=S1(t,:);
            r1=(A2(stimu(1):stimu(1)+400));
            r2=(A2(stimu(2):stimu(2)+400));
            r3=(A2(stimu(3):stimu(3)+400));
            r4=(A2(stimu(4):stimu(4)+400));
            r5=(A2(stimu(5):stimu(5)+400));
            r6=(A2(stimu(6):stimu(6)+400));
            data(t)=1/std([std(r1);std(r2);std(r3);std(r4);std(r5);std(r6)]);
%             data(t)=r1*r2*r3*r4*r5*r6;
        end
        S1(isnan(data),:)=[];
        data(isnan(data))=[];
        [H,E]=sort(data,'descend');
        S1=S1(E(1:20),:);
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        B4=abs(B3);
        B4(B4<0)=0;
        [w,h] = nnmf(B4,40);
        S2=h;
        data=zeros(40,1);
        for t=1:40
            A2=S2(t,:);
            r1=(A2(stimu(1):stimu(1)+400));
            r2=(A2(stimu(2):stimu(2)+400));
            r3=(A2(stimu(3):stimu(3)+400));
            r4=(A2(stimu(4):stimu(4)+400));
            r5=(A2(stimu(5):stimu(5)+400));
            r6=(A2(stimu(6):stimu(6)+400));
            data(t)=1/std([std(r1);std(r2);std(r3);std(r4);std(r5);std(r6)]);
%             data(t)=r1*r2*r3*r4*r5*r6;
        end
        S2(isnan(data),:)=[];
        data(isnan(data))=[];
        [H,E]=sort(data,'descend');
        S2=S2(E(1:20),:);
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        [A,B,R,U,V] = canoncorr(S1',S2');
        U1 =S1'*A;
        V1 =S2'*B;
        P=U1.*V1;
        R(R<0.3)=0;
        P1=P*R';
        Data(s2,:)=P1;
    end
    save([PATH2,list2(s1).name],'Data');
end


















