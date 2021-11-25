% clears workspace and closes all the figures
clear all
close all
clc
%% Write here the correct file name
[Full_data, si1] = abfload('180720_020.abf'); % Ctrl mouse


Time = 0:(si1/1000):(length(Full_data)-1)*(si1/1000);
Time = Time';
%% Trace extraction
n=1;


for i = 39:4:50%% Combined 1 stimul
            
            Combined_1st(:, n) = Full_data(:, 1, i);
            n = n + 1;
end   

% Удаление некорректных серий
%Combined_1st(:,1)=[];

n=1;
for j = 40:4:50%% Combined 1-4 stimuls
        Combined_1_4st(:, n) = Full_data(:, 1, j);
        n = n + 1;
        
end

n=1;
for k = 41:4:50 %%Combined 1-5 stimuls
            Combined_1_5st(:, n) = Full_data(:, 1, k);
            n = n + 1;
end
n=1;
for m =42:4:50 %% Combined Resistance 1-5 stimuls
                Current_Resistance_Combined(:, n) = Full_data(:, 1, m);
                n = n + 1;
end   


Combined_all = [];%%pack all traces in one array
n = 1;
for i = 39:1:50
    Combined_all(:, n) = Full_data(:, 1, i);
    n = n + 1;
end
                    figure('Name', 'All traces')
                    subplot(1, 4, 1)
                    plot(Time, Combined_1st);
                    grid on;
                    axis([450, 1000, -250, 50])
                    title('Combined 1 stimul, all traces');
                    ylabel('Current, pA');
                    xlabel('Time, msec');


                    subplot(1, 4, 2)
                    plot(Time, Combined_1_4st);
                    grid on;
                    axis([450, 800, -250, 50])
                    title('Combined 1-4 stimuls, all traces');
                    ylabel('Current, pA');
                    xlabel('Time, msec');


                    subplot(1, 4, 3)
                    plot(Time, Combined_1_5st);
                    grid on;
                    title('Combined 1-5 stimuls, all traces');
                    axis([450, 1000, -250, 50])
                    ylabel('Current, pA');
                    xlabel('Time, msec');

                    subplot(1, 4, 4)
                    plot(Time, Current_Resistance_Combined);
                    grid on;
                    axis([450, 1200, -200, 50])
                    title('Current Resistance Combined, all traces');
                    ylabel('Current Resistance Combined, pA');
                    xlabel('Time, msec');
                    
              
                    
 %% *%% BASELINE*
 
BLstart = 1; %start point
BLend = 2450; %end point

%% BL find and offset combined stimul
for i = 1:size(Combined_1st, 2)%% BL for 1 st
    BLCombined_1st(i) = mean(Combined_1st(BLstart:BLend, i));
    Combined_1st_Offset(:, i) = Combined_1st(:, i) - BLCombined_1st(i);
end

for i = 1:size(Combined_1_4st, 2)%% BL for 4 st
    BLCombined_1_4st(i) = mean(Combined_1_4st(BLstart:BLend, i));
    Combined_1_4st_Offset(:, i) = Combined_1_4st(:, i) - BLCombined_1_4st(i);
end
for i = 1:size(Combined_1_5st, 2)%% BL for 5 st
    BLCombined_1_5st(i) = mean(Combined_1_5st(BLstart:BLend, i));
    Combined_1_5st_Offset(:, i) = Combined_1_5st(:, i) - BLCombined_1_5st(i);
end

for i = 1:size(Combined_all, 2) %% BL check for all traces
    BLCombined_all(i) = mean(Combined_all(BLstart:BLend, i));
    Combined_all_Offset(:, i) = Combined_all(:, i) - BLCombined_all(i);
end


                    figure('Name', 'Baseline offset');
                    subplot(3, 4,1)
                    plot(Time, Combined_1st_Offset);
                    grid on;
                    axis([450, 800, -250, 50])
                    title('Combined 1 stimul, BL offset traces');
                    ylabel('Current, pA');
                    xlabel('Time, msec');
                 
                    subplot(3, 4, 2)
                    plot(Time, Combined_1_4st_Offset);
                    axis([450, 800, -250, 50])
                    grid on;
                    title('Combined 1-4 stimul,BL offset traces');
                    ylabel('Current, pA');
                    xlabel('Time, msec');
                    
                    subplot(3, 4, 3)
                    plot(Time, Combined_1_5st_Offset);
                    axis([450, 1000, -500, 200])
                    grid on;
                    title('Combined 1-5 stimuls holding current timecourse');
                    ylabel('Current, pA');
                    xlabel('Time, msec');
                    
                    subplot(3, 4, 4)
                    plot([BLCombined_all], ':r*')
                    grid on;
                    hold on
                    title('Timecourse for whole record');
                    ylabel('Current, pA');
                    xlabel('rec number');
                    
                    subplot(3, 4, 5)
                    plot([BLCombined_1st], ':r*')
                    hold on
                    grid on
                    title('Combined 1 stimul holding current timecourse');
                    ylabel('Current, pA');
                    xlabel('Number of trace');

                    
                    subplot(3, 4, 6)
                    plot ([BLCombined_1_4st], ':r*')
                    hold on
                    grid on
                    title('Combined 4 stimul holding current timecourse');
                    ylabel('Current, pA');
                    xlabel('Number of trace');
                    
                    subplot(3, 4, 7)
                    plot([BLCombined_1_5st], ':r*')
                    hold on
                    bar([zeros(size(BLCombined_1_5st, 2),1)'], 'm')
                    grid on
                    title('Combined 1-5 stimuls holding current timecourse');
                    ylabel('Current, pA');
                    xlabel('Number of trace');
                    legend('Combined 1-5 stimuls holding current timecourse')
                    

 %% *RESISTANCE*
%%ADD!!!!!!!!!!!!




 %% *TRANSPORTERS SUBSTRACTION*
%The current in response to the fifth(1-5) stimulus was obtained 
%by subtracting the response to 4 stimuli from the current evoked by 5 stimuli.
%IGluT was recorded in the presence of 25 ?M NBQX, 50 ?M D-AP5, and 100 ?M picrotoxin,
% which blocked AMPA, NMDA, and GABAA receptors, respectively.
%

Combined_1st_Offset_Average=mean(Combined_1st_Offset, 2);
Combined_1_4st_Offset_Average=mean(Combined_1_4st_Offset, 2);
Combined_1_5st_Offset_Average=mean(Combined_1_5st_Offset, 2);
Transporter_1 = Combined_1st_Offset_Average;
Transporter_5 = Combined_1_5st_Offset_Average - Combined_1_4st_Offset_Average;                    
                    
                    figure('Name', 'Transporters');
                    
                    subplot(3, 4,1)
                    plot(Time, Transporter_1 );
                    grid on;
                    axis([450, 800, -100, 50])
                    title('Transporter 1');
                    ylabel('Current, pA');
                    xlabel('Time, msec');
                    
                    subplot(3, 4,2)
                    plot(Time, Transporter_5);
                    grid on;
                    axis([450, 800, -100, 50])
                    title('Transporter 5');
                    ylabel('Current, pA');
                    xlabel('Time, msec');
                    
                    Transporter_5_ampl = Transporter_5(400:19999);
                    Transporter_1_ampl = Transporter_1(1:19600);
                    Time_transporter = Time(1:19600);
                    
                    subplot(3, 4,5)
                    plot(Time_transporter, Transporter_1_ampl, Time_transporter,Transporter_5_ampl);
                    grid on;
                    axis([450, 800, -100, 50])
                    title('Transporter 5');
                    ylabel('Current, pA');
                    xlabel('Time, msec');
                    
 
           
  %% *1 TRANSPORTER DECAY TIME AND AMPLITUDE MEASURE*                   

t_start = 2525; 
t_end   = 2590;

[minTransporter_1_amplitude,NminTransporter_1] = min(Transporter_1(t_start:t_end ));% find the amplitude

t_start = 2535; 
t_end   = 2595;

%Transporter_5_sgfilt =  sgolayfilt(Transporter_5_buttLoop,3,11);
Transporter_1_sgfilt =  sgolayfilt(Transporter_1,3, 11);

s_T1 = size(Transporter_1(t_start:t_end), 1);
TimeDecayTransporter_1_NORM = 0:(si1/1000):(s_T1-1)*(si1/1000);
TimeDecayTransporter_1 = TimeDecayTransporter_1_NORM';
Transporter_1_Fit = Transporter_1(t_start:t_end);
Transporter_1_Fit_filt = Transporter_1_sgfilt(t_start:t_end);
                    figure('Name', 'Transporter fiting')                     
                    subplot(2, 2,1)
                    plot(TimeDecayTransporter_1, Transporter_1_Fit,TimeDecayTransporter_1,Transporter_1_Fit_filt);
                    grid on;
                    %axis([450, 800, -100, 50])
                    title('Transporter 1');
                    ylabel('Current, pA');
                    xlabel('Time, msec');
                   
%% *5 TRANSPORTER AMPLITUDE MEASURE*  

t_start = 2910; 
t_end   = 3200;

[minTransporter_5_amplitude,NminTransporter_5] = min(Transporter_5(t_start:t_end ));% find the amplitude

t_start = 2935; 
t_end   = 2999;
s_T1 = size(Transporter_5(t_start:t_end), 1);
TimeDecayTransporter_5_NORM = 0:(si1/1000):(s_T1-1)*(si1/1000);
TimeDecayTransporter_5 = TimeDecayTransporter_5_NORM';
Transporter_5_Fit = Transporter_5(t_start:t_end);
Transporter_5_Fit_Filt =  sgolayfilt(Transporter_5_Fit,3,41);
                    subplot(2, 2,2)
                    plot(TimeDecayTransporter_5, Transporter_5_Fit_Filt, TimeDecayTransporter_5, Transporter_5_Fit,'r') ;
                    grid on;
                    %axis([450, 800, -100, 50])
                    title('Transporter 5');
                    ylabel('Current, pA');
                    xlabel('Time, msec');                
           
%% *1 TRANSPORTER DECAY TIME AND AMPLITUDE MEASURE*
% Fit: 'untitled fit 1'.
[xData, yData] = prepareCurveData( TimeDecayTransporter_1, Transporter_1_Fit_filt );

% Set up fittype and options.
ft = fittype( 'a*exp(-b*x)+c', 'independent', 'x', 'dependent', 'y' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.StartPoint = [0.0838213779969326 0.228976968716819 0.91333736150167];

% Fit model to data.
[fitresult, gof] = fit( xData, yData, ft, opts );
TRANSPORTER_Tay_decay_1st=1/fitresult.b;
            % Plot fit with data.
                    subplot(2, 2,3)
                    h = plot( fitresult, xData, yData);
                    hold on
                    plot(1/fitresult.b, fitresult.a*exp(-1), 'ro')
                    legend( h, 'Transporter_1_Fit vs. TimeDecayTransporter_1', 'untitled fit 1', 'Location', 'NorthEast' );
                    xlabel ('TimeDecayTransporter_1')
                    ylabel ('Transporter_1_Fit')
                    grid on

%% *5 TRANSPORTER DECAY TIME MEASURE* 

% Fit: 'untitled fit 1'.
[xData, yData] = prepareCurveData( TimeDecayTransporter_5, Transporter_5_Fit );

% Set up fittype and options.
ft = fittype( 'a*exp(-b*x)+c', 'independent', 'x', 'dependent', 'y' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.Lower = [-25 -Inf -Inf];
opts.StartPoint = [0.111202755293787 0.780252068321138 0.389738836961253];

% Fit model to data.
[fitresult, gof] = fit( xData, yData, ft, opts );
TRANSPORTER_Tay_decay_5st=1/fitresult.b;
% Plot fit with data.
                subplot(2, 2,4);
                h = plot( fitresult, xData, yData );
                hold on
                plot(1/fitresult.b, fitresult.a*exp(-1), 'ro')
                legend( h, 'Transporter_5_Fit_Filt vs. TimeDecayTransporter_5', 'untitled fit 1', 'Location', 'NorthEast' );
                % Label axes
                xlabel TimeDecayTransporter_5
                ylabel Transporter_5_Fit_Filt
                grid on

%% *POTASSIUM AMPLITUDE MEASURE* 

%Calculate amplitudes of Potassium in Combined Currents(not on peak)
IK1=mean(Combined_1st_Offset_Average(3500:3705));
potassium_1st = Combined_1st_Offset_Average;
IK5_pre = Combined_1_5st_Offset_Average - Combined_1_4st_Offset_Average;
potassium_5st = IK5_pre;
IK5=mean(IK5_pre(3500:3705));
                    potassium_1st_cut = Combined_1st_Offset_Average(1:19600);
                    potassium_5st_cut = IK5_pre(400:19999);
                    figure( 'Name', 'Amplitude potassium 1 and 5 200 ms after st' );
                    subplot(2, 3,1)
                    plot(Time_transporter, potassium_1st_cut,Time_transporter,  potassium_5st_cut,'r');
                    hold on
                    plot(Time(3500),IK5, 'bo')
                    grid on;
                    axis([450, 900, -100, 50])
                    title('POTASSIUM 1 AND 5');
                    ylabel('Current, pA');
                    xlabel('Time, msec');
                    
               
               
%% *1ST POTASSIUM DECAY TIME MEASURE*                     
t_start = 3500; 
t_end   = 30000;

s_T1 = size(potassium_1st(t_start:t_end), 1);
TimeDecaypotassium_1st = 0:(si1/1000):(s_T1-1)*(si1/1000);
TimeDecaypotassium_1st = TimeDecaypotassium_1st';
potassium_1st_Fit = potassium_1st(t_start:t_end);
potassium_1st_Fit_Filt =  sgolayfilt(potassium_1st_Fit,3,41);
                    subplot(2, 3,2)
                    plot(TimeDecaypotassium_1st, potassium_1st_Fit_Filt, TimeDecaypotassium_1st, potassium_1st_Fit,'r') ;
                    grid on;
                    axis([200, 10000, -100, 50])
                    title('Potassium_1st');
                    ylabel('Current, pA');
                    xlabel('Time, msec'); 
                    
[xData, yData] = prepareCurveData( TimeDecaypotassium_1st, potassium_1st_Fit );


% Set up fittype and options.
ft = fittype( 'exp1' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.StartPoint = [-26.0087190355539 -0.000422746944146957];

% Fit model to data.
[fitresult, gof] = fit( xData, yData, ft, opts );
POTASSUIM_Tay_decay_1st=-1/fitresult.b;

                        % Plot fit with data.
                        subplot(2, 3,3)
                        h = plot( fitresult, xData, yData );
                        hold on;
                        plot(-1/fitresult.b, fitresult.a*exp(-1), 'ro');
                        legend( h, 'potassium_1st_Fit_Filt vs. TimeDecaypotassium_1st', 'untitled fit 1', 'Location', 'NorthEast' );
                        title('Potassium_1st fit');
                        xlabel TimeDecaypotassium_1st
                        ylabel potassium_1st_Fit_Filt
                        grid on
                       
 %% *5ST POTASSIUM DECAY TIME MEASURE*  
t_start = 3500; 
t_end   = 30000;

s_T1 = size(potassium_5st(t_start:t_end), 1);
TimeDecaypotassium_5st = 0:(si1/1000):(s_T1-1)*(si1/1000);
TimeDecaypotassium_5st = TimeDecaypotassium_5st';
potassium_5st_Fit = potassium_5st(t_start:t_end);
potassium_5st_Fit_Filt =  sgolayfilt(potassium_5st_Fit,3,41);
                    subplot(2, 3,5)
                    plot(TimeDecaypotassium_5st, potassium_5st_Fit_Filt, TimeDecaypotassium_5st, potassium_5st_Fit,'r') ;
                    grid on;
                    %axis([200, 10000, -100, 50])
                    title('Potassium_1st');
                    ylabel('Current, pA');
                    xlabel('Time, msec');   
                    
[xData, yData] = prepareCurveData( TimeDecaypotassium_5st, potassium_5st_Fit_Filt );

% Set up fittype and options.
ft = fittype( 'exp1' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.StartPoint = [-33.08482449033 -0.000927678714154588];


% Fit model to data.
[fitresult, gof] = fit( xData, yData, ft, opts );
POTASSUIM_Tay_decay_5st=-1/fitresult.b;
                % Plot fit with data.
                subplot(2, 3,6);
                h = plot( fitresult, xData, yData );
                hold on;
                plot(-1/fitresult.b, fitresult.a*exp(-1), 'ro');
                legend( h, 'potassium_5st_Fit_Filt vs. TimeDecaypotassium_5st', 'untitled fit 1', 'Location', 'NorthEast' );
                % Label axes
                xlabel TimeDecaypotassium_5st
                ylabel potassium_5st_Fit_Filt
                grid on         


%return
%save('traces_glut.mat','Transporter_1_sgfilt','Transporter_5_sgfilt' ...
 %'Combined_1_4st_sgfilt', 'Combined_1_5st_sgfilt', 'Time')
