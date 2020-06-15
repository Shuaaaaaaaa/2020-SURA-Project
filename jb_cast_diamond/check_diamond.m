function boolean=check_diamond(x_vals,head,tail)

[head_peak_v,head_peak_ind]=max(head);
[tail_peak_v,tail_peak_ind]=max(tail);
[head_through_v,head_through_ind]=min(head);
[tail_through_v,tail_through_ind]=min(tail);

head_D=[];
tail_D=[];

for k=1:length(x_vals)
    if k==1
        head_D(1,k)=0;
        tail_D(1,k)=0;
    else
        head_D(1,k)=head(1,k)-head(1,k-1);
        tail_D(1,k)=tail(1,k)-tail(1,k-1);
    end
end

%% Variables that exist:
% x_vals
% head,tail,head_D,tail_D
% head_peak,head_through,tail_peak,tail_through,...

%% CASE 1a
if (head_peak_ind==1 || head_peak_ind==length(x_vals))&&(tail_peak_ind==1 || tail_peak_ind==length(x_vals))...
        && all(head_D(2:head_through_ind)<0) && all(tail_D(2:tail_through_ind)<0)...
        && all(head_D(head_through_ind+1:end)>0) && all(tail_D(tail_through_ind+1:end)>0)
    % NOT C-SHAPE
    disp('CASE 1a');
    
%% CASE 1b
elseif (head_through_ind==1 || head_through_ind==length(x_vals))&&(tail_through_ind==1 || tail_through_ind==length(x_vals))...
        && all(head_D(2:head_peak_ind)>0) && all(tail_D(2:tail_peak_ind)>0)...
        && all(head_D(head_peak_ind+1:end)<0) && all(tail_D(tail_peak_ind+1:end)<0)
    % NOT C-SHAPE
    disp('CASE 1b');
end

boolean=0;
end