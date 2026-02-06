function [tortuosity,radius,cefp] = evaluation_for_real(poro,os,Rt,n0)
% Parameter description
% poro: porosity
% os: oil saturation
% Rt: formation resistivity
% poro,os,Rt: One-dimensional column vector
% n0: Numeric Constant
% tortuosity: Pore-throat tortuosity
% radius: pore-throat radius
% cefp: Comprehensive evaluation factor of pore structure

%%  Calculation process 

% parameter validation
    if ~iscolumn(poro) || ~iscolumn(os) || ~iscolumn(Rt)
        error('The input vector must be a column vector');
    end
    
    if length(poro) ~= length(os) || length(os) ~= length(Rt)
        error('All vector lengths must be the same');
    end

% tortuosity calculation
 
tortuosity = (((poro/100).*((0.168/Rt).^(-1)).*((100-os)./100))).^0.5;
assignin('base', 'tortuosity', tortuosity);

% radius calculation

radius = (3.141592654^(-1/2)).*(((poro/100).*(0.168/Rt).*(((100-os)./100).^(-1))).^0.25).*(n0^(-1/2))*1000000;
assignin('base', 'radius', radius);

% cefp calculation
cefp = radius/tortuosity;
assignin('base', 'cefp', cefp);

end