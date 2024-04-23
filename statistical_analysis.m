%%
PATH='/media/wangyu/新加卷1/王宇范式预实验_young/NVC_block_30_old/NVC_HbO_feature/stats_corr/';
for t1=1
    for t2=1:14
        load('frontal_items_1_old.mat');
        O1=reshape(DATA(t1,t2,:),1,180)';
        load('frontal_items_3_old.mat');
        O3=reshape(DATA(t1,t2,:),1,180)';
        load('frontal_items_5_old.mat');
        O5=reshape(DATA(t1,t2,:),1,180)';
        [p3,stats]=vartestn([O1,O3,O5]); 
        
        [h11,p11]=lillietest(O1);
        [h21,p21]=lillietest(O3);
        [h22,p22]=lillietest(O5);
        
        varname={'subject';'stimulus'};
        data=[O1,O3,O5];
        [p,tbl,stats] = anova1(data);
        results11=multcompare(stats,'CType','bonferroni','Estimate','row');%
        results8=multcompare(stats,'CType','hsd','Estimate','row');%
        results13=multcompare(stats,'CType','dunn-sidak','Estimate','row');%
        results14=multcompare(stats,'CType','lsd','Estimate','row');%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%
        results21=multcompare(stats,'CType','bonferroni','Estimate','column');%
        results22=multcompare(stats,'CType','hsd','Estimate','column');%
        results23=multcompare(stats,'CType','dunn-sidak','Estimate','column');%
        results24=multcompare(stats,'CType','lsd','Estimate','column');%%Ð
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        DaTa{1,1}=p11;DaTa{2,1}=p21;DaTa{3,1}=p22;
        DaTa{1,2}=p3;
        DaTa{1,3}=results11;DaTa{2,3}=results8;DaTa{3,3}=results13;DaTa{4,3}=results14;
        DaTa{1,4}=results21;DaTa{2,4}=results22;DaTa{3,4}=results23;DaTa{4,4}=results24;
        DaTa{1,5}=tbl;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%
        save([PATH,'Am_frontal_',num2str(t1),'-',num2str(t2),'.mat'],'DaTa');
        save([PATH,'Am_frontal_Data_channel',num2str(t1),'-',num2str(t2),'.mat'],'data');
        clear data;
        clear DaTa;
        close all;
    end
end
%%
for t1=2
    for t2=1:14
        load('frontal_items_1_old.mat');
        O1=reshape(DATA(t1,t2,:),1,180)';
        load('frontal_items_3_old.mat');
        O3=reshape(DATA(t1,t2,:),1,180)';
        load('frontal_items_5_old.mat');
        O5=reshape(DATA(t1,t2,:),1,180)';
        [p3,stats]=vartestn([O1,O3,O5]); 
        
        [h11,p11]=lillietest(O1);
        [h21,p21]=lillietest(O3);
        [h22,p22]=lillietest(O5);
        
        varname={'subject';'stimulus'};
        data=[O1,O3,O5];
        [p,tbl,stats] = anova1(data);
        results11=multcompare(stats,'CType','bonferroni','Estimate','row');%
        results8=multcompare(stats,'CType','hsd','Estimate','row');%
        results13=multcompare(stats,'CType','dunn-sidak','Estimate','row');%
        results14=multcompare(stats,'CType','lsd','Estimate','row');%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%
        results21=multcompare(stats,'CType','bonferroni','Estimate','column');%
        results22=multcompare(stats,'CType','hsd','Estimate','column');%
        results23=multcompare(stats,'CType','dunn-sidak','Estimate','column');%
        results24=multcompare(stats,'CType','lsd','Estimate','column');%%Ð
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        DaTa{1,1}=p11;DaTa{2,1}=p21;DaTa{3,1}=22;
        DaTa{1,2}=p3;
        DaTa{1,3}=results11;DaTa{2,3}=results8;DaTa{3,3}=results13;DaTa{4,3}=results14;
        DaTa{1,4}=results21;DaTa{2,4}=results22;DaTa{3,4}=results23;DaTa{4,4}=results24;
        DaTa{1,5}=tbl;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%
        save([PATH,'Ti_frontal_',num2str(t1),'-',num2str(t2),'.mat'],'DaTa');
        save([PATH,'Ti_frontal_Data_channel',num2str(t1),'-',num2str(t2),'.mat'],'data');
        clear data;
        clear DaTa;
        close all;
    end
end

