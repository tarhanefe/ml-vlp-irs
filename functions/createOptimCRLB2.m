function [CRLBList,points_n] = createOptimCRLB2(N,initial,algorithm)
    pd = placePDs(1,[0.5;0.5;0.85],[0;0;0]);
    led = placeLEDs(1);
    led.m = 20;
    irs_p1d = 21;
    r = 0.5;
    mu = 5;
    irs = placeIRS(irs_p1d,1,r,mu);
    dim = 3;
    sig_dB = 150;
    sig = 10.^(-sig_dB/20);
    [irs_prof,points_n] = optimizeIrsProfiles2(pd,led,irs,N,initial,algorithm,sig);
    CRLBList = [];
    noise_range = 100:5:150;
    for i = noise_range
        sig = 10.^(-i/20);
        crlb_dum = calcCRLB(led,pd,irs_prof,sig,dim,'LOS_IRS');
        CRLBList = horzcat(CRLBList,crlb_dum);
    end
end