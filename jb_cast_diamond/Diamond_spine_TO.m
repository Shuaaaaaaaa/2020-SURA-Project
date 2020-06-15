function Diamond_spine_TO(genotype,timestamp,larva_ind,view_sec,window,bin)
set(0,'DefaultLegendAutoUpdate','off')
%vectors={Center2Head,Center2Tail,Center2Head_bin,Center2Tail_bin};%,Center_deg,Center_rad,Head_5,Tail_7,NonC_deg,NonC_rad};
%delta_vectors={Center2Head_D,Center2Tail_D,Center2Head_D_bin,Center2Tail_D_bin};
%time={time_frame,time_sec};
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% PLOT_Delta_THETA_bin (bin=0.5)
[jbt,jb_beh,view_frame,vectors,delta_vectors,time]=process_jb_spine_TO(genotype,timestamp,larva_ind,view_sec,bin);
c_shape=find_diamond(jb_beh{1,11},delta_vectors,time,jbt);

%% PLOT
fig2=figure('Renderer', 'painters', 'units','normalized','outerposition',[0 0 1 1]);
%orient(fig,'landscape');
%%
hold on
plot1=plot(time{1},smoothdata(delta_vectors{3}(:,1),'gaussian',window),'Color',[1 0 0],'LineWidth',0.5,'DisplayName','DeltaCenter2Head');
plot2=plot(time{1},smoothdata(delta_vectors{4}(:,1),'gaussian',window),'Color',[0 0 1],'LineWidth',0.5,'DisplayName','DeltaCenter2Tail');
%plot3=plot(1:length(vectors{4}(:,1)),smooth(vectors{4}(:,1)),'Color',[0 0 0],'LineWidth',0.5,'DisplayName','Theta between Center2Head and Center2Tail');
legend;
plot1.Color(4) = 0.8; % Transparency of lines
plot2.Color(4) = 0.8;

xlabel('Frame'),ylabel('Theta (deg)')
xlim([0 (time{1}(end))])
%upperlim=max(vertcat(coordinates(:,1),coordinates(:,2),coordinates(:,3),coordinates(:,4)));
%bottomlim=min(vertcat(coordinates(:,1),coordinates(:,2),coordinates(:,3),coordinates(:,4)));
ylim([-180 180])
title({strcat(strrep(genotype,'_','-'),'@',num2str(larva_ind),'-delta-vectors(smooth(gaussian,',num2str(window),'))','-bin:',num2str(bin),'sec')});%,'jb RUN=light green','jb CAST=light blue','jb ROLL=magenda'})%'JAABA ROLL=blue(upper line)'
for j=1:size(view_sec,1)
    f=fill([view_frame(j,1),view_frame(j,2),view_frame(j,2),view_frame(j,1)],[-180 -180 180 180],'k');
    f.FaceAlpha=0.1;
    f.EdgeColor='none';
end
%% Cast_strong
for j=1:size(jb_beh{1,11},1)
    f=fill([jb_beh{1,11}(j,1),jb_beh{1,11}(j,2),jb_beh{1,11}(j,2),jb_beh{1,11}(j,1)],[-180 -180 180 180],[200/255 149/255 237/255]);
    f.FaceAlpha=0.1;
    f.EdgeColor='none';
end
% RUN=yellow green
plot(jb_beh{1,3}',(jb_beh{1,4}-180)','Color',[154/255 205/255 50/255],'LineWidth',2);
% ROLL=hot pink
plot(jb_beh{1,5}',(jb_beh{1,6}-180)','Color',[1 105/255 180/255],'LineWidth',2);
% CAST=corn flower blue
plot(jb_beh{1,7}',(jb_beh{1,8}-180)','Color',[100/255 149/255 237/255],'LineWidth',2);
% CAST_weak
plot(jb_beh{1,9}',(jb_beh{1,10}-175)','Color',[100/255 200/255 237/255],'LineWidth',2);
% CAST_strong
plot(jb_beh{1,11}',(jb_beh{1,12}-175)','Color',[200/255 149/255 237/255],'LineWidth',2);
hold off
%% PRINT
print(fig2,strcat(genotype,'@',num2str(larva_ind),'_D_vectors(smooth(gaussian,',num2str(window),'))','bin',num2str(bin*10)),'-dpng','-r800');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% PLOT_Delta_THETA
%% PLOT
bin=0.2;
[jbt,jb_beh,view_frame,vectors,delta_vectors,time]=process_jb_spine_TO(genotype,timestamp,larva_ind,view_sec,bin);
fig3=figure('Renderer', 'painters', 'units','normalized','outerposition',[0 0 1 1]);
%orient(fig,'landscape');
%%
hold on
plot1=plot(1:length(delta_vectors{1}(:,1)),smoothdata(delta_vectors{1}(:,1),'gaussian',window),'Color',[1 0 0],'LineWidth',0.5,'DisplayName','DeltaCenter2Head');
plot2=plot(1:length(delta_vectors{2}(:,1)),smoothdata(delta_vectors{2}(:,1),'gaussian',window),'Color',[0 0 1],'LineWidth',0.5,'DisplayName','DeltaCenter2Tail');
%plot3=plot(1:length(vectors{4}(:,1)),smooth(vectors{4}(:,1)),'Color',[0 0 0],'LineWidth',0.5,'DisplayName','Theta between Center2Head and Center2Tail');
legend;
plot1.Color(4) = 0.8; % Transparency of lines
plot2.Color(4) = 0.8;

xlabel('Frame'),ylabel('Theta (deg)')
xlim([0 length(delta_vectors{1})])
%upperlim=max(vertcat(coordinates(:,1),coordinates(:,2),coordinates(:,3),coordinates(:,4)));
%bottomlim=min(vertcat(coordinates(:,1),coordinates(:,2),coordinates(:,3),coordinates(:,4)));
ylim([-180 180])
title({strcat(strrep(genotype,'_','-'),'@',num2str(larva_ind),'-delta-vectors(smooth(gaussian,',num2str(window),'))')});%,'jb RUN=light green','jb CAST=light blue','jb ROLL=magenda'})%'JAABA ROLL=blue(upper line)'
for j=1:size(view_sec,1)
    f=fill([view_frame(j,1),view_frame(j,2),view_frame(j,2),view_frame(j,1)],[-180 -180 180 180],'k');
    f.FaceAlpha=0.1;
    f.EdgeColor='none';
end
%% Cast_strong
for j=1:size(jb_beh{1,11},1)
    f=fill([jb_beh{1,11}(j,1),jb_beh{1,11}(j,2),jb_beh{1,11}(j,2),jb_beh{1,11}(j,1)],[-180 -180 180 180],[200/255 149/255 237/255]);
    f.FaceAlpha=0.1;
    f.EdgeColor='none';
end
% RUN=yellow green
plot(jb_beh{1,3}',(jb_beh{1,4}-180)','Color',[154/255 205/255 50/255],'LineWidth',2);
% ROLL=hot pink
plot(jb_beh{1,5}',(jb_beh{1,6}-180)','Color',[1 105/255 180/255],'LineWidth',2);
% CAST=corn flower blue
plot(jb_beh{1,7}',(jb_beh{1,8}-180)','Color',[100/255 149/255 237/255],'LineWidth',2);
% CAST_weak
plot(jb_beh{1,9}',(jb_beh{1,10}-175)','Color',[100/255 200/255 237/255],'LineWidth',2);
% CAST_strong
plot(jb_beh{1,11}',(jb_beh{1,12}-175)','Color',[200/255 149/255 237/255],'LineWidth',2);
hold off
%% PRINT
print(fig3,strcat(genotype,'@',num2str(larva_ind),'_D_vectors(smooth(gaussian,',num2str(window),'))'),'-dpng','-r800');
close all
end



