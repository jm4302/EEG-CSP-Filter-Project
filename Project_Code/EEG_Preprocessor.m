clear all 
%% John Mavroudes
%% Load run info 
load('classrun1.mat'); load('classrun2.mat');
load('classrun3.mat'); load('classrun4.mat');

%% Load data
run1 = load('run1.mat'); run1 = struct2cell(run1); run1 = cell2mat(run1);
run2 = load('run2.mat'); run2 = struct2cell(run2); run2 = cell2mat(run2);
run3 = load('run3.mat'); run3 = struct2cell(run3); run3 = cell2mat(run3);
run4 = load('run4.mat'); run4 = struct2cell(run4); run4 = cell2mat(run4); 

%% Reshape data 
run1 = squeeze(run1);
run2 = squeeze(run2);
run3 = squeeze(run3);
run4 = squeeze(run4); 

%% Find the indices for all events 
trigger1 = run1(18,:);
trigger2 = run2(18,:);
trigger3 = run3(18,:);
trigger4 = run4(18,:);

index_run1 = find(diff(trigger1)>0);
index_run2 = find(diff(trigger2)>0);
index_run3 = find(diff(trigger3)>0);
index_run4 = find(diff(trigger4)>0);

%% Separate left from right 
%2 left                             %1 right 
left_index_run1 = find(z1(2,:)==1); right_index_run1 = find(z1(1,:)==1);
left_index_run2 = find(z2(2,:)==1); right_index_run2 = find(z2(1,:)==1);
left_index_run3 = find(z3(2,:)==1); right_index_run3 = find(z3(1,:)==1);
left_index_run4 = find(z4(2,:)==1); right_index_run4 = find(z4(1,:)==1);

%% Selection criteria
delay = 2; %sec
t_begin = 4.5-delay; 
t_end = 8-delay;
fs = 256; %sampling frequency 
index_offset = fs*t_begin; %4.5 sec index length
index_duration = fs*(t_end-t_begin); %number of indicies for data acquisition

%% Run1 
%left side 
for i = left_index_run1 
    index_run1_left(i) = index_run1(i);  %left activity trigger indicies 
end

index_run1_left(index_run1_left==0) = [];

run1_range_left = zeros(length(index_run1_left),index_duration); %initalize
%determines the ranges of indicies within the window of time after each trigger
for i = 1:length(index_run1_left)
   output = index_run1_left(:,i)+1+index_offset:index_run1_left(:,i)+1+index_offset+index_duration;  
   for j = 1:index_duration
    run1_range_left(i,j) = output(j); 
   end    
end
run1_range_left = run1_range_left';
run1_range_left = reshape(run1_range_left,1,index_duration*i);

%right side     
for i = right_index_run1 
    index_run1_right(i) = index_run1(i);  %right activiity trigger indicies
end

index_run1_right(index_run1_right==0) = [];

run1_range_right = zeros(length(index_run1_right),index_duration); %initalize
%determines the ranges of indicies within the window of time after each trigger
for i = 1:length(index_run1_right)
   output = index_run1_right(:,i)+1+index_offset:index_run1_right(:,i)+1+index_offset+index_duration;  
   for j = 1:index_duration
    run1_range_right(i,j) = output(j); 
   end    
end
run1_range_right = run1_range_right';
run1_range_right = reshape(run1_range_right,1,index_duration*i);

    run1_channels = run1(2:17,:); %extracts the data for the 16 channels 
    
    run1_left = run1_channels(:,run1_range_left); %extracts left imagined movement data
    run1_right = run1_channels(:,run1_range_right); %extracts the right imagined movement data 

%% Run2 
    %left side 
for i = left_index_run1
    index_run2_left(i) = index_run2(i);
end

index_run2_left(index_run2_left==0) = [];

run2_range_left = zeros(length(index_run2_left),index_duration);
for i = 1:length(index_run2_left)
   output = index_run2_left(:,i)+1+index_offset:index_run2_left(:,i)+1+index_offset+index_duration;  
   for j = 1:index_duration
    run2_range_left(i,j) = output(j); 
   end    
end
run2_range_left = run2_range_left';
run2_range_left = reshape(run2_range_left,1,index_duration*i);

%right side     
for i = right_index_run1
    index_run2_right(i) = index_run2(i);
end

index_run2_right(index_run2_right==0) = [];

run2_range_right = zeros(length(index_run2_right),index_duration);
for i = 1:length(index_run2_right)
   output = index_run2_right(:,i)+1+index_offset:index_run2_right(:,i)+1+index_offset+index_duration;  
   for j = 1:index_duration
    run2_range_right(i,j) = output(j); 
   end    
end
run2_range_right = run2_range_right';
run2_range_right = reshape(run2_range_right,1,index_duration*i);

    run2_channels = run2(2:17,:);
    
    run2_left = run2_channels(:,run2_range_left);  
    run2_right = run2_channels(:,run2_range_right);
    
%% Run3 
%left side 
for i = left_index_run3 
    index_run3_left(i) = index_run3(i);
end

index_run3_left(index_run3_left==0) = [];

run3_range_left = zeros(length(index_run3_left),index_duration);
for i = 1:length(index_run3_left)
   output = index_run3_left(:,i)+1+index_offset:index_run3_left(:,i)+1+index_offset+index_duration;  
   for j = 1:index_duration
    run3_range_left(i,j) = output(j); 
   end    
end
run3_range_left = run3_range_left';
run3_range_left = reshape(run3_range_left,1,index_duration*i);

%right side     
for i = right_index_run3 
    index_run3_right(i) = index_run3(i);
end

index_run3_right(index_run3_right==0) = [];

run3_range_right = zeros(length(index_run3_right),index_duration);
for i = 1:length(index_run3_right)
   output = index_run3_right(:,i)+1+index_offset:index_run3_right(:,i)+1+index_offset+index_duration;  
   for j = 1:index_duration
    run3_range_right(i,j) = output(j); 
   end    
end
run3_range_right = run3_range_right';
run3_range_right = reshape(run3_range_right,1,index_duration*i);

    run3_channels = run3(2:17,:);
    
    run3_left = run3_channels(:,run3_range_left);  
    run3_right = run3_channels(:,run3_range_right);
    
%% Run4 
%left side 
for i = left_index_run4 
    index_run4_left(i) = index_run4(i);
end

index_run4_left(index_run4_left==0) = [];

run4_range_left = zeros(length(index_run4_left),index_duration);
for i = 1:length(index_run4_left)
   output = index_run4_left(:,i)+1+index_offset:index_run4_left(:,i)+1+index_offset+index_duration;  
   for j = 1:index_duration
    run4_range_left(i,j) = output(j); 
   end    
end
run4_range_left = run4_range_left';
run4_range_left = reshape(run4_range_left,1,index_duration*i);

%right side     
for i = right_index_run4 
    index_run4_right(i) = index_run4(i);
end

index_run4_right(index_run4_right==0) = [];

run4_range_right = zeros(length(index_run4_right),index_duration);
for i = 1:length(index_run4_right)
   output = index_run4_right(:,i)+1+index_offset:index_run4_right(:,i)+1+index_offset+index_duration;  
   for j = 1:index_duration
    run4_range_right(i,j) = output(j); 
   end    
end
run4_range_right = run4_range_right';
run4_range_right = reshape(run4_range_right,1,index_duration*i);

    run4_channels = run4(2:17,:);
    
    run4_left = run4_channels(:,run4_range_left);  
    run4_right = run4_channels(:,run4_range_right);
    
 left_total = [run1_left run2_left run3_left run4_left];
 right_total = [run1_right run2_right run3_right run4_right];
   
%Filter data between 8 and 20Hz 
fl = designfilt('lowpassfir','FilterOrder',100,'CutoffFrequency',20,'SampleRate',fs);
for i = 1:16
left_total(i,:) = filter(fl, left_total(i,:));
right_total(i,:) = filter(fl, right_total(i,:));
end

fh = designfilt('highpassfir','FilterOrder',100,'CutoffFrequency',8,'SampleRate',fs);
for i = 1:16
left_total(i,:) = filter(fh, left_total(i,:));
right_total(i,:) = filter(fh, right_total(i,:));
end


