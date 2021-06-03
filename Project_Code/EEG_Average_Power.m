%% Differences in Average Power for Left and Right Brain Activity over all channels

%Calcuates the average power 
Avg_power_l = (1/length(left_total))*sum(abs(left_total).^2,2);
Avg_power_r = (1/length(right_total))*sum(abs(right_total).^2,2);


names = {'Fz','F2','F1','FC2','FC1','FC4','FC3','FC6','FC5','C2','C1','C6','C5','CPz','CP3','CP4'};

%Plots the average power 
figure
plot(Avg_power_r)
title('Average Power for Right Brain Activity');
xlabel('Channel');
ylabel('Average Power - microvolts^2 seconds^2 / meters^2');
set(gca,'xtick',[1:16],'xticklabel',names)

figure
plot(Avg_power_l)
title('Average Power for Left Brain Activity');
xlabel('Channel');
ylabel('Average Power - microvolts^2 seconds^2 / meters^2');
set(gca,'xtick',[1:16],'xticklabel',names)

%Plots the topoplots 
 figure
 topoplot(Avg_power_r,'CSP.locs')
 title('Topoplot of Right Brain Activity') 
   
 figure
 topoplot(Avg_power_l,'CSP.locs')
 title('Topoplot of Left Brain Activity') 
 
 figure
 topoplot(abs(Avg_power_r-Avg_power_l),'CSP.locs')
 title('Topoplot of the Difference Between Left and Right Brain Activity') 

