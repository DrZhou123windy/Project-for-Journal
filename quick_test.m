function [tortuosity,radius,cefp,Sw,VSH] = quick_test(poro,Rt,GR,m,n0)
% Parameter description
% poro: porosity
% Rt: formation resistivity
% poro,os,Rt: One-dimensional column vector
% m,n0: Numeric Constant
% Sw: water saturation
% tortuosity: Pore-throat tortuosity
% radius: pore-throat radius
% cefp: Comprehensive evaluation factor of pore structure

%%  Calculation process

m=1.72;
n0=2.266e+9;
poro=[11.8,11.8,11.1];
Rt=[12.39,12.87,20.41];
GR=[104.53,86.87,99.63];

% Sw is the calculated parameter

% water saturation calculation

VSH =((2.^(2.*((GR-30)/(155-30)))-1)/(2^2-1))*100;

Sw =(((1.1282*0.8972*0.168./(Rt.*(poro/100).^m)).^(1/2)))*100-VSH;

% tortuosity calculation
 
tortuosity = ((((poro/100).^(1-m)).*(1.1282*0.8972).*(((Sw)/100).^(1-2)))).^0.5;

% radius calculation

radius = (3.141592654^(-1/2)).*((((poro/100).^(1+m)).*((1.1282*0.8972)^(-1)).*(((Sw)/100).^(2-1))).^0.25).*(n0^(-1/2))*1000000;

% cefp calculation
cefp = radius/tortuosity;

fprintf('The output result of cefp is shown in the following array\n');

end