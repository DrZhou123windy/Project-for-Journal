function [HT,Kps,J,S,KT] = evaluation_for_potential(poro,perm,tortuosity,radius,cefp,m)
% Parameter description
% poro: porosity
% perm: reservoir permeability 
% poro,perm,tortuosity,radius,cefp: One-dimensional column vector
% KT: effective zoning factor
% m: Numeric Constant
% tortuosity: Pore-throat tortuosity
% radius: pore-throat radius
% cefp: Comprehensive evaluation factor of pore structure
% Kps: pore morphology factor
% S: specific surface area
% J: lithologic index
% HT：characteristic factor of Tiab flow unit

%%  Calculation process 

% parameter validation
    if ~iscolumn(poro) || ~iscolumn(perm) || ~iscolumn(tortuosity) || ~iscolumn(radius) || ~iscolumn(cefp) 
        error('The input vector must be a column vector');
    end
    
    if length(poro) ~= length(perm) || length(poro) ~= length(tortuosity) || length(poro) ~= length(radius) || length(poro) ~= length(cefp) || length(perm) ~= length(tortuosity) || length(perm) ~= length(radius) || length(perm) ~= length(cefp) || length(tortuosity) ~= length(radius) || length(tortuosity) ~= length(cefp) || length(radius) ~= length(cefp)
        error('All vector lengths must be the same');
    end

% HT,Kps,J,S,KT are calculated parameter

% specific surface area calculation

S = 2./radius.*(poro/100)./(1-(poro/100));
assignin('base', 'S', S);

% effective zoning factor calculation

KT = ((poro/100).^3)./(S^2)./((1-(poro/100)).^2)./(perm/1000);
assignin('base', 'KT', KT);

% pore morphology factor calculation
 
Kps = KT./((tortuosity).^2);
assignin('base', 'Kps', Kps);

% lithologic index calculation

J = ((1/KT).^0.5);
assignin('base', 'J', J);

% characteristic factor of Tiab flow unit calculation

HT = Kps.*((poro/100).^(1-m)).*(S^2);
assignin('base', 'HT', HT);

end