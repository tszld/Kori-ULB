% Estimates of basal and englacial thermal conditions of the AIS 
% Olivia Raspoet and Frank Pattyn (2025)

% Calculate and save ensemble MEAN RESULTS
clear
clearvars
close all

% Save results in a new file (1)
% Save results and append in an existing file (2)
% Save mean results of enthalpy (or other) seperately (3)
Save=2;

% Choose variable (see below) 
% or select 'LBTS' to calculate likely basal thermal state
% add '_Basins' for integrated values over subglacial basins
% add '_EAIS','_WAIS','_AP' for regionnaly integrated values
var='LBTS';

% Choose model name for model mean or select 'all' for the ensemble mean
% Add '_cst' to model name to select simulations using constant thermodynamic parameters
% Add or replace by 'MAR' or 'RACMO' to select simulations by regional climate model
% Add or replace by 'HFX' to select simulations by geothermal heat flow
model='all';

% Basins
switch var
    case {'Prop_EAIS','Prop_WAIS','Prop_AP','BV_EAIS','BV_WAIS','BV_AP',...
          'BVG_EAIS','BVG_WAIS','BVG_AP', 'BVF_EAIS','BVF_WAIS','BVF_AP',...
          'DBW_EAIS','DBW_WAIS','DBW_AP','BVR_EAIS','BVR_WAIS','BVR_AP'}
         Basins=1;
    case {'Prop_Basins','BV_Basins','BVG_Basins','BVF_Basins','DBW_Basins','BVR_Basins'}
         Basins=2;
    otherwise
         Basins=0;
end

% Load results depending on the selected model/variable
switch var
    case 'LBTS'
        var1='Tbc_*';
    otherwise
        switch model
           case 'all'
               var1=[var,'_*'];
           otherwise
               var1=[var,'_',model,'_*'];
        end
end

if Basins<2
    switch var
        case 'tmp'
             load('ResultsAntarctica8km_englacial_temperature.mat',var1)
        case 'wat'
             load('ResultsAntarctica8km_englacial_meltwater.mat',var1)
        case {'Tbc','Prop','Ht','LBTS'}
             load('ResultsAntarctica8km_basal_temperature.mat',var1)
        case{'Bmelt','BmeltG','BmeltF','BmeltR','Dbw','WF'}
             load('ResultsAntarctica8km_subglacial_meltwater.mat',var1)
        case{'BV','BVG','BVF','BVR','DBW'}
             load('ResultsAntarctica8km_subglacial_meltwater.mat',var1)
        case 'H'
            load('ResultsAntarctica8km_ice_thickness.mat',var1)
        case{'Fric','ud','ub'}
            load('Supplement\ResultsAntarctica8km_velocity.mat',var1)
            % Note: not provided in this repository
        case {'MASKTBC','Tpmp'}
            load('Supplement\ResultsAntarctica8km_MASKTBC.mat',var1)
            % Note: not provided in this repository
    end
end
if Basins>0
    switch model
        case 'HySSAE'
            load ResultsAntarctica8km_Basins.mat '*HySSAE*'
        case 'HySSAE_cst'
            load ResultsAntarctica8km_Basins.mat '*HySSAE_cst*'
        case 'HySSA'
            load ResultsAntarctica8km_Basins.mat '*HySSA_*' 
        case 'HySSA_cst'
            load ResultsAntarctica8km_Basins.mat '*HySSA_cst*'
        case 'Vobs'
            load ResultsAntarctica8km_Basins.mat '*Vobs*'
        case 'Vobs_cst'
            load ResultsAntarctica8km_Basins.mat '*Vobs_cst*'
        case 'Tfield_nc'
            load ResultsAntarctica8km_Basins.mat '*Tfield_nc*'
        case 'Tfield_nc_cst'
            load ResultsAntarctica8km_Basins.mat '*Tfield_nc_cst*'
        case 'Tfield_c'
            load ResultsAntarctica8km_Basins.mat '*Tfield_c*'
        case 'Tfield_c_cst'
            load ResultsAntarctica8km_Basins.mat '*Tfield_c_cst*'
        otherwise
            load('ResultsAntarctica8km_Basins.mat',var1)
    end
end

switch model
    case{'HySSA','HySSAE','Vobs','Tfield_nc','Tfield_c'}
        clear '*cst*';
end

% Load MASK
load MASKZB8km.mat

% SIA mode not considered in this study
clear '*Kori*'

if Basins==0
    clear '*AP*' '*WAIS*' '*EAIS*' '*Basins*'
elseif Basins==2
    clear '*AP*' '*WAIS*' '*EAIS*'
elseif Basins==1
    clear '*Basins*'
end

switch var
    case{'Bmelt','BmeltF','BmeltG'}
        % remove basal melting from ice shelves
        MASK(MASK~=1)=0;
end

switch var
    case {'tmp','wat'}
        switch model
            case 'all'
                varname=[var,'.*'];
            otherwise
                varname=[var,'.*',model,'.*'];   
        end
        [var_mean,var_std]=FindMean3(varname,who,MASK);
    case 'LBTS'
        switch model
            case 'all'
                varname=['Tbc','.*'];
            otherwise
                varname=['Tbc','.*',model,'.*'];   
        end
        [frozen,thawed]=LikelyBasalState(varname,who,MASK);
    case {'Prop','BV','BVG','BVF','DBW','BVR'}
        switch model
            case 'all'
                varname=[var,'.*'];
                [var_mean,var_std,var_min,var_max]=FindMean1(varname,who);
            otherwise
                varname=[var,'.*',model,'.*'];   
                [var_mean,var_std,var_min,var_max]=FindMean1(varname,who);
        end
    case {'Prop_EAIS','Prop_WAIS','Prop_AP','BV_EAIS','BV_WAIS','BV_AP',...
          'BVG_EAIS','BVG_WAIS','BVG_AP', 'BVF_EAIS','BVF_WAIS','BVF_AP',...
          'DBW_EAIS','DBW_WAIS','DBW_AP','BVR_EAIS','BVR_WAIS','BVR_AP'}
        switch model
            case 'all'
                varname=[var,'.*'];
                [var_mean,var_std,var_min,var_max]=FindMean1(varname,who);
            otherwise
                varname=[var,'.*',model,'.*'];   
                [var_mean,var_std,var_min,var_max]=FindMean1(varname,who);
        end
    case {'Prop_Basins','BV_Basins','BVG_Basins','BVF_Basins','DBW_Basins','BVR_Basins'}
                varname=[var,'.*'];
                [var_mean,var_std]=FindMeanBasins(varname,who);

    otherwise
        switch model
            case 'all'
                varname=[var,'.*'];
                [var_mean,var_std]=FindMean2(varname,who,MASK);
            otherwise
                varname=[var,'.*',model,'.*'];   
                [var_mean,var_std]=FindMean2(varname,who,MASK);
        end
        % choose FindMean1,FindMean2 or FindMean3 according to 
        % variable size (1d, 2d, or 3d)
        % [var_mean,var_std,var_min,var_max]=FindMean1(varname,who);
        % [var_mean,var_std]=FindMean2(varname,who,MASK);
end

switch var
    case 'LBTS'
    MeanVarName=['LBTS_', model];
    eval([MeanVarName, ' = thawed;']);
    otherwise
    MeanVarName=[var, '_Mean_', model];
    StdVarName=[var, '_Std_', model];
    eval([MeanVarName, ' = var_mean;']);
    eval([StdVarName, ' = var_std;']);
end

% -------------------------------------------------------------------------
% Name structure
% -------------------------------------------------------------------------
% var_model_RCM_GHF

% -------------------------------------------------------------------------
% Variables (var)
% -------------------------------------------------------------------------
% 3d variables
% tmp: englacial temperature field (K)
% wat: englacial water content (fraction) | ENTHALPY ONLY

% 2d variables
% Tbc: basal temperature corrected for the pressure melting point (°C)
% Bmelt: basal melt rate (m/a)
% BmeltG: contribution of geothermal heat to basal melt (m/a)
% BmeltF: contribution of frictional heat to basal melt (m/a)
% WF: subglacial water flux from the subglacial water routing (m^2/a)
% H: ice thickness (m; Kori-ULB Enth & Kori-ULB Opt)
% ub: basal velocities (m/a) - not provided
% ud: deformational velocities or balance velocities (m/a) - not provided
% Fric: Frictional heat (W/m^2) - not provided
% Tpmp: pressure melting point temperature (°C; Kori-ULB Opt) - not provided
% MASKTBC: mask indicating where basal ice is at the pressure melting point - not provided

% ENTHALPY ONLY:
% BmeltR : basal refreezing rate (m/a)
% Dbw: vertically integrated englacial meltwater drained to the bed (m/a)
% Ht: thickness of the temperate ice layers (m)

% 1d variables
% BV: subglacial meltwater volume for the grounded ice sheet (Gt/a)
% BVG: subglacial meltwater volume from geothermal heat (Gt/a)
% BVF: subglcial meltwater volume from frictional heat (Gt/a)
% Prop: fraction of temperate basal conditions (%)

% ENTHALPY ONLY:
% BVR: volume of basal refreezing (Gt/a)
% DBW: volume of englacial meltwater drained to the bed (Gt/a)

% _EAIS   :  as above for the East Antarctic Ice Sheet
% _WAIS   :  as above for the West Antarctic Ice Sheet
% _AP     :  as above for the Antarctic Peninsula
% _Basins :  as above for each subglacial basin (27x1)

% -------------------------------------------------------------------------
% Ice-dynamical models (model)
% -------------------------------------------------------------------------
% HySSA: results from the second initialization with Kori-Opt
% HySSAE: same as above but with the enthalpy gradient method
% Vobs:  results from Kori-Obs (using observed surface velocities)
% Tfield_nc: uncalibrated hybrid ice sheet/ice stream model (Pattyn, 2010)
% Tfield_c:  calibrated hybrid ice sheet/ice stream model (Pattyn, 2010)
%
% add '_cst' to model name for results with constant thermodynamic parameters

% -------------------------------------------------------------------------
% Regional climate model (RCM)
% -------------------------------------------------------------------------
% MAR v3.11 (Kittel et al., 2020)
% RACMO2.3p2 (Van Wessem et al., 2018)

% -------------------------------------------------------------------------
% Geothermal heat flow datasets (GHF)
% -------------------------------------------------------------------------
% HF1: Purucker  (2013)
% HF2: An et al. (2015)
% HF3: Shapiro & Ritzwoller (2004)
% HF4: Shen et al. (2020)
% HF5: Martos et al. (2017)
% HF6: Stal et al. (2021)
% HF7: Losing et al. (2021)
% HF8: Fox-Maule et al. (2005)
% HF9: Haeger et al (2022)


% -------------------------------------------------------------------------
% Save Mean Results
% -------------------------------------------------------------------------
if Save==1
    switch var
        case {'Tbc','Bmelt'}
        save('ResultsAntarctica8km_Mean.mat',MeanVarName,StdVarName)
        otherwise
        save('ResultsAntarctica8km_Mean.mat',MeanVarName)
    end
elseif Save==2
    switch var
        case {'Tbc','Bmelt'}
        save('ResultsAntarctica8km_Mean.mat',MeanVarName,StdVarName,'-append')
        otherwise
        save('ResultsAntarctica8km_Mean.mat',MeanVarName,'-append')
    end
elseif Save==3
       save('ResultsAntarctica8km_Mean_New.mat',MeanVarName,'-append')
end

% -------------------------------------------------------------------------
% Figure
% -------------------------------------------------------------------------
switch var
    case {'Tbc','WF','LBTS'}
    myfig(eval(MeanVarName)); colorbar;
    case {'Bmelt','BmeltG','BmeltF'}
    myfig(eval(MeanVarName),0,20e-3); colorbar;
end

% -------------------------------------------------------------------------
function [Mean,Std,Min,Max]=FindMean1(var,who)
% Calculate ensemble mean for 1d variables

% Series of characters to search for
sc = var;

% Get the list of variables in the workspace
lv = who;

% Filter the variables starting with the character series
vf = lv(~cellfun('isempty', regexp(lv, sc)));

% Get the values ​​of the filtered variables
v = cellfun(@(x) evalin('base', x), vf);

% Calculate Mean
v(isnan(v))=0;
Mean = mean(v,'omitnan');
Std = std(v,'omitnan');
Min = min(v);
Max = max(v);
end

function [Mean,Std]=FindMean2(var,who,MASK)
% Calculate ensemble mean for 2d variables

% Series of characters to search for
sc = var; 

% Get the list of variables in the workspace
lv = who;

% Filter the variables starting with the character series
vf = lv(~cellfun('isempty', regexp(lv, sc)));

% Get the values ​​of the filtered variables
v = cellfun(@(x) evalin('base', x), vf,'UniformOutput', false);

% Ensemble mean and standard deviation
n=(size(cell2mat(v(1)))); A=zeros(n(1),n(2),length(v));
for i=1:length(v)
    A(:,:,i)=cell2mat(v(i));
end

Mean = mean(A,3,'omitnan');  
Mean(MASK==0)=NaN;

Std = std(A,[],3,'omitnan');    
Std(MASK==0)=NaN;
end

function [Mean,Std]=FindMean3(var,who,MASK)
% Calculate ensemble mean for 3d variables

% Series of characters to search for
sc = var; 

% Get the list of variables in the workspace
lv = who;

% Filter the variables starting with the character series
vf = lv(~cellfun('isempty', regexp(lv, sc)));

% Get the values ​​of the filtered variables
v = cellfun(@(x) evalin('base', x), vf,'UniformOutput', false);

% Ensemble mean and standard deviation
n=(size(cell2mat(v(1)))); A=zeros(n(1),n(2),n(3),length(v));
for i=1:length(v)
    A(:,:,:,i)=cell2mat(v(i));
end

Mean = mean(A,4,'omitnan');  
Mean(MASK==0)=NaN;

Std = std(A,[],4,'omitnan');    
Std(MASK==0)=NaN;
end

function [Mean,Std]=FindMeanBasins(var,who)
% Calculate ensemble mean for each subglacial basin

% Series of characters to search for
sc = var; 

% Get the list of variables in the workspace
lv = who;

% Filter the variables starting with the character series
vf = lv(~cellfun('isempty', regexp(lv, sc)));

% Get the values ​​of the filtered variables
v = cellfun(@(x) evalin('base', x), vf,'UniformOutput', false);

% Ensemble mean and standard deviation
n=(size(cell2mat(v(1)))); A=zeros(n(1),n(2),length(v));
for i=1:length(v)
    A(:,:,i)=cell2mat(v(i));
end

Mean = mean(A,3,'omitnan');  
Std = std(A,[],3,'omitnan');    
end

function [frozen,thawed]=LikelyBasalState(var1,who,MASK)

% Series of characters to search for
sc = var1; % Tbc

% Get the list of variables in the workspace
lv = who;

% Filter the variables starting with the character series
vf = lv(~cellfun('isempty', regexp(lv, sc)));

% Get the values ​​of the filtered variables
v = cellfun(@(x) evalin('base', x), vf,'UniformOutput', false);

% Likely basal thermal state
n=(size(cell2mat(v(1)))); A=zeros(n(1),n(2),length(v)); 

for i=1:length(v)
    A(:,:,i)=cell2mat(v(i));
end

temp_combined = A;
tpmp=-0.5; 

below_fusion = temp_combined < tpmp;
at_fusion = temp_combined >= tpmp;

frozen=zeros(size(below_fusion)); 
thawed=zeros(size(frozen));

for i=1:length(v)
frozen(:,:,i) = below_fusion(:,:,i);
thawed(:,:,i) = at_fusion(:,:,i);
end

frozen = sum(frozen,3)./size(temp_combined,3);
thawed = sum(thawed,3)./size(temp_combined,3);

frozen(MASK~=1)=NaN; 
thawed(MASK~=1)=NaN; 
end