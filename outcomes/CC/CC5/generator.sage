class Generator(BaseGenerator):
    def data(self):
        t = var("t")
        y,yp,ypp = CheckIt.vars("y","y'","y''")

        odes = []
        yparts = [(exp(t),exp(0*t)),(sin(t),cos(t))]
        shuffle(yparts)
        for ypart in yparts:
            # pick a,c for (D-a)(D+a) and (D^2+c^2) or (D-c)D
            a,c = sample([2,3,4,5],2)
            c = c*choice([-1,1])
            d1,d2 = [randrange(1,4)*choice([-1,1]) for _ in range(2)]
            k1 = var("k_1")
            k2 = var("k_2")
            full_part = d1*ypart[0](t=c*t)+d2*ypart[1](t=c*t)
            odes += [{
                "ode": CheckIt.shuffled_equation(ypp,
                    a*a*y,
                    -full_part.diff().diff() +\
                    -a*a*full_part
                ),
                "ode_sol": 
                    (y==k1*exp(a*t)+k2*exp(-a*t)+full_part),
            }]

        return { "odes": odes }
