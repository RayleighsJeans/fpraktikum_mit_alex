function out = resfunc(param, omega, data)
    out = ( ( param(2)^2 - omega.^2 ).^2 + param(3)^2.*omega.^2 ).^0.5;
    out = param(1)./out - data;
end