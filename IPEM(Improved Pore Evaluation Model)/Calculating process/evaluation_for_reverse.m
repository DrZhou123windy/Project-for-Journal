function [tortuosity,radius,cefp,Sw,VSH] = evaluation_for_reverse(poro,GR,m,n0,Rt)
% Parameter description
% poro: porosity
% GR: Natural Gamma Value
% Rt: formation resistivity
% VSH:shale content
% poro,os,Rt: One-dimensional column vector
% m,n0: Numeric Constant
% Sw: water saturation
% tortuosity: Pore-throat tortuosity
% radius: pore-throat radius
% cefp: Comprehensive evaluation factor of pore structure

%%  Calculation process 

% parameter validation
    if ~iscolumn(poro) ||  ~iscolumn(GR) ||  ~iscolumn(Rt) 
        error('The input vector must be a column vector');
    end
    
    if length(poro) ~= length(GR) || length(poro) ~= length(Rt) || length(GR) ~= length(Rt)
        error('All vector lengths must be the same');
    end

% Sw and VSH is the calculated parameter

% water saturation calculation

VSH =((2.^(2.*((GR-30)/(155-30)))-1)/(2^2-1))*100;
assignin('base', 'VSH', VSH);

Sw =(((1.1282*0.8972*0.168./(Rt.*(poro/100).^m)).^(1/2)))*100-VSH;
assignin('base', 'Sw', Sw);

% tortuosity calculation
 
tortuosity = ((((poro/100).^(1-m)).*(1.1282*0.8972).*(((Sw)/100).^(1-2)))).^0.5;
assignin('base', 'tortuosity', tortuosity);

% radius calculation

radius = (3.141592654^(-1/2)).*((((poro/100).^(1+m)).*((1.1282*0.8972)^(-1)).*(((Sw)/100).^(2-1))).^0.25).*(n0^(-1/2))*1000000;
assignin('base', 'radius', radius);

% cefp calculation
cefp = radius/tortuosity;
assignin('base', 'cefp', cefp);

end