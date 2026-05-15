function val = degalbet(x,dim,irs,led)
    lt = irs.xt;
    nt = irs.nt;
    l = led.l;

    d1 = dot((l-lt)',nt')';
    d2 = dot((x-lt)',nt')' ;
    n1 = nnorm(l-lt);
    n2 = nnorm(x-lt);
    nc1 = nnorm(ccros(x-lt,nt));
    nc2 = nnorm(ccros(l-lt,nt));
    nd1 = nt(:,dim);
    nd2 = nt(:,f_l(dim+1));
    nd3 = nt(:,f_l(dim+2));
    xd1 = x(:,dim);
    xd2 = x(:,f_l(dim+1));
    xd3 = x(:,f_l(dim+2));
    ltd1 = lt(:,dim);
    ltd2 = lt(:,f_l(dim+1));
    ltd3 = lt(:,f_l(dim+2));
    
    val.cosalpha = d1./n1;
    val.sinalpha = (1-val.cosalpha.^2).^0.5;   

    kcos1 = d2.*d1;
    kcos2 = n2.*n1;
    kcos3 = nc1.*nc2;
    val.cosbetminal = (kcos1+kcos3)./kcos2;
    
    dercos1 = nd1.*n2.^(-1);
    dercos2 = d2.*n2.^(-3).*(xd1-ltd1);
    dercos3 = nc1.^(-1);
    dercos4 = nd2.*((xd1-ltd1).*nd2-(xd2-ltd2).*nd1);
    dercos5 = nd3.*((xd3-ltd3).*nd1-(xd1-ltd1).*nd3);
    dercos6 = n2.^(-1);
    dercos7 = n2.^(-3).*(xd1-ltd1).*nc1;
    
    val.dercosbetminal = val.cosalpha.*(dercos1-dercos2)+val.sinalpha.*(dercos3.*(dercos4-dercos5).*dercos6-dercos7);
end