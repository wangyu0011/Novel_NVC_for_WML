%%
PATH1='/.../raw_data/';
PATH2='/.../fNIRS_data/';
for k=1:30
    cd(PATH1);
    list1=dir(['sub',num2str(k),'_*']);
    cd([PATH1,list1(1).name]);
    list2=dir('*_ST1');
    cd(list2(1).name);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    list3=dir('*.snirf');
    acquired_path = list3(1).name;
    if ~isempty(acquired_path)
        acquired = SnirfClass(acquired_path);
        data = acquired.data;
        aux = acquired.aux;
    %     dod = acquired.dod;
    %     mlActMan = acquired.mlActMan;
    %     mlActAuto = acquired.mlActAuto;
        probe = acquired.probe;
    %     dc = acquired.dc;
    end
    %{
      Converts intensity data to optical density
    %}
    dod = hmrR_Intensity2OD(data);
    mlActAuto = cell(length(dod),1);
    mlActMan = cell(length(dod),1);
    %{
      Perform a bandpass filter on time course data.
    %}
    aux = hmrR_BandpassFilt(aux,0,0.5);
    %{
      SplineSG_Motion_Correction
    %}
    mlActAuto = cell(length(dod),1);
    dod = hmrR_MotionCorrectSplineSG(dod,mlActAuto,0.99,10,1);
    %{
      Convert OD to concentrations.
    %}
    dc2 = hmrR_OD2Conc(dod,probe,[1  1]);
    fs=20.7;
    hpf=0.01;
    lpf=0.2;
    y=dc2.dataTimeSeries;
    cd /../
    [y2,ylpf] = nirs_BandpassFilt( y, fs, hpf, lpf );
    data2=y2;
    save([PATH2,num2str(k),'-1.mat'],'data2');
end

