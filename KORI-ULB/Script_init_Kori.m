% ----------------------------------------------------------------------- %
%        Estimates of basal and englacial thermal conditions              %
%                    of the Antarctic ice sheet                           %
%                                                                         %
%                         Olivia RASPOET                                  %
%                          Frank PATTYN                                   %
%                                                                         %
%                   Laboratoire de Glaciologie                            %
%                 Université Libre de Bruxelles                           %
%                                                                         %
%                              2025                                       %
%                                                                         %
%   Script used to run the simulations with the Kori-ULB ice flow model   %
%                                                                         %
% ----------------------------------------------------------------------- %

clear ctr;

% Run the model without graphical outputs (3)
% Run the model with graphical outputs (1)
ctr.runmode=3;

% Choose climate model
MAR=0;
RACMO=1;

% Choose GHF
HF=4;

% Choose thermodynamic model
Constant=0;
Enthalpy=1;

% Choose between Kori-ULB Opt (KoriVobs=0) or Kori-ULB Obs (KoriVobs=1)
% Kori-ULB Opt: optimization following a two steps procedure
KoriVobs=0;

% Bedmachine file contains the necessary variables to run the model
% B,Bo,Bor,Btau,Db,H,Ho,lat,lon,MASK,MASKo,Mb,So,stdB,To,Ts,v,vx,vy,ZB
% The Bedmachine files are not provided in this repository
% Additional information about the model and input data 
% can be found at: https://github.com/FrankPat/Kori-ULB

if MAR==1
init_file=['Bedmachinev3_8km_MAR_HF',num2str(HF)];
elseif RACMO==1
init_file=['Bedmachinev3_8km_racmo_HF',num2str(HF)];
end

% Domain
ctr.imax=701;
ctr.jmax=701;
ctr.delta=8.e3;
ctr.kmax=21; % number of vertical layers

% First initialization
ctr.dt=10; 
ctr.nsteps=10001; 
ctr.inverse=1;
ctr.Tinit=1;
ctr.Tinv=200; %=200
ctr.Hinv=500; %=500

% basal sliding
ctr.m=3;
ctr.subwaterflow=1; % water routing

if KoriVobs==1
   ctr.obsv=1;
else
   ctr.obsv=0;
end

if Constant==1
    ctr.cst=1; cst=1; % constant K and Cp
else
    ctr.cst=0; cst=0; % K(T) and Cp(T)
end

if Enthalpy==1
    ctr.enthalpy=1;
    ctr.ENTM=1; % corrector step in the cold part
    ctr.drain=2; % drainage function 
    ctr.Tcalc=3; % influence of water content on thermomechanical coupling
else
    ctr.enthalpy=0;
    ctr.Tcalc=2; % thermomechanical coupling
end

% load(init_file,'MASK','ZB');
% ctr.Asin=zeros(ctr.imax,ctr.jmax)+1e-10;
% ctr.Asin(MASK==3)=1e-6; %=1e-7
% ctr.Asin(MASK==0)=1e-5; %=1e-6
% clear MASK

if MAR==1
filenameSIA=['Test25km_SIA_MAR_HF',num2str(HF)];
elseif RACMO==1
filenameSIA=['Test25km_SIA_racmo_HF',num2str(HF)];
end

if ctr.obsv==1
    filenameSIA=[filenameSIA,'_vobs'];
end
if ctr.enthalpy==1
    filenameSIA=[filenameSIA,'_enth'];
end
if ctr.cst==1
   filenameSIA=[filenameSIA,'_cst'];
end

if Enthalpy==1
KoriModelEnth(init_file,filenameSIA,ctr);
else
KoriModelAll(init_file,filenameSIA,ctr);
end

%% Second initialization
if KoriVobs==0

ctr.dt=0.1; % smaller time step
ctr.nsteps=20001; % more iterations

ctr.Tinit=0; % initialization with analytical solution (1)
ctr.Tinv=20; %=200
ctr.Hinv=500; %=500
ctr.HinvMelt=100;
ctr.TinvMelt=10;

ctr.inverse=2; % optimization of basal sliding coefficients
ctr.SSA=2; % hybrid model
ctr.shelf=1; % add ice shelves
ctr.GroundedMelt=2; % keep grounding line at observed position (2)
ctr.calving=4; % keep calving front at observed position (4)

if ctr.GroundedMelt<2
    ctr.schoof=1; % flux condition due to coarse grid
else
    ctr.schoof=0; % no flux condition because of fixed ice sheet geometry
end

if MAR==1
filenameSIA=['Test25km_SIA_MAR_HF',num2str(HF)];
filename=['Test25km_HySSA',num2str(ctr.GroundedMelt),'_MAR_HF',num2str(HF)];
elseif RACMO==1
filenameSIA=['Test25km_SIA_racmo_HF',num2str(HF)];
filename=['Test25km_HySSA',num2str(ctr.GroundedMelt),'_racmo_HF',num2str(HF)];
end

if ctr.enthalpy==1
   filenameSIA=[filenameSIA,'_enth'];
   filename=[filename,'_enth'];
end
if ctr.cst==1
   filenameSIA=[filenameSIA,'_cst'];
   filename=[filename,'_cst'];
end

% Second optimization
if Enthalpy==1
KoriModelEnth(filenameSIA,filename,ctr);
else
KoriModelAll(filenameSIA,filename,ctr);
end
end