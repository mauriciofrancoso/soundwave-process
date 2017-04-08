function [] = processSound(verbose)
% processSound  
% This function will do all the job to get coefficient from sound. If
% verbose true it will plot the graphics

% Mauricio Avanzi Françoso
% Federal University of ABC Undergrad Student
% 2017


%% borracha process

% create a object to store all information regarding borracha

borracha=cell(2,4); %

for i=1:4
    if i==1 || i==4
        fileName = [sprintf('borracha %0.0d',i) '.mp3']; % as I had to split 
        %                                                one of my files and save as two
        %                                                mp3 files, I
        %                                                had to do this
        %                                                little trick to
        %                                                process
    else
        fileName = [sprintf('borracha %0.0d',i) '.m4a'];
    end
    fullFile=fullfile('sound',fileName);
    [Y,FS]=audioread(fullFile); %read the audio file
    [ frequency,time ] = getNMaxValues( Y,5,FS );
    
    borracha{1,i}=Y; %store at the object I create
    borracha{2,i}=FS;
    borracha{3,i}=frequency;
    borracha{4,i}=time;
end
%% pebolim process

% do the same processing for pebolim


pebolim=cell(2,4);

for i=1:4
    
    fileName = [sprintf('pebolim %0.0d',i) '.m4a'];
    fullFile=fullfile('sound',fileName);
    [Y,FS]=audioread(fullFile);
    [ frequency,time ] = getNMaxValues( Y,5,FS );
    
    pebolim{1,i}=Y;
    pebolim{2,i}=FS;
    pebolim{3,i}=frequency;
    pebolim{4,i}=time;
    
end

%% plot
% if verbose, it will plot the graphics

if verbose
    close all
    for i=1:4
        figure
        hold on
        plot(borracha{1,i}(:,1));
        plot(borracha{3,i},0.5*ones(4,1),'o');
        legend('signal','peaks');
        xlabel('Time');
        ylabel('Intensity');
        title(sprintf('Borracha %0.0f',i));
        
        figure
        hold on
        plot(pebolim{3,i},0.5*ones(4,1),'o');
        plot(pebolim{1,i}(:,1));
        legend('peaks','signal');
        xlabel('Time');
        ylabel('Intensity');
        title(sprintf('Pebolim %0.0f',i));
    end
    
    
end

%% get the elastic coefficient

eBorracha=NaN(4,1);
ePebolim=NaN(4,1);


for i=1:4
    eBorracha(i,1) = (borracha{4,i}(2,1)-borracha{4,i}(1,1))/(borracha{4,1}(3,1)-borracha{4,i}(2,1));
    ePebolim(i,1) = (pebolim{4,i}(2,1)-pebolim{4,i}(1,1))/(pebolim{4,1}(3,1)-pebolim{4,i}(2,1));
end

if verbose
   EBorracha=NaN(2,1);
   EBorracha(1,1)=eBorracha(2,1);
   EBorracha(2,1)=eBorracha(4,1);
   eBorracha=EBorracha;
   
   EPebolim=NaN(2,1);
   EPebolim(1,1)=ePebolim(3,1);
   EPebolim(2,1)=ePebolim(4,1);
   ePebolim=EPebolim;
end


%% data process
% process the data regarding the coefficient

meanBorracha=mean(eBorracha);
meanPebolim=mean(ePebolim);

varBorracha=var(eBorracha);
varPebolim=var(ePebolim);

stdBorracha=std(eBorracha);
stdPebolim=std(ePebolim);


if verbose
    stdMeanBorracha=stdBorracha/2;
    stdMeanPebolim=stdPebolim/2;
else
    stdMeanBorracha=stdBorracha/4;
    stdMeanPebolim=stdPebolim/4;
end


borrachaInfo=cat(1,meanBorracha,varBorracha,stdBorracha,stdMeanBorracha);
pebolimInfo=cat(1,meanPebolim,varPebolim,stdPebolim,stdMeanPebolim);
    
if verbose
    display(borrachaInfo);
    display(pebolimInfo);
end

%% ping pong coefficient

deltaT=([0.46,0.42,0.36,0.32,0.3,0.28,0.24,0.22,0.22,0.18])';

[row,~]=size(deltaT);

N=(1:row)';

plot(N,deltaT);
f = fit(N,deltaT,'exp1');


if verbose
    display(f);
    figure
    plot(f,N,deltaT);
    %txt1 = 'f(t)=0.5*exp(-0.1*t)';
    %text(4.57,0.35,txt1, 'FontSize', 20,'Interpreter', 'none')
    xlabel('N');
    ylabel('Time (s)');
    title('Ping pong Regression');
end





B=NaN(1,5);
for i=1:5
    B(1,i)=A(2,i)/A(1,i);
end
end
