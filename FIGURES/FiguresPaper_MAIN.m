% ====================================================================== %
%        Estimates of basal and englacial thermal conditions             %
%                    of the Antarctic ice sheet                          %
%                                                                        %
%                         Olivia RASPOET                                 %
%                          Frank PATTYN                                  %
%                                                                        %
%                   Laboratoire de Glaciologie                           %
%                 Université Libre de Bruxelles                          %
%                                                                        %
%                              2025                                      %
%                                                                        %
%                    Figures for the main paper                          %
%                                                                        %
% ====================================================================== %

% close all
% clearvars 
% clc

Figure1=0;  % Figure 1: Ensemble mean basal thermal state / basal temperatures
Figure2=0;  % Figure 2: Ensemble mean subglacial meltwater production
Figure3=0;  % Figure 3: Subglacial and englacial meltwater production for enthalpy 
Figure4=0;  % Figure 4: Sensitivity analysis
Figure5=0;  % Figure 5: Temperature profiles
Figure6=1;  % Figure 6: RMSE of the ensemble
Basins=2;   % Delineation of subglacial basins for Figures 1, 2, and 3
Load=1;     % Load results for Figures 4 and 5 

ProfilsT_exist=0; % (1) Temperature profiles from borehole measurements in Figure 5
                  % (0) No temperature profiles from borehole measurements in Figure 5
                  % Note: borehole measurements are not included in this repository

% -------------------------- Colors for plots --------------------------- %
scrsz = get(groot,'ScreenSize');
Couleurs1=brewermap(10-2,'*RdYlBu');
Couleurs=[0 0 0.5; Couleurs1(1:3,:); Couleurs1(5:8,:); 0.5 0 0];

pieTbcColors=[0.92,0.27,0.27;0.51,0.81,0.99];
pieBmeltColors=[0.38,0.50,0.96;0.66,0.76,1.00];

% ---------------------------- Legend name ------------------------------ %

ModelOrder={'Kori-ULB Enth','Kori-ULB Opt.','Kori-ULB Obs.', ...
     'Uncalibrated Model (Pattyn,2010) ','Calibrated Model (Pattyn,2010)'};

GHFOrder={'Purucker (2013)','An et al. (2015)','Shen et al. (2020)','Shapiro & Ritzwoller (2004)',...
    'Stal et al. (2021)','Lösing & Ebbing (2021)','Haeger et al. (2022)','Fox-Maule et al. (2005)','Martos et al. (2017)'};

SMBOrder={'MAR','RACMO'};

% ------------------------------ Load MASK ------------------------------ %

load MASKZB8km.mat
% MASK(MASK~=0)=1;
ctr.imax=701; ctr.jmax=701; ctr.delta=8e3;
Li=(ctr.imax-1)*ctr.delta/1e3; % length of domain in y
Lj=(ctr.jmax-1)*ctr.delta/1e3; % length of domain in x
x=0:ctr.delta/1e3:Lj;
y=0:ctr.delta/1e3:Li;

% ---------------------------- MEAN RESULTS ----------------------------- %

if Figure1==1 || Figure2==1 || Figure3==1 || Figure4==1
% Generated with ScriptMeanResults.m
load ResultsAntarctica8km_Mean.mat

BV_Mean_all=BVG_Mean_all+BVF_Mean_all;
BV_EAIS_Mean=BVG_EAIS_Mean_all+BVF_EAIS_Mean_all;
BV_WAIS_Mean=BVG_WAIS_Mean_all+BVF_WAIS_Mean_all;
BV_AP_Mean=BVG_AP_Mean_all+BVF_AP_Mean_all;
BV_Basins_Mean=BVG_Basins_Mean_all+BVF_Basins_Mean_all;
end

% ------------------------------ FIGURES -------------------------------- %

if Figure1==1

    f1=figure;
    set(f1,'color','white','Position',[0.0100    0.0338    1.0830    0.8520].*1000);

    t1=tiledlayout(2,2);
    t1.TileSpacing='Tight';

    % Ensemble mean basal temperatures
    s1=nexttile(1,[1 1]);

    Tbc_Mean_all(MASK~=1)=NaN;
    myfig4(Tbc_Mean_all,-30,0); axis('off'); cb=colorbar; 
    cb.Label.String='Ensemble mean basal temperature (°C)';
    cb.Label.FontSize = 12;
    
    if Basins>=1
        hold on; contour(x,y,MASKZB,'k');
    end
    
    text(0,5600,'a','FontSize',15)

    % Standard deviation of basal temperatures
    s1b=nexttile(2,[1 1]);

    Tbc_Std_all(MASK~=1)=NaN;
    myfig4(Tbc_Std_all,0,10); axis('off'); cb=colorbar; 
    cb.Label.String='Standard deviation (°C)'; 
    cb.Label.FontSize = 12;
    s1b.Colormap=brewermap([],'Reds');
    
    if Basins>=1
        hold on
        contour(x,y,MASKZB,'k');
        text(2410,1080,'EAIS');
        text(450,2065,'WAIS');
        text(700,4160,'AP')
    else
        hold on
        contour(x,y,MASK==1,'k');
    end
    
    text(0,5600,'b','FontSize',15)

    if Basins>=1
    % Basins
    s1c=nexttile(3,[1 1]);

    Prop_Map_Basins=NaN(size(ZB));
    for i=1:27
        Prop_Map_Basins(ZB==i)=Prop_Basins_Mean_all(i);
    end
    myfig4(Prop_Map_Basins); axis('off'); clim([0 100]);
    hold on; contour(x,y,MASKZB,'k');
    hold on; contour(x,y,MASK==1,'k');
    for i=1:27
    contour(x,y,ZB==i,1,'k','LineWidth',0.1);
    end
    
    % EAIS
    text(2568,2997,'2');
    text(2872,3779,'3');
    text(2378,4340,'4');
    text(2780,4636,'5');
    text(3513,4480,'6');
    text(4258,4246,'7');
    text(4726,4028,'8');
    text(4596,3753,'9');
    text(4049,3443,'10');
    text(4452,3150,'11');
    text(4925,2758,'12');
    text(4556,1929,'13');
    text(3991,1153,'14');
    text(3240,936,'15');
    text(3381,1344,'16');
    text(3405,2290,'17');
    
    % WAIS
    text(1869,2862,'1');
    text(1943,2389,'18');
    text(1846,2040,'19');
    text(1470,1788,'20');
    text(1372,2304,'21');
    text(1110,2678,'22');
    text(523,2781,'23');
    
    % AP
    text(304,3381,'24');
    text(43,3893,'25');
    text(512,4223,'26');
    text(1083,3970,'27');
    
    text(0,5600,'c','FontSize',15);
    cb=colorbar; 
    cb.Label.String='Fraction of temperate basal conditions (%)'; 
    cb.Label.FontSize = 12;
    end

    % Likely basal thermal state
    s1d=nexttile(4,[1 1]);

    % Define ticks values
    tick_values = linspace(0, 1, 11);
    tick_positions = linspace(0, 1, 11);
    
    % Define names of ticks
    labels = cell(size(tick_positions));
    labels{1} = '100%'; % cold
    labels{2} = '90%';
    labels{3} = '80%';
    labels{4} = '70%';
    labels{5} = '60%';
    labels{6} = '50% ';
    labels{7} = '60%';
    labels{8} = '70%';
    labels{9} = '80%';
    labels{10} = '90%';
    labels{11} = '100%'; % temperate

    % Likely basal thermal state
    myfig4(LBTS_all.*100,0,100);  
    text(0,5600,'d','FontSize',15); axis('off');

    hCB=colorbar; %('Position',[0.9198,0.11,0.01512,0.815]);% add colorbar, save its handle
    hNuCBAx=axes('Position',hCB.Position,'color','none');   % add mew axes at same position
    hNuCBAx.XAxis.Visible='off';    % hide the x axis of new
    hCB.Position=hNuCBAx.Position;  % put the colorbar back to overlay second axeix
    hNuCBAx.YLim=[0 100];           % alternate scale limits new axis
    hNuCBAx.YDir='reverse';
    ylabel(hCB,'Likely temperate (%)','FontSize',11,'Rotation',90, ...
        'VerticalAlignment','middle','HorizontalAlignment','left','Color',Couleurs(end-1,:),'Position',[2.7696,68.1382,0])
    ylabel(hNuCBAx,'Likely cold (%)','FontSize',11,'Rotation',90, ...
        'VerticalAlignment','baseline','HorizontalAlignment','right','Color',Couleurs(1,:),'Position',[-1.288,73.320,0])
    hCB.Position=hNuCBAx.Position;  % put the colorbar back to overlay the second axe

% Add pie plots
figure(f1)

n=2; n2=2;
subplot_ax = s1;
pie_ax = axes('Position',[subplot_ax.Position(1)-0.26/n,subplot_ax.Position(2),subplot_ax.Position(3),0.08/n2]);
pie_data = [Prop_Mean_all 100-Prop_Mean_all];
pie(pie_ax,pie_data);
pie_ax.Colormap = pieTbcColors; 

l=legend('Temperate/Thawed','Cold/Frozen');
l.Location='east';
legend('boxoff')

if Basins>=1 
    pie_ax1 = axes('Position',[subplot_ax.Position(1)+0.02/n,subplot_ax.Position(2)+0.15/n2,subplot_ax.Position(3),0.04/n2]);
    pie_ax2 = axes('Position',[subplot_ax.Position(1)-0.2/n,subplot_ax.Position(2)+0.25/n2,subplot_ax.Position(3),0.04/n2]);
    pie_ax3 = axes('Position',[subplot_ax.Position(1)-0.17/n,subplot_ax.Position(2)+0.55/n2,subplot_ax.Position(3),0.04/n2]);

    pie_data1 = [Prop_EAIS_Mean_all 100-Prop_EAIS_Mean_all];
    pie_data2 = [Prop_WAIS_Mean_all 100-Prop_WAIS_Mean_all];
    pie_data3 = [Prop_AP_Mean_all   100-Prop_AP_Mean_all];

    labels1 = {[num2str(round(Prop_EAIS_Mean_all)),' %'],' '};
    labels2 = {[num2str(round(Prop_WAIS_Mean_all)),' %'],' '};
    labels3 = {[num2str(round(Prop_AP_Mean_all)),' %'],' '};

    pie(pie_ax1,pie_data1,labels1);
    pie(pie_ax2,pie_data2,labels2);
    pie(pie_ax3,pie_data3,labels3);

    pie_ax1.Colormap = pieTbcColors; 
    pie_ax2.Colormap = pieTbcColors; 
    pie_ax3.Colormap = pieTbcColors; 
end

% Define colormap
s1.Colormap=brewermap([],'Reds'); s1.CLim=[-20 0]; 
s1b.Colormap=brewermap([],'Reds');
s1c.Colormap=brewermap(100,'*RdBu');
s1d.Colormap=brewermap(20,'*RdBu');
end

if Figure2==1
    f2=figure;
    set(f2,'color','white','Position',[0.0100    0.0338    1.0830    0.8520].*1000);

    t2=tiledlayout(2,2);
    t2.TileSpacing='Tight';

    % Ensemble mean basal melt rates
    s2=nexttile(1,[1 1]);

    Bmelt_Mean_all(MASK~=1)=NaN;
    Bmelt_Mean_all(round(MASKTBC_Mean_all)<2)=0; % no basal melting where the bed is cold
    myfig4(Bmelt_Mean_all.*1000,0,20); axis('off'); cb=colorbar; 
    cb.Label.String='Ensemble mean basal melt rate (mm a^{-1})'; 
    cb.Label.FontSize = 12;

    if Basins>=1
        hold on; 
        contour(x,y,MASKZB,'k');
    end

    text(0,5600,'a','FontSize',15);

    % Standard deviation of basal melt rates
    s2b=nexttile(2,[1 1]);

    Bmelt_Std_all(MASK~=1)=NaN;
    myfig4(Bmelt_Std_all.*1000,0,10); axis('off'); cb=colorbar; 
    cb.Label.String='Standard deviation (mm a^{-1})'; 
    cb.Label.FontSize = 12;

    text(0,5600,'b','FontSize',15);
    s2b.Colormap=brewermap([],'Blues');

    if Basins>=1
        hold on; 
        contour(x,y,MASKZB,'k');
        text(2410,1080,'EAIS');
        text(450,2065,'WAIS');
        text(700,4160,'AP')
    else
        hold on;
        contour(x,y,MASK==1,'k');
    end

    % Subglacial water flux
    s2c=nexttile(4,[1 1]);

    WF_Mean_all(MASK~=1)=NaN;
    myfig4(WF_Mean_all./1e3,0,10); axis('off'); cb=colorbar; 
    cb.Label.String='Ensemble mean subglacial water flux (10^{3} m^{2} a^{-1})'; 
    cb.Label.FontSize = 12;

    text(0,5600,'d','FontSize',15);
    s2c.Colormap=brewermap([],'Blues');
     
    if Basins>=1
        hold on; 
        contour(x,y,MASKZB,'k');
        % text(3300,3100,'EAIS');
        % text(450,2065,'WAIS');
        % text(700,4160,'AP')
    else
        hold on;
        contour(x,y,MASK==1,'k');
    end

    % Relative contribution of geothermal/frictional heat to basal melt
    s2d=nexttile(3,[1 1]);

    BmeltG_Mean_all(round(MASKTBC_Mean_all)<2)=NaN; % no basal melting where the bed is cold
    BmeltF_Mean_all(round(MASKTBC_Mean_all)<2)=NaN; % no basal melting where the bed is cold
    myfig4((BmeltG_Mean_all./(BmeltG_Mean_all+BmeltF_Mean_all)).*100,0,100); axis('off')
    hold on; contour(x,y,MASK==1,'k');

    text(0,5600,'c','FontSize',15);
    s2d.Colormap=crameri("lapaz");
    
    if Basins>=2
    % Subglacial meltwater production for subglacial basins
        for i=1:27
            contour(x,y,ZB==i,1,'k','LineWidth',0.1); hold on
        end

    % EAIS
    text(2734,2979,[num2str(round(BVG_Basins_Mean_all(2)+BVF_Basins_Mean_all(2),1))]);
    text(2872,3779,[num2str(round(BVG_Basins_Mean_all(3)+BVF_Basins_Mean_all(3),1))]);
    text(1750,4440,[num2str(round(BVG_Basins_Mean_all(4)+BVF_Basins_Mean_all(4),1))]);
    text(2546,5142,[num2str(round(BVG_Basins_Mean_all(5)+BVF_Basins_Mean_all(5),1))]);
    text(3446,5094,[num2str(round(BVG_Basins_Mean_all(6)+BVF_Basins_Mean_all(6),1))]);
    text(4431,4773,[num2str(round(BVG_Basins_Mean_all(7)+BVF_Basins_Mean_all(7),1))]);
    text(5033,4028,[num2str(round(BVG_Basins_Mean_all(8)+BVF_Basins_Mean_all(8),1))]);
    text(5083,3539,[num2str(round(BVG_Basins_Mean_all(9)+BVF_Basins_Mean_all(9),1))]);
    text(3751,3362,[num2str(round(BVG_Basins_Mean_all(10)+BVF_Basins_Mean_all(10),1))]);
    text(4375,3036,[num2str(round(BVG_Basins_Mean_all(11)+BVF_Basins_Mean_all(11),1))]);
    text(4651,2711,[num2str(round(BVG_Basins_Mean_all(12)+BVF_Basins_Mean_all(12),1))]);
    text(4322,2002,[num2str(round(BVG_Basins_Mean_all(13)+BVF_Basins_Mean_all(13),1))]);
    text(4238,618.,[num2str(round(BVG_Basins_Mean_all(14)+BVF_Basins_Mean_all(14),1))]);
    text(3233,575.,[num2str(round(BVG_Basins_Mean_all(15)+BVF_Basins_Mean_all(15),1))]);
    text(2780,1310,[num2str(round(BVG_Basins_Mean_all(16)+BVF_Basins_Mean_all(16),1))]);
    text(3465,2390,[num2str(round(BVG_Basins_Mean_all(17)+BVF_Basins_Mean_all(17),1))]);
    
    % WAIS
    text(1815,2771,[num2str(round(BVG_Basins_Mean_all(1)+BVF_Basins_Mean_all(1),1))]);
    text(1943,2389,[num2str(round(BVG_Basins_Mean_all(18)+BVF_Basins_Mean_all(18),1))]);
    text(1846,2040,[num2str(round(BVG_Basins_Mean_all(19)+BVF_Basins_Mean_all(19),1))]);
    text(1457,1402,[num2str(round(BVG_Basins_Mean_all(20)+BVF_Basins_Mean_all(20),1))]);
    text(781.,2014,[num2str(round(BVG_Basins_Mean_all(21)+BVF_Basins_Mean_all(21),1))]);
    text(873.,2304,[num2str(round(BVG_Basins_Mean_all(22)+BVF_Basins_Mean_all(22),1))]);
    text(523,2781,[num2str(round(BVG_Basins_Mean_all(23)+BVF_Basins_Mean_all(23),1))]);
    
    % AP
    text(304,3381,[num2str(round(BVG_Basins_Mean_all(24)+BVF_Basins_Mean_all(24),1))]);
    text(43,3893,[num2str(round(BVG_Basins_Mean_all(25)+BVF_Basins_Mean_all(25),1))]);
    text(512,4223,[num2str(round(BVG_Basins_Mean_all(26)+BVF_Basins_Mean_all(26),1))]);
    text(1083,3970,[num2str(round(BVG_Basins_Mean_all(27)+BVF_Basins_Mean_all(27),1))]);
    
    text(0,0,'Subglacial meltwater volume'+"\newline"+'(Gt a^{-1})')
    end

    hCB=colorbar('Position',[0.4581+0.02    0.1100    0.0148    0.3964]);
    hNuCBAx=axes('Position',hCB.Position,'color','none');  % add mew axes at same posn
    hNuCBAx.XAxis.Visible='off';    % hide the x axis of new
    hCB.Position=hNuCBAx.Position;  % put the colorbar back to overlay second axeix
    hNuCBAx.YLim=[0 100];           % alternate scale limits new axis
    hNuCBAx.YDir='reverse';
    ylabel(hCB,    'Relative contribution of geothermal heat (%)','FontSize',11,'Rotation',90,'VerticalAlignment','middle','HorizontalAlignment','center')
    ylabel(hNuCBAx,'Relative contribution of frictional heat (%)','FontSize',11,'Rotation',90,'VerticalAlignment','middle','HorizontalAlignment','center')
    hCB.Position=hNuCBAx.Position;  % put the colorbar back to overlay the second axe

    % Add pie plots
    figure(f2)

    n=2; n2=2;
    subplot_ax = s2;

    pie_ax = axes('Position',[subplot_ax.Position(1)-0.26/n,subplot_ax.Position(2),subplot_ax.Position(3),0.08/n2]);
    pie_data = [BVG_Mean_all BVF_Mean_all];
    pie(pie_ax,pie_data);
    pie_ax.Colormap = pieBmeltColors;
    text(subplot_ax.Position(1)-6.6/n,subplot_ax.Position(2)+2,[num2str(round(BV_Mean_all,1)),' Gt a^{-1}'])

    l=legend('Geothermal heat contribution','Frictional heat contribution','Drainage of englacial water');
    %l.Location='eastoutside';
    legend('boxoff')

    if Basins>=1
    % Pie plots for each region
    pie_ax1 = axes('Position',[subplot_ax.Position(1)+0.02/n,subplot_ax.Position(2)+0.15/n2,subplot_ax.Position(3),0.04/n2]);
    pie_ax2 = axes('Position',[subplot_ax.Position(1)-0.2/n,subplot_ax.Position(2)+0.25/n2,subplot_ax.Position(3),0.04/n2]);
    pie_ax3 = axes('Position',[subplot_ax.Position(1)-0.17/n,subplot_ax.Position(2)+0.55/n2,subplot_ax.Position(3),0.04/n2]);

    pie_data1 = [BVG_EAIS_Mean_all BVF_EAIS_Mean_all];
    pie_data2 = [BVG_WAIS_Mean_all BVF_WAIS_Mean_all];
    pie_data3 = [BVG_AP_Mean_all   BVF_AP_Mean_all];

    labels1 = {[num2str(round(BV_EAIS_Mean,1)),' Gt a^{-1}'],' '};
    labels2 = {[num2str(round(BV_WAIS_Mean,1)),' Gt a^{-1}'],' '};
    labels3 = {[num2str(round(BV_AP_Mean,1)),' Gt a^{-1}'],' '};

    pie(pie_ax1,pie_data1,labels1);
    pie(pie_ax2,pie_data2,labels2);
    pie(pie_ax3,pie_data3,labels3);

    pie_ax1.Colormap = pieBmeltColors; 
    pie_ax2.Colormap = pieBmeltColors; 
    pie_ax3.Colormap = pieBmeltColors; 
    end

    % Apply colormaps
    s2.Colormap=brewermap([],'Blues');
    s2b.Colormap=brewermap([],'Blues');
    s2d.Colormap=crameri("lapaz");
    s2c.Colormap=brewermap([],'Blues');
end

if Figure3==1

    % Load results for enthalpy
    load ResultsAntarctica8km_Mean.mat '*HySSAE*'
    load ResultsAntarctica8km_Basins.mat '*HySSAE*'

    f=figure;
    set(f,'color','white','Position',[0.0100    0.0338    1.0830    0.8520].*1000);

    t=tiledlayout(2,2);
    t.TileSpacing="Tight";

    % Thickness of temperate ice
    Ht_Mean_Enth=(Ht_Mean_HySSAE+Ht_Mean_HySSAE_cst)./2;
    Tbc_Mean_Enth=(Tbc_Mean_HySSAE+Tbc_Mean_HySSAE_cst)./2;
    % Basal melt and refreezing rate
    Bmelt_Mean_Enth=(Bmelt_Mean_HySSAE+Bmelt_Mean_HySSAE_cst)./2;
    BmeltR_Mean_Enth=(BmeltR_Mean_HySSAE+BmeltR_Mean_HySSAE_cst)./2;
    % Subglacial meltwater drained to bed
    Dbw_Mean_Enth=(Dbw_Mean_HySSAE+Dbw_Mean_HySSAE_cst)./2;
    % Components of subglacial meltwater production
    BVG_Mean_Enth=(BVG_Mean_HySSAE+BVG_Mean_HySSAE_cst)/2;
    BVF_Mean_Enth=(BVF_Mean_HySSAE+BVF_Mean_HySSAE_cst)/2;
    % BV_Mean_Enth=(BV_Mean_HySSAE+BV_Mean_HySSAE_cst)/2;
    DBW_Mean_Enth=(DBW_Mean_HySSAE+DBW_Mean_HySSAE_cst)/2;
    BVR_Mean_Enth=(BVR_Mean_HySSAE+BVR_Mean_HySSAE_cst)/2;   
    BV_Mean_Enth=BVG_Mean_Enth+BVF_Mean_Enth-BVR_Mean_Enth;
    % Integrated over subglacial basins
    BVG_Basins_Mean_Enth=(BVG_Basins_Mean_HySSAE+BVG_Basins_Mean_HySSAE_cst)/2;
    BVF_Basins_Mean_Enth=(BVF_Basins_Mean_HySSAE+BVF_Basins_Mean_HySSAE_cst)/2;
    BVR_Basins_Mean_Enth=(BVR_Basins_Mean_HySSAE+BVR_Basins_Mean_HySSAE_cst)/2;
    DBW_Basins_Mean_Enth=(DBW_Basins_Mean_HySSAE+DBW_Basins_Mean_HySSAE_cst)/2;
    BV_Basins_Mean_Enth=BVG_Basins_Mean_Enth+BVF_Basins_Mean_Enth-BVR_Basins_Mean_Enth;

    Ht_Mean_Enth(MASKZB==0)=NaN;
    Ht_Mean_Enth(Tbc_Mean_Enth<-0.5)=NaN;
    % prctile(Ht_Mean_Enth(MASK==1), 80)
    Bmelt_Mean_Enth(MASKZB==0)=NaN;
    BmeltR_Mean_Enth(MASKZB==0)=NaN;
    Dbw_Mean_Enth(MASKZB==0)=NaN;

    % Basal melting for enthalpy
    s1=nexttile(1);
    %myfig4(Bmelt_Mean_Enth.*1000,-2,20); axis('off'); hold on
    %cb=colorbar; cb.Label.String='Basal melt (+) and refreezing (-) rate (mm a^{-1})'; cb.Label.FontSize=12;
    myfig4(Bmelt_Mean_Enth.*1000,0,20); axis('off'); hold on
    cb=colorbar; cb.Label.String='Basal melt rate (mm a^{-1})'; cb.Label.FontSize=12;
    
    contour(x,y,MASK==1,1,'k');
    % 1300,215
    % text(-195,-226,{['Total basal melting: ',num2str(round(BV_Mean_Enth-BVR_Mean_Enth,1)),' Gt a^{-1}']; ...
    %            ['Total basal refreezing: ',num2str(round(BVR_Mean_Enth,1)),' Gt a^{-1}']})
    % hold on; contour(x,y,BmeltR_Mean_Enth.*1000<-0.005,1,':w');
    text(-267,885,['Total basal melting: ',num2str(round(BV_Mean_Enth,1)),' Gt a^{-1}'])

    text(0,5600,'a','FontSize',15)

    if Basins>=2
        for i=1:27
            contour(x,y,ZB==i,1,'k','LineWidth',0.1); hold on
        end

    % EAIS
    %text(1505,3846,[num2str(round(BV_Basins_Mean_Enth(2),1))]);
    text(2734,2979,[num2str(round(BV_Basins_Mean_Enth(2),1))]);
    %text(1456,4226,[num2str(round(BV_Basins_Mean_Enth(3),1))]);
    text(2872,3779,[num2str(round(BV_Basins_Mean_Enth(3),1))]);
    text(1750,4440,[num2str(round(BV_Basins_Mean_Enth(4),1))]);
    text(2546,5142,[num2str(round(BV_Basins_Mean_Enth(5),1))]);
    text(3446,5094,[num2str(round(BV_Basins_Mean_Enth(6),1))]);
    text(4431,4773,[num2str(round(BV_Basins_Mean_Enth(7),1))]);
    text(5033,4028,[num2str(round(BV_Basins_Mean_Enth(8),1))]);
    text(5083,3539,[num2str(round(BV_Basins_Mean_Enth(9),1))]);
    %text(5400,3188,[num2str(round(BV_Basins_Mean_Enth(10),1))]);
    text(3751,3362,[num2str(round(BV_Basins_Mean_Enth(10),1))]);
    %text(5416,2815,[num2str(round(BV_Basins_Mean_Enth(11),1))]);
    text(4375,3036,[num2str(round(BV_Basins_Mean_Enth(11),1))]);
    %text(5482,2484,[num2str(round(BV_Basins_Mean_Enth(12),1))]);
    text(4651,2711,[num2str(round(BV_Basins_Mean_Enth(12),1))]);
    %text(5250,1594,[num2str(round(BV_Basins_Mean_Enth(13),1))]);
    text(4322,2002,[num2str(round(BV_Basins_Mean_Enth(13),1))]);
    text(4238,618.,[num2str(round(BV_Basins_Mean_Enth(14),1))]);
    text(3233,575.,[num2str(round(BV_Basins_Mean_Enth(15),1))]);
    %text(3027,1203,[num2str(round(BV_Basins_Mean_Enth(16),1))]);
    text(2946,1310,[num2str(round(BV_Basins_Mean_Enth(16),1))]); 
    %text(2807,1747,[num2str(round(BV_Basins_Mean_Enth(17),1))]);
    text(3465,2390,[num2str(round(BV_Basins_Mean_Enth(17),1))]);
    
    % WAIS
    %text(1554,3458,[num2str(round(BV_Basins_Mean_Enth(1),1))]);
    text(1815,2771,[num2str(round(BV_Basins_Mean_Enth(1),1))]);
    %text(2523,1961,[num2str(round(BV_Basins_Mean_Enth(18),1))]);
    text(2543,1988,[num2str(round(BV_Basins_Mean_Enth(18),1))]);
    %text(2336,1540,[num2str(round(BV_Basins_Mean_Enth(19),1))]);
    text(2296,1662,[num2str(round(BV_Basins_Mean_Enth(19),1))]);
    text(1457,1402,[num2str(round(BV_Basins_Mean_Enth(20),1))]);
    text(781.,2014,[num2str(round(BV_Basins_Mean_Enth(21),1))]);
    text(873.,2304,[num2str(round(BV_Basins_Mean_Enth(22),1))]);
    text(523,2781,[num2str(round(BV_Basins_Mean_Enth(23),1))]);
    
    % AP
    text(304,3381,[num2str(round(BV_Basins_Mean_Enth(24),1))]);
    text(43,3893,[num2str(round(BV_Basins_Mean_Enth(25),1))]);
    text(512,4223,[num2str(round(BV_Basins_Mean_Enth(26),1))]);
    text(1083,3970,[num2str(round(BV_Basins_Mean_Enth(27),1))]);
    end

    % figure1=f;
    % % Create arrow
    % annotation(figure1,'arrow',[0.296768236380425 0.236195752539243],...
    %     [0.728577464788732 0.802347417840376]);
    % 
    % % Create arrow
    % annotation(figure1,'arrow',[0.319667590027701 0.23471837488458],...
    %     [0.784446009389671 0.823004694835681]);
    % 
    % % Create arrow
    % annotation(figure1,'arrow',[0.355493998153278 0.433795013850416],...
    %     [0.765197183098592 0.756807511737089]);
    % 
    % % Create arrow
    % annotation(figure1,'arrow',[0.384672206832872 0.43601108033241],...
    %     [0.747826291079812 0.731455399061033]);


    % Basal refreezing for enthalpy
    s1b=nexttile(2);
    myfig4(BmeltR_Mean_Enth.*1000,-0.1,0); axis('off'); hold on
    cb=colorbar; cb.Label.String='Basal refreezing rate (mm a^{-1})'; cb.Label.FontSize=12;
    % 1300,215
    text(0,417,['Total basal refreezing: ',num2str(round(BVR_Mean_Enth,1)),' Gt a^{-1}'])
    % hold on; contour(x,y,BmeltR_Mean_Enth.*1000<-0.005,1,':w');

    contour(x,y,MASK==1,1,'k');
    text(0,5600,'b','FontSize',15)

    % if Basins>=2
    %     for i=1:27
    %         contour(x,y,ZB==i,1,'k','LineWidth',0.1); hold on
    %     end
    % 
    % % EAIS
    % text(2467,2979,[num2str(round(BVR_Basins_Mean_Enth(2),3))]);
    % text(2638,3765,[num2str(round(BVR_Basins_Mean_Enth(3),3))]);
    % text(1516,4440,[num2str(round(BVR_Basins_Mean_Enth(4),3))]);
    % text(2546,5142,[num2str(round(BVR_Basins_Mean_Enth(5),3))]);
    % text(3446,5094,[num2str(round(BVR_Basins_Mean_Enth(6),3))]);
    % text(4431,4773,[num2str(round(BVR_Basins_Mean_Enth(7),3))]);
    % text(5033,4028,[num2str(round(BVR_Basins_Mean_Enth(8),3))]);
    % text(5083,3539,[num2str(round(BVR_Basins_Mean_Enth(9),3))]);
    % text(3751,3362,[num2str(round(BVR_Basins_Mean_Enth(10),3))]);
    % text(4241,3036,[num2str(round(BVR_Basins_Mean_Enth(11),3))]);
    % text(4651,2711,[num2str(round(BVR_Basins_Mean_Enth(12),3))]);
    % text(4322,1901,[num2str(round(BVR_Basins_Mean_Enth(13),3))]);
    % text(4021,618.,[num2str(round(BVR_Basins_Mean_Enth(14),3))]);
    % text(3233,575.,[num2str(round(BVR_Basins_Mean_Enth(15),3))]);
    % text(2946,1310,[num2str(round(BVR_Basins_Mean_Enth(16),3))]);
    % text(3231,2256,[num2str(round(BVR_Basins_Mean_Enth(17),3))]);
    % 
    % % WAIS
    % text(1364,2921,[num2str(round(BVR_Basins_Mean_Enth(1),3))]);
    % text(1809,2389,[num2str(round(BVR_Basins_Mean_Enth(18),3))]);
    % text(1629,1973,[num2str(round(BVR_Basins_Mean_Enth(19),3))]);
    % text(1457,1402,[num2str(round(BVR_Basins_Mean_Enth(20),3))]);
    % text(981.,2264,[num2str(round(BVR_Basins_Mean_Enth(21),3))]);
    % text(1023,2687,[num2str(round(BVR_Basins_Mean_Enth(22),3))]);
    % text(523,2781,[num2str(round(BVR_Basins_Mean_Enth(23),3))]);
    % 
    % % AP
    % text(304,3381,[num2str(round(BVR_Basins_Mean_Enth(24),3))]);
    % text(43,3893,[num2str(round(BVR_Basins_Mean_Enth(25),3))]);
    % text(512,4223,[num2str(round(BVR_Basins_Mean_Enth(26),3))]);
    % text(1083,3970,[num2str(round(BVR_Basins_Mean_Enth(27),3))]);
    % end

    % Englacial meltwater drained to bed
    s2=nexttile(3);
    myfig4(Dbw_Mean_Enth.*1000,0,10); axis('off'); hold on
    cb=colorbar; cb.Label.String='Englacial meltwater drained to the bed (mm a^{-1})'; cb.Label.FontSize=12;

    contour(x,y,MASK==1,1,'k');

    ticks = cb.Ticks; 
    cb.TickLabels = arrayfun(@(x) sprintf('%.0f', x), ticks, 'UniformOutput', false);

    text(0-267,0,['Total englacial meltwater drained to the bed: ','\newline',num2str(round(DBW_Mean_Enth,2)),' Gt a^{-1}'])
    text(0,5600,'c','FontSize',15)

    if Basins>=2
        for i=1:27
            contour(x,y,ZB==i,1,'k','LineWidth',0.1); hold on
        end

    % EAIS
    text(2734,2979,[num2str(round(DBW_Basins_Mean_Enth(2),1))]);
    text(2872,3779,[num2str(round(DBW_Basins_Mean_Enth(3),1))]);
    text(1750,4440,[num2str(round(DBW_Basins_Mean_Enth(4),1))]);
    text(2546,5142,[num2str(round(DBW_Basins_Mean_Enth(5),1))]);
    text(3446,5094,[num2str(round(DBW_Basins_Mean_Enth(6),1))]);
    text(4431,4773,[num2str(round(DBW_Basins_Mean_Enth(7),1))]);
    text(5033,4028,[num2str(round(DBW_Basins_Mean_Enth(8),1))]);
    text(5083,3539,[num2str(round(DBW_Basins_Mean_Enth(9),1))]);
    text(3751,3362,[num2str(round(DBW_Basins_Mean_Enth(10),1))]);
    text(4375,3036,[num2str(round(DBW_Basins_Mean_Enth(11),1))]);
    text(4651,2711,[num2str(round(DBW_Basins_Mean_Enth(12),1))]);
    text(4322,2002,[num2str(round(DBW_Basins_Mean_Enth(13),1))]);
    text(4238,618.,[num2str(round(DBW_Basins_Mean_Enth(14),1))]);
    text(3233,575.,[num2str(round(DBW_Basins_Mean_Enth(15),1))]);
    text(2780,1310,[num2str(round(DBW_Basins_Mean_Enth(16),1))]);
    text(3465,2390,[num2str(round(DBW_Basins_Mean_Enth(17),1))]);
    
    % WAIS
    text(1815,2771,[num2str(round(DBW_Basins_Mean_Enth(1),1))]);
    %text(1943,2389,[num2str(round(DBW_Basins_Mean_Enth(18),1))]);
    text(2543,1988,[num2str(round(DBW_Basins_Mean_Enth(18),1))]);
    %text(1846,2040,[num2str(round(DBW_Basins_Mean_Enth(19),1))]);
    text(2296,1662,[num2str(round(DBW_Basins_Mean_Enth(19),1))]);
    text(1457,1402,[num2str(round(DBW_Basins_Mean_Enth(20),1))]);
    text(781.,2014,[num2str(round(DBW_Basins_Mean_Enth(21),1))]);
    text(873.,2304,[num2str(round(DBW_Basins_Mean_Enth(22),1))]);
    text(523,2781,[num2str(round(DBW_Basins_Mean_Enth(23),1))]);
    
    % AP
    text(304,3381,[num2str(round(DBW_Basins_Mean_Enth(24),1))]);
    text(43,3893,[num2str(round(DBW_Basins_Mean_Enth(25),1))]);
    text(512,4223,[num2str(round(DBW_Basins_Mean_Enth(26),1))]);
    text(1083,3970,[num2str(round(DBW_Basins_Mean_Enth(27),1))]);
    end

    % Thickness of the temperate ice layer
    s2b=nexttile(4);
    myfig4(Ht_Mean_Enth); axis('off'); hold on
    cb=colorbar; cb.Label.String='Thickness of the temperate ice layer (m)'; cb.Label.FontSize=12;
 
    contour(x,y,MASK==1,1,'k');

    HT_Mean_Enth=mean(mean(Ht_Mean_Enth(MASK==1),'omitnan'),'omitnan');
    text(0,0,['Average temperate ice layer thickness: ','\newline',num2str(round(HT_Mean_Enth,2)),' m']);
    
    text(0,5600,'d','FontSize',15)

    % Add pie plots
    n=2; n2=2;
    subplot_ax = s1;
    pie_ax = axes('Position',[subplot_ax.Position(1)-0.26/n,subplot_ax.Position(2),subplot_ax.Position(3),0.08/n2]);
    pie_data = [(BVG_Mean_HySSAE+BVG_Mean_HySSAE_cst)./2 (BVF_Mean_HySSAE+BVF_Mean_HySSAE_cst)./2];
    pie(pie_ax,pie_data);
    pie_ax.Colormap = pieBmeltColors;
    legend('Geothermal heat contribution','Frictional heat contribution','Location','South');

    % Apply colormaps
    % Old version
    % c1=flipud(crameri('lapaz')); c2=brewermap([],'*RdBu'); %crameri('vik');
    % C = [interp1(1:size(c1,1), c1, linspace(1, size(c1,1), round(2/22 * 256)));
    %      interp1(1:size(c2,1), c2, linspace(1, size(c2,1), 256 -  round(2/22 * 256)))];
    % s1.Colormap=C;

    % Current colormaps
    s1.Colormap=brewermap([],'Blues');
    s1b.Colormap=brewermap([],'*Blues');
    s2.Colormap=brewermap([],'Blues');
    colors=flipud(crameri('lapaz'));
    colors2=colors(25:225,:);
    s2b.Colormap=colors2;
end


if Figure4==1

% Data processing for sensitivity analysis
if Load==1
load ResultsAntarctica8km_basal_temperature.mat 'Prop*'
load ResultsAntarctica8km_subglacial_meltwater.mat 'BV*' 'DBW*'
end

% ------------------------------------------------------------------------%
%                          MODELLING APPROACHES                           %
% ------------------------------------------------------------------------%

% ---------------- Fraction of temperate basal conditions ----------------%

Prop_KoriE=[Prop_HySSAE_MAR_HF1; Prop_HySSAE_RACMO_HF1;Prop_HySSAE_MAR_HF2; Prop_HySSAE_RACMO_HF2; ...
            Prop_HySSAE_MAR_HF4; Prop_HySSAE_RACMO_HF4;Prop_HySSAE_MAR_HF3; Prop_HySSAE_RACMO_HF3; ...
            Prop_HySSAE_MAR_HF6; Prop_HySSAE_RACMO_HF6;Prop_HySSAE_MAR_HF7; Prop_HySSAE_RACMO_HF7; ...
            Prop_HySSAE_MAR_HF9; Prop_HySSAE_RACMO_HF9;...
            Prop_HySSAE_MAR_HF8; Prop_HySSAE_RACMO_HF8;Prop_HySSAE_MAR_HF5; Prop_HySSAE_RACMO_HF5];
 
Prop_KoriE_cst=[Prop_HySSAE_cst_MAR_HF1; Prop_HySSAE_cst_RACMO_HF1;Prop_HySSAE_cst_MAR_HF2; Prop_HySSAE_cst_RACMO_HF2; ...
                Prop_HySSAE_cst_MAR_HF4; Prop_HySSAE_cst_RACMO_HF4;Prop_HySSAE_cst_MAR_HF3; Prop_HySSAE_cst_RACMO_HF3; ...
                Prop_HySSAE_cst_MAR_HF6; Prop_HySSAE_cst_RACMO_HF6;Prop_HySSAE_cst_MAR_HF7; Prop_HySSAE_cst_RACMO_HF7; ...
                Prop_HySSAE_cst_MAR_HF9; Prop_HySSAE_cst_RACMO_HF9;...
                Prop_HySSAE_cst_MAR_HF8; Prop_HySSAE_cst_RACMO_HF8;Prop_HySSAE_cst_MAR_HF5; Prop_HySSAE_cst_RACMO_HF5];

Prop_Kori=[Prop_HySSA_MAR_HF1; Prop_HySSA_RACMO_HF1;Prop_HySSA_MAR_HF2; Prop_HySSA_RACMO_HF2; ...
           Prop_HySSA_MAR_HF4; Prop_HySSA_RACMO_HF4;Prop_HySSA_MAR_HF3; Prop_HySSA_RACMO_HF3; ...
           Prop_HySSA_MAR_HF6; Prop_HySSA_RACMO_HF6;Prop_HySSA_MAR_HF7; Prop_HySSA_RACMO_HF7; ...
           Prop_HySSA_MAR_HF9; Prop_HySSA_RACMO_HF9;...
           Prop_HySSA_MAR_HF8; Prop_HySSA_RACMO_HF8;Prop_HySSA_MAR_HF5; Prop_HySSA_RACMO_HF5];
 
Prop_Kori_cst=[Prop_HySSA_cst_MAR_HF1; Prop_HySSA_cst_RACMO_HF1;Prop_HySSA_cst_MAR_HF2; Prop_HySSA_cst_RACMO_HF2; ...
               Prop_HySSA_cst_MAR_HF4; Prop_HySSA_cst_RACMO_HF4;Prop_HySSA_cst_MAR_HF3; Prop_HySSA_cst_RACMO_HF3; ...
               Prop_HySSA_cst_MAR_HF6; Prop_HySSA_cst_RACMO_HF6;Prop_HySSA_cst_MAR_HF7; Prop_HySSA_cst_RACMO_HF7; ...
               Prop_HySSA_cst_MAR_HF9; Prop_HySSA_cst_RACMO_HF9;...
               Prop_HySSA_cst_MAR_HF8; Prop_HySSA_cst_RACMO_HF8;Prop_HySSA_cst_MAR_HF5; Prop_HySSA_cst_RACMO_HF5];

Prop_Vobs=[Prop_Vobs_MAR_HF1; Prop_Vobs_RACMO_HF1;Prop_Vobs_MAR_HF2; Prop_Vobs_RACMO_HF2; ...
           Prop_Vobs_MAR_HF4; Prop_Vobs_RACMO_HF4;Prop_Vobs_MAR_HF3; Prop_Vobs_RACMO_HF3; ...
           Prop_Vobs_MAR_HF6; Prop_Vobs_RACMO_HF6;Prop_Vobs_MAR_HF7; Prop_Vobs_RACMO_HF7; ...
           Prop_Vobs_MAR_HF9; Prop_Vobs_RACMO_HF9; ...
           Prop_Vobs_MAR_HF8; Prop_Vobs_RACMO_HF8;Prop_Vobs_MAR_HF5; Prop_Vobs_RACMO_HF5];

Prop_Vobs_cst=[Prop_Vobs_cst_MAR_HF1; Prop_Vobs_cst_RACMO_HF1;Prop_Vobs_cst_MAR_HF2; Prop_Vobs_cst_RACMO_HF2; ...
               Prop_Vobs_cst_MAR_HF4; Prop_Vobs_cst_RACMO_HF4;Prop_Vobs_cst_MAR_HF3; Prop_Vobs_cst_RACMO_HF3; ...
               Prop_Vobs_cst_MAR_HF6; Prop_Vobs_cst_RACMO_HF6;Prop_Vobs_cst_MAR_HF7; Prop_Vobs_cst_RACMO_HF7; ...
               Prop_Vobs_cst_MAR_HF9; Prop_Vobs_cst_RACMO_HF9; ...
               Prop_Vobs_cst_MAR_HF8; Prop_Vobs_cst_RACMO_HF8;Prop_Vobs_cst_MAR_HF5; Prop_Vobs_cst_RACMO_HF5];

Prop_Tfield_nc=[ Prop_Tfield_nc_MAR_HF1; Prop_Tfield_nc_RACMO_HF1;Prop_Tfield_nc_MAR_HF2; Prop_Tfield_nc_RACMO_HF2; ...
           Prop_Tfield_nc_MAR_HF4; Prop_Tfield_nc_RACMO_HF4;Prop_Tfield_nc_MAR_HF3; Prop_Tfield_nc_RACMO_HF3; ...
           Prop_Tfield_nc_MAR_HF6; Prop_Tfield_nc_RACMO_HF6;Prop_Tfield_nc_MAR_HF7; Prop_Tfield_nc_RACMO_HF7; ...
           Prop_Tfield_nc_MAR_HF9; Prop_Tfield_nc_RACMO_HF9; ...
           Prop_Tfield_nc_MAR_HF8; Prop_Tfield_nc_RACMO_HF8;Prop_Tfield_nc_MAR_HF5; Prop_Tfield_nc_RACMO_HF5];

Prop_Tfield_nc_cst=[Prop_Tfield_nc_cst_MAR_HF1; Prop_Tfield_nc_cst_RACMO_HF1;Prop_Tfield_nc_cst_MAR_HF2; Prop_Tfield_nc_cst_RACMO_HF2; ...
               Prop_Tfield_nc_cst_MAR_HF4; Prop_Tfield_nc_cst_RACMO_HF4;Prop_Tfield_nc_cst_MAR_HF3; Prop_Tfield_nc_cst_RACMO_HF3; ...
               Prop_Tfield_nc_cst_MAR_HF6; Prop_Tfield_nc_cst_RACMO_HF6;Prop_Tfield_nc_cst_MAR_HF7; Prop_Tfield_nc_cst_RACMO_HF7; ...
               Prop_Tfield_nc_cst_MAR_HF9; Prop_Tfield_nc_cst_RACMO_HF9; ...
               Prop_Tfield_nc_cst_MAR_HF8; Prop_Tfield_nc_cst_RACMO_HF8;Prop_Tfield_nc_cst_MAR_HF5; Prop_Tfield_nc_cst_RACMO_HF5];

Prop_Tfield_c=[ Prop_Tfield_c_MAR_HF1; Prop_Tfield_c_RACMO_HF1;Prop_Tfield_c_MAR_HF2; Prop_Tfield_c_RACMO_HF2; ...
           Prop_Tfield_c_MAR_HF4; Prop_Tfield_c_RACMO_HF4;Prop_Tfield_c_MAR_HF3; Prop_Tfield_c_RACMO_HF3; ...
           Prop_Tfield_c_MAR_HF6; Prop_Tfield_c_RACMO_HF6;Prop_Tfield_c_MAR_HF7; Prop_Tfield_c_RACMO_HF7; ...
           Prop_Tfield_c_MAR_HF9; Prop_Tfield_c_RACMO_HF9; ...
           Prop_Tfield_c_MAR_HF8; Prop_Tfield_c_RACMO_HF8;Prop_Tfield_c_MAR_HF5; Prop_Tfield_c_RACMO_HF5];

Prop_Tfield_c_cst=[Prop_Tfield_c_cst_MAR_HF1; Prop_Tfield_c_cst_RACMO_HF1;Prop_Tfield_c_cst_MAR_HF2; Prop_Tfield_c_cst_RACMO_HF2; ...
               Prop_Tfield_c_cst_MAR_HF4; Prop_Tfield_c_cst_RACMO_HF4;Prop_Tfield_c_cst_MAR_HF3; Prop_Tfield_c_cst_RACMO_HF3; ...
               Prop_Tfield_c_cst_MAR_HF6; Prop_Tfield_c_cst_RACMO_HF6;Prop_Tfield_c_cst_MAR_HF7; Prop_Tfield_c_cst_RACMO_HF7; ...
               Prop_Tfield_c_cst_MAR_HF9; Prop_Tfield_c_cst_RACMO_HF9; ...
               Prop_Tfield_c_cst_MAR_HF8; Prop_Tfield_c_cst_RACMO_HF8;Prop_Tfield_c_cst_MAR_HF5; Prop_Tfield_c_cst_RACMO_HF5];

% ------------ Volume of subglacial water from geothermal heat ---------- %

BVG_KoriE=[BVG_HySSAE_MAR_HF1; BVG_HySSAE_RACMO_HF1;BVG_HySSAE_MAR_HF2; BVG_HySSAE_RACMO_HF2; ...
            BVG_HySSAE_MAR_HF4; BVG_HySSAE_RACMO_HF4;BVG_HySSAE_MAR_HF3; BVG_HySSAE_RACMO_HF3; ...
            BVG_HySSAE_MAR_HF6; BVG_HySSAE_RACMO_HF6;BVG_HySSAE_MAR_HF7; BVG_HySSAE_RACMO_HF7; ...
            BVG_HySSAE_MAR_HF9; BVG_HySSAE_RACMO_HF9;...
            BVG_HySSAE_MAR_HF8; BVG_HySSAE_RACMO_HF8;BVG_HySSAE_MAR_HF5; BVG_HySSAE_RACMO_HF5];
 
BVG_KoriE_cst=[BVG_HySSAE_cst_MAR_HF1; BVG_HySSAE_cst_RACMO_HF1;BVG_HySSAE_cst_MAR_HF2; BVG_HySSAE_cst_RACMO_HF2; ...
                BVG_HySSAE_cst_MAR_HF4; BVG_HySSAE_cst_RACMO_HF4;BVG_HySSAE_cst_MAR_HF3; BVG_HySSAE_cst_RACMO_HF3; ...
                BVG_HySSAE_cst_MAR_HF6; BVG_HySSAE_cst_RACMO_HF6;BVG_HySSAE_cst_MAR_HF7; BVG_HySSAE_cst_RACMO_HF7; ...
                BVG_HySSAE_cst_MAR_HF9; BVG_HySSAE_cst_RACMO_HF9;...
                BVG_HySSAE_cst_MAR_HF8; BVG_HySSAE_cst_RACMO_HF8;BVG_HySSAE_cst_MAR_HF5; BVG_HySSAE_cst_RACMO_HF5];

BVG_Kori=[BVG_HySSA_MAR_HF1; BVG_HySSA_RACMO_HF1;BVG_HySSA_MAR_HF2; BVG_HySSA_RACMO_HF2; ...
           BVG_HySSA_MAR_HF4; BVG_HySSA_RACMO_HF4;BVG_HySSA_MAR_HF3; BVG_HySSA_RACMO_HF3; ...
           BVG_HySSA_MAR_HF6; BVG_HySSA_RACMO_HF6;BVG_HySSA_MAR_HF7; BVG_HySSA_RACMO_HF7; ...
           BVG_HySSA_MAR_HF9; BVG_HySSA_RACMO_HF9;...
           BVG_HySSA_MAR_HF8; BVG_HySSA_RACMO_HF8;BVG_HySSA_MAR_HF5; BVG_HySSA_RACMO_HF5];
 
BVG_Kori_cst=[BVG_HySSA_cst_MAR_HF1; BVG_HySSA_cst_RACMO_HF1;BVG_HySSA_cst_MAR_HF2; BVG_HySSA_cst_RACMO_HF2; ...
               BVG_HySSA_cst_MAR_HF4; BVG_HySSA_cst_RACMO_HF4;BVG_HySSA_cst_MAR_HF3; BVG_HySSA_cst_RACMO_HF3; ...
               BVG_HySSA_cst_MAR_HF6; BVG_HySSA_cst_RACMO_HF6;BVG_HySSA_cst_MAR_HF7; BVG_HySSA_cst_RACMO_HF7; ...
               BVG_HySSA_cst_MAR_HF9; BVG_HySSA_cst_RACMO_HF9;...
               BVG_HySSA_cst_MAR_HF8; BVG_HySSA_cst_RACMO_HF8;BVG_HySSA_cst_MAR_HF5; BVG_HySSA_cst_RACMO_HF5];

BVG_Vobs=[BVG_Vobs_MAR_HF1; BVG_Vobs_RACMO_HF1;BVG_Vobs_MAR_HF2; BVG_Vobs_RACMO_HF2; ...
           BVG_Vobs_MAR_HF4; BVG_Vobs_RACMO_HF4;BVG_Vobs_MAR_HF3; BVG_Vobs_RACMO_HF3; ...
           BVG_Vobs_MAR_HF6; BVG_Vobs_RACMO_HF6;BVG_Vobs_MAR_HF7; BVG_Vobs_RACMO_HF7; ...
           BVG_Vobs_MAR_HF9; BVG_Vobs_RACMO_HF9; ...
           BVG_Vobs_MAR_HF8; BVG_Vobs_RACMO_HF8;BVG_Vobs_MAR_HF5; BVG_Vobs_RACMO_HF5];

BVG_Vobs_cst=[BVG_Vobs_cst_MAR_HF1; BVG_Vobs_cst_RACMO_HF1;BVG_Vobs_cst_MAR_HF2; BVG_Vobs_cst_RACMO_HF2; ...
               BVG_Vobs_cst_MAR_HF4; BVG_Vobs_cst_RACMO_HF4;BVG_Vobs_cst_MAR_HF3; BVG_Vobs_cst_RACMO_HF3; ...
               BVG_Vobs_cst_MAR_HF6; BVG_Vobs_cst_RACMO_HF6;BVG_Vobs_cst_MAR_HF7; BVG_Vobs_cst_RACMO_HF7; ...
               BVG_Vobs_cst_MAR_HF9; BVG_Vobs_cst_RACMO_HF9; ...
               BVG_Vobs_cst_MAR_HF8; BVG_Vobs_cst_RACMO_HF8;BVG_Vobs_cst_MAR_HF5; BVG_Vobs_cst_RACMO_HF5];

BVG_Tfield_nc=[ BVG_Tfield_nc_MAR_HF1; BVG_Tfield_nc_RACMO_HF1;BVG_Tfield_nc_MAR_HF2; BVG_Tfield_nc_RACMO_HF2; ...
           BVG_Tfield_nc_MAR_HF4; BVG_Tfield_nc_RACMO_HF4;BVG_Tfield_nc_MAR_HF3; BVG_Tfield_nc_RACMO_HF3; ...
           BVG_Tfield_nc_MAR_HF6; BVG_Tfield_nc_RACMO_HF6;BVG_Tfield_nc_MAR_HF7; BVG_Tfield_nc_RACMO_HF7; ...
           BVG_Tfield_nc_MAR_HF9; BVG_Tfield_nc_RACMO_HF9; ...
           BVG_Tfield_nc_MAR_HF8; BVG_Tfield_nc_RACMO_HF8;BVG_Tfield_nc_MAR_HF5; BVG_Tfield_nc_RACMO_HF5];

BVG_Tfield_nc_cst=[BVG_Tfield_nc_cst_MAR_HF1; BVG_Tfield_nc_cst_RACMO_HF1;BVG_Tfield_nc_cst_MAR_HF2; BVG_Tfield_nc_cst_RACMO_HF2; ...
               BVG_Tfield_nc_cst_MAR_HF4; BVG_Tfield_nc_cst_RACMO_HF4;BVG_Tfield_nc_cst_MAR_HF3; BVG_Tfield_nc_cst_RACMO_HF3; ...
               BVG_Tfield_nc_cst_MAR_HF6; BVG_Tfield_nc_cst_RACMO_HF6;BVG_Tfield_nc_cst_MAR_HF7; BVG_Tfield_nc_cst_RACMO_HF7; ...
               BVG_Tfield_nc_cst_MAR_HF9; BVG_Tfield_nc_cst_RACMO_HF9; ...
               BVG_Tfield_nc_cst_MAR_HF8; BVG_Tfield_nc_cst_RACMO_HF8;BVG_Tfield_nc_cst_MAR_HF5; BVG_Tfield_nc_cst_RACMO_HF5];

BVG_Tfield_c=[BVG_Tfield_c_MAR_HF1; BVG_Tfield_c_RACMO_HF1;BVG_Tfield_c_MAR_HF2; BVG_Tfield_c_RACMO_HF2; ...
           BVG_Tfield_c_MAR_HF4; BVG_Tfield_c_RACMO_HF4;BVG_Tfield_c_MAR_HF3; BVG_Tfield_c_RACMO_HF3; ...
           BVG_Tfield_c_MAR_HF6; BVG_Tfield_c_RACMO_HF6;BVG_Tfield_c_MAR_HF7; BVG_Tfield_c_RACMO_HF7; ...
           BVG_Tfield_c_MAR_HF9; BVG_Tfield_c_RACMO_HF9; ...
           BVG_Tfield_c_MAR_HF8; BVG_Tfield_c_RACMO_HF8;BVG_Tfield_c_MAR_HF5; BVG_Tfield_c_RACMO_HF5];

BVG_Tfield_c_cst=[BVG_Tfield_c_cst_MAR_HF1; BVG_Tfield_c_cst_RACMO_HF1;BVG_Tfield_c_cst_MAR_HF2; BVG_Tfield_c_cst_RACMO_HF2; ...
               BVG_Tfield_c_cst_MAR_HF4; BVG_Tfield_c_cst_RACMO_HF4;BVG_Tfield_c_cst_MAR_HF3; BVG_Tfield_c_cst_RACMO_HF3; ...
               BVG_Tfield_c_cst_MAR_HF6; BVG_Tfield_c_cst_RACMO_HF6;BVG_Tfield_c_cst_MAR_HF7; BVG_Tfield_c_cst_RACMO_HF7; ...
               BVG_Tfield_c_cst_MAR_HF9; BVG_Tfield_c_cst_RACMO_HF9; ...
               BVG_Tfield_c_cst_MAR_HF8; BVG_Tfield_c_cst_RACMO_HF8;BVG_Tfield_c_cst_MAR_HF5; BVG_Tfield_c_cst_RACMO_HF5];

% ---------- Volume of subglacial water from frictional heat ------------ %

BVF_KoriE=[BVF_HySSAE_MAR_HF1; BVF_HySSAE_RACMO_HF1;BVF_HySSAE_MAR_HF2; BVF_HySSAE_RACMO_HF2; ...
            BVF_HySSAE_MAR_HF4; BVF_HySSAE_RACMO_HF4;BVF_HySSAE_MAR_HF3; BVF_HySSAE_RACMO_HF3; ...
            BVF_HySSAE_MAR_HF6; BVF_HySSAE_RACMO_HF6;BVF_HySSAE_MAR_HF7; BVF_HySSAE_RACMO_HF7; ...
            BVF_HySSAE_MAR_HF9; BVF_HySSAE_RACMO_HF9;...
            BVF_HySSAE_MAR_HF8; BVF_HySSAE_RACMO_HF8;BVF_HySSAE_MAR_HF5; BVF_HySSAE_RACMO_HF5];
 
BVF_KoriE_cst=[BVF_HySSAE_cst_MAR_HF1; BVF_HySSAE_cst_RACMO_HF1;BVF_HySSAE_cst_MAR_HF2; BVF_HySSAE_cst_RACMO_HF2; ...
                BVF_HySSAE_cst_MAR_HF4; BVF_HySSAE_cst_RACMO_HF4;BVF_HySSAE_cst_MAR_HF3; BVF_HySSAE_cst_RACMO_HF3; ...
                BVF_HySSAE_cst_MAR_HF6; BVF_HySSAE_cst_RACMO_HF6;BVF_HySSAE_cst_MAR_HF7; BVF_HySSAE_cst_RACMO_HF7; ...
                BVF_HySSAE_cst_MAR_HF9; BVF_HySSAE_cst_RACMO_HF9;...
                BVF_HySSAE_cst_MAR_HF8; BVF_HySSAE_cst_RACMO_HF8;BVF_HySSAE_cst_MAR_HF5; BVF_HySSAE_cst_RACMO_HF5];

BVF_Kori=[BVF_HySSA_MAR_HF1; BVF_HySSA_RACMO_HF1;BVF_HySSA_MAR_HF2; BVF_HySSA_RACMO_HF2; ...
           BVF_HySSA_MAR_HF4; BVF_HySSA_RACMO_HF4;BVF_HySSA_MAR_HF3; BVF_HySSA_RACMO_HF3; ...
           BVF_HySSA_MAR_HF6; BVF_HySSA_RACMO_HF6;BVF_HySSA_MAR_HF7; BVF_HySSA_RACMO_HF7; ...
           BVF_HySSA_MAR_HF9; BVF_HySSA_RACMO_HF9;...
           BVF_HySSA_MAR_HF8; BVF_HySSA_RACMO_HF8;BVF_HySSA_MAR_HF5; BVF_HySSA_RACMO_HF5];
 
BVF_Kori_cst=[BVF_HySSA_cst_MAR_HF1; BVF_HySSA_cst_RACMO_HF1;BVF_HySSA_cst_MAR_HF2; BVF_HySSA_cst_RACMO_HF2; ...
               BVF_HySSA_cst_MAR_HF4; BVF_HySSA_cst_RACMO_HF4;BVF_HySSA_cst_MAR_HF3; BVF_HySSA_cst_RACMO_HF3; ...
               BVF_HySSA_cst_MAR_HF6; BVF_HySSA_cst_RACMO_HF6;BVF_HySSA_cst_MAR_HF7; BVF_HySSA_cst_RACMO_HF7; ...
               BVF_HySSA_cst_MAR_HF9; BVF_HySSA_cst_RACMO_HF9;...
               BVF_HySSA_cst_MAR_HF8; BVF_HySSA_cst_RACMO_HF8;BVF_HySSA_cst_MAR_HF5; BVF_HySSA_cst_RACMO_HF5];

BVF_Vobs=[BVF_Vobs_MAR_HF1; BVF_Vobs_RACMO_HF1;BVF_Vobs_MAR_HF2; BVF_Vobs_RACMO_HF2; ...
          BVF_Vobs_MAR_HF4; BVF_Vobs_RACMO_HF4;BVF_Vobs_MAR_HF3; BVF_Vobs_RACMO_HF3; ...
          BVF_Vobs_MAR_HF6; BVF_Vobs_RACMO_HF6;BVF_Vobs_MAR_HF7; BVF_Vobs_RACMO_HF7; ...
          BVF_Vobs_MAR_HF9; BVF_Vobs_RACMO_HF9; ...
          BVF_Vobs_MAR_HF8; BVF_Vobs_RACMO_HF8;BVF_Vobs_MAR_HF5; BVF_Vobs_RACMO_HF5];

BVF_Vobs_cst=[BVF_Vobs_cst_MAR_HF1; BVF_Vobs_cst_RACMO_HF1;BVF_Vobs_cst_MAR_HF2; BVF_Vobs_cst_RACMO_HF2; ...
              BVF_Vobs_cst_MAR_HF4; BVF_Vobs_cst_RACMO_HF4;BVF_Vobs_cst_MAR_HF3; BVF_Vobs_cst_RACMO_HF3; ...
              BVF_Vobs_cst_MAR_HF6; BVF_Vobs_cst_RACMO_HF6;BVF_Vobs_cst_MAR_HF7; BVF_Vobs_cst_RACMO_HF7; ...
              BVF_Vobs_cst_MAR_HF9; BVF_Vobs_cst_RACMO_HF9; ...
              BVF_Vobs_cst_MAR_HF8; BVF_Vobs_cst_RACMO_HF8;BVF_Vobs_cst_MAR_HF5; BVF_Vobs_cst_RACMO_HF5];

BVF_Tfield_nc=[BVF_Tfield_nc_MAR_HF1; BVF_Tfield_nc_RACMO_HF1;BVF_Tfield_nc_MAR_HF2; BVF_Tfield_nc_RACMO_HF2; ...
           BVF_Tfield_nc_MAR_HF4; BVF_Tfield_nc_RACMO_HF4;BVF_Tfield_nc_MAR_HF3; BVF_Tfield_nc_RACMO_HF3; ...
           BVF_Tfield_nc_MAR_HF6; BVF_Tfield_nc_RACMO_HF6;BVF_Tfield_nc_MAR_HF7; BVF_Tfield_nc_RACMO_HF7; ...
           BVF_Tfield_nc_MAR_HF9; BVF_Tfield_nc_RACMO_HF9; ...
           BVF_Tfield_nc_MAR_HF8; BVF_Tfield_nc_RACMO_HF8;BVF_Tfield_nc_MAR_HF5; BVF_Tfield_nc_RACMO_HF5];

BVF_Tfield_nc_cst=[ BVF_Tfield_nc_cst_MAR_HF1; BVF_Tfield_nc_cst_RACMO_HF1;BVF_Tfield_nc_cst_MAR_HF2; BVF_Tfield_nc_cst_RACMO_HF2; ...
               BVF_Tfield_nc_cst_MAR_HF4; BVF_Tfield_nc_cst_RACMO_HF4;BVF_Tfield_nc_cst_MAR_HF3; BVF_Tfield_nc_cst_RACMO_HF3; ...
               BVF_Tfield_nc_cst_MAR_HF6; BVF_Tfield_nc_cst_RACMO_HF6;BVF_Tfield_nc_cst_MAR_HF7; BVF_Tfield_nc_cst_RACMO_HF7; ...
               BVF_Tfield_nc_cst_MAR_HF9; BVF_Tfield_nc_cst_RACMO_HF9; ...
               BVF_Tfield_nc_cst_MAR_HF8; BVF_Tfield_nc_cst_RACMO_HF8;BVF_Tfield_nc_cst_MAR_HF5; BVF_Tfield_nc_cst_RACMO_HF5];

BVF_Tfield_c=[BVF_Tfield_c_MAR_HF1; BVF_Tfield_c_RACMO_HF1;BVF_Tfield_c_MAR_HF2; BVF_Tfield_c_RACMO_HF2; ...
           BVF_Tfield_c_MAR_HF4; BVF_Tfield_c_RACMO_HF4;BVF_Tfield_c_MAR_HF3; BVF_Tfield_c_RACMO_HF3; ...
           BVF_Tfield_c_MAR_HF6; BVF_Tfield_c_RACMO_HF6;BVF_Tfield_c_MAR_HF7; BVF_Tfield_c_RACMO_HF7; ...
           BVF_Tfield_c_MAR_HF9; BVF_Tfield_c_RACMO_HF9; ...
           BVF_Tfield_c_MAR_HF8; BVF_Tfield_c_RACMO_HF8;BVF_Tfield_c_MAR_HF5; BVF_Tfield_c_RACMO_HF5];

BVF_Tfield_c_cst=[BVF_Tfield_c_cst_MAR_HF1; BVF_Tfield_c_cst_RACMO_HF1;BVF_Tfield_c_cst_MAR_HF2; BVF_Tfield_c_cst_RACMO_HF2; ...
               BVF_Tfield_c_cst_MAR_HF4; BVF_Tfield_c_cst_RACMO_HF4;BVF_Tfield_c_cst_MAR_HF3; BVF_Tfield_c_cst_RACMO_HF3; ...
               BVF_Tfield_c_cst_MAR_HF6; BVF_Tfield_c_cst_RACMO_HF6;BVF_Tfield_c_cst_MAR_HF7; BVF_Tfield_c_cst_RACMO_HF7; ...
               BVF_Tfield_c_cst_MAR_HF9; BVF_Tfield_c_cst_RACMO_HF9; ...
               BVF_Tfield_c_cst_MAR_HF8; BVF_Tfield_c_cst_RACMO_HF8;BVF_Tfield_c_cst_MAR_HF5; BVF_Tfield_c_cst_RACMO_HF5];

% --------------- Total volume of subglacial meltwater ------------------ %

BV_KoriE=BVG_KoriE+BVF_KoriE;
BV_KoriE_cst=BVG_KoriE_cst+BVF_KoriE_cst;
BV_Kori=BVG_Kori+BVF_Kori;
BV_Kori_cst=BVG_Kori_cst+BVF_Kori_cst;
BV_Vobs=BVG_Vobs+BVF_Vobs;
BV_Vobs_cst=BVG_Vobs_cst+BVF_Vobs_cst;
BV_Tfield_nc=BVG_Tfield_nc+BVF_Tfield_nc;
BV_Tfield_nc_cst=BVG_Tfield_nc_cst+BVF_Tfield_nc_cst;
BV_Tfield_c=BVG_Tfield_c+BVF_Tfield_c;
BV_Tfield_c_cst=BVG_Tfield_c_cst+BVF_Tfield_c_cst;

% ------------------------------------------------------------------------%
%                       Geothermal heat flow                              %
% ------------------------------------------------------------------------%

% ------------ Fraction of temperate basal conditions ------------------- %
Prop_HF1=[Prop_HySSAE_MAR_HF1; Prop_HySSAE_RACMO_HF1; Prop_HySSAE_cst_MAR_HF1; Prop_HySSAE_cst_RACMO_HF1;...
          Prop_HySSA_MAR_HF1; Prop_HySSA_RACMO_HF1; Prop_HySSA_cst_MAR_HF1; Prop_HySSA_cst_RACMO_HF1;...
          Prop_Vobs_MAR_HF1; Prop_Vobs_RACMO_HF1; Prop_Vobs_cst_MAR_HF1; Prop_Vobs_cst_RACMO_HF1;...
          Prop_Tfield_nc_MAR_HF1; Prop_Tfield_nc_RACMO_HF1; Prop_Tfield_nc_cst_MAR_HF1; Prop_Tfield_nc_cst_RACMO_HF1;...
          Prop_Tfield_c_MAR_HF1; Prop_Tfield_c_RACMO_HF1; Prop_Tfield_c_cst_MAR_HF1; Prop_Tfield_c_cst_RACMO_HF1];

Prop_HF2=[Prop_HySSAE_MAR_HF2; Prop_HySSAE_RACMO_HF2; Prop_HySSAE_cst_MAR_HF2; Prop_HySSAE_cst_RACMO_HF2;...
          Prop_HySSA_MAR_HF2; Prop_HySSA_RACMO_HF2; Prop_HySSA_cst_MAR_HF2; Prop_HySSA_cst_RACMO_HF2;...
          Prop_Vobs_MAR_HF2; Prop_Vobs_RACMO_HF2; Prop_Vobs_cst_MAR_HF2; Prop_Vobs_cst_RACMO_HF2;...
          Prop_Tfield_nc_MAR_HF2; Prop_Tfield_nc_RACMO_HF2; Prop_Tfield_nc_cst_MAR_HF2; Prop_Tfield_nc_cst_RACMO_HF2;...
          Prop_Tfield_c_MAR_HF2; Prop_Tfield_c_RACMO_HF2; Prop_Tfield_c_cst_MAR_HF2; Prop_Tfield_c_cst_RACMO_HF2];

Prop_HF3=[Prop_HySSAE_MAR_HF3; Prop_HySSAE_RACMO_HF3; Prop_HySSAE_cst_MAR_HF3; Prop_HySSAE_cst_RACMO_HF3;...
          Prop_HySSA_MAR_HF3; Prop_HySSA_RACMO_HF3; Prop_HySSA_cst_MAR_HF3; Prop_HySSA_cst_RACMO_HF3;...
          Prop_Vobs_MAR_HF3; Prop_Vobs_RACMO_HF3; Prop_Vobs_cst_MAR_HF3; Prop_Vobs_cst_RACMO_HF3;...
          Prop_Tfield_nc_MAR_HF3; Prop_Tfield_nc_RACMO_HF3; Prop_Tfield_nc_cst_MAR_HF3; Prop_Tfield_nc_cst_RACMO_HF3;...
          Prop_Tfield_c_MAR_HF3; Prop_Tfield_c_RACMO_HF3; Prop_Tfield_c_cst_MAR_HF3; Prop_Tfield_c_cst_RACMO_HF3];

Prop_HF4=[Prop_HySSAE_MAR_HF4; Prop_HySSAE_RACMO_HF4; Prop_HySSAE_cst_MAR_HF4; Prop_HySSAE_cst_RACMO_HF4;...
          Prop_HySSA_MAR_HF4; Prop_HySSA_RACMO_HF4; Prop_HySSA_cst_MAR_HF4; Prop_HySSA_cst_RACMO_HF4;...
          Prop_Vobs_MAR_HF4; Prop_Vobs_RACMO_HF4; Prop_Vobs_cst_MAR_HF4; Prop_Vobs_cst_RACMO_HF4;...
          Prop_Tfield_nc_MAR_HF4; Prop_Tfield_nc_RACMO_HF4; Prop_Tfield_nc_cst_MAR_HF4; Prop_Tfield_nc_cst_RACMO_HF4;...
          Prop_Tfield_c_MAR_HF4; Prop_Tfield_c_RACMO_HF4; Prop_Tfield_c_cst_MAR_HF4; Prop_Tfield_c_cst_RACMO_HF4];

Prop_HF5=[Prop_HySSAE_MAR_HF5; Prop_HySSAE_RACMO_HF5; Prop_HySSAE_cst_MAR_HF5; Prop_HySSAE_cst_RACMO_HF5;...
          Prop_HySSA_MAR_HF5; Prop_HySSA_RACMO_HF5; Prop_HySSA_cst_MAR_HF5; Prop_HySSA_cst_RACMO_HF5;...
          Prop_Vobs_MAR_HF5; Prop_Vobs_RACMO_HF5; Prop_Vobs_cst_MAR_HF5; Prop_Vobs_cst_RACMO_HF5;...
          Prop_Tfield_nc_MAR_HF5; Prop_Tfield_nc_RACMO_HF5; Prop_Tfield_nc_cst_MAR_HF5; Prop_Tfield_nc_cst_RACMO_HF5;...
          Prop_Tfield_c_MAR_HF5; Prop_Tfield_c_RACMO_HF5; Prop_Tfield_c_cst_MAR_HF5; Prop_Tfield_c_cst_RACMO_HF5];

Prop_HF6=[Prop_HySSAE_MAR_HF6; Prop_HySSAE_RACMO_HF6; Prop_HySSAE_cst_MAR_HF6; Prop_HySSAE_cst_RACMO_HF6;...
          Prop_HySSA_MAR_HF6; Prop_HySSA_RACMO_HF6; Prop_HySSA_cst_MAR_HF6; Prop_HySSA_cst_RACMO_HF6;...
          Prop_Vobs_MAR_HF6; Prop_Vobs_RACMO_HF6; Prop_Vobs_cst_MAR_HF6; Prop_Vobs_cst_RACMO_HF6;...
          Prop_Tfield_nc_MAR_HF6; Prop_Tfield_nc_RACMO_HF6; Prop_Tfield_nc_cst_MAR_HF6; Prop_Tfield_nc_cst_RACMO_HF6;...
          Prop_Tfield_c_MAR_HF6; Prop_Tfield_c_RACMO_HF6; Prop_Tfield_c_cst_MAR_HF6; Prop_Tfield_c_cst_RACMO_HF6];

Prop_HF7=[Prop_HySSAE_MAR_HF7; Prop_HySSAE_RACMO_HF7; Prop_HySSAE_cst_MAR_HF7; Prop_HySSAE_cst_RACMO_HF7;...
          Prop_HySSA_MAR_HF7; Prop_HySSA_RACMO_HF7; Prop_HySSA_cst_MAR_HF7; Prop_HySSA_cst_RACMO_HF7;...
          Prop_Vobs_MAR_HF7; Prop_Vobs_RACMO_HF7; Prop_Vobs_cst_MAR_HF7; Prop_Vobs_cst_RACMO_HF7;...
          Prop_Tfield_nc_MAR_HF7; Prop_Tfield_nc_RACMO_HF7; Prop_Tfield_nc_cst_MAR_HF7; Prop_Tfield_nc_cst_RACMO_HF7;...
          Prop_Tfield_c_MAR_HF7; Prop_Tfield_c_RACMO_HF7; Prop_Tfield_c_cst_MAR_HF7; Prop_Tfield_c_cst_RACMO_HF7];

Prop_HF8=[Prop_HySSAE_MAR_HF8; Prop_HySSAE_RACMO_HF8; Prop_HySSAE_cst_MAR_HF8; Prop_HySSAE_cst_RACMO_HF8;...
          Prop_HySSA_MAR_HF8; Prop_HySSA_RACMO_HF8; Prop_HySSA_cst_MAR_HF8; Prop_HySSA_cst_RACMO_HF8;...
          Prop_Vobs_MAR_HF8; Prop_Vobs_RACMO_HF8; Prop_Vobs_cst_MAR_HF8; Prop_Vobs_cst_RACMO_HF8;...
          Prop_Tfield_nc_MAR_HF8; Prop_Tfield_nc_RACMO_HF8; Prop_Tfield_nc_cst_MAR_HF8; Prop_Tfield_nc_cst_RACMO_HF8;...
          Prop_Tfield_c_MAR_HF8; Prop_Tfield_c_RACMO_HF8; Prop_Tfield_c_cst_MAR_HF8; Prop_Tfield_c_cst_RACMO_HF8];

Prop_HF9=[Prop_HySSAE_MAR_HF9; Prop_HySSAE_RACMO_HF9; Prop_HySSAE_cst_MAR_HF9; Prop_HySSAE_cst_RACMO_HF9;...
          Prop_HySSA_MAR_HF9; Prop_HySSA_RACMO_HF9; Prop_HySSA_cst_MAR_HF9; Prop_HySSA_cst_RACMO_HF9;...
          Prop_Vobs_MAR_HF9; Prop_Vobs_RACMO_HF9; Prop_Vobs_cst_MAR_HF9; Prop_Vobs_cst_RACMO_HF9;...
          Prop_Tfield_nc_MAR_HF9; Prop_Tfield_nc_RACMO_HF9; Prop_Tfield_nc_cst_MAR_HF9; Prop_Tfield_nc_cst_RACMO_HF9;...
          Prop_Tfield_c_MAR_HF9; Prop_Tfield_c_RACMO_HF9; Prop_Tfield_c_cst_MAR_HF9; Prop_Tfield_c_cst_RACMO_HF9];

% ---------- Volume of subglacial water from geothermal heat  -----------
BVG_HF1=[BVG_HySSAE_MAR_HF1; BVG_HySSAE_RACMO_HF1; BVG_HySSAE_cst_MAR_HF1; BVG_HySSAE_cst_RACMO_HF1;...
          BVG_HySSA_MAR_HF1; BVG_HySSA_RACMO_HF1; BVG_HySSA_cst_MAR_HF1; BVG_HySSA_cst_RACMO_HF1;...
          BVG_Vobs_MAR_HF1; BVG_Vobs_RACMO_HF1; BVG_Vobs_cst_MAR_HF1; BVG_Vobs_cst_RACMO_HF1;...
          BVG_Tfield_nc_MAR_HF1; BVG_Tfield_nc_RACMO_HF1; BVG_Tfield_nc_cst_MAR_HF1; BVG_Tfield_nc_cst_RACMO_HF1;...
          BVG_Tfield_c_MAR_HF1; BVG_Tfield_c_RACMO_HF1; BVG_Tfield_c_cst_MAR_HF1; BVG_Tfield_c_cst_RACMO_HF1];

BVG_HF2=[BVG_HySSAE_MAR_HF2; BVG_HySSAE_RACMO_HF2; BVG_HySSAE_cst_MAR_HF2; BVG_HySSAE_cst_RACMO_HF2;...
          BVG_HySSA_MAR_HF2; BVG_HySSA_RACMO_HF2; BVG_HySSA_cst_MAR_HF2; BVG_HySSA_cst_RACMO_HF2;...
          BVG_Vobs_MAR_HF2; BVG_Vobs_RACMO_HF2; BVG_Vobs_cst_MAR_HF2; BVG_Vobs_cst_RACMO_HF2;...
          BVG_Tfield_nc_MAR_HF2; BVG_Tfield_nc_RACMO_HF2; BVG_Tfield_nc_cst_MAR_HF2; BVG_Tfield_nc_cst_RACMO_HF2;...
          BVG_Tfield_c_MAR_HF2; BVG_Tfield_c_RACMO_HF2; BVG_Tfield_c_cst_MAR_HF2; BVG_Tfield_c_cst_RACMO_HF2];

BVG_HF3=[BVG_HySSAE_MAR_HF3; BVG_HySSAE_RACMO_HF3; BVG_HySSAE_cst_MAR_HF3; BVG_HySSAE_cst_RACMO_HF3;...
          BVG_HySSA_MAR_HF3; BVG_HySSA_RACMO_HF3; BVG_HySSA_cst_MAR_HF3; BVG_HySSA_cst_RACMO_HF3;...
          BVG_Vobs_MAR_HF3; BVG_Vobs_RACMO_HF3; BVG_Vobs_cst_MAR_HF3; BVG_Vobs_cst_RACMO_HF3;...
          BVG_Tfield_nc_MAR_HF3; BVG_Tfield_nc_RACMO_HF3; BVG_Tfield_nc_cst_MAR_HF3; BVG_Tfield_nc_cst_RACMO_HF3;...
          BVG_Tfield_c_MAR_HF3; BVG_Tfield_c_RACMO_HF3; BVG_Tfield_c_cst_MAR_HF3; BVG_Tfield_c_cst_RACMO_HF3];

BVG_HF4=[BVG_HySSAE_MAR_HF4; BVG_HySSAE_RACMO_HF4; BVG_HySSAE_cst_MAR_HF4; BVG_HySSAE_cst_RACMO_HF4;...
          BVG_HySSA_MAR_HF4; BVG_HySSA_RACMO_HF4; BVG_HySSA_cst_MAR_HF4; BVG_HySSA_cst_RACMO_HF4;...
          BVG_Vobs_MAR_HF4; BVG_Vobs_RACMO_HF4; BVG_Vobs_cst_MAR_HF4; BVG_Vobs_cst_RACMO_HF4;...
          BVG_Tfield_nc_MAR_HF4; BVG_Tfield_nc_RACMO_HF4; BVG_Tfield_nc_cst_MAR_HF4; BVG_Tfield_nc_cst_RACMO_HF4;...
          BVG_Tfield_c_MAR_HF4; BVG_Tfield_c_RACMO_HF4; BVG_Tfield_c_cst_MAR_HF4; BVG_Tfield_c_cst_RACMO_HF4];

BVG_HF5=[BVG_HySSAE_MAR_HF5; BVG_HySSAE_RACMO_HF5; BVG_HySSAE_cst_MAR_HF5; BVG_HySSAE_cst_RACMO_HF5;...
          BVG_HySSA_MAR_HF5; BVG_HySSA_RACMO_HF5; BVG_HySSA_cst_MAR_HF5; BVG_HySSA_cst_RACMO_HF5;...
          BVG_Vobs_MAR_HF5; BVG_Vobs_RACMO_HF5; BVG_Vobs_cst_MAR_HF5; BVG_Vobs_cst_RACMO_HF5;...
          BVG_Tfield_nc_MAR_HF5; BVG_Tfield_nc_RACMO_HF5; BVG_Tfield_nc_cst_MAR_HF5; BVG_Tfield_nc_cst_RACMO_HF5;...
          BVG_Tfield_c_MAR_HF5; BVG_Tfield_c_RACMO_HF5; BVG_Tfield_c_cst_MAR_HF5; BVG_Tfield_c_cst_RACMO_HF5];

BVG_HF6=[BVG_HySSAE_MAR_HF6; BVG_HySSAE_RACMO_HF6; BVG_HySSAE_cst_MAR_HF6; BVG_HySSAE_cst_RACMO_HF6;...
          BVG_HySSA_MAR_HF6; BVG_HySSA_RACMO_HF6; BVG_HySSA_cst_MAR_HF6; BVG_HySSA_cst_RACMO_HF6;...
          BVG_Vobs_MAR_HF6; BVG_Vobs_RACMO_HF6; BVG_Vobs_cst_MAR_HF6; BVG_Vobs_cst_RACMO_HF6;...
          BVG_Tfield_nc_MAR_HF6; BVG_Tfield_nc_RACMO_HF6; BVG_Tfield_nc_cst_MAR_HF6; BVG_Tfield_nc_cst_RACMO_HF6;...
          BVG_Tfield_c_MAR_HF6; BVG_Tfield_c_RACMO_HF6; BVG_Tfield_c_cst_MAR_HF6; BVG_Tfield_c_cst_RACMO_HF6];

BVG_HF7=[BVG_HySSAE_MAR_HF7; BVG_HySSAE_RACMO_HF7; BVG_HySSAE_cst_MAR_HF7; BVG_HySSAE_cst_RACMO_HF7;...
          BVG_HySSA_MAR_HF7; BVG_HySSA_RACMO_HF7; BVG_HySSA_cst_MAR_HF7; BVG_HySSA_cst_RACMO_HF7;...
          BVG_Vobs_MAR_HF7; BVG_Vobs_RACMO_HF7; BVG_Vobs_cst_MAR_HF7; BVG_Vobs_cst_RACMO_HF7;...
          BVG_Tfield_nc_MAR_HF7; BVG_Tfield_nc_RACMO_HF7; BVG_Tfield_nc_cst_MAR_HF7; BVG_Tfield_nc_cst_RACMO_HF7;...
          BVG_Tfield_c_MAR_HF7; BVG_Tfield_c_RACMO_HF7; BVG_Tfield_c_cst_MAR_HF7; BVG_Tfield_c_cst_RACMO_HF7];

BVG_HF8=[BVG_HySSAE_MAR_HF8; BVG_HySSAE_RACMO_HF8; BVG_HySSAE_cst_MAR_HF8; BVG_HySSAE_cst_RACMO_HF8;...
          BVG_HySSA_MAR_HF8; BVG_HySSA_RACMO_HF8; BVG_HySSA_cst_MAR_HF8; BVG_HySSA_cst_RACMO_HF8;...
          BVG_Vobs_MAR_HF8; BVG_Vobs_RACMO_HF8; BVG_Vobs_cst_MAR_HF8; BVG_Vobs_cst_RACMO_HF8;...
          BVG_Tfield_nc_MAR_HF8; BVG_Tfield_nc_RACMO_HF8; BVG_Tfield_nc_cst_MAR_HF8; BVG_Tfield_nc_cst_RACMO_HF8;...
          BVG_Tfield_c_MAR_HF8; BVG_Tfield_c_RACMO_HF8; BVG_Tfield_c_cst_MAR_HF8; BVG_Tfield_c_cst_RACMO_HF8];

BVG_HF9=[BVG_HySSAE_MAR_HF9; BVG_HySSAE_RACMO_HF9; BVG_HySSAE_cst_MAR_HF9; BVG_HySSAE_cst_RACMO_HF9;...
          BVG_HySSA_MAR_HF9; BVG_HySSA_RACMO_HF9; BVG_HySSA_cst_MAR_HF9; BVG_HySSA_cst_RACMO_HF9;...
          BVG_Vobs_MAR_HF9; BVG_Vobs_RACMO_HF9; BVG_Vobs_cst_MAR_HF9; BVG_Vobs_cst_RACMO_HF9;...
          BVG_Tfield_nc_MAR_HF9; BVG_Tfield_nc_RACMO_HF9; BVG_Tfield_nc_cst_MAR_HF9; BVG_Tfield_nc_cst_RACMO_HF9;...
          BVG_Tfield_c_MAR_HF9; BVG_Tfield_c_RACMO_HF9; BVG_Tfield_c_cst_MAR_HF9; BVG_Tfield_c_cst_RACMO_HF9];

% -------- Volume of subglacial water from frictional heat  -------------
BVF_HF1=[BVF_HySSAE_MAR_HF1; BVF_HySSAE_RACMO_HF1; BVF_HySSAE_cst_MAR_HF1; BVF_HySSAE_cst_RACMO_HF1;...
          BVF_HySSA_MAR_HF1; BVF_HySSA_RACMO_HF1; BVF_HySSA_cst_MAR_HF1; BVF_HySSA_cst_RACMO_HF1;...
          BVF_Vobs_MAR_HF1; BVF_Vobs_RACMO_HF1; BVF_Vobs_cst_MAR_HF1; BVF_Vobs_cst_RACMO_HF1;...
          BVF_Tfield_nc_MAR_HF1; BVF_Tfield_nc_RACMO_HF1; BVF_Tfield_nc_cst_MAR_HF1; BVF_Tfield_nc_cst_RACMO_HF1;...
          BVF_Tfield_c_MAR_HF1; BVF_Tfield_c_RACMO_HF1; BVF_Tfield_c_cst_MAR_HF1; BVF_Tfield_c_cst_RACMO_HF1];

BVF_HF2=[BVF_HySSAE_MAR_HF2; BVF_HySSAE_RACMO_HF2; BVF_HySSAE_cst_MAR_HF2; BVF_HySSAE_cst_RACMO_HF2;...
          BVF_HySSA_MAR_HF2; BVF_HySSA_RACMO_HF2; BVF_HySSA_cst_MAR_HF2; BVF_HySSA_cst_RACMO_HF2;...
          BVF_Vobs_MAR_HF2; BVF_Vobs_RACMO_HF2; BVF_Vobs_cst_MAR_HF2; BVF_Vobs_cst_RACMO_HF2;...
          BVF_Tfield_nc_MAR_HF2; BVF_Tfield_nc_RACMO_HF2; BVF_Tfield_nc_cst_MAR_HF2; BVF_Tfield_nc_cst_RACMO_HF2;...
          BVF_Tfield_c_MAR_HF2; BVF_Tfield_c_RACMO_HF2; BVF_Tfield_c_cst_MAR_HF2; BVF_Tfield_c_cst_RACMO_HF2];

BVF_HF3=[BVF_HySSAE_MAR_HF3; BVF_HySSAE_RACMO_HF3; BVF_HySSAE_cst_MAR_HF3; BVF_HySSAE_cst_RACMO_HF3;...
          BVF_HySSA_MAR_HF3; BVF_HySSA_RACMO_HF3; BVF_HySSA_cst_MAR_HF3; BVF_HySSA_cst_RACMO_HF3;...
          BVF_Vobs_MAR_HF3; BVF_Vobs_RACMO_HF3; BVF_Vobs_cst_MAR_HF3; BVF_Vobs_cst_RACMO_HF3;...
          BVF_Tfield_nc_MAR_HF3; BVF_Tfield_nc_RACMO_HF3; BVF_Tfield_nc_cst_MAR_HF3; BVF_Tfield_nc_cst_RACMO_HF3;...
          BVF_Tfield_c_MAR_HF3; BVF_Tfield_c_RACMO_HF3; BVF_Tfield_c_cst_MAR_HF3; BVF_Tfield_c_cst_RACMO_HF3];

BVF_HF4=[BVF_HySSAE_MAR_HF4; BVF_HySSAE_RACMO_HF4; BVF_HySSAE_cst_MAR_HF4; BVF_HySSAE_cst_RACMO_HF4;...
          BVF_HySSA_MAR_HF4; BVF_HySSA_RACMO_HF4; BVF_HySSA_cst_MAR_HF4; BVF_HySSA_cst_RACMO_HF4;...
          BVF_Vobs_MAR_HF4; BVF_Vobs_RACMO_HF4; BVF_Vobs_cst_MAR_HF4; BVF_Vobs_cst_RACMO_HF4;...
          BVF_Tfield_nc_MAR_HF4; BVF_Tfield_nc_RACMO_HF4; BVF_Tfield_nc_cst_MAR_HF4; BVF_Tfield_nc_cst_RACMO_HF4;...
          BVF_Tfield_c_MAR_HF4; BVF_Tfield_c_RACMO_HF4; BVF_Tfield_c_cst_MAR_HF4; BVF_Tfield_c_cst_RACMO_HF4];

BVF_HF5=[BVF_HySSAE_MAR_HF5; BVF_HySSAE_RACMO_HF5; BVF_HySSAE_cst_MAR_HF5; BVF_HySSAE_cst_RACMO_HF5;...
          BVF_HySSA_MAR_HF5; BVF_HySSA_RACMO_HF5; BVF_HySSA_cst_MAR_HF5; BVF_HySSA_cst_RACMO_HF5;...
          BVF_Vobs_MAR_HF5; BVF_Vobs_RACMO_HF5; BVF_Vobs_cst_MAR_HF5; BVF_Vobs_cst_RACMO_HF5;...
          BVF_Tfield_nc_MAR_HF5; BVF_Tfield_nc_RACMO_HF5; BVF_Tfield_nc_cst_MAR_HF5; BVF_Tfield_nc_cst_RACMO_HF5;...
          BVF_Tfield_c_MAR_HF5; BVF_Tfield_c_RACMO_HF5; BVF_Tfield_c_cst_MAR_HF5; BVF_Tfield_c_cst_RACMO_HF5];

BVF_HF6=[BVF_HySSAE_MAR_HF6; BVF_HySSAE_RACMO_HF6; BVF_HySSAE_cst_MAR_HF6; BVF_HySSAE_cst_RACMO_HF6;...
          BVF_HySSA_MAR_HF6; BVF_HySSA_RACMO_HF6; BVF_HySSA_cst_MAR_HF6; BVF_HySSA_cst_RACMO_HF6;...
          BVF_Vobs_MAR_HF6; BVF_Vobs_RACMO_HF6; BVF_Vobs_cst_MAR_HF6; BVF_Vobs_cst_RACMO_HF6;...
          BVF_Tfield_nc_MAR_HF6; BVF_Tfield_nc_RACMO_HF6; BVF_Tfield_nc_cst_MAR_HF6; BVF_Tfield_nc_cst_RACMO_HF6;...
          BVF_Tfield_c_MAR_HF6; BVF_Tfield_c_RACMO_HF6; BVF_Tfield_c_cst_MAR_HF6; BVF_Tfield_c_cst_RACMO_HF6];

BVF_HF7=[BVF_HySSAE_MAR_HF7; BVF_HySSAE_RACMO_HF7; BVF_HySSAE_cst_MAR_HF7; BVF_HySSAE_cst_RACMO_HF7;...
          BVF_HySSA_MAR_HF7; BVF_HySSA_RACMO_HF7; BVF_HySSA_cst_MAR_HF7; BVF_HySSA_cst_RACMO_HF7;...
          BVF_Vobs_MAR_HF7; BVF_Vobs_RACMO_HF7; BVF_Vobs_cst_MAR_HF7; BVF_Vobs_cst_RACMO_HF7;...
          BVF_Tfield_nc_MAR_HF7; BVF_Tfield_nc_RACMO_HF7; BVF_Tfield_nc_cst_MAR_HF7; BVF_Tfield_nc_cst_RACMO_HF7;...
          BVF_Tfield_c_MAR_HF7; BVF_Tfield_c_RACMO_HF7; BVF_Tfield_c_cst_MAR_HF7; BVF_Tfield_c_cst_RACMO_HF7];

BVF_HF8=[BVF_HySSAE_MAR_HF8; BVF_HySSAE_RACMO_HF8; BVF_HySSAE_cst_MAR_HF8; BVF_HySSAE_cst_RACMO_HF8;...
          BVF_HySSA_MAR_HF8; BVF_HySSA_RACMO_HF8; BVF_HySSA_cst_MAR_HF8; BVF_HySSA_cst_RACMO_HF8;...
          BVF_Vobs_MAR_HF8; BVF_Vobs_RACMO_HF8; BVF_Vobs_cst_MAR_HF8; BVF_Vobs_cst_RACMO_HF8;...
          BVF_Tfield_nc_MAR_HF8; BVF_Tfield_nc_RACMO_HF8; BVF_Tfield_nc_cst_MAR_HF8; BVF_Tfield_nc_cst_RACMO_HF8;...
          BVF_Tfield_c_MAR_HF8; BVF_Tfield_c_RACMO_HF8; BVF_Tfield_c_cst_MAR_HF8; BVF_Tfield_c_cst_RACMO_HF8];

BVF_HF9=[BVF_HySSAE_MAR_HF9; BVF_HySSAE_RACMO_HF9; BVF_HySSAE_cst_MAR_HF9; BVF_HySSAE_cst_RACMO_HF9;...
          BVF_HySSA_MAR_HF9; BVF_HySSA_RACMO_HF9; BVF_HySSA_cst_MAR_HF9; BVF_HySSA_cst_RACMO_HF9;...
          BVF_Vobs_MAR_HF9; BVF_Vobs_RACMO_HF9; BVF_Vobs_cst_MAR_HF9; BVF_Vobs_cst_RACMO_HF9;...
          BVF_Tfield_nc_MAR_HF9; BVF_Tfield_nc_RACMO_HF9; BVF_Tfield_nc_cst_MAR_HF9; BVF_Tfield_nc_cst_RACMO_HF9;...
          BVF_Tfield_c_MAR_HF9; BVF_Tfield_c_RACMO_HF9; BVF_Tfield_c_cst_MAR_HF9; BVF_Tfield_c_cst_RACMO_HF9];

% ------------------- Total volume of subglacial water ------------------ % 
BV_HF1=BVG_HF1+BVF_HF1;
BV_HF2=BVG_HF2+BVF_HF2;
BV_HF3=BVG_HF3+BVF_HF3;
BV_HF4=BVG_HF4+BVF_HF4;
BV_HF5=BVG_HF5+BVF_HF5;
BV_HF6=BVG_HF6+BVF_HF6;
BV_HF7=BVG_HF7+BVF_HF7;
BV_HF8=BVG_HF8+BVF_HF8;
BV_HF9=BVG_HF9+BVF_HF9;

% ------------------ Englacial drained water ---------------------------- %
DBW_HF1=[DBW_HySSAE_MAR_HF1; DBW_HySSAE_RACMO_HF1; DBW_HySSAE_cst_MAR_HF1; DBW_HySSAE_cst_RACMO_HF1];
DBW_HF2=[DBW_HySSAE_MAR_HF2; DBW_HySSAE_RACMO_HF2; DBW_HySSAE_cst_MAR_HF2; DBW_HySSAE_cst_RACMO_HF2];
DBW_HF3=[DBW_HySSAE_MAR_HF3; DBW_HySSAE_RACMO_HF3; DBW_HySSAE_cst_MAR_HF3; DBW_HySSAE_cst_RACMO_HF3];
DBW_HF4=[DBW_HySSAE_MAR_HF4; DBW_HySSAE_RACMO_HF4; DBW_HySSAE_cst_MAR_HF4; DBW_HySSAE_cst_RACMO_HF4];
DBW_HF5=[DBW_HySSAE_MAR_HF5; DBW_HySSAE_RACMO_HF5; DBW_HySSAE_cst_MAR_HF5; DBW_HySSAE_cst_RACMO_HF5];
DBW_HF6=[DBW_HySSAE_MAR_HF6; DBW_HySSAE_RACMO_HF6; DBW_HySSAE_cst_MAR_HF6; DBW_HySSAE_cst_RACMO_HF6];
DBW_HF7=[DBW_HySSAE_MAR_HF7; DBW_HySSAE_RACMO_HF7; DBW_HySSAE_cst_MAR_HF7; DBW_HySSAE_cst_RACMO_HF7];
DBW_HF8=[DBW_HySSAE_MAR_HF8; DBW_HySSAE_RACMO_HF8; DBW_HySSAE_cst_MAR_HF8; DBW_HySSAE_cst_RACMO_HF8];
DBW_HF9=[DBW_HySSAE_MAR_HF9; DBW_HySSAE_RACMO_HF9; DBW_HySSAE_cst_MAR_HF9; DBW_HySSAE_cst_RACMO_HF9];

DBW_KoriE=[DBW_HySSAE_MAR_HF1; DBW_HySSAE_RACMO_HF1; DBW_HySSAE_MAR_HF2; DBW_HySSAE_RACMO_HF2; ...
           DBW_HySSAE_MAR_HF4; DBW_HySSAE_RACMO_HF4; DBW_HySSAE_MAR_HF3; DBW_HySSAE_RACMO_HF3; ...
           DBW_HySSAE_MAR_HF6; DBW_HySSAE_RACMO_HF6; DBW_HySSAE_MAR_HF7; DBW_HySSAE_RACMO_HF7; ...
           DBW_HySSAE_MAR_HF9; DBW_HySSAE_RACMO_HF9; ...
           DBW_HySSAE_MAR_HF8; DBW_HySSAE_RACMO_HF8; DBW_HySSAE_MAR_HF5; DBW_HySSAE_RACMO_HF5];
 
DBW_KoriE_cst=[DBW_HySSAE_cst_MAR_HF1; DBW_HySSAE_cst_RACMO_HF1; DBW_HySSAE_cst_MAR_HF2; DBW_HySSAE_cst_RACMO_HF2; ...
               DBW_HySSAE_cst_MAR_HF4; DBW_HySSAE_cst_RACMO_HF4; DBW_HySSAE_cst_MAR_HF3; DBW_HySSAE_cst_RACMO_HF3; ...
               DBW_HySSAE_cst_MAR_HF6; DBW_HySSAE_cst_RACMO_HF6; DBW_HySSAE_cst_MAR_HF7; DBW_HySSAE_cst_RACMO_HF7; ...
               DBW_HySSAE_cst_MAR_HF9; DBW_HySSAE_cst_RACMO_HF9; ...
               DBW_HySSAE_cst_MAR_HF8; DBW_HySSAE_cst_RACMO_HF8; DBW_HySSAE_cst_MAR_HF5; DBW_HySSAE_cst_RACMO_HF5];

DBW_Kori=zeros(size(DBW_KoriE));
DBW_Kori_cst=zeros(size(DBW_KoriE));
DBW_Vobs=zeros(size(DBW_KoriE));
DBW_Vobs_cst=zeros(size(DBW_KoriE));
DBW_Tfield_nc=zeros(size(DBW_KoriE));
DBW_Tfield_nc_cst=zeros(size(DBW_KoriE));
DBW_Tfield_c=zeros(size(DBW_KoriE));
DBW_Tfield_c_cst=zeros(size(DBW_KoriE));

% ----------------------------- BOXPLOTS -------------------------------- % 

% Couleurs= [0 0 0.5; 0.00 0.4470 0.7410; 0.3010 0.7450 0.9330; 0.9200 0.8400 0.7300; 0.9290 0.6940 0.1250; 0.8500 0.3250 0.0980; 0.83,0.12,0.25; 0.5 0 0]; 
Couleurs2=[0.5 0 0; 0.95,0.75,0.75 ; 0 0 0.5; 0.73,0.73,1.00; 0.3010 0.7450 0.9330; 0.69,0.84,0.99; 0.9290 0.6940 0.1250; 1.00,0.89,0.63; 0.84,0.43,0.05; 1.00,0.82,0.64];
Couleurs3=[0.3010 0.7450 0.9330; 0.9290 0.6940 0.1250];
Couleurs1=brewermap(10-2,'*RdYlBu');
Couleurs=[0 0 0.5; Couleurs1(1:3,:); Couleurs1(5:8,:); 0.5 0 0];

Modelname={'Kori-ULB Enth';'Kori-ULB Enth cst'; ...
           'Kori-ULB Opt';'Kori-ULB Opt cst'; ...
           'Kori-ULB Obs';'Kori-ULB Obs cst'; ...
           'Uncalibrated model (Pattyn,2010)';'Uncalibrated model (Pattyn,2010) cst'; ...
           'Calibrated model (Pattyn,2010)' ;'Calibrated model (Pattyn,2010) cst'};

% -------------------------------------------------------------------------
f=figure;
set(f,'Position',[29.0000   50.2000  844.4000  835.6000])

t2 = tiledlayout(4,2); 
t2.TileSpacing = 'Tight';

% -------------------------------------------------------------------------
nexttile(t2,1,[1 1])
data=[Prop_HF1,Prop_HF2,Prop_HF4,Prop_HF3,Prop_HF6,Prop_HF7,Prop_HF9,Prop_HF8,Prop_HF5];

for i=1:9
b = boxchart(i * ones(size(data, 1), 1), data(:, i)); hold on
b.BoxFaceColor = Couleurs(i, :); 
b.MarkerColor = Couleurs(i,:);
b.MarkerSize = 3;

text(i,-1,num2str(round(mean(data(:,i)))),'VerticalAlignment','top','HorizontalAlignment','center','FontSize',9);
text(i,min(data(:,i)),num2str(round(min(data(:,i)),1)),'VerticalAlignment','top','HorizontalAlignment','center','FontSize',7);
text(i,max(data(:,i)),num2str(round(max(data(:,i)),1)),'VerticalAlignment','bottom','HorizontalAlignment','center','FontSize',7);
end
text(0,-1,'Mean:','VerticalAlignment','top','HorizontalAlignment','right','FontSize',9)
ylabel({'Fraction of temperate'; 'basal conditions (%)';' '},'FontSize',11);
xticks([1 2 3 4 5 6 7 8 9 10])
xticklabels({' ',' ',' ',' ',' ',' ',' ',' ',' ',' '}); 
ylim([0 100])

b2 = boxchart(10 * ones(size(data(:),1),1), data(:)); hold on
b2.BoxFaceColor = [17 17 17]/255;
b2.MarkerColor =  [17 17 17]/255;
b2.MarkerSize = 3;
text(10,-1,num2str(round(mean(data(:)))),'VerticalAlignment','top','HorizontalAlignment','center','FontSize',9,'FontWeight','Bold');
text(10,min(data(:)),num2str(round(min(data(:)),1)),'VerticalAlignment','top','HorizontalAlignment','center','FontSize',7);
text(10,max(data(:)),num2str(round(max(data(:)),1)),'VerticalAlignment','bottom','HorizontalAlignment','center','FontSize',7);
grid on

text(0.25,100,'a','FontSize',12)

% -------------------------------------------------------------------------
nexttile(t2,2,[1 1])
data=[Prop_KoriE,Prop_KoriE_cst,Prop_Kori,Prop_Kori_cst,Prop_Vobs,Prop_Vobs_cst,Prop_Tfield_nc,Prop_Tfield_nc_cst,Prop_Tfield_c,Prop_Tfield_c_cst];

for i=1:10
b = boxchart(i * ones(size(data, 1), 1), data(:, i)); hold on
b.BoxFaceColor = Couleurs2(i, :); 
b.MarkerColor = Couleurs2(i,:);
b.MarkerSize = 3;

text(i,-1,num2str(round(mean(data(:,i)))),'VerticalAlignment','top','HorizontalAlignment','center','FontSize',9); 
text(i,min(data(:,i)),num2str(round(min(data(:,i)),1)),'VerticalAlignment','top','HorizontalAlignment','center','FontSize',7);
text(i,max(data(:,i)),num2str(round(max(data(:,i)),1)),'VerticalAlignment','bottom','HorizontalAlignment','center','FontSize',7);
end
text(0,-1,'Mean:','VerticalAlignment','top','HorizontalAlignment','right','FontSize',9)
% ylabel({'Fraction of temperate'; 'basal conditions (%)';' '},'FontSize',11);
xticks([1 2 3 4 5 6 7 8 9 10 11])
xticklabels({' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' '}); 
ylim([0 100])
grid on

b2 = boxchart(11 * ones(size(data(:),1),1), data(:)); hold on
b2.BoxFaceColor = [17 17 17]/255;
b2.MarkerColor =  [17 17 17]/255;
b2.MarkerSize = 3;
text(11,-1,num2str(round(mean(data(:)))),'VerticalAlignment','top','HorizontalAlignment','center','FontSize',9,'FontWeight','Bold');
text(11,min(data(:)),num2str(round(min(data(:)),1)),'VerticalAlignment','top','HorizontalAlignment','center','FontSize',7);
text(11,max(data(:)),num2str(round(max(data(:)),1)),'VerticalAlignment','bottom','HorizontalAlignment','center','FontSize',7);

text(0.25,100,'b','FontSize',12)

% -------------------------------------------------------------------------
nexttile(t2,3,[1 1])
data=[BV_HF1,BV_HF2,BV_HF4,BV_HF3,BV_HF6,BV_HF7,BV_HF9,BV_HF8,BV_HF5];

for i=1:9
b = boxchart(i * ones(size(data, 1), 1), data(:, i)); hold on
b.BoxFaceColor = Couleurs(i, :); 
b.MarkerColor = Couleurs(i,:);
b.MarkerSize = 3;

text(i,min(data(:))-10,num2str(round(mean(data(:,i)))),'VerticalAlignment','top','HorizontalAlignment','center','FontSize',9);
text(i,min(data(:,i)),num2str(round(min(data(:,i)),1)),'VerticalAlignment','top','HorizontalAlignment','center','FontSize',7);
text(i,max(data(:,i)),num2str(round(max(data(:,i)),1)),'VerticalAlignment','bottom','HorizontalAlignment','center','FontSize',7);
end
text(0,min(data(:))-10,'Mean:','VerticalAlignment','top','HorizontalAlignment','right','FontSize',9)
ylabel({'Subglacial'; 'meltwater (Gt a^{-1})';' '},'FontSize',11);
xticks([1 2 3 4 5 6 7 8 9 10])
xticklabels({' ',' ',' ',' ',' ',' ',' ',' ',' ',' '}); 
ylim([min(data(:))-10 max(data(:))+10])

b2 = boxchart(10 * ones(size(data(:),1),1), data(:)); hold on
b2.BoxFaceColor = [17 17 17]/255;
b2.MarkerColor =  [17 17 17]/255;
b2.MarkerSize = 3;
text(10,min(data(:))-10,num2str(round(mean(data(:)))),'VerticalAlignment','top','HorizontalAlignment','center','FontSize',9,'FontWeight','Bold');
text(10,min(data(:)),num2str(round(min(data(:)),1)),'VerticalAlignment','top','HorizontalAlignment','center','FontSize',7);
text(10,max(data(:)),num2str(round(max(data(:)),1)),'VerticalAlignment','bottom','HorizontalAlignment','center','FontSize',7);
grid on

text(0.25,max(data(:))+10,'c','FontSize',12)

% -------------------------------------------------------------------------
nexttile(t2,4,[1 1])
data=[BV_KoriE,BV_KoriE_cst,BV_Kori,BV_Kori_cst,BV_Vobs,BV_Vobs_cst,BV_Tfield_nc,BV_Tfield_nc_cst,BV_Tfield_c,BV_Tfield_c_cst];

for i=1:10
b = boxchart(i * ones(size(data, 1), 1), data(:, i)); hold on
b.BoxFaceColor = Couleurs2(i, :); 
b.MarkerColor = Couleurs2(i,:);
b.MarkerSize = 3;

text(i,min(data(:))-10,num2str(round(mean(data(:,i)))),'VerticalAlignment','top','HorizontalAlignment','center','FontSize',9);
text(i,min(data(:,i)),num2str(round(min(data(:,i)),1)),'VerticalAlignment','top','HorizontalAlignment','center','FontSize',7);
text(i,max(data(:,i)),num2str(round(max(data(:,i)),1)),'VerticalAlignment','bottom','HorizontalAlignment','center','FontSize',7);
end
text(0,min(data(:))-10,'Mean:','VerticalAlignment','top','HorizontalAlignment','right','FontSize',9)
% ylabel({'Subglacial'; 'meltwater (Gt a^{-1})';' '},'FontSize',11);
xticks([1 2 3 4 5 6 7 8 9 10 11])
xticklabels({' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' '}); 
ylim([min(data(:))-10 max(data(:))+10])

b2 = boxchart(11 * ones(size(data(:),1),1), data(:)); hold on
b2.BoxFaceColor = [17 17 17]/255;
b2.MarkerColor =  [17 17 17]/255;
b2.MarkerSize = 3;
text(11,min(data(:))-10,num2str(round(mean(data(:)))),'VerticalAlignment','top','HorizontalAlignment','center','FontSize',9,'FontWeight','Bold');
text(11,min(data(:)),num2str(round(min(data(:)),1)),'VerticalAlignment','top','HorizontalAlignment','center','FontSize',7);
text(11,max(data(:)),num2str(round(max(data(:)),1)),'VerticalAlignment','bottom','HorizontalAlignment','center','FontSize',7);
grid on

text(0.25,max(data(:))+10,'d','FontSize',12)

% -------------------------------------------------------------------------
nexttile(t2,5,[1 1])
data=[BVG_HF1,BVG_HF2,BVG_HF4,BVG_HF3,BVG_HF6,BVG_HF7,BVG_HF9,BVG_HF8,BVG_HF5];

for i=1:9
b = boxchart(i * ones(size(data, 1), 1), data(:, i)); hold on
b.BoxFaceColor = Couleurs(i, :); 
b.MarkerColor = Couleurs(i,:);
b.MarkerSize = 3;

text(i,min(data(:))-10,num2str(round(mean(data(:,i)))),'VerticalAlignment','top','HorizontalAlignment','center','FontSize',9);
text(i,min(data(:,i)),num2str(round(min(data(:,i)),1)),'VerticalAlignment','top','HorizontalAlignment','center','FontSize',7);
text(i,max(data(:,i)),num2str(round(max(data(:,i)),1)),'VerticalAlignment','bottom','HorizontalAlignment','center','FontSize',7);
end
text(0,min(data(:))-10,'Mean:','VerticalAlignment','top','HorizontalAlignment','right','FontSize',9)
ylabel({'Geothermal heat'; 'contribution (Gt a^{-1})';' '},'FontSize',11);
xticks([1 2 3 4 5 6 7 8 9 10])
xticklabels({' ',' ',' ',' ',' ',' ',' ',' ',' ',' '}); 
ylim([min(data(:))-10 max(data(:))+10])

b2 = boxchart(10 * ones(size(data(:),1),1), data(:)); hold on
b2.BoxFaceColor = [17 17 17]/255;
b2.MarkerColor =  [17 17 17]/255;
b2.MarkerSize = 3;
text(10,min(data(:))-10,num2str(round(mean(data(:)))),'VerticalAlignment','top','HorizontalAlignment','center','FontSize',9,'FontWeight','Bold');
text(10,min(data(:)),num2str(round(min(data(:)),1)),'VerticalAlignment','top','HorizontalAlignment','center','FontSize',7);
text(10,max(data(:)),num2str(round(max(data(:)),1)),'VerticalAlignment','bottom','HorizontalAlignment','center','FontSize',7);
grid on

text(0.25,max(data(:))+10,'e','FontSize',12)

% -------------------------------------------------------------------------
nexttile(t2,6,[1 1])
data=[BVG_KoriE,BVG_KoriE_cst,BVG_Kori,BVG_Kori_cst,BVG_Vobs,BVG_Vobs_cst,BVG_Tfield_nc,BVG_Tfield_nc_cst,BVG_Tfield_c,BVG_Tfield_c_cst];

for i=1:10
b = boxchart(i * ones(size(data, 1), 1), data(:, i)); hold on
b.BoxFaceColor = Couleurs2(i, :); 
b.MarkerColor = Couleurs2(i,:);
b.MarkerSize = 3;

text(i,min(data(:))-10,num2str(round(mean(data(:,i)))),'VerticalAlignment','top','HorizontalAlignment','center','FontSize',9);
text(i,min(data(:,i)),num2str(round(min(data(:,i)),1)),'VerticalAlignment','top','HorizontalAlignment','center','FontSize',7);
text(i,max(data(:,i)),num2str(round(max(data(:,i)),1)),'VerticalAlignment','bottom','HorizontalAlignment','center','FontSize',7);
end
text(0,min(data(:))-10,'Mean:','VerticalAlignment','top','HorizontalAlignment','right','FontSize',9)
% ylabel({'Geothermal heat';'contribution (Gt a^{-1})';' '},'FontSize',11);
xticks([1 2 3 4 5 6 7 8 9 10 11])
xticklabels({' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' '}); 
ylim([min(data(:))-10 max(data(:))+10])

b2 = boxchart(11 * ones(size(data(:),1),1), data(:)); hold on
b2.BoxFaceColor = [17 17 17]/255;
b2.MarkerColor =  [17 17 17]/255;
b2.MarkerSize = 3;
text(11,min(data(:))-10,num2str(round(mean(data(:)))),'VerticalAlignment','top','HorizontalAlignment','center','FontSize',9,'FontWeight','Bold');
text(11,min(data(:)),num2str(round(min(data(:)),1)),'VerticalAlignment','top','HorizontalAlignment','center','FontSize',7);
text(11,max(data(:)),num2str(round(max(data(:)),1)),'VerticalAlignment','bottom','HorizontalAlignment','center','FontSize',7);
grid on

text(0.25,max(data(:))+10,'f','FontSize',12)

% -------------------------------------------------------------------------
nexttile(t2,7,[1 1])

data=[BVF_HF1,BVF_HF2,BVF_HF4,BVF_HF3,BVF_HF6,BVF_HF7,BVF_HF9,BVF_HF8,BVF_HF5];
 
for i=1:9
b = boxchart(i * ones(size(data, 1), 1), data(:, i)); hold on
b.BoxFaceColor = Couleurs(i, :); 
b.MarkerColor = Couleurs(i,:);
b.MarkerSize = 3;

text(i,min(data(:))-10,num2str(round(mean(data(:,i)))),'VerticalAlignment','top','HorizontalAlignment','center','FontSize',9);
text(i,min(data(:,i)),num2str(round(min(data(:,i)),1)),'VerticalAlignment','top','HorizontalAlignment','center','FontSize',7);
text(i,max(data(:,i)),num2str(round(max(data(:,i)),1)),'VerticalAlignment','bottom','HorizontalAlignment','center','FontSize',7);
end
text(0,min(data(:))-10,'Mean:','VerticalAlignment','top','HorizontalAlignment','right','FontSize',9)
ylabel({'Frictional heat'; 'contribution (Gt a^{-1})';' '},'FontSize',11);
xticks([1 2 3 4 5 6 7 8 9 10])
xticklabels({' ',' ',' ',' ',' ',' ',' ',' ',' ',' '}); 
ylim([min(data(:))-10 max(data(:))+10])

b2 = boxchart(10 * ones(size(data(:),1),1), data(:)); hold on
b2.BoxFaceColor = [17 17 17]/255;
b2.MarkerColor =  [17 17 17]/255;
b2.MarkerSize = 3;
text(10,min(data(:))-10,num2str(round(mean(data(:)))),'VerticalAlignment','top','HorizontalAlignment','center','FontSize',9,'FontWeight','Bold');
text(10,min(data(:)),num2str(round(min(data(:)),1)),'VerticalAlignment','top','HorizontalAlignment','center','FontSize',7);
text(10,max(data(:)),num2str(round(max(data(:)),1)),'VerticalAlignment','bottom','HorizontalAlignment','center','FontSize',7);
grid on

text(0.25,max(data(:))+10,'g','FontSize',12)

lg2=legend([GHFOrder,'Ensemble']);
title(lg2,'Geothermal heat flow datasets')
lg2.FontSize = 9;
% lg2.Layout.Tile = 9;
lg2.Location='Southoutside';

% -------------------------------------------------------------------------
nexttile(t2,8,[1 1])

data=[BVF_KoriE,BVF_KoriE_cst,BVF_Kori,BVF_Kori_cst,BVF_Vobs,BVF_Vobs_cst,BVF_Tfield_nc,BVF_Tfield_nc_cst,BVF_Tfield_c,BVF_Tfield_c_cst];

for i=1:10
b = boxchart(i * ones(size(data, 1), 1), data(:, i)); hold on
b.BoxFaceColor = Couleurs2(i, :); 
b.MarkerColor = Couleurs2(i,:);
b.MarkerSize = 3;

text(i,min(data(:))-10,num2str(round(mean(data(:,i)))),'VerticalAlignment','top','HorizontalAlignment','center','FontSize',9);
text(i,min(data(:,i)),num2str(round(min(data(:,i)),1)),'VerticalAlignment','top','HorizontalAlignment','center','FontSize',7);
text(i,max(data(:,i)),num2str(round(max(data(:,i)),1)),'VerticalAlignment','bottom','HorizontalAlignment','center','FontSize',7);
end
text(0,min(data(:))-10,'Mean:','VerticalAlignment','top','HorizontalAlignment','right','FontSize',9)
ylabel(' ');
% ylabel({'Frictional heat';'contribution (Gt a^{-1})';' '},'FontSize',11);
xticks([1 2 3 4 5 6 7 8 9 10 11])
xticklabels({' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' '}); 
ylim([min(data(:))-10 max(data(:))+10])

b2 = boxchart(11 * ones(size(data(:),1),1), data(:)); hold on
b2.BoxFaceColor = [17 17 17]/255;
b2.MarkerColor =  [17 17 17]/255;
b2.MarkerSize = 3;
text(11,min(data(:))-10,num2str(round(mean(data(:)))),'VerticalAlignment','top','HorizontalAlignment','center','FontSize',9,'FontWeight','Bold');
text(11,min(data(:)),num2str(round(min(data(:)),1)),'VerticalAlignment','top','HorizontalAlignment','center','FontSize',7);
text(11,max(data(:)),num2str(round(max(data(:)),1)),'VerticalAlignment','bottom','HorizontalAlignment','center','FontSize',7);
grid on

text(0.25,max(data(:))+10,'h','FontSize',12)

lg=legend([Modelname;'Ensemble']);
title(lg,'Modelling approaches')
lg.FontSize = 9;
% lg.Layout.Tile = 10;
lg.Location='Southoutside';
set(lg,'Position',[0.574940191205222,0.025530556885272,0.294410237696768,0.215055055033938])
end


if Figure6==1 | Figure5==1 
% Data processing for the comparison with observational constraints
Couleurs2=[0.5 0 0; 0.95,0.75,0.75 ; 0 0 0.5; 0.73,0.73,1.00; 0.3010 0.7450 0.9330; 0.69,0.84,0.99; 0.9290 0.6940 0.1250; 1.00,0.89,0.63; 0.84,0.43,0.05; 1.00,0.82,0.64];

% Location of temperature profiles in x,y coordinates (km)
% load ProfilsTxy.mat
xSP=2804; ySP=2804;
xKH=2806; yKH=4443;
xDF=3688; yDF=3868;
xDC=4163; yDC=1908;
xVK=4009; yVK=2439;
xLD=5162; yLD=1813;
xTD=3287; yTD=1564;
xSC=2336; ySC=2031;
xBY=1858; yBY=2268;
xWA=1741; yWA=2373;

% --------------------- Modelling approaches ---------------------------- %

% Load RMSE for temperature profiles
load RMSEProfilsT_2024.mat

RMSEKORIE=RMSE_HySSAE;
RMSEKORIE_cst=RMSE_HySSAE_cst;
RMSEKORI=RMSE_HySSA;
RMSEKORI_cst=RMSE_HySSA_cst;
RMSEVOBS=RMSE_Vobs;
RMSEVOBS_cst=RMSE_Vobs_cst;
RMSETFIELDNC=RMSE_Tfield_nc;
RMSETFIELDNC_cst=RMSE_Tfield_nc_cst;
RMSETFIELDC=RMSE_Tfield_c;
RMSETFIELDC_cst=RMSE_Tfield_c_cst;

% mean for all profile
RMSE_KoriE=mean(RMSEKORIE);
RMSE_KoriE_cst=mean(RMSEKORIE_cst);
RMSE_Kori=mean(RMSEKORI);
RMSE_Kori_cst=mean(RMSEKORI_cst);
RMSE_Vobs=mean(RMSEVOBS);
RMSE_Vobs_cst=mean(RMSEVOBS_cst);
RMSE_Tfield_nc=mean(RMSETFIELDNC);
RMSE_Tfield_nc_cst=mean(RMSETFIELDNC_cst);
RMSE_Tfield_c=mean(RMSETFIELDC);
RMSE_Tfield_c_cst=mean(RMSETFIELDC_cst);

% mean for each profile
RMSE_Temp_Mean=(mean(RMSEKORIE,2)+mean(RMSEKORIE_cst,2)+...
                mean(RMSEKORI,2)+mean(RMSEKORI_cst,2)+...
                mean(RMSEVOBS,2)+mean(RMSEVOBS_cst,2)+...
                mean(RMSETFIELDNC,2)+mean(RMSETFIELDNC_cst,2)+...
                mean(RMSETFIELDC,2)+mean(RMSETFIELDC_cst,2))./10;

xtemp=[xSP; xKH; xVK; xDF; xDC; xSC; xLD; xTD; xBY; xWA];
ytemp=[ySP; yKH; yVK; yDF; yDC; ySC; yLD; yTD; yBY; yWA];

load RMSE_SMOS_2024.mat

RMSE_SMOS_KoriE=RMSE_SMOS_HySSAE;
RMSE_SMOS_KoriE_cst=RMSE_SMOS_HySSAE_cst;
RMSE_SMOS_Kori=RMSE_SMOS_HySSA;
RMSE_SMOS_Kori_cst=RMSE_SMOS_HySSA_cst;

load RMSE_Lakes_2024.mat
load Sublakes.mat 'xlakes' 'ylakes'

RMSE_Lakes_KoriE=RMSE_Lakes_HySSAE;
RMSE_Lakes_KoriE_cst=RMSE_Lakes_HySSAE_cst;
RMSE_Lakes_Kori=RMSE_Lakes_HySSA;
RMSE_Lakes_Kori_cst=RMSE_Lakes_HySSA_cst;


% Min/Max
temp_HF1=[mean(RMSEKORIE(:,1:2)),mean(RMSEKORIE_cst(:,1:2)),...
          mean(RMSEKORI(:,1:2)),mean(RMSEKORI_cst(:,1:2)),...
          mean(RMSEVOBS(:,1:2)),mean(RMSEVOBS_cst(:,1:2)),...
          mean(RMSETFIELDNC(:,1:2)),mean(RMSETFIELDNC_cst(:,1:2)),...
          mean(RMSETFIELDC(:,1:2)),mean(RMSETFIELDC_cst(:,1:2))];

temp_HF2=[mean(RMSEKORIE(:,3:4)),mean(RMSEKORIE_cst(:,3:4)),...
          mean(RMSEKORI(:,3:4)),mean(RMSEKORI_cst(:,3:4)),...
          mean(RMSEVOBS(:,3:4)),mean(RMSEVOBS_cst(:,3:4)),...
          mean(RMSETFIELDNC(:,3:4)),mean(RMSETFIELDNC_cst(:,3:4)),...
          mean(RMSETFIELDC(:,3:4)),mean(RMSETFIELDC_cst(:,3:4))];

temp_HF3=[mean(RMSEKORIE(:,5:6)),mean(RMSEKORIE_cst(:,5:6)),...
          mean(RMSEKORI(:,5:6)),mean(RMSEKORI_cst(:,5:6)),...
          mean(RMSEVOBS(:,5:6)),mean(RMSEVOBS_cst(:,5:6)),...
          mean(RMSETFIELDNC(:,5:6)),mean(RMSETFIELDNC_cst(:,5:6)),...
          mean(RMSETFIELDC(:,5:6)),mean(RMSETFIELDC_cst(:,5:6))];

temp_HF4=[mean(RMSEKORIE(:,7:8)),mean(RMSEKORIE_cst(:,7:8)),...
         mean(RMSEKORI(:,7:8)),mean(RMSEKORI_cst(:,7:8)),...
         mean(RMSEVOBS(:,7:8)),mean(RMSEVOBS_cst(:,7:8)),...
         mean(RMSETFIELDNC(:,7:8)),mean(RMSETFIELDNC_cst(:,7:8)),...
         mean(RMSETFIELDC(:,7:8)),mean(RMSETFIELDC_cst(:,7:8))];

temp_HF5=[mean(RMSEKORIE(:,9:10)),mean(RMSEKORIE_cst(:,9:10)),...
          mean(RMSEKORI(:,9:10)),mean(RMSEKORI_cst(:,9:10)),...
          mean(RMSEVOBS(:,9:10)),mean(RMSEVOBS_cst(:,9:10)),...
          mean(RMSETFIELDNC(:,9:10)),mean(RMSETFIELDNC_cst(:,9:10)),...
          mean(RMSETFIELDC(:,9:10)),mean(RMSETFIELDC_cst(:,9:10))];

temp_HF6=[mean(RMSEKORIE(:,11:12)),mean(RMSEKORIE_cst(:,11:12)),...
          mean(RMSEKORI(:,11:12)),mean(RMSEKORI_cst(:,11:12)),...
          mean(RMSEVOBS(:,11:12)),mean(RMSEVOBS_cst(:,11:12)),...
          mean(RMSETFIELDNC(:,11:12)),mean(RMSETFIELDNC_cst(:,11:12)),...
          mean(RMSETFIELDC(:,11:12)),mean(RMSETFIELDC_cst(:,11:12))];

temp_HF7=[mean(RMSEKORIE(:,13:14)),mean(RMSEKORIE_cst(:,13:14)),...
          mean(RMSEKORI(:,13:14)),mean(RMSEKORI_cst(:,13:14)),...
          mean(RMSEVOBS(:,13:14)),mean(RMSEVOBS_cst(:,13:14)),...
          mean(RMSETFIELDNC(:,13:14)),mean(RMSETFIELDNC_cst(:,13:14)),...
          mean(RMSETFIELDC(:,13:14)),mean(RMSETFIELDC_cst(:,13:14))];

temp_HF8=[mean(RMSEKORIE(:,15:16)),mean(RMSEKORIE_cst(:,15:16)),...
          mean(RMSEKORI(:,15:16)),mean(RMSEKORI_cst(:,15:16)),...
          mean(RMSEVOBS(:,15:16)),mean(RMSEVOBS_cst(:,15:16)),...
          mean(RMSETFIELDNC(:,15:16)),mean(RMSETFIELDNC_cst(:,15:16)),...
          mean(RMSETFIELDC(:,15:16)),mean(RMSETFIELDC_cst(:,15:16))];

temp_HF9=[mean(RMSEKORIE(:,17:18)),mean(RMSEKORIE_cst(:,17:18)),...
          mean(RMSEKORI(:,17:18)),mean(RMSEKORI_cst(:,17:18)),...
          mean(RMSEVOBS(:,17:18)),mean(RMSEVOBS_cst(:,17:18)),...
          mean(RMSETFIELDNC(:,17:18)),mean(RMSETFIELDNC_cst(:,17:18)),...
          mean(RMSETFIELDC(:,17:18)),mean(RMSETFIELDC_cst(:,17:18))];

MIN_temp_HF1=min(temp_HF1); MIN_temp_HF2=min(temp_HF2);
MIN_temp_HF3=min(temp_HF3); MIN_temp_HF4=min(temp_HF4);
MIN_temp_HF5=min(temp_HF5); MIN_temp_HF6=min(temp_HF6);
MIN_temp_HF7=min(temp_HF7); MIN_temp_HF8=min(temp_HF8);
MIN_temp_HF9=min(temp_HF9); 

MAX_temp_HF1=max(temp_HF1); MAX_temp_HF2=max(temp_HF2);
MAX_temp_HF3=max(temp_HF3); MAX_temp_HF4=max(temp_HF4);
MAX_temp_HF5=max(temp_HF5); MAX_temp_HF6=max(temp_HF6);
MAX_temp_HF7=max(temp_HF7); MAX_temp_HF8=max(temp_HF8);
MAX_temp_HF9=max(temp_HF9); 


SMOS_HF1=[RMSE_SMOS_KoriE(1:2),RMSE_SMOS_KoriE_cst(1:2),...
          RMSE_SMOS_Kori(1:2),RMSE_SMOS_Kori_cst(1:2),...
          RMSE_SMOS_Vobs(1:2),RMSE_SMOS_Vobs_cst(1:2),...
          RMSE_SMOS_Tfield_nc(1:2),RMSE_SMOS_Tfield_nc_cst(1:2),...
          RMSE_SMOS_Tfield_c(1:2),RMSE_SMOS_Tfield_c_cst(1:2)];

SMOS_HF2=[RMSE_SMOS_KoriE(3:4),RMSE_SMOS_KoriE_cst(3:4),...
          RMSE_SMOS_Kori(3:4),RMSE_SMOS_Kori_cst(3:4),...
          RMSE_SMOS_Vobs(3:4),RMSE_SMOS_Vobs_cst(3:4),...
          RMSE_SMOS_Tfield_nc(3:4),RMSE_SMOS_Tfield_nc_cst(3:4),...
          RMSE_SMOS_Tfield_c(3:4),RMSE_SMOS_Tfield_c_cst(3:4)];

SMOS_HF3=[RMSE_SMOS_KoriE(5:6),RMSE_SMOS_KoriE_cst(5:6),...
          RMSE_SMOS_Kori(5:6),RMSE_SMOS_Kori_cst(5:6),...
          RMSE_SMOS_Vobs(5:6),RMSE_SMOS_Vobs_cst(5:6),...
          RMSE_SMOS_Tfield_nc(5:6),RMSE_SMOS_Tfield_nc_cst(5:6),...
          RMSE_SMOS_Tfield_c(5:6),RMSE_SMOS_Tfield_c_cst(5:6)];

SMOS_HF4=[RMSE_SMOS_KoriE(7:8),RMSE_SMOS_KoriE_cst(7:8),...
          RMSE_SMOS_Kori(7:8),RMSE_SMOS_Kori_cst(7:8),...
          RMSE_SMOS_Vobs(7:8),RMSE_SMOS_Vobs_cst(7:8),...
          RMSE_SMOS_Tfield_nc(7:8),RMSE_SMOS_Tfield_nc_cst(7:8),...
          RMSE_SMOS_Tfield_c(7:8),RMSE_SMOS_Tfield_c_cst(7:8)];

SMOS_HF5=[RMSE_SMOS_KoriE(9:10),RMSE_SMOS_KoriE_cst(9:10),...
          RMSE_SMOS_Kori(9:10),RMSE_SMOS_Kori_cst(9:10),...
          RMSE_SMOS_Vobs(9:10),RMSE_SMOS_Vobs_cst(9:10),...
          RMSE_SMOS_Tfield_nc(9:10),RMSE_SMOS_Tfield_nc_cst(9:10),...
          RMSE_SMOS_Tfield_c(9:10),RMSE_SMOS_Tfield_c_cst(9:10)];

SMOS_HF6=[RMSE_SMOS_KoriE(11:12),RMSE_SMOS_KoriE_cst(11:12),...
          RMSE_SMOS_Kori(11:12),RMSE_SMOS_Kori_cst(11:12),...
          RMSE_SMOS_Vobs(11:12),RMSE_SMOS_Vobs_cst(11:12),...
          RMSE_SMOS_Tfield_nc(11:12),RMSE_SMOS_Tfield_nc_cst(11:12),...
          RMSE_SMOS_Tfield_c(11:12),RMSE_SMOS_Tfield_c_cst(11:12)];

SMOS_HF7=[RMSE_SMOS_KoriE(13:14),RMSE_SMOS_KoriE_cst(13:14),...
          RMSE_SMOS_Kori(13:14),RMSE_SMOS_Kori_cst(13:14),...
          RMSE_SMOS_Vobs(13:14),RMSE_SMOS_Vobs_cst(13:14),...
          RMSE_SMOS_Tfield_nc(13:14),RMSE_SMOS_Tfield_nc_cst(13:14),...
          RMSE_SMOS_Tfield_c(13:14),RMSE_SMOS_Tfield_c_cst(13:14)];

SMOS_HF8=[RMSE_SMOS_KoriE(15:16),RMSE_SMOS_KoriE_cst(15:16),...
          RMSE_SMOS_Kori(15:16),RMSE_SMOS_Kori_cst(15:16),...
          RMSE_SMOS_Vobs(15:16),RMSE_SMOS_Vobs_cst(15:16),...
          RMSE_SMOS_Tfield_nc(15:16),RMSE_SMOS_Tfield_nc_cst(15:16),...
          RMSE_SMOS_Tfield_c(15:16),RMSE_SMOS_Tfield_c_cst(15:16)];

SMOS_HF9=[RMSE_SMOS_KoriE(17:18),RMSE_SMOS_KoriE_cst(17:18),...
          RMSE_SMOS_Kori(17:18),RMSE_SMOS_Kori_cst(17:18),...
          RMSE_SMOS_Vobs(17:18),RMSE_SMOS_Vobs_cst(17:18),...
          RMSE_SMOS_Tfield_nc(17:18),RMSE_SMOS_Tfield_nc_cst(17:18),...
          RMSE_SMOS_Tfield_c(17:18),RMSE_SMOS_Tfield_c_cst(17:18)];

MIN_SMOS_HF1=min(SMOS_HF1); MIN_SMOS_HF2=min(SMOS_HF2);
MIN_SMOS_HF3=min(SMOS_HF3); MIN_SMOS_HF4=min(SMOS_HF4);
MIN_SMOS_HF5=min(SMOS_HF5); MIN_SMOS_HF6=min(SMOS_HF6);
MIN_SMOS_HF7=min(SMOS_HF7); MIN_SMOS_HF8=min(SMOS_HF8);
MIN_SMOS_HF9=min(SMOS_HF9); 

MAX_SMOS_HF1=max(SMOS_HF1); MAX_SMOS_HF2=max(SMOS_HF2);
MAX_SMOS_HF3=max(SMOS_HF3); MAX_SMOS_HF4=max(SMOS_HF4);
MAX_SMOS_HF5=max(SMOS_HF5); MAX_SMOS_HF6=max(SMOS_HF6);
MAX_SMOS_HF7=max(SMOS_HF7); MAX_SMOS_HF8=max(SMOS_HF8);
MAX_SMOS_HF9=max(SMOS_HF9); 

Lakes_HF1=[RMSE_Lakes_KoriE(1:2),RMSE_Lakes_KoriE_cst(1:2),...
           RMSE_Lakes_Kori(1:2),RMSE_Lakes_Kori_cst(1:2),...
           RMSE_Lakes_Vobs(1:2),RMSE_Lakes_Vobs_cst(1:2),...
           RMSE_Lakes_Tfield_nc(1:2),RMSE_Lakes_Tfield_nc_cst(1:2),...
           RMSE_Lakes_Tfield_c(1:2),RMSE_Lakes_Tfield_c_cst(1:2)];

Lakes_HF2=[RMSE_Lakes_KoriE(3:4),RMSE_Lakes_KoriE_cst(3:4),...
          RMSE_Lakes_Kori(3:4),RMSE_Lakes_Kori_cst(3:4),...
          RMSE_Lakes_Vobs(3:4),RMSE_Lakes_Vobs_cst(3:4),...
          RMSE_Lakes_Tfield_nc(3:4),RMSE_Lakes_Tfield_nc_cst(3:4),...
          RMSE_Lakes_Tfield_c(3:4),RMSE_Lakes_Tfield_c_cst(3:4)];

Lakes_HF3=[RMSE_Lakes_KoriE(5:6),RMSE_Lakes_KoriE_cst(5:6),...
          RMSE_Lakes_Kori(5:6),RMSE_Lakes_Kori_cst(5:6),...
          RMSE_Lakes_Vobs(5:6),RMSE_Lakes_Vobs_cst(5:6),...
          RMSE_Lakes_Tfield_nc(5:6),RMSE_Lakes_Tfield_nc_cst(5:6),...
          RMSE_Lakes_Tfield_c(5:6),RMSE_Lakes_Tfield_c_cst(5:6)];

Lakes_HF4=[RMSE_Lakes_KoriE(7:8),RMSE_Lakes_KoriE_cst(7:8),...
          RMSE_Lakes_Kori(7:8),RMSE_Lakes_Kori_cst(7:8),...
          RMSE_Lakes_Vobs(7:8),RMSE_Lakes_Vobs_cst(7:8),...
          RMSE_Lakes_Tfield_nc(7:8),RMSE_Lakes_Tfield_nc_cst(7:8),...
          RMSE_Lakes_Tfield_c(7:8),RMSE_Lakes_Tfield_c_cst(7:8)];

Lakes_HF5=[RMSE_Lakes_KoriE(9:10),RMSE_Lakes_KoriE_cst(9:10),...
           RMSE_Lakes_Kori(9:10),RMSE_Lakes_Kori_cst(9:10),...
           RMSE_Lakes_Vobs(9:10),RMSE_Lakes_Vobs_cst(9:10),...
           RMSE_Lakes_Tfield_nc(9:10),RMSE_Lakes_Tfield_nc_cst(9:10),...
           RMSE_Lakes_Tfield_c(9:10),RMSE_Lakes_Tfield_c_cst(9:10)];

Lakes_HF6=[RMSE_Lakes_KoriE(11:12),RMSE_Lakes_KoriE_cst(11:12),...
           RMSE_Lakes_Kori(11:12),RMSE_Lakes_Kori_cst(11:12),...
           RMSE_Lakes_Vobs(11:12),RMSE_Lakes_Vobs_cst(11:12),...
           RMSE_Lakes_Tfield_nc(11:12),RMSE_Lakes_Tfield_nc_cst(11:12),...
           RMSE_Lakes_Tfield_c(11:12),RMSE_Lakes_Tfield_c_cst(11:12)];

Lakes_HF7=[RMSE_Lakes_KoriE(13:14),RMSE_Lakes_KoriE_cst(13:14),...
           RMSE_Lakes_Kori(13:14),RMSE_Lakes_Kori_cst(13:14),...
           RMSE_Lakes_Vobs(13:14),RMSE_Lakes_Vobs_cst(13:14),...
           RMSE_Lakes_Tfield_nc(13:14),RMSE_Lakes_Tfield_nc_cst(13:14),...
           RMSE_Lakes_Tfield_c(13:14),RMSE_Lakes_Tfield_c_cst(13:14)];

Lakes_HF8=[RMSE_Lakes_KoriE(15:16),RMSE_Lakes_KoriE_cst(15:16),...
           RMSE_Lakes_Kori(15:16),RMSE_Lakes_Kori_cst(15:16),...
           RMSE_Lakes_Vobs(15:16),RMSE_Lakes_Vobs_cst(15:16),...
           RMSE_Lakes_Tfield_nc(15:16),RMSE_Lakes_Tfield_nc_cst(15:16),...
           RMSE_Lakes_Tfield_c(15:16),RMSE_Lakes_Tfield_c_cst(15:16)];

Lakes_HF9=[RMSE_Lakes_KoriE(17:18),RMSE_Lakes_KoriE_cst(17:18),...
          RMSE_Lakes_Kori(17:18),RMSE_Lakes_Kori_cst(17:18),...
          RMSE_Lakes_Vobs(17:18),RMSE_Lakes_Vobs_cst(17:18),...
          RMSE_Lakes_Tfield_nc(17:18),RMSE_Lakes_Tfield_nc_cst(17:18),...
          RMSE_Lakes_Tfield_c(17:18),RMSE_Lakes_Tfield_c_cst(17:18)];

MIN_Lakes_HF1=min(Lakes_HF1); MIN_Lakes_HF2=min(Lakes_HF2);
MIN_Lakes_HF3=min(Lakes_HF3); MIN_Lakes_HF4=min(Lakes_HF4);
MIN_Lakes_HF5=min(Lakes_HF5); MIN_Lakes_HF6=min(Lakes_HF6);
MIN_Lakes_HF7=min(Lakes_HF7); MIN_Lakes_HF8=min(Lakes_HF8);
MIN_Lakes_HF9=min(Lakes_HF9); 

MAX_Lakes_HF1=max(Lakes_HF1); MAX_Lakes_HF2=max(Lakes_HF2);
MAX_Lakes_HF3=max(Lakes_HF3); MAX_Lakes_HF4=max(Lakes_HF4);
MAX_Lakes_HF5=max(Lakes_HF5); MAX_Lakes_HF6=max(Lakes_HF6);
MAX_Lakes_HF7=max(Lakes_HF7); MAX_Lakes_HF8=max(Lakes_HF8);
MAX_Lakes_HF9=max(Lakes_HF9); 


% --------------------- Regional Climate Models ------------------------- %

% Temperatures profiles
RMSE_temp_MAR=(mean(RMSEKORIE(:,1:2:end),2)+mean(RMSEKORIE_cst(:,1:2:end),2)+...
               mean(RMSEKORI(:,1:2:end),2)+mean(RMSEKORI_cst(:,1:2:end),2)+...
               mean(RMSEVOBS(:,1:2:end),2)+mean(RMSEVOBS_cst(:,1:2:end),2)+...
               mean(RMSETFIELDNC(:,1:2:end),2)+mean(RMSETFIELDNC_cst(:,1:2:end),2)+...
               mean(RMSETFIELDC(:,1:2:end),2)+mean(RMSETFIELDC_cst(:,1:2:end),2))./10;

RMSE_temp_RACMO=(mean(RMSEKORIE(:,2:2:end),2)+mean(RMSEKORIE_cst(:,2:2:end),2)+...
                 mean(RMSEKORI(:,2:2:end),2)+mean(RMSEKORI_cst(:,2:2:end),2)+...
                 mean(RMSEVOBS(:,2:2:end),2)+mean(RMSEVOBS_cst(:,2:2:end),2)+...
                 mean(RMSETFIELDNC(:,2:2:end),2)+mean(RMSETFIELDNC_cst(:,2:2:end),2)+...
                 mean(RMSETFIELDC(:,2:2:end),2)+mean(RMSETFIELDC_cst(:,2:2:end),2))./10;

temp_MAR=[mean(RMSEKORIE(:,1:2:end)),mean(RMSEKORIE_cst(:,1:2:end)),...
          mean(RMSEKORI(:,1:2:end)),mean(RMSEKORI_cst(:,1:2:end)),...
          mean(RMSEVOBS(:,1:2:end)),mean(RMSEVOBS_cst(:,1:2:end)),...
          mean(RMSETFIELDNC(:,1:2:end)),mean(RMSETFIELDNC_cst(:,1:2:end)),...
          mean(RMSETFIELDC(:,1:2:end)),mean(RMSETFIELDC_cst(:,1:2:end))];

temp_RACMO=[mean(RMSEKORIE(:,2:2:end)),mean(RMSEKORIE_cst(:,2:2:end)),...
            mean(RMSEKORI(:,2:2:end)),mean(RMSEKORI_cst(:,2:2:end)),...
            mean(RMSEVOBS(:,2:2:end)),mean(RMSEVOBS_cst(:,2:2:end)),...
            mean(RMSETFIELDNC(:,2:2:end)),mean(RMSETFIELDNC_cst(:,2:2:end)),...
            mean(RMSETFIELDC(:,2:2:end)),mean(RMSETFIELDC_cst(:,2:2:end))];

MIN_temp_MAR=min(temp_MAR); 
MIN_temp_RACMO=min(temp_RACMO); 
MAX_temp_MAR=max(temp_MAR); 
MAX_temp_RACMO=max(temp_RACMO); 

% SMOS
RMSE_SMOS_MAR=(mean(RMSE_SMOS_KoriE(1,1:2:end),2)+mean(RMSE_SMOS_KoriE_cst(1,1:2:end),2)+...
               mean(RMSE_SMOS_Kori(1,1:2:end),2)+mean(RMSE_SMOS_Kori_cst(1,1:2:end),2)+...
               mean(RMSE_SMOS_Vobs(1,1:2:end),2)+mean(RMSE_SMOS_Vobs_cst(1,1:2:end),2)+...
               mean(RMSE_SMOS_Tfield_nc(1,1:2:end),2)+mean(RMSE_SMOS_Tfield_nc_cst(1,1:2:end),2)+...
               mean(RMSE_SMOS_Tfield_c(1,1:2:end),2)+mean(RMSE_SMOS_Tfield_c_cst(1,1:2:end),2))./10;

RMSE_SMOS_RACMO=(mean(RMSE_SMOS_KoriE(1,2:2:end),2)+mean(RMSE_SMOS_KoriE_cst(1,2:2:end),2)+...
                 mean(RMSE_SMOS_Kori(1,2:2:end),2)+mean(RMSE_SMOS_Kori_cst(1,2:2:end),2)+...
                 mean(RMSE_SMOS_Vobs(1,2:2:end),2)+mean(RMSE_SMOS_Vobs_cst(1,2:2:end),2)+...
                 mean(RMSE_SMOS_Tfield_nc(1,2:2:end),2)+mean(RMSE_SMOS_Tfield_nc_cst(1,2:2:end),2)+...
                 mean(RMSE_SMOS_Tfield_c(1,2:2:end),2)+mean(RMSE_SMOS_Tfield_c_cst(1,2:2:end),2))./10;

SMOS_MAR=[RMSE_SMOS_KoriE(1:2:end),RMSE_SMOS_KoriE_cst(1:2:end),...
          RMSE_SMOS_Kori(1:2:end),RMSE_SMOS_Kori_cst(1:2:end),...
          RMSE_SMOS_Vobs(1:2:end),RMSE_SMOS_Vobs_cst(1:2:end),...
          RMSE_SMOS_Tfield_nc(1:2:end),RMSE_SMOS_Tfield_nc_cst(1:2:end),...
          RMSE_SMOS_Tfield_c(1:2:end),RMSE_SMOS_Tfield_c_cst(1:2:end)];

SMOS_RACMO=[RMSE_SMOS_KoriE(2:2:end),RMSE_SMOS_KoriE_cst(2:2:end),...
            RMSE_SMOS_Kori(2:2:end),RMSE_SMOS_Kori_cst(2:2:end),...
            RMSE_SMOS_Vobs(2:2:end),RMSE_SMOS_Vobs_cst(2:2:end),...
            RMSE_SMOS_Tfield_nc(2:2:end),RMSE_SMOS_Tfield_nc_cst(2:2:end),...
            RMSE_SMOS_Tfield_c(2:2:end),RMSE_SMOS_Tfield_c_cst(2:2:end)];

MIN_SMOS_MAR=min(SMOS_MAR); 
MIN_SMOS_RACMO=min(SMOS_RACMO);
MAX_SMOS_MAR=max(SMOS_MAR); 
MAX_SMOS_RACMO=max(SMOS_RACMO);

% Subglacial lakes
Lakes_MAR=[RMSE_Lakes_KoriE(1:2:end),RMSE_Lakes_KoriE_cst(1:2:end),...
           RMSE_Lakes_Kori(1:2:end),RMSE_Lakes_Kori_cst(1:2:end),...
           RMSE_Lakes_Vobs(1:2:end),RMSE_Lakes_Vobs_cst(1:2:end),...
           RMSE_Lakes_Tfield_nc(1:2:end),RMSE_Lakes_Tfield_nc_cst(1:2:end),...
           RMSE_Lakes_Tfield_c(1:2:end),RMSE_Lakes_Tfield_c_cst(1:2:end)];

Lakes_RACMO=[RMSE_Lakes_KoriE(2:2:end),RMSE_Lakes_KoriE_cst(2:2:end),...
             RMSE_Lakes_Kori(2:2:end),RMSE_Lakes_Kori_cst(2:2:end),...
             RMSE_Lakes_Vobs(2:2:end),RMSE_Lakes_Vobs_cst(2:2:end),...
             RMSE_Lakes_Tfield_nc(2:2:end),RMSE_Lakes_Tfield_nc_cst(2:2:end),...
             RMSE_Lakes_Tfield_c(2:2:end),RMSE_Lakes_Tfield_c_cst(2:2:end)];

MIN_Lakes_MAR=min(Lakes_MAR); 
MIN_Lakes_RACMO=min(Lakes_RACMO);
MAX_Lakes_MAR=max(Lakes_MAR); 
MAX_Lakes_RACMO=max(Lakes_RACMO);

clear min; clear max;
end

if Figure6==1

f=figure;
set(f,'Position',[scrsz(1)+10  scrsz(2)+10  (scrsz(3)-9)*(2/3)  scrsz(4)-9])

t = tiledlayout(2,3);
t.TileSpacing = 'Tight';

% Colors and legend
Couleurs1=brewermap(10-2,'*RdYlBu');
Couleurs2=[0 0 0.5; Couleurs1(1:3,:); Couleurs1(5:8,:); 0.5 0 0];
Couleurs=[Couleurs2(1,:);Couleurs2(1,:);
          Couleurs2(2,:);Couleurs2(2,:);
          Couleurs2(4,:);Couleurs2(4,:);
          Couleurs2(3,:);Couleurs2(3,:);
          Couleurs2(9,:);Couleurs2(9,:);
          Couleurs2(5,:);Couleurs2(5,:);
          Couleurs2(6,:);Couleurs2(6,:);
          Couleurs2(8,:);Couleurs2(8,:);
          Couleurs2(7,:);Couleurs2(7,:)];

Symbols1={'s';'o';'d';'p';'h'};
Symbols2={'+';'^';'<';'>';'v'};

nexttile(t,1,[1 2])

y_minKoriE=min([RMSE_SMOS_KoriE'; RMSE_SMOS_KoriE_cst']);
y_maxKoriE=max([RMSE_SMOS_KoriE'; RMSE_SMOS_KoriE_cst']);
y_minKori=min([RMSE_SMOS_Kori'; RMSE_SMOS_Kori_cst']);
y_maxKori=max([RMSE_SMOS_Kori'; RMSE_SMOS_Kori_cst']);
y_minVobs=min([RMSE_SMOS_Vobs'; RMSE_SMOS_Vobs_cst']);
y_maxVobs=max([RMSE_SMOS_Vobs'; RMSE_SMOS_Vobs_cst']);
y_minTfield_nc=min([RMSE_SMOS_Tfield_nc'; RMSE_SMOS_Tfield_nc_cst']);
y_maxTfield_nc=max([RMSE_SMOS_Tfield_nc'; RMSE_SMOS_Tfield_nc_cst']);
y_minTfield_c=min([RMSE_SMOS_Tfield_c'; RMSE_SMOS_Tfield_c_cst']);
y_maxTfield_c=max([RMSE_SMOS_Tfield_c'; RMSE_SMOS_Tfield_c_cst']);

x_minKoriE=min([RMSE_KoriE'; RMSE_KoriE_cst']);
x_maxKoriE=max([RMSE_KoriE'; RMSE_KoriE_cst']);
x_minKori=min([RMSE_Kori'; RMSE_Kori_cst']);
x_maxKori=max([RMSE_Kori'; RMSE_Kori_cst']);
x_minVobs=min([RMSE_Vobs'; RMSE_Vobs_cst']);
x_maxVobs=max([RMSE_Vobs'; RMSE_Vobs_cst']);
x_minTfield_nc=min([RMSE_Tfield_nc'; RMSE_Tfield_nc_cst']);
x_maxTfield_nc=max([RMSE_Tfield_nc'; RMSE_Tfield_nc_cst']);
x_minTfield_c=min([RMSE_Tfield_c'; RMSE_Tfield_c_cst']);
x_maxTfield_c=max([RMSE_Tfield_c'; RMSE_Tfield_c_cst']);

hold on
rectangle('position',[x_minTfield_nc-0.15 y_minTfield_nc-0.15  x_maxTfield_nc-x_minTfield_nc+0.27 y_maxTfield_nc-y_minTfield_nc+0.3],'Linestyle','-.','FaceColor',Couleurs2(8,:),'FaceAlpha',0.);
rectangle('position',[x_minTfield_c-0.15  y_minTfield_c-0.15   x_maxTfield_c-x_minTfield_c+0.27   y_maxTfield_c-y_minTfield_c+0.3],'Linestyle','--','FaceColor',Couleurs2(1,:),'FaceAlpha',0.);
rectangle('position',[x_minKoriE-0.15     y_minKoriE-0.15      x_maxKoriE-x_minKoriE+0.27         y_maxKoriE-y_minKoriE+0.3],'Linestyle','-','EdgeColor',[0.50,0.50,0.50],'FaceColor',Couleurs2(2,:),'FaceAlpha',0.);
rectangle('position',[x_minKori-0.15      y_minKori-0.15       x_maxKori-x_minKori+0.27           y_maxKori-y_minKori+0.3],'Linestyle','-','FaceColor',Couleurs2(4,:),'FaceAlpha',0.);
rectangle('position',[x_minVobs-0.15      y_minVobs-0.15       x_maxVobs-x_minVobs+0.27           y_maxVobs-y_minVobs+0.3],'Linestyle',':','FaceColor',Couleurs2(6,:),'FaceAlpha',0.);

% Kori-ULB Enth
for i=1:2:18
    plot(RMSE_KoriE(i),RMSE_SMOS_KoriE(i),'s','Color',Couleurs(i,:),'MarkerFaceColor',Couleurs(i,:)); hold on;
end
for i=2:2:18
    plot(RMSE_KoriE(i),RMSE_SMOS_KoriE(i),'s','Color',Couleurs(i,:)); hold on;
end
for i=1:2:18
    plot(RMSE_KoriE_cst(i),RMSE_SMOS_KoriE_cst(i),'+','Color',Couleurs(i,:),'MarkerFaceColor',Couleurs(i,:),'linewidth',2); hold on;
end
for i=2:2:18
    plot(RMSE_KoriE_cst(i),RMSE_SMOS_KoriE_cst(i),'+','Color',Couleurs(i,:)); hold on;
end

% Kori-ULB Opt
pval=zeros(1,18);
for i=1:2:18
    p=plot(RMSE_Kori(i),RMSE_SMOS_Kori(i),'o','Color',Couleurs(i,:),'MarkerFaceColor',Couleurs(i,:)); hold on;
    pval(i)=p;
end
for i=2:2:18
    p=plot(RMSE_Kori(i),RMSE_SMOS_Kori(i),'o','Color',Couleurs(i,:)); hold on;
    pval(i)=p;
end
for i=1:2:18
    plot(RMSE_Kori_cst(i),RMSE_SMOS_Kori_cst(i),'^','Color',Couleurs(i,:),'MarkerFaceColor',Couleurs(i,:)); hold on;
end
for i=2:2:18
    plot(RMSE_Kori_cst(i),RMSE_SMOS_Kori_cst(i),'^','Color',Couleurs(i,:)); hold on;
end

p1=pval(1); p1r=pval(2);
p2=pval(3); p2r=pval(4);
p3=pval(5); p3r=pval(6);
p4=pval(7); p4r=pval(8);
p5=pval(9); p5r=pval(10);
p6=pval(11); p6r=pval(12);
p7=pval(13); p7r=pval(14);
p8=pval(15); p8r=pval(16);
p9=pval(17); p9r=pval(17);

p1b=plot(RMSE_Kori(1),RMSE_SMOS_Kori(1),'o','Color',Couleurs(1,:),'MarkerFaceColor',Couleurs(1,:)); hold on;
p1c=plot(RMSE_Kori(2),RMSE_SMOS_Kori(2),'o','Color',Couleurs(1,:)); hold on;

% Kori Obs
for i=1:2:18
    plot(RMSE_Vobs(i),RMSE_SMOS_Vobs(i),'d','Color',Couleurs(i,:),'MarkerFaceColor',Couleurs(i,:)); hold on;
end
for i=2:2:18
    plot(RMSE_Vobs(i),RMSE_SMOS_Vobs(i),'d','Color',Couleurs(i,:)); hold on;
end
for i=1:2:18
    plot(RMSE_Vobs_cst(i),RMSE_SMOS_Vobs_cst(i),'<','Color',Couleurs(i,:),'MarkerFaceColor',Couleurs(i,:)); hold on;
end
for i=2:2:18
    plot(RMSE_Vobs_cst(i),RMSE_SMOS_Vobs_cst(i),'<','Color',Couleurs(i,:)); hold on;
end


% Uncalibrated model of Pattyn (2010)
for i=1:2:18
    plot(RMSE_Tfield_nc(i),RMSE_SMOS_Tfield_nc(i),'p','Color',Couleurs(i,:),'MarkerFaceColor',Couleurs(i,:)); hold on;
end
for i=2:2:18
    plot(RMSE_Tfield_nc(i),RMSE_SMOS_Tfield_nc(i),'p','Color',Couleurs(i,:)); hold on;
end
for i=1:2:18
    plot(RMSE_Tfield_nc_cst(i),RMSE_SMOS_Tfield_nc_cst(i),'>','Color',Couleurs(i,:),'MarkerFaceColor',Couleurs(i,:)); hold on;
end
for i=2:2:18
    plot(RMSE_Tfield_nc_cst(i),RMSE_SMOS_Tfield_nc_cst(i),'>','Color',Couleurs(i,:)); hold on;
end

% Calibrated model of Pattyn (2010)
for i=1:2:18
    plot(RMSE_Tfield_c(i),RMSE_SMOS_Tfield_c(i),'h','Color',Couleurs(i,:),'MarkerFaceColor',Couleurs(i,:)); hold on;
end
for i=2:2:18
    plot(RMSE_Tfield_c(i),RMSE_SMOS_Tfield_c(i),'h','Color',Couleurs(i,:)); hold on;
end
for i=1:2:18
    plot(RMSE_Tfield_c_cst(i),RMSE_SMOS_Tfield_c_cst(i),'v','Color',Couleurs(i,:),'MarkerFaceColor',Couleurs(i,:)); hold on;
end
for i=2:2:18
    plot(RMSE_Tfield_c_cst(i),RMSE_SMOS_Tfield_c_cst(i),'v','Color',Couleurs(i,:)); hold on;
end

ylabel('RMSE SMOS temperature field (°C)','Fontsize',13);
xlabel('RMSE borehole temperature profiles (°C)','Fontsize',13)
% axis('square');

MEANALL=mean([RMSEKORIE(:);RMSEKORIE_cst(:);RMSEKORI(:);RMSEKORI_cst(:);RMSEVOBS(:);RMSEVOBS_cst(:); ...
               RMSETFIELDNC(:);RMSETFIELDNC_cst(:);RMSETFIELDC(:);RMSETFIELDC_cst(:)]);
text1=[num2str(round(MEANALL,2)),' °C'];
xline(MEANALL,'-',text1);

MEANALL=mean([RMSE_SMOS_KoriE(:);RMSE_SMOS_KoriE_cst(:);RMSE_SMOS_Kori(:);RMSE_SMOS_Kori_cst(:);RMSE_SMOS_Vobs(:); ...
    RMSE_SMOS_Vobs_cst(:); RMSE_SMOS_Tfield_nc(:);RMSE_SMOS_Tfield_nc_cst(:);RMSE_SMOS_Tfield_c(:);RMSE_SMOS_Tfield_c_cst(:)]);
text2=[num2str(round(MEANALL,2)),' °C'];
yline(MEANALL,'-',text2);

xlim([1 8])
% ylim([2 10])
% plot([min([xlim ylim]) max([xlim ylim])], [min([xlim ylim]) max([xlim ylim])], '--k')
grid on; 

% text(x_maxKoriE+0.2,y_minKoriE-0.4,'Kori-ULB'+"\newline"+'Enth.','HorizontalAlignment','right','VerticalAlignment','top','FontSize',10);
% text(x_minKori+0.2,y_minKori-0.4,'Kori-ULB'+"\newline"+'Opt.','HorizontalAlignment','right','VerticalAlignment','top','FontSize',10);
% text(x_minVobs-0.2,y_minVobs-0.2,'Kori-ULB'+"\newline"+'Obs.','HorizontalAlignment','right','VerticalAlignment','bottom','FontSize',10);
% text(x_minTfield_nc-0.1,y_minTfield_nc+0.1,{'Uncalibrated model';'Pattyn (2010)'},'HorizontalAlignment','left','VerticalAlignment','bottom','FontSize',10);
% text(x_minTfield_c-0.1,y_maxTfield_c+0.2,{'Calibrated model';'Pattyn (2010)'},'HorizontalAlignment','left','VerticalAlignment','top','FontSize',10);

% annotation('textbox', [0.05, 0.9, 0.1, 0.05], 'String', 'a', ...
%             'EdgeColor', 'none', 'FontSize', 20);

nexttile(t,3); axis('off');
hleg=legend([p1b,p1r,p1,p2,p4,p3,p6,p7,p9,p8,p5],[SMBOrder,GHFOrder]);
title(hleg,'Datasets')
hleg.FontSize = 11;
hleg.Layout.Tile = 3;
hleg.Location = 'SouthEastoutside';

nexttile(t,4,[1 2])

hold on
x_minKoriE=min([RMSE_KoriE'; RMSE_KoriE_cst']);
x_maxKoriE=max([RMSE_KoriE'; RMSE_KoriE_cst']);
x_minKori=min([RMSE_Kori'; RMSE_Kori_cst']);
x_maxKori=max([RMSE_Kori'; RMSE_Kori_cst']);
x_minVobs=min([RMSE_Vobs'; RMSE_Vobs_cst']);
x_maxVobs=max([RMSE_Vobs'; RMSE_Vobs_cst']);
x_minTfield_nc=min([RMSE_Tfield_nc'; RMSE_Tfield_nc_cst']);
x_maxTfield_nc=max([RMSE_Tfield_nc'; RMSE_Tfield_nc_cst']);
x_minTfield_c=min([RMSE_Tfield_c'; RMSE_Tfield_c_cst']);
x_maxTfield_c=max([RMSE_Tfield_c'; RMSE_Tfield_c_cst']);

y_minKoriE=min([RMSE_Lakes_KoriE'; RMSE_Lakes_KoriE_cst']);
y_maxKoriE=min(max([RMSE_Lakes_KoriE'; RMSE_Lakes_KoriE_cst']),20);
y_minKori=min([RMSE_Lakes_Kori'; RMSE_Lakes_Kori_cst']);
y_maxKori=min(max([RMSE_Lakes_Kori'; RMSE_Lakes_Kori_cst']),20);
y_minVobs=min([RMSE_Lakes_Vobs'; RMSE_Lakes_Vobs_cst']);
y_maxVobs=min(max([RMSE_Lakes_Vobs'; RMSE_Lakes_Vobs_cst']),20);
y_minTfield_nc=min([RMSE_Lakes_Tfield_nc'; RMSE_Lakes_Tfield_nc_cst']);
y_maxTfield_nc=min(max([RMSE_Lakes_Tfield_nc'; RMSE_Lakes_Tfield_nc_cst']),20);
y_minTfield_c=min([RMSE_Lakes_Tfield_c'; RMSE_Lakes_Tfield_c_cst']);
y_maxTfield_c=min(max([RMSE_Lakes_Tfield_c'; RMSE_Lakes_Tfield_c_cst']),20);

rectangle('position',[x_minTfield_nc-0.15 y_minTfield_nc-0.15 x_maxTfield_nc-x_minTfield_nc+0.27 y_maxTfield_nc-y_minTfield_nc+0.3],'Linestyle','-.','FaceColor',Couleurs2(8,:),'FaceAlpha',0.);
rectangle('position',[x_minTfield_c-0.15 y_minTfield_c-0.15 x_maxTfield_c-x_minTfield_c+0.27 y_maxTfield_c-y_minTfield_c+0.3],'Linestyle','--','FaceColor',Couleurs2(1,:),'FaceAlpha',0.);
rectangle('position',[x_minKoriE-0.15 y_minKoriE-0.15 x_maxKoriE-x_minKoriE+0.27 y_maxKoriE-y_minKoriE+0.3],'Linestyle','-','EdgeColor',[0.50,0.50,0.50],'FaceColor',Couleurs2(2,:),'FaceAlpha',0.);
rectangle('position',[x_minKori-0.15 y_minKori-0.15 x_maxKori-x_minKori+0.27 y_maxKori-y_minKori+0.3],'Linestyle','-','FaceColor',Couleurs2(4,:),'FaceAlpha',0.);
rectangle('position',[x_minVobs-0.15 y_minVobs-0.15 x_maxVobs-x_minVobs+0.27 y_maxVobs-y_minVobs+0.3],'Linestyle',':','FaceColor',Couleurs2(6,:),'FaceAlpha',0.);

% Kori-ULB Enth
for i=1:2:18
    plot(RMSE_KoriE(i),RMSE_Lakes_KoriE(i),'s','Color',Couleurs(i,:),'MarkerFaceColor',Couleurs(i,:)); hold on;
end
for i=2:2:18
    plot(RMSE_KoriE(i),RMSE_Lakes_KoriE(i),'s','Color',Couleurs(i,:)); hold on;
end
for i=1:2:18
    plot(RMSE_KoriE_cst(i),RMSE_Lakes_KoriE_cst(i),'+','Color',Couleurs(i,:),'MarkerFaceColor',Couleurs(i,:)); hold on;
end
for i=2:2:18
    plot(RMSE_KoriE_cst(i),RMSE_Lakes_KoriE_cst(i),'+','Color',Couleurs(i,:)); hold on;
end

% Kori-ULB Opt
for i=1:2:18
    p=plot(RMSE_Kori(i),RMSE_Lakes_Kori(i),'o','Color',Couleurs(i,:),'MarkerFaceColor',Couleurs(i,:)); hold on;
end
for i=2:2:18
    p=plot(RMSE_Kori(i),RMSE_Lakes_Kori(i),'o','Color',Couleurs(i,:)); hold on;
end
for i=1:2:18
    plot(RMSE_Kori_cst(i),RMSE_Lakes_Kori_cst(i),'^','Color',Couleurs(i,:),'MarkerFaceColor',Couleurs(i,:)); hold on;
end
for i=2:2:18
    plot(RMSE_Kori_cst(i),RMSE_Lakes_Kori_cst(i),'^','Color',Couleurs(i,:)); hold on;
end

% Kori Obs
for i=1:2:18
    plot(RMSE_Vobs(i),RMSE_Lakes_Vobs(i),'d','Color',Couleurs(i,:),'MarkerFaceColor',Couleurs(i,:)); hold on;
end
for i=2:2:18
    plot(RMSE_Vobs(i),RMSE_Lakes_Vobs(i),'d','Color',Couleurs(i,:)); hold on;
end
for i=1:2:18
    plot(RMSE_Vobs_cst(i),RMSE_Lakes_Vobs_cst(i),'<','Color',Couleurs(i,:),'MarkerFaceColor',Couleurs(i,:)); hold on;
end
for i=2:2:18
    plot(RMSE_Vobs_cst(i),RMSE_Lakes_Vobs_cst(i),'<','Color',Couleurs(i,:)); hold on;
end


% Uncalibrated model of Pattyn (2010)
for i=1:2:18
    plot(RMSE_Tfield_nc(i),RMSE_Lakes_Tfield_nc(i),'p','Color',Couleurs(i,:),'MarkerFaceColor',Couleurs(i,:)); hold on;
end
for i=2:2:18
    plot(RMSE_Tfield_nc(i),RMSE_Lakes_Tfield_nc(i),'p','Color',Couleurs(i,:)); hold on;
end
for i=1:2:18
    plot(RMSE_Tfield_nc_cst(i),RMSE_Lakes_Tfield_nc_cst(i),'>','Color',Couleurs(i,:),'MarkerFaceColor',Couleurs(i,:)); hold on;
end
for i=2:2:18
    plot(RMSE_Tfield_nc_cst(i),RMSE_Lakes_Tfield_nc_cst(i),'>','Color',Couleurs(i,:)); hold on;
end

% Calibrated model of Pattyn (2010)
for i=1:2:18
    plot(RMSE_Tfield_c(i),RMSE_Lakes_Tfield_c(i),'h','Color',Couleurs(i,:),'MarkerFaceColor',Couleurs(i,:)); hold on;
end
for i=2:2:18
    plot(RMSE_Tfield_c(i),RMSE_Lakes_Tfield_c(i),'h','Color',Couleurs(i,:)); hold on;
end
for i=1:2:18
    plot(RMSE_Tfield_c_cst(i),RMSE_Lakes_Tfield_c_cst(i),'v','Color',Couleurs(i,:),'MarkerFaceColor',Couleurs(i,:)); hold on;
end
for i=2:2:18
    plot(RMSE_Tfield_c_cst(i),RMSE_Lakes_Tfield_c_cst(i),'v','Color',Couleurs(i,:)); hold on;
end

p13e=plot(RMSE_KoriE(2),RMSE_Lakes_KoriE(2),'s','Color',Couleurs(1,:)); hold on;
p13ec=plot(RMSE_KoriE_cst(2),RMSE_Lakes_KoriE_cst(2),'+','Color',Couleurs(1,:)); hold on;
p13=plot(RMSE_Kori(2),RMSE_Lakes_Kori(2),'o','Color',Couleurs(1,:)); hold on;
p13b=plot(RMSE_Kori_cst(2),RMSE_Lakes_Kori_cst(2),'^','Color',Couleurs(1,:)); hold on;
p13c=plot(RMSE_Kori_cst(2),RMSE_Lakes_Kori_cst(2),'^','Color',Couleurs(1,:)); hold on;
p14=plot(RMSE_Vobs(2),RMSE_Lakes_Vobs(2),'d','Color',Couleurs(1,:)); hold on;
p14b=plot(RMSE_Vobs_cst(2),RMSE_Lakes_Vobs_cst(2),'<','Color',Couleurs(1,:)); hold on;
p15=plot(RMSE_Tfield_nc(2),RMSE_Lakes_Tfield_nc(2),'p','Color',Couleurs(1,:)); hold on;
p15b=plot(RMSE_Tfield_nc_cst(2),RMSE_Lakes_Tfield_nc_cst(2),'>','Color',Couleurs(1,:)); hold on;
p16=plot(RMSE_Tfield_c(2),RMSE_Lakes_Tfield_c(2),'h','Color',Couleurs(1,:)); hold on;
p16b=plot(RMSE_Tfield_c_cst(2),RMSE_Lakes_Tfield_c_cst(2),'v','Color',Couleurs(1,:)); hold on;

xlabel('RMSE borehole temperature profiles (°C)','Fontsize',13);
ylabel('RMSE subglacial lakes (°C)','Fontsize',13)
% ylim([2 10])
% axis('square');

MEANALL=mean([RMSEKORIE(:);RMSEKORIE_cst(:);RMSEKORI(:);RMSEKORI_cst(:);RMSEVOBS(:);RMSEVOBS_cst(:); ...
               RMSETFIELDNC(:);RMSETFIELDNC_cst(:);RMSETFIELDC(:);RMSETFIELDC_cst(:)]);
% text1=[num2str(round(MEANALL,2)),' °C'];
xline(MEANALL,'-');

MEANALL=mean([RMSE_Lakes_KoriE(:);RMSE_Lakes_KoriE_cst(:);RMSE_Lakes_Kori(:);RMSE_Lakes_Kori_cst(:);RMSE_Lakes_Vobs(:); ...
    RMSE_Lakes_Vobs_cst(:); RMSE_Lakes_Tfield_nc(:);RMSE_Lakes_Tfield_nc_cst(:);RMSE_Lakes_Tfield_c(:);RMSE_Lakes_Tfield_c_cst(:)]);
text2=[num2str(round(MEANALL,2)),' °C'];
yline(MEANALL,'-',text2);

xlim([1 8])
% plot([min([xlim ylim]) max([xlim ylim])], [min([xlim ylim]) max([xlim ylim])], '--k')
grid on; 

% text(x_maxKoriE+0.2,y_maxKoriE,'Kori-ULB'+"\newline"+'Enth.','HorizontalAlignment','left','VerticalAlignment','top','FontSize',10);
% text(x_maxKori+0.2,y_maxKori,'Kori-ULB'+"\newline"+'Opt.','HorizontalAlignment','left','VerticalAlignment','top','FontSize',10);
% text(x_minVobs-0.2,y_minVobs,'Kori-ULB'+"\newline"+'Obs.','HorizontalAlignment','right','VerticalAlignment','bottom','FontSize',10);
% text(x_maxTfield_nc-0.1,y_maxTfield_nc,{'Uncalibrated model';'Pattyn (2010)'},'HorizontalAlignment','right','VerticalAlignment','top','FontSize',10);
% text(x_minTfield_c-0.1,y_maxTfield_c,{'Calibrated model';'Pattyn (2010)'},'HorizontalAlignment','left','VerticalAlignment','top','FontSize',10);

set(gca,'yscale','log')

nexttile(t,6); axis('off');
hleg2=legend([p13e,p13ec,p13,p13b,p14,p14b,p15,p15b,p16,p16b], ...
    {'Kori-ULB Opt Enth','Kori-ULB Opt Enth cst','Kori-ULB Opt','Kori-ULB Opt cst','Kori-ULB Obs','Kori-ULB Obs cst', ...
    'Uncalibrated model (Pattyn,2010)','Uncalibrated model (Pattyn,2010) cst',...
    'Calibrated model (Pattyn,2010)','Calibrated model (Pattyn,2010) cst'});
title(hleg2,'Modelling approaches')
hleg2.FontSize = 11;
hleg2.Layout.Tile = 6;
hleg2.Location = 'NorthEastoutside';
end

if Figure5==1

if Load==1
% Load modelled temperature profiles
load ResultsAntarctica8km_englacial_temperature.mat 
load ResultsAntarctica8km_ice_thickness.mat
end

% Location of temperature profiles in x,y coordinates (km)
% load ProfilsTxy.mat

% Figure
f3=figure;
set(f3,'Position',[0.0542    0.0502    1.3812    0.8356].*1.e3);
set(f3,'WindowState','maximized')

t=tiledlayout(4,8);
t.TileSpacing = 'tight';

% Colors and legend
Couleurs1=brewermap(10-2,'*RdYlBu');
Couleurs2=[0 0 0.5; Couleurs1(1:3,:); Couleurs1(5:8,:); 0.5 0 0];
Couleurs=[Couleurs2(1,:);Couleurs2(2,:);Couleurs2(4,:);Couleurs2(3,:); Couleurs2(9,:);...
          Couleurs2(5,:);Couleurs2(6,:);Couleurs2(8,:);Couleurs2(7,:)];

Symbols1={':s';':o';':d';':p';':h'};
Symbols2={':+';':^';':<';':>';':v'};

% Mean RMSE for each temperature profile
RMSE_Temp_Mean=round((mean(RMSEKORIE,2)+mean(RMSEKORIE_cst,2)+ ...
                      mean(RMSEKORI,2)+mean(RMSEKORI_cst,2)+...
                      mean(RMSEVOBS,2)+mean(RMSEVOBS_cst,2)+...
                      mean(RMSETFIELDNC,2)+mean(RMSETFIELDNC_cst,2)+...
                      mean(RMSETFIELDC,2)+mean(RMSETFIELDC_cst,2))./10,2);

% South Pole
nexttile(5-4)
Xx=round(ySP/8); Yy=round(xSP/8); 
if ProfilsT_exist==1
load ProfilsT\Southpole_temp
plot(temp+273.15,depth,'*-k','MarkerSize',3); hold on; title('South Pole'); axis ij; axis('square')
xlabel('Temperature (K)','FontSize',11); ylabel('Depth (m)','FontSize',11);
end

% Kori-ULB Enth
Model='HySSAE';
PlotProfiles(Model,Xx,Yy,zeta1,Couleurs,Symbols1{1},Symbols2{1}); hold on;
% Kori-ULB Opt
Model='HySSA';
PlotProfiles(Model,Xx,Yy,zeta,Couleurs,Symbols1{2},Symbols2{2})
% Kori-ULB Obs
Model='Vobs';
PlotProfiles(Model,Xx,Yy,zeta,Couleurs,Symbols1{3},Symbols2{3})
% Uncalibrated Hybrid Model (Pattyn,2010)
Model='Tfield_nc';
PlotProfiles(Model,Xx,Yy,zeta,Couleurs,Symbols1{4},Symbols2{4})
% Calibrated Hybrid Model (Pattyn,2010)
Model='Tfield_c';
PlotProfiles(Model,Xx,Yy,zeta,Couleurs,Symbols1{5},Symbols2{5})

% south pole
ax1 = gca; xlim1 = ax1.XLim; ylim1 = ax1.YLim;
text(max(xlim1),min(ylim1),[num2str(RMSE_Temp_Mean(1)),'°C'],'VerticalAlignment', 'top', 'HorizontalAlignment', 'right');

hax = gca;
hax.Children = circshift(hax.Children, -180);

% Kohnen
nexttile(6-4)
Xx=round(yKH/8); Yy=round(xKH/8); 
if ProfilsT_exist==1
load ProfilsT\Kohnen
plot(temp+273.15,depth,'*-k','MarkerSize',3); hold on; title('Kohnen'); axis ij; axis('square')
%xlabel('Temperature (K)'); ylabel('Depth (m)')
end

% Kori-ULB Enth
Model='HySSAE';
PlotProfiles(Model,Xx,Yy,zeta1,Couleurs,Symbols1{1},Symbols2{1}); hold on;
% Kori-ULB Opt
Model='HySSA';
PlotProfiles(Model,Xx,Yy,zeta,Couleurs,Symbols1{2},Symbols2{2})
% Kori-ULB Obs
Model='Vobs';
PlotProfiles(Model,Xx,Yy,zeta,Couleurs,Symbols1{3},Symbols2{3})
% Uncalibrated Hybrid Model (Pattyn,2010)
Model='Tfield_nc';
PlotProfiles(Model,Xx,Yy,zeta,Couleurs,Symbols1{4},Symbols2{4})
% Calibrated Hybrid Model (Pattyn,2010)
Model='Tfield_c';
PlotProfiles(Model,Xx,Yy,zeta,Couleurs,Symbols1{5},Symbols2{5})

% Khonen
ax1 = gca; xlim1 = ax1.XLim; ylim1 = ax1.YLim;
text(max(xlim1),min(ylim1),[num2str(RMSE_Temp_Mean(2)),'°C'],'VerticalAlignment', 'top', 'HorizontalAlignment', 'right');

hax = gca;
hax.Children = circshift(hax.Children, -180);

% Dome F
nexttile(7-4)
Xx=round(yDF/8); Yy=round(xDF/8); 
if ProfilsT_exist==1
load ProfilsT\DF_temp
plot(temp+273.15,depth,'*-k','MarkerSize',3); hold on; title('Dome F'); axis ij; axis('square')
%xlabel('Temperature (K)'); ylabel('Depth (m)')
end

% Kori-ULB Enth
Model='HySSAE';
PlotProfiles(Model,Xx,Yy,zeta1,Couleurs,Symbols1{1},Symbols2{1}); hold on;
% Kori-ULB Opt
Model='HySSA';
PlotProfiles(Model,Xx,Yy,zeta,Couleurs,Symbols1{2},Symbols2{2})
% Kori-ULB Obs
Model='Vobs';
PlotProfiles(Model,Xx,Yy,zeta,Couleurs,Symbols1{3},Symbols2{3})
% Uncalibrated Hybrid Model (Pattyn,2010)
Model='Tfield_nc';
PlotProfiles(Model,Xx,Yy,zeta,Couleurs,Symbols1{4},Symbols2{4})
% Calibrated Hybrid Model (Pattyn,2010)
Model='Tfield_c';
PlotProfiles(Model,Xx,Yy,zeta,Couleurs,Symbols1{5},Symbols2{5})

% Dome F
ax1 = gca; xlim1 = ax1.XLim; ylim1 = ax1.YLim;
text(max(xlim1),min(ylim1),[num2str(RMSE_Temp_Mean(5)),'°C'],'VerticalAlignment', 'top', 'HorizontalAlignment', 'right');

hax = gca;
hax.Children = circshift(hax.Children, -180);

% Vostok
nexttile(8-4)
Xx=round(yVK/8); Yy=round(xVK/8); 
if ProfilsT_exist==1
load ProfilsT\Vostok_temp
plot(temp+273.15,depth,'*-k','MarkerSize',3);hold on; title('Vostok'); axis ij; axis('square')
%xlabel('Temperature (K)'); ylabel('Depth (m)')
end

% Kori-ULB Enth
Model='HySSAE';
PlotProfiles(Model,Xx,Yy,zeta1,Couleurs,Symbols1{1},Symbols2{1}); hold on;
% Kori-ULB Opt
Model='HySSA';
PlotProfiles(Model,Xx,Yy,zeta,Couleurs,Symbols1{2},Symbols2{2})
% Kori-ULB Obs
Model='Vobs';
PlotProfiles(Model,Xx,Yy,zeta,Couleurs,Symbols1{3},Symbols2{3})
% Uncalibrated Hybrid Model (Pattyn,2010)
Model='Tfield_nc';
PlotProfiles(Model,Xx,Yy,zeta,Couleurs,Symbols1{4},Symbols2{4})
% Calibrated Hybrid Model (Pattyn,2010)
Model='Tfield_c';
PlotProfiles(Model,Xx,Yy,zeta,Couleurs,Symbols1{5},Symbols2{5})

% Vostok
ax1 = gca; xlim1 = ax1.XLim; ylim1 = ax1.YLim;
text(max(xlim1),min(ylim1),[num2str(RMSE_Temp_Mean(3)),'°C'],'VerticalAlignment', 'top', 'HorizontalAlignment', 'right');

hax = gca;
hax.Children = circshift(hax.Children, -180);

% Dome C
nexttile(16-4)
Xx=round(yDC/8); Yy=round(xDC/8); 
if ProfilsT_exist==1
load ProfilsT\DomeC_temp
plot(temp+273.15,depth,'*-k','MarkerSize',3); hold on; title('Dome C'); axis ij; axis('square')
%xlabel('Temperature (K)'); ylabel('Depth (m)')
end

% Kori-ULB Enth
Model='HySSAE';
PlotProfiles(Model,Xx,Yy,zeta1,Couleurs,Symbols1{1},Symbols2{1}); hold on
% Kori-ULB Opt
Model='HySSA';
PlotProfiles(Model,Xx,Yy,zeta,Couleurs,Symbols1{2},Symbols2{2})
% Kori-ULB Obs
Model='Vobs';
PlotProfiles(Model,Xx,Yy,zeta,Couleurs,Symbols1{3},Symbols2{3})
% Uncalibrated Hybrid Model (Pattyn,2010)
Model='Tfield_nc';
PlotProfiles(Model,Xx,Yy,zeta,Couleurs,Symbols1{4},Symbols2{4})
% Calibrated Hybrid Model (Pattyn,2010)
Model='Tfield_c';
PlotProfiles(Model,Xx,Yy,zeta,Couleurs,Symbols1{5},Symbols2{5})

% Dome C
ax1 = gca; xlim1 = ax1.XLim; ylim1 = ax1.YLim;
text(max(xlim1),min(ylim1),[num2str(RMSE_Temp_Mean(4)),'°C'],'VerticalAlignment', 'top', 'HorizontalAlignment', 'right');

hax = gca;
hax.Children = circshift(hax.Children, -180);

% Siple Coast
nexttile(31-4)
Xx=round(ySC/8); Yy=round(xSC/8); 
if ProfilsT_exist==1
load ProfilsT\Siple_temp
plot(temp+273.15,depth,'*-k','MarkerSize',3); hold on; title('Siple Coast'); axis ij; axis('square')
%xlabel('Temperature (K)'); ylabel('Depth (m)')
end

% Kori-ULB Enth
Model='HySSAE';
PlotProfiles(Model,Xx,Yy,zeta1,Couleurs,Symbols1{1},Symbols2{1}); hold on;
% Kori-ULB Opt
Model='HySSA';
PlotProfiles(Model,Xx,Yy,zeta,Couleurs,Symbols1{2},Symbols2{2})
% Kori-ULB Obs
Model='Vobs';
PlotProfiles(Model,Xx,Yy,zeta,Couleurs,Symbols1{3},Symbols2{3})
% Uncalibrated Hybrid Model (Pattyn,2010)
Model='Tfield_nc';
PlotProfiles(Model,Xx,Yy,zeta,Couleurs,Symbols1{4},Symbols2{4})
% Calibrated Hybrid Model (Pattyn,2010)
Model='Tfield_c';
PlotProfiles(Model,Xx,Yy,zeta,Couleurs,Symbols1{5},Symbols2{5})

% Siple Coast
ax1 = gca; xlim1 = ax1.XLim; ylim1 = ax1.YLim;
text(max(xlim1),min(ylim1),[num2str(RMSE_Temp_Mean(6)),'°C'],'VerticalAlignment', 'top', 'HorizontalAlignment', 'right');

hax = gca;
hax.Children = circshift(hax.Children, -180);

% Law Dome
nexttile(24-4)
Xx=round(yLD/8); Yy=round(xLD/8); 
if ProfilsT_exist==1
load ProfilsT\Law_temp
plot(temp+273.15,depth,'*-k','MarkerSize',3); hold on; title('Law Dome'); axis ij; axis('square')
%xlabel('Temperature (K)'); ylabel('Depth (m)')
end

% Kori-ULB Enth
Model='HySSAE';
PlotProfiles(Model,Xx,Yy,zeta1,Couleurs,Symbols1{1},Symbols2{1}); hold on;
% Kori-ULB Opt
Model='HySSA';
PlotProfiles(Model,Xx,Yy,zeta,Couleurs,Symbols1{2},Symbols2{2})
% Kori-ULB Obs
Model='Vobs';
PlotProfiles(Model,Xx,Yy,zeta,Couleurs,Symbols1{3},Symbols2{3})
% Uncalibrated Hybrid Model (Pattyn,2010)
Model='Tfield_nc';
PlotProfiles(Model,Xx,Yy,zeta,Couleurs,Symbols1{4},Symbols2{4})
% Calibrated Hybrid Model (Pattyn,2010)
Model='Tfield_c';
PlotProfiles(Model,Xx,Yy,zeta,Couleurs,Symbols1{5},Symbols2{5})

% Law Dome
ax1 = gca; xlim1 = ax1.XLim; ylim1 = ax1.YLim;
text(max(xlim1),min(ylim1),[num2str(RMSE_Temp_Mean(7)),'°C'],'VerticalAlignment', 'top', 'HorizontalAlignment', 'right');

hax = gca;
hax.Children = circshift(hax.Children, -180);

% Taylor Dome
nexttile(32-4)
Xx=round(yTD/8); Yy=round(xTD/8); 
if ProfilsT_exist==1
load ProfilsT\TaylorDome
plot(temp+273.15,depth,'*-k','MarkerSize',3); hold on; title('Taylor Dome'); axis ij; axis('square')
%xlabel('Temperature (K)'); ylabel('Depth (m)')
end

% Kori-ULB Enth
Model='HySSAE';
PlotProfiles(Model,Xx,Yy,zeta1,Couleurs,Symbols1{1},Symbols2{1}); hold on;
% Kori-ULB Opt
Model='HySSA';
PlotProfiles(Model,Xx,Yy,zeta,Couleurs,Symbols1{2},Symbols2{2})
% Kori-ULB Obs
Model='Vobs';
PlotProfiles(Model,Xx,Yy,zeta,Couleurs,Symbols1{3},Symbols2{3})
% Uncalibrated Hybrid Model (Pattyn,2010)
Model='Tfield_nc';
PlotProfiles(Model,Xx,Yy,zeta,Couleurs,Symbols1{4},Symbols2{4})
% Calibrated Hybrid Model (Pattyn,2010)
Model='Tfield_c';
PlotProfiles(Model,Xx,Yy,zeta,Couleurs,Symbols1{5},Symbols2{5})

% Taylor Dome
ax1 = gca; xlim1 = ax1.XLim; ylim1 = ax1.YLim;
text(max(xlim1),min(ylim1),[num2str(RMSE_Temp_Mean(8)),'°C'],'VerticalAlignment', 'top', 'HorizontalAlignment', 'right');

hax = gca;
hax.Children = circshift(hax.Children, -180);

% Byrd
nexttile(30-4)
Xx=round(yBY/8); Yy=round(xBY/8); 
if ProfilsT_exist==1
load ProfilsT\Byrd_temps
plot(temp+273.15,depth,'*-k','MarkerSize',3); hold on; 
title('Byrd Station'); axis ij; axis('square')
%xlabel('Temperature (K)'); ylabel('Depth (m)')
end

% Kori-ULB Enth
Model='HySSAE';
PlotProfiles(Model,Xx,Yy,zeta1,Couleurs,Symbols1{1},Symbols2{1}); hold on;
% Kori-ULB Opt
Model='HySSA';
PlotProfiles(Model,Xx,Yy,zeta,Couleurs,Symbols1{2},Symbols2{2})
% Kori-ULB Obs
Model='Vobs';
PlotProfiles(Model,Xx,Yy,zeta,Couleurs,Symbols1{3},Symbols2{3})
% Uncalibrated Hybrid Model (Pattyn,2010)
Model='Tfield_nc';
PlotProfiles(Model,Xx,Yy,zeta,Couleurs,Symbols1{4},Symbols2{4})
% Calibrated Hybrid Model (Pattyn,2010)
Model='Tfield_c';
PlotProfiles(Model,Xx,Yy,zeta,Couleurs,Symbols1{5},Symbols2{5})

% Byrd
ax1 = gca; xlim1 = ax1.XLim; ylim1 = ax1.YLim;
text(max(xlim1),min(ylim1),[num2str(RMSE_Temp_Mean(9)),'°C'],'VerticalAlignment', 'top', 'HorizontalAlignment', 'right');

hax = gca;
hax.Children = circshift(hax.Children, -180);

% WAIS Divide
nexttile(29-4)
Xx=round(yWA/8); Yy=round(xWA/8); 
if ProfilsT_exist==1
load ProfilsT\WAIS_Divide
P1=plot(temp+273.15,depth,'*-k','MarkerSize',3); hold on; 
title('WAIS Divide'); axis ij; axis('square')
%xlabel('Temperature (K)'); ylabel('Depth (m)')
end

% Kori-ULB Enth
Model='HySSAE';
PlotProfiles(Model,Xx,Yy,zeta1,Couleurs,Symbols1{1},Symbols2{1}); hold on;
% Kori-ULB Opt
Model='HySSA';
PlotProfiles(Model,Xx,Yy,zeta,Couleurs,Symbols1{2},Symbols2{2})
% Kori-ULB Obs
Model='Vobs';
PlotProfiles(Model,Xx,Yy,zeta,Couleurs,Symbols1{3},Symbols2{3})
% Uncalibrated Hybrid Model (Pattyn,2010)
Model='Tfield_nc';
PlotProfiles(Model,Xx,Yy,zeta,Couleurs,Symbols1{4},Symbols2{4})
% Calibrated Hybrid Model (Pattyn,2010)
Model='Tfield_c';
PlotProfiles(Model,Xx,Yy,zeta,Couleurs,Symbols1{5},Symbols2{5})

% WAIS
ax1 = gca; xlim1 = ax1.XLim; ylim1 = ax1.YLim;
text(max(xlim1),min(ylim1),[num2str(RMSE_Temp_Mean(10)),'°C'],'VerticalAlignment', 'top', 'HorizontalAlignment', 'right');

nexttile(13-4,[2 3])
% Contour of the Antarctic ice sheet
load MASKZB8km.mat
ctr.imax=701; ctr.jmax=701; ctr.delta=8e3;
Li=(ctr.imax-1)*ctr.delta/1e3; % length of domain in y
Lj=(ctr.jmax-1)*ctr.delta/1e3; % length of domain in x
x=0:ctr.delta/1e3:Lj;
y=0:ctr.delta/1e3:Li;
contour(x,y,MASK==1,'k','Linewidth',0.1) ; hold on; axis('square');

% if Basins>=2
%     for i=1:27
%     contour(x,y,ZB==i,'k','Linewidth',0.001); hold on;
%     end
% end

% SMOS basal temperatures (processed from Macelloni et al, 2019)
load Tsmos25km.mat % original resolution
TbcSMOS(QF>0)=NaN;
myfig4(TbcSMOS,-20,0); hold on; 
%text(5600,5600,'SMOS basal temperatures corrected for pmp (°C) ','Rotation',90,'HorizontalAlignment','right');
cb=colorbar('Position',[0.344190750588585,0.329992686439963,0.010416666666667,0.375014627120074]);
cb.Label.String='SMOS basal temperatures corrected for pmp (°C)';
cb.Label.FontSize = 10;
axis('off')
colormap(brewermap([],'Reds'));
load Tsmos8km.mat % regridded 
p3=contour(x,y,QF==0,1,'k');

% Add subglacial lakes (processed from Livingstone et al, 2022)
load SubLakes.mat
p1=plot(xlakes,ylakes,'o','Color',[0.64,0.08,0.18],'MarkerSize',1.25); hold on

% Add location of temperature profiles
p2=plot(xSP,ySP,'ok');
pSP=plot(xSP,ySP,'o','MarkerEdgeColor','k');
text(xSP-150,ySP+200,'SP');
pVK=plot(xVK,yVK,'o','MarkerEdgeColor','k');
text(xVK-150,yVK+200,'VK'); 
pKH=plot(xKH,yKH,'o','MarkerEdgeColor','k');
text(xKH-150,yKH+200,'KH'); 
pDF=plot(xDF,yDF,'o','MarkerEdgeColor','k'); 
text(xDF-150,yDF+200,'DF');
pDC=plot(xDC,yDC,'o','MarkerEdgeColor','k');
text(xDC-150,yDC+200,'DC'); 
pSC=plot(xSC,ySC,'o','MarkerEdgeColor','k');
text(xSC-150,ySC+200,'SC'); 
pLD=plot(xLD,yLD,'o','MarkerEdgeColor','k');
text(xLD-150,yLD+200,'LD');
pTD=plot(xTD,yTD,'o','MarkerEdgeColor','k');
text(xTD-150,yTD+200,'TD'); 
pBY=plot(xBY,yBY,'o','MarkerEdgeColor','k'); 
text(xBY-150,yBY-200,'BY'); 
pWA=plot(xWA,yWA,'o','MarkerEdgeColor','k');
text(xWA-150,yWA+200,'WA'); 

figure1=f3;
% Create arrow
annotation(figure1,'arrow',[0.231770833333333 0.139322916666667],...
    [0.52034724857685 0.720588235294118]);
annotation(figure1,'arrow',[0.234375 0.234895833333333],...
    [0.630878557874763 0.74573055028463]);
annotation(figure1,'arrow',[0.267708333333333 0.331510416666667],...
    [0.592453510436433 0.745256166982922]);
annotation(figure1,'arrow',[0.280989583333333 0.402083333333333],...
    [0.495204933586338 0.743833017077799]);
annotation(figure1,'arrow',[0.286197916666667 0.383072916666667],...
    [0.459151802656546 0.587286527514231]);
annotation(figure1,'arrow',[0.32265625 0.389583333333333],...
    [0.450138519924099 0.40607210626186]);
annotation(figure1,'arrow',[0.253645833333333 0.402604166666667],...
    [0.434060721062619 0.278937381404175]);
annotation(figure1,'arrow',[0.219270833333333 0.303385416666667],...
    [0.461523719165085 0.27561669829222]);
annotation(figure1,'arrow',[0.193489583333333 0.127083333333333],...
    [0.485717267552182 0.286053130929791]);
annotation(figure1,'arrow',[0.199479166666667 0.229166666666667],...
    [0.47765275142315 0.287001897533207]);

legend([p1 p2],'Subglacial lakes','Temperature profiles','FontSize',10)

set(legend,'Location','Southwest')
legend('boxoff')  

axis('off')
end

function PlotProfiles(Model,Xx,Yy,zeta,Couleurs,Symbols1,Symbols2)

for i=1:9
tmp=evalin('base',['tmp_',Model,'_MAR_HF',num2str(i,'%i')]);
varname = ['H_',Model,'_MAR_HF',num2str(i)];
if evalin('base', ['exist(''', varname, ''', ''var'')'])
   H=evalin('base',['H_',Model,'_MAR_HF',num2str(i)]);
else
   H=evalin('base','H_obs');
end
plot(squeeze(tmp(Xx,Yy,:)),zeta*H(Xx,Yy),Symbols1,'Color',Couleurs(i,:),'MarkerFaceColor',Couleurs(i,:),'MarkerSize',1); axis ij; hold on;
end

for i=1:9
tmp=evalin('base',['tmp_',Model,'_RACMO_HF',num2str(i,'%i')]);
varname = ['H_',Model,'_RACMO_HF',num2str(i)];
if evalin('base', ['exist(''', varname, ''', ''var'')'])
   H=evalin('base',['H_',Model,'_RACMO_HF',num2str(i)]);
else
   H=evalin('base','H_obs');
end
plot(squeeze(tmp(Xx,Yy,:)),zeta*H(Xx,Yy),Symbols1,'Color',Couleurs(i,:),'MarkerSize',1); axis ij; hold on;
end

for i=1:9
tmp=evalin('base',['tmp_',Model,'_cst_MAR_HF',num2str(i,'%i')]);
varname = ['H_',Model,'_cst_MAR_HF',num2str(i)];
if evalin('base', ['exist(''', varname, ''', ''var'')'])
   H=evalin('base',['H_',Model,'_cst_MAR_HF',num2str(i)]);
else
   H=evalin('base','H_obs');
end
plot(squeeze(tmp(Xx,Yy,:)),zeta*H(Xx,Yy),Symbols2,'Color',Couleurs(i,:),'MarkerFaceColor',Couleurs(i,:),'MarkerSize',1); axis ij; hold on;
end

for i=1:9
tmp=evalin('base',['tmp_',Model,'_cst_RACMO_HF',num2str(i,'%i')]);
varname = ['H_',Model,'_cst_RACMO_HF',num2str(i)];
if evalin('base', ['exist(''', varname, ''', ''var'')'])
   H=evalin('base',['H_',Model,'_cst_RACMO_HF',num2str(i)]);
else
   H=evalin('base','H_obs');
end
plot(squeeze(tmp(Xx,Yy,:)),zeta*H(Xx,Yy),Symbols2,'Color',Couleurs(i,:),'MarkerSize',1); axis ij; hold on;
end
end