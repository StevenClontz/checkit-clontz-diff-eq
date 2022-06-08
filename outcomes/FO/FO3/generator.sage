class Generator(BaseGenerator):
    def data(self):
        t,y,u,k = var("t y u k")
        yp = var("yp", latex_name="y'")
        up = var("up", latex_name="u'")
        m,n,s,r,q = sample(range(2,8),5)
        s,r = [_*choice([-1,1]) for _ in [s,r]]
        b = (m-n)*choice([-1,1])*randrange(2,5)
        linear = (t*up-n*u==b*t^m)
        linear_sol = (u == k*t^n+b/(m-n)*t^m)
        subs = [y/t,y^(-q),r*t+s*y]
        odes = [
            {
                "ode": expand(CheckIt.shuffled_equation(
                    yp*t,
                    -(n+1)*y,
                    -b*t^(m+1)
                )*t^(randrange(2,5))),
                "sol": (subs[0]==linear_sol.rhs()),
            },
            {
                "ode": expand(CheckIt.shuffled_equation(
                    n,
                    q*t*y*yp,
                    b*t^m*y^q
                )*t^(randrange(2,5))),
                "sol": (subs[1]==linear_sol.rhs()),
            },
            {
                "ode": expand(CheckIt.shuffled_equation(
                    (r-n*r)*t,
                    s*t*yp,
                    -n*s*y,
                    -b*t^m
                )*t^(randrange(2,5))),
                "sol": (subs[2]==linear_sol.rhs()),
            },
        ]
        shuffle(odes)

        return {
            "odes":odes, 
            "linear":linear,
            "linear_sol":linear_sol,
            "sub0": (u==subs[0]),
            "sub1": (u==subs[1]),
            "sub2": (u==subs[2]),
        }
