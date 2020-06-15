function [jbt,jb_beh,view_frame,vectors,delta_vectors,time]=process_jb_spine_TO(genotype,timestamp,larva_ind,view_sec,bin)
%%
[driver,effector,tracker,protocol,times]=read_name(genotype);
%%
jb=load(strcat('D:\TOMOKO\jb-results\',tracker,'\',driver,'@',effector,'\',protocol,'\',timestamp,'\trx.mat'));
jb=jb.trx;
numero=0;
%% find larva_ind
for i=1:size(jb,1)
    if (jb(i).numero_larva_num==larva_ind)
        numero=i;
    end
end
if (numero==0)
    disp('numero_larva_num does not exist');
end
Roll0={};Roll1={};
Run0={};Run1={};
Cast0={};Cast1={};Cast_weak0={};Cast_weak1={};Cast_strong0={};Cast_strong1={};aninum=1;
%% TRACK
jbt=jb(numero).t;
t0={jbt(1)};
t1={jbt(end)};
view_frame=[];
for i=1:size(view_sec,1)
    disp(i);
    view_frame(i,1)=find(jbt(:)==view_sec(i,1));
    view_frame(i,2)=find(jbt(:)==view_sec(i,2));
end
%% ROLL
jbroll=jb(numero).roll;
ind=find(jbroll==1);
if ~isempty(ind)
    Roll0{aninum}=[ind(1)];
    k=1;
    Roll1{aninum}=[];
    for j=2:length(ind)
        dif=ind(j)-ind(j-1);
        if dif~=1
            Roll0{aninum}(k+1)=ind(j);
            Roll1{aninum}(k)=ind(j-1);
            k=k+1;
        end
    end
    Roll1{aninum}(k)=ind(end);
    % Convert to sec
    %Roll0{aninum}=jbt(Roll0{aninum});
    %Roll1{aninum}=jbt(Roll1{aninum});
else
    Roll0{aninum}=[];
    Roll1{aninum}=[];
end
%% RUN
jbrun=jb(numero).run;
ind=find(jbrun==1);
if ~isempty(ind)
    Run0{aninum}=[ind(1)];
    k=1;
    Run1{aninum}=[];
    for j=2:length(ind)
        dif=ind(j)-ind(j-1);
        if dif~=1
            Run0{aninum}(k+1)=ind(j);
            Run1{aninum}(k)=ind(j-1);
            k=k+1;
        end
    end
    Run1{aninum}(k)=ind(end);
    % Convert to sec
    %Run0{aninum}=jbt(Run0{aninum});
    %Run1{aninum}=jbt(Run1{aninum});
else
    Run0{aninum}=[];
    Run1{aninum}=[];
end
%% CAST
jbcast=jb(numero).cast;
ind=find(jbcast==1);
if ~isempty(ind)
    Cast0{aninum}=[ind(1)];
    k=1;
    Cast1{aninum}=[];
    for j=2:length(ind)
        dif=ind(j)-ind(j-1);
        if dif~=1
            Cast0{aninum}(k+1)=ind(j);
            Cast1{aninum}(k)=ind(j-1);
            k=k+1;
        end
    end
    Cast1{aninum}(k)=ind(end);
    % Convert to sec
    %Cast0{aninum}=jbt(Cast0{aninum});
    %Cast1{aninum}=jbt(Cast1{aninum});
else
    Cast0{aninum}=[];
    Cast1{aninum}=[];
end
%% CAST_STRONG
jbcast_strong=jb(numero).cast_strong;
ind=find(jbcast_strong==1);
if ~isempty(ind)
    Cast_strong0{aninum}=[ind(1)];
    k=1;
    Cast_strong1{aninum}=[];
    for j=2:length(ind)
        dif=ind(j)-ind(j-1);
        if dif~=1
            Cast_strong0{aninum}(k+1)=ind(j);
            Cast_strong1{aninum}(k)=ind(j-1);
            k=k+1;
        end
    end
    Cast_strong1{aninum}(k)=ind(end);
    % Convert to sec
    %Cast_strong0{aninum}=jbt(Cast_strong0{aninum});
    %Cast_strong1{aninum}=jbt(Cast_strong1{aninum});
else
    
    Cast_strong0{aninum}=[];
    Cast_strong1{aninum}=[];
end
%% CAST_WEAK
jbcast_weak=jb(numero).cast_weak;
ind=find(jbcast_weak==1);
if ~isempty(ind)
    Cast_weak0{aninum}=[ind(1)];
    k=1;
    Cast_weak1{aninum}=[];
    for j=2:length(ind)
        dif=ind(j)-ind(j-1);
        if dif~=1
            Cast_weak0{aninum}(k+1)=ind(j);
            Cast_weak1{aninum}(k)=ind(j-1);
            k=k+1;
        end
    end
    Cast_weak1{aninum}(k)=ind(end);
    % Convert to sec
    %Cast_weak0{aninum}=jbt(Cast_weak0{aninum});
    %Cast_weak1{aninum}=jbt(Cast_weak1{aninum});
else
    Cast_weak0{aninum}=[];
    Cast_weak1{aninum}=[];
end

Run=horzcat(Run0{:}',Run1{:}');Run_T=zeros(size(Run));%Run_T(:)=0;
Roll=horzcat(Roll0{:}',Roll1{:}');Roll_T=zeros(size(Roll));%Roll_T(:)=0;
Cast=horzcat(Cast0{:}',Cast1{:}');Cast_T=zeros(size(Cast));%Cast_T(:)=-10;
Cast_weak=horzcat(Cast_weak0{:}',Cast_weak1{:}');Cast_weak_T=zeros(size(Cast_weak));%Cast_weak_T(:)=-10;
Cast_strong=horzcat(Cast_strong0{:}',Cast_strong1{:}');Cast_strong_T=zeros(size(Cast_strong));%Cast_strong_T(:)=-10;
%row: animal
%column: beh
jb_beh=[t0,t1,{Run},{Run_T},{Roll},{Roll_T},{Cast},{Cast_T},{Cast_weak},{Cast_weak_T},{Cast_strong},{Cast_strong_T}];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Process Center2Head=[]; Center2Tail=[];
head_x=jb(numero).x_head;
head_y=jb(numero).y_head;
center_x=jb(numero).x_neck;
center_y=jb(numero).y_neck;
tail_x=jb(numero).x_tail;
tail_y=jb(numero).y_tail;
%% Test
for i=1:length(head_x)
    if (jb(numero).x_spine(i,1)~=head_x(i,1))
        disp('head_x mismatch');
    end 
    if (jb(numero).y_spine(i,1)~=head_y(i,1))
        disp('head_x mismatch');
    end 
    if (jb(numero).x_spine(i,6)~=center_x(i,1))
        disp('center_x mismatch');
    end 
    if (jb(numero).y_spine(i,6)~=center_y(i,1))
        disp('center_y mismatch');
    end 
    if (jb(numero).x_spine(i,11)~=tail_x(i,1))
        disp('tail_x mismatch');
    end 
    if (jb(numero).y_spine(i,11)~=tail_y(i,1))
        disp('tail_y mismatch');
    end 
end
%% Vectors
Center2Head=[]; Center2Tail=[];
for i=1:length(head_x)
    Center2Head(i,1)=head_x(i,1)-center_x(i,1); % head_x
    Center2Head(i,2)=head_y(i,1)-center_y(i,1); % head_y
    Center2Tail(i,1)=tail_x(i,1)-center_x(i,1); % tail_x
    Center2Tail(i,2)=tail_y(i,1)-center_y(i,1); % tail_y
end
%% TEST
% Center2Head(1,1)=0;Center2Head(1,2)=1;
% Center2Tail(1,1)=0;Center2Tail(1,2)=-1;
% Center2Head(2,1)=1/sqrt(2);Center2Head(2,2)=1/sqrt(2);
% Center2Tail(2,1)=1/sqrt(2);Center2Tail(2,2)=-1/sqrt(2);
%% How to calculate angle?
% If v1 = [x1,y1] and v2 = [x2,y2] are the components of two vectors, then
%    a = atan2d(x1*y2-y1*x2,x1*x2+y1*y2);
% gives the angle in degrees between the vectors as measured in a counterclockwise direction from v1 to v2. If that angle would exceed 180 degrees, then the angle is measured in the clockwise direction but given a negative value. In other words, the output of 'atan2d' always ranges from -180 to +180 degrees.
% One further observation: Besides the greater range of 'atan2d' as compared with 'acosd', the former does not suffer the inaccuracies that occur with 'acosd' for angles near zero and 180 degrees.
%%
Center2Head_D=[]; Center2Tail_D=[];
for i=1:length(head_x)
    if i==1
        Center2Head_D(i,1)=0; 
        Center2Tail_D(i,1)=0;
    else
        % Angle from Center2Head(i-1) to Center2Head(i)
        Center2Head_D(i,1)=atan2d(Center2Head(i-1,1)*Center2Head(i,2)-Center2Head(i-1,2)*Center2Head(i,1),...
            Center2Head(i-1,1)*Center2Head(i,1)+Center2Head(i-1,2)*Center2Head(i,2)); 
        % Angle from Center2Tail(i-1) to Center2Tail(i)
        Center2Tail_D(i,1)=atan2d(Center2Tail(i-1,1)*Center2Tail(i,2)-Center2Tail(i-1,2)*Center2Tail(i,1),...
            Center2Tail(i-1,1)*Center2Tail(i,1)+Center2Tail(i-1,2)*Center2Tail(i,2));
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% bin=0.5sec
time_sec=[ceil(jbt(1)):bin:floor(jbt(end))];
time_frame=[];
for i=1:length(time_sec)
    [value,index]=min(abs(jbt-time_sec(i)));
    time_frame(i)=index;
end
Center2Head_bin=[]; Center2Tail_bin=[];
for i=1:length(time_frame)
    Center2Head_bin(i,1)=head_x(time_frame(i),1)-center_x(time_frame(i),1); % head_x
    Center2Head_bin(i,2)=head_y(time_frame(i),1)-center_y(time_frame(i),1); % head_y
    Center2Tail_bin(i,1)=tail_x(time_frame(i),1)-center_x(time_frame(i),1); % tail_x
    Center2Tail_bin(i,2)=tail_y(time_frame(i),1)-center_y(time_frame(i),1); % tail_y
end
Center2Head_D_bin=[]; Center2Tail_D_bin=[];
for i=1:length(time_frame)
    if i==1
        Center2Head_D_bin(i,1)=0; 
        Center2Tail_D_bin(i,1)=0;
    else
        % Angle from Center2Head(i-1) to Center2Head(i)
        Center2Head_D_bin(i,1)=atan2d(Center2Head_bin(i-1,1)*Center2Head_bin(i,2)-Center2Head_bin(i-1,2)*Center2Head_bin(i,1),...
            Center2Head_bin(i-1,1)*Center2Head_bin(i,1)+Center2Head_bin(i-1,2)*Center2Head_bin(i,2)); 
        % Angle from Center2Tail(i-1) to Center2Tail(i)
        Center2Tail_D_bin(i,1)=atan2d(Center2Tail_bin(i-1,1)*Center2Tail_bin(i,2)-Center2Tail_bin(i-1,2)*Center2Tail_bin(i,1),...
            Center2Tail_bin(i-1,1)*Center2Tail_bin(i,1)+Center2Tail_bin(i-1,2)*Center2Tail_bin(i,2));
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
vectors={Center2Head,Center2Tail,Center2Head_bin,Center2Tail_bin};%,Center_deg,Center_rad,Head_5,Tail_7,NonC_deg,NonC_rad};
time={time_frame,time_sec};
delta_vectors={Center2Head_D,Center2Tail_D,Center2Head_D_bin,Center2Tail_D_bin};
end