function e_ff = effectiveClearance(Pu,Pd,D,mdot,T)
    if nargin == 0 
        Pu = 10000 ;
        Pd = 10100 ;
        D = 0.75 ;
        mdot = 10 ;
        T = 273 + 21 ;
    end
    gamma = 1.4 ;
    R = D/2 ;
    if Pu/Pd < (2/(gamma+1))^(-gamma/(gamma-1))
        Q = sqrt( (2*gamma/(R*(gamma-1))) * ( (Pu/Pd)^(-2/gamma) - (Pu/Pd)^(-(gamma-1)/gamma) ) ) ;
    else
        Q = sqrt( gamma/R * (2/(gamma+1)^((gamma+1)/(gamma-1))) ) ;
    end
    e_ff = (mdot*sqrt(T))/(pi*Pu*D*Q) ;
end