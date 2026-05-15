function der = dernlos(x,nb,dim,led,irs)
    lt = irs.xt;
    nt = irs.nt;
    l = led.l;
    n = led.n;
    m = 5;
    A = irs.size(1)*irs.size(2);
    pk = 0.95;
    muk = 5;
    rk = 0;
    Apd = 1e-4;
    irsVis = irsVisibility(x,nb,irs,led);
    angles = degalbet(x,dim,irs,led);
    ang = angles.cosbetminal;
    derang = angles.dercosbetminal;

    d1 = ((lt-l)*n');
    d2 = dot((l-lt)',nt')';
    d3 = ((lt-x)*nb');
    d4 = dot((x-lt)',nt')';
    n1 = nnorm(l-lt);
    n2 = nnorm(x-lt);
    nd1 = nt(:,dim);
    nb1 = nb(:,dim);
    xd1 = x(:,dim);
    ltd1 = lt(:,dim);

    val1 = (m+1)*pk*Apd*A*d1.^(m).*d2.*irsVis./(4*pi^2.*n1.^(m+3));
    val2_1 = (nd1.*d3-nb1.*d4).*n2.^(-4);
    val2_2 = -4*n2.^(-6).*(xd1-ltd1).*d4.*d3;
    val2 = 2*rk.*(val2_1+val2_2);
    val3_1 = (1-rk)*(1+muk);
    val3_2 = ang.^muk.*(-1*nb1*n2.^(-3)-3.*d3.*n2.^(-5).*(xd1-ltd1));
    val3_3 = muk.*ang.^(muk-1).*d3.*derang./(n2.^(3));
    val3 = val3_1.*(val3_2+val3_3);
    der = val1.*(val2+val3);
end