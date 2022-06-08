class Generator(BaseGenerator):
    def data(self):
        t = var("t")
        y = var("y")
        d = dirac_delta
        u = unit_step

        a,b,c,k,l = sample(range(2,10),5)
        a,b,c = sorted([a,b,c])
        integrand = k*l*d(t-a)*exp(l*t)
        value = 0
        ints = [{"b":b,"c":c,"integrand":integrand,"value":value}]
        
        a,b,c,k,l = sample(range(2,10),5)
        a,b,c = sorted([a,b,c])
        integrand = k*l*d(t-b)*exp(l*t)
        value = k*l*exp(l*b)
        ints += [{"b":a,"c":c,"integrand":integrand,"value":value}]
        
        a,b,c,k,l = sample(range(2,10),5)
        a,b,c = sorted([a,b,c])
        integrand = k*l*d(t-c)*exp(l*t)
        value = 0
        ints += [{"b":a,"c":b,"integrand":integrand,"value":value}]

        a,b,c,k,l = sample(range(2,10),5)
        a,b,c = sorted([a,b,c])
        integrand = k*l*u(t-a)*exp(l*t)
        value = k*exp(l*c)-k*exp(l*b)
        ints += [{"b":b,"c":c,"integrand":integrand,"value":value}]
        
        a,b,c,k,l = sample(range(2,10),5)
        a,b,c = sorted([a,b,c])
        integrand = k*l*u(t-b)*exp(l*t)
        value = k*exp(l*c)-k*exp(l*b)
        ints += [{"b":a,"c":c,"integrand":integrand,"value":value}]
        
        a,b,c,k,l = sample(range(2,10),5)
        a,b,c = sorted([a,b,c])
        integrand = k*l*u(t-c)*exp(l*t)
        value = 0
        ints += [{"b":a,"c":b,"integrand":integrand,"value":value}]

        shuffle(ints)

        return {"integrals":ints}
