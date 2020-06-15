function timestamps=get_jb_timestamps_CC(driver,effector,tracker,protocol)
location=strcat('D:\TOMOKO\jb-results\',tracker,'\',driver,'@',effector,'\',protocol);
geno_folder=dir(location);
%start=cd('D:\TOMOKO\jb-results');
%% Get timestamps
timestamps=cell(1,length(geno_folder)-2);
for i=3:length(geno_folder)
    timestamps(i-2)=cellstr(geno_folder(i).name);
end
end