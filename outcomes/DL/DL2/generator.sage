class Generator(BaseGenerator):
    def data(self):
        t = var("t")
        s = var("s")
        d = dirac_delta
        u = unit_step
        k = choice([-1,1])*randrange(2,5)
        m = choice([-1,1])*randrange(2,4)
        n = choice([-1,1])*randrange(2,5)
        q = choice([-1,1])*randrange(2,5)
        p = randrange(2,5)
        a = randrange(1,5)
        b = randrange(2,5)
        c = randrange(2,5)
        use_u = choice([True,False])
        use_sin = choice([True,False])
        pretransform = k+m*t^p
        if use_u:
            pretransform += n*u(t-a)
        else:
            pretransform += n*d(t-a)
        if use_sin:
            pretransform += q*sin(b*t)
        else:
            pretransform += q*cos(b*t)
        transform = k/s+m*factorial(p)/s^(p+1)
        if use_u:
            transform += n*e^(-a*s)/s
        else:
            transform += n*e^(-a*s)
        if use_sin:
            transform += q*b/(s^2+b^2)
        else:
            transform += q*s/(s^2+b^2)
        e_pretransform = b*e^(c*t)
        e_transform = b/(s-c)

        return {
            "pretransform": pretransform,
            "transform": transform,
            "e_pretransform": e_pretransform,
            "e_transform": e_transform,
        }