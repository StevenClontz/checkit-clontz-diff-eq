class Generator(BaseGenerator):
    def data(self):
        t = var("t")
        s = var("s")
        d = dirac_delta
        u = unit_step
        dis = [d,u]
        shuffle(dis)
        trig = [sin,cos]
        shuffle(trig)
        tf = []
        for i in [0,1]:
            k = choice([-1,1])*randrange(2,7)
            m = choice([-1,1])*randrange(2,7)
            n = choice([-1,1])*randrange(2,7)
            q = choice([-1,1])*randrange(2,7)
            r = choice([-1,1])*randrange(2,7)
            p = randrange(3,5)
            a = randrange(1,7)
            b = randrange(2,7)
            c = randrange(2,7)
            w = randrange(2,7)
            pretransform = k+m*t^p+r*exp(w*t)
            pretransform += n*dis[i](t-a)
            pretransform += q*trig[i](b*t)
            transform = k/s+m*factorial(p)/s^(p+1)+r/(s-w)
            if dis[i]==u:
                transform += n*e^(-a*s)/s
            else:
                transform += n*e^(-a*s)
            if trig[i]==sin:
                transform += q*b/(s^2+b^2)
            else:
                transform += q*s/(s^2+b^2)
            tf += [{"pre":pretransform,"post":transform}]
        
        e_pretransform = b*e^(c*t)
        e_transform = b/(s-c)

        return {
            "pretransform": tf[0]["pre"],
            "transform": tf[0]["post"],
            "pretransform2": tf[1]["pre"],
            "transform2": tf[1]["post"],
            "e_pretransform": e_pretransform,
            "e_transform": e_transform,
        }