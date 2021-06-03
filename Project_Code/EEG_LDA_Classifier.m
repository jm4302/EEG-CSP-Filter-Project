%% Find the CSP filtered data 
%Data set for the left and right imagined movements 
 left_total = [run1_left run2_left run3_left run4_left];
 right_total = [run1_right run2_right run3_right run4_right];

%Covariance matrices 
C_plus = cov(left_total');
C_neg = cov(right_total');

%Find the eigen vectors and eigen values 
[U,Lambda] = eig(C_plus,C_plus+C_neg);

%Extract the top six eigen vectors 
W = U(:,11:16);

%Plot the scalp plot of the CSP filters  
 for i = 1:6
 figure(1)
 subplot(2,3,i)
 topoplot(W(:,i),'CSP.locs')
 title(['CSP Filter ',num2str(i)]) 
 end

%Calculate the CSP filtered data 
Left_proj = W'*left_total;
Right_proj = W'*right_total;

%% Calculate the standard deviation of the data before and after filtering 
%before 
for i = 1:80
    for j = 1:16
      std_left_before(j,i) = std(left_total(j,(i-1)*896+1:i*896));
      std_right_before(j,i) = std(right_total(j,(i-1)*896+1:i*896));
    end
end

%after
for i = 1:80
    for j = 1:6
      std_left(j,i) = std(Left_proj(j,(i-1)*896+1:i*896));
      std_right(j,i) = std(Right_proj(j,(i-1)*896+1:i*896));
    end
end

%% Shows the separation before and after
figure
subplot(1,2,1)
scatter(std_left_before(6,:),std_left_before(7,:),'x')
hold on 
scatter(std_right_before(6,:),std_right_before(7,:),'x')
title('Separation before CSP filtering')
xlabel('Channel 6 (FC4)')
ylabel('Channel 7 (FC3)')
legend('Left','Right','location','southeast')

subplot(1,2,2)
scatter(std_left(5,:),std_left(6,:),'x')
hold on 
scatter(std_right(5,:),std_right(6,:),'x')
title('Separation after CSP filtering')
xlabel('CSP Filter 6 (Strongest)')
ylabel('CSP Filter 5 (Second Strongest)')
legend('Left','Right','location','southeast')

%% LDA Analysis

floor = 2;
cieling = 72;

for i = 1:10
    %Get Random Position
    Rand = round((cieling-floor).*rand(1,1) + floor);

    %%Training data
    left_train = std_left(:,Rand:Rand+7);
    right_train = std_right(:,Rand:Rand+7);
    training = [left_train right_train];
    
    %Sample data 
    left_sample = horzcat(std_left(:,1:Rand-1),std_left(:,Rand+8:end));
    right_sample = horzcat(std_right(:,1:Rand-1),std_right(:,Rand+8:end));
    sample = [left_sample right_sample];
 
    %Training group Classification
    class1_training = ones(1,length(left_train));     %ones denote left 
    class2_training = zeros(1,length(right_train));   %zeros denote right
    group = [class1_training class2_training];

    %Sample group Classification
    class1_sample = -1*ones(1,length(left_sample));  %ones denote left
    class2_sample = zeros(1,length(right_sample));   %zeros denote right
    sample_ID = [class1_sample class2_sample];
    sample_ID = sample_ID';
 
    %Apply LDA Classifier 
    class = classify(sample',training',group','Linear');
     
    Score_Array = abs(class + sample_ID);
    Len = length(Score_Array);
    Percentage(i) = 100*(Len-sum(Score_Array))/Len;
end

%Plots the percent accuracy of the LDA classifier per trial 
figure
plot(1:10,Percentage,'-*')
title('Percent accuracy of LDA classifier per trial') 
xlabel('Trial Number')
ylabel('Accuracy (%)')

%Standard error 
STD_Err = std(Percentage)/sqrt(10);


