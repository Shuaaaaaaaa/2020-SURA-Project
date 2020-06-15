function c_shape=find_diamond_draft
(cast_strong,delta_vectors,time,jbt)
c_shape=int16.empty(1,0);
% [cast_strong_start_frame   cast_strong_end_frame   ith event] 
%% Currently 0.5 bin --> 0,0.5,1,1.5,...
theta_threshold=10;
time_frame_bin=time{1};time_sec_bin=time{2};
Center2Head_D_bin=delta_vectors{3};Center2Tail_D_bin=delta_vectors{4};
%%
for i=1:size(cast_strong,1)
    % Make sure cs_start and cs_end fully covers (never less cover) strong cast
    cs_start=cast_strong(i,1);cs_end=cast_strong(i,2);
    [v,ind]=min(abs(time_frame_bin-cs_start));
    if time_frame_bin(ind)>cs_start && ind~=1
        ind=ind-1;
    end
    cs_start=(ind);
    [v,ind]=min(abs(time_frame_bin-cs_end));
    if time_frame_bin(ind)<cs_end && ind~=length(time_frame_bin)
        ind=ind+1;
    end
    cs_end=(ind);
    %% Check if it is a diamond shape
    head=Center2Head_D_bin(cs_start:cs_end);head=head';
    tail=Center2Tail_D_bin(cs_start:cs_end);tail=tail';
    x_vals=time_frame_bin(cs_start:cs_end); % Here, x_vals: 0.5sec bin
    %% Intersection Points
    L=InterX(vertcat(x_vals,head),vertcat(x_vals,tail));
%         L  = [x11 x12 x13 ... NaN x21 x22 x23 ...;
%               y11 y12 y13 ... NaN y21 y22 y23 ...]
    %% Make Head,Tail more precise (smaller bin=1 frame)
    head_smallbin=[];
    tail_smallbin=[];
    x_vals_smallbin=[];
    for j=1:length(x_vals)-1
        x_temp=[x_vals(j):1:x_vals(j+1)];
        head_temp=[head(j):(head(j+1)-head(j))/(length(x_temp)-1):head(j+1)];
        tail_temp=[tail(j):(tail(j+1)-tail(j))/(length(x_temp)-1):tail(j+1)];
        
        x_vals_smallbin=horzcat(x_vals_smallbin,x_temp);
        head_smallbin=horzcat(head_smallbin,head_temp);
        tail_smallbin=horzcat(tail_smallbin,tail_temp);
        if j~=length(x_vals)-1
            x_vals_smallbin(end)=[];
            head_smallbin(end)=[];
            tail_smallbin(end)=[];
        end
    end
    %% Test PLOT
    % Check whether head=head_smallbin...
    figure;
    line(x_vals,head);
    hold on;
    line(x_vals,tail);
    plot(L(1,:),L(2,:),'r*')
    figure;
    line(x_vals_smallbin,head_smallbin);
    hold on;
    line(x_vals_smallbin,tail_smallbin);
    plot(L(1,:),L(2,:),'r*')
    
    %%
    if size(L,2)==1 % There needs to be at least 2 intersections to examine for diamonds
        % NO C-SHAPE
        %
    else
        for j=1:size(L,2)-1
            interval_start=L(:,j);interval_end=L(:,j+1);
            
            x_vals_extracted_ind=[find(x_vals_smallbin==ceil(interval_start(1))) find(x_vals_smallbin==floor(interval_end(1)))];
            head_extracted=head_smallbin(x_vals_extracted_ind(1):x_vals_extracted_ind(2));
            tail_extracted=tail_smallbin(x_vals_extracted_ind(1):x_vals_extracted_ind(2));         
            
            if check_diamond()
                % [cast_strong_start_frame   cast_strong_end_frame   ith event] 
                c_shape=vertcat(c_shape,[cs_start cs_end i]);
                continue
            end            
        end
        
        
        
        
        
        
        % If there exists #n intersections, #(n-1) intervals exist.
        for j=1:size(L,2)-1
            interval_start=L(:,j);interval_end=L(:,j+1);
            
            [v,ind]=min(abs(x_vals_smallbin-interval_start(1,1)));
            ind_start=ind;
            [v,ind]=min(abs(x_vals_smallbin-interval_end(1,1)));
            ind_end=ind;
            
            interval_x=x_vals_smallbin(ind_start:ind_end);
            interval_head=head_smallbin(ind_start:ind_end);
            interval_tail=tail_smallbin(ind_start:ind_end);
            
            [head_peak_v,head_peak_ind]=max(interval_head);
            [tail_peak_v,tail_peak_ind]=max(interval_tail);
            [~,head_through_ind]=min(interval_head);
            [tail_through_v,tail_through_ind]=min(interval_tail);
            
            interval_head_D=[];
            interval_tail_D=[];
            
            for k=1:length(interval_x)
                if k==1
                    interval_head_D(1,k)=0;
                    interval_tail_D(1,k)=0;
                else
                    interval_head_D(1,k)=interval_head(1,j)-interval_head(1,k-1);
                    interval_tail_D(1,k)=interval_tail(1,j)-interval_tail(1,k-1);
                end
            end
            
            %% CASE 1a
            if all(interval_head_D(2:head_through_ind)<0) && all(interval_tail_D(2:tail_through_ind)<0)...
                && all(interval_head_D(head_through_ind+1:end)>0) && all(interval_tail_D(tail_through_ind+1:end)>0)
                % NOT C-SHAPE
                disp('CASE 1a');
            %% CASE 1b
            elseif all(interval_head_D(2:head_peak_ind)>0) && all(interval_tail_D(2:tail_peak_ind)>0)...
                && all(interval_head_D(head_peak_ind+1:end)<0) && all(interval_tail_D(tail_peak_ind+1:end)<0)
                % NOT C-SHAPE   
                disp('CASE 1b');
            %% CASE 2a    
            elseif all(interval_head_D(2:head_peak_ind)>0) && all(interval_tail_D(2:tail_through_ind)<0)...
                && all(interval_head_D(head_peak_ind+1:end)<0) && all(interval_tail_D(tail_through_ind+1:end)>0)
                % C-SHAPE
                % CONSTRAINT_A: peak, through magnitude should be somewhat similar...
                if abs(head_peak_v) <= 2*abs(tail_through_v) || 2*abs(head_peak_v) >= abs(tail_through_v)
                    % CONSTRAINT_B: theta threshold?
                    c_shape(end,1)=cast_strong(i,1);c_shape(end,2)=cast_strong(i,2);c_shape(end,3)=i;
                    disp('CASE 2a');
                end
            %% CASE 2b
            elseif all(interval_head_D(2:head_through_ind)<0) && all(interval_tail_D(2:tail_peak_ind)>0)...
                && all(interval_head_D(head_through_ind+1:end)>0) && all(interval_tail_D(tail_peak_ind+1:end)<0)
                % C-SHAPE
                % CONSTRAINT: peak, through magnitude should be somewhat similar...
                if abs(head_through_v) <= 2*abs(tail_peak_v) || 2*abs(head_through_v) >= abs(tail_peak_v)
                    c_shape(end,1)=cast_strong(i,1);c_shape(end,2)=cast_strong(i,2);c_shape(end,3)=i;
                    disp('CASE 2b');
                end
            %% CASE 3a
            elseif all(interval_head>=interval_tail)
            
            
            %% CASE 3b
            %crosscorr(head,tail)%,'NumLags',200)%,'NumSTD',2)
            elseif all(interval_head<=interval_tail)
            
            end
        end
    end
end
%% TEST PLOT
plot(time_frame_bin(cs_start:cs_end),head); hold on; plot(time_frame_bin(cs_start:cs_end),tail);
plot(L(1,:),L(2,:),'r*')
end