function [tortuosity,radius,cefp,Sw] = evaluation_for_m(poro,Rt,m,n0)
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

% parameter validation
    if ~iscolumn(poro) ||  ~iscolumn(Rt) 
        error('The input vector must be a column vector');
    end
    
    if length(poro) ~= length(Rt) 
        error('All vector lengths must be the same');
    end

% Sw is the calculated parameter

% water saturation calculation

Sw =(((1.1282*0.8972*0.168./(Rt.*(poro/100).^m)).^(1/2)))*100;
assignin('base', 'Sw', Sw);

% tortuosity calculation
 
tortuosity = (((poro/100).*((0.168/Rt).^(-1)).*((Sw)/100))).^0.5;
assignin('base', 'tortuosity', tortuosity);

% radius calculation

radius = (3.141592654^(-1/2)).*(((poro/100).*(0.168/Rt).*(((Sw)/100).^(-1))).^0.25).*(n0^(-1/2))*1000000;
assignin('base', 'radius', radius);

% cefp calculation
cefp = radius/tortuosity;
assignin('base', 'cefp', cefp);

end