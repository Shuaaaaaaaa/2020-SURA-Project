function [etho_jb,aninum]=optimize_data_ethogram(jb_beh)
% jb_beh=[jbt0sRoll',jbt1sRoll',jbt0sRun',jbt1sRun',...
%     jbt0sCast',jbt1sCast',jbt0sCast_large',jbt1sCast_large',...
%     jbt0sCast_weak',jbt1sCast_weak',jbt0sCast_strong',jbt1sCast_strong',...
%     jbt0s',jbt1s',jb_numero'];
jb_run=[];jb_runT=[];
jb_cast=[];jb_castT=[];jb_cast_large=[];jb_castT_large=[];jb_cast_weak=[];jb_castT_weak=[];jb_cast_strong=[];jb_castT_strong=[];
jb_roll=[];jb_rollT=[];
%% Choose aninum for ethogram
% aninum=0;
% if size(jb_beh,1)>=100
%     aninum=100;
% elseif size(jb_beh,1)>=50
%     aninum=50;
% elseif size(jb_beh,1)>=30
%     aninum=30;
% elseif size(jb_beh,1)>=20
%     aninum=20;
% elseif size(jb_beh,1)>=10
%     aninum=10;
% else
    aninum=size(jb_beh,1);
% end
%% Randomly choose #aninum among jb_beh
% out1 = randperm(size(jb_beh,1));
% aninum_ind = out1(1:aninum);
%%
for i=1:aninum
    ind=i;
    %% ROLL
    if ~isempty(jb_beh{ind,1})
    jb_MM=jb_beh{ind,1};
    jb_MM(:,2)=jb_beh{ind,2};
    jb_TT=zeros(size(jb_MM));
    jb_TT(:,:)=str2num(jb_beh{i,15});
    jb_roll=vertcat(jb_roll,jb_MM);
    jb_rollT=vertcat(jb_rollT,jb_TT);
    end
    %% RUN
    if ~isempty(jb_beh{ind,3})
    jb_MM=jb_beh{ind,3};
    jb_MM(:,2)=jb_beh{ind,4};
    jb_TT=zeros(size(jb_MM));
    jb_TT(:,:)=str2num(jb_beh{i,15});
    jb_run=vertcat(jb_run,jb_MM);
    jb_runT=vertcat(jb_runT,jb_TT);
    end
    %% CAST
    if ~isempty(jb_beh{ind,5})
    jb_MM=jb_beh{ind,5};
    jb_MM(:,2)=jb_beh{ind,6};
    jb_TT=zeros(size(jb_MM));
    jb_TT(:,:)=str2num(jb_beh{i,15});
    jb_cast=vertcat(jb_cast,jb_MM);
    jb_castT=vertcat(jb_castT,jb_TT);
    end
    %% CAST_LARGE
    if ~isempty(jb_beh{ind,7})
    jb_MM=jb_beh{ind,7};
    jb_MM(:,2)=jb_beh{ind,8};
    jb_TT=zeros(size(jb_MM));
    jb_TT(:,:)=str2num(jb_beh{i,15});
    jb_cast_large=vertcat(jb_cast_large,jb_MM);
    jb_castT_large=vertcat(jb_castT_large,jb_TT);
    end
    %% CAST_WEAK
    if ~isempty(jb_beh{ind,9})
    jb_MM=jb_beh{ind,9};
    jb_MM(:,2)=jb_beh{ind,10};
    jb_TT=zeros(size(jb_MM));
    jb_TT(:,:)=str2num(jb_beh{i,15});
    jb_cast_weak=vertcat(jb_cast_weak,jb_MM);
    jb_castT_weak=vertcat(jb_castT_weak,jb_TT);
    end
    %% CAST_STRONG
    if ~isempty(jb_beh{ind,11})
    jb_MM=jb_beh{ind,11};
    jb_MM(:,2)=jb_beh{ind,12};
    jb_TT=zeros(size(jb_MM));
    jb_TT(:,:)=str2num(jb_beh{i,15});
    jb_cast_strong=vertcat(jb_cast_strong,jb_MM);
    jb_castT_strong=vertcat(jb_castT_strong,jb_TT);
    end
end
etho_jb={jb_roll,jb_rollT,jb_run,jb_runT,jb_cast,jb_castT,...
    jb_cast_large,jb_castT_large,jb_cast_weak,jb_castT_weak,...
    jb_cast_strong,jb_castT_strong};
end