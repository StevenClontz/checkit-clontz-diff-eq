def generator():
    t = var("t")
    y,yp,ypp = mi_vars("y","y'","y''")

    def cclinear():
        # pick a,b for (D-a)(D-b)
        a = randrange(1,5)*choice([-1,1])
        b = randrange(5,9)*choice([-1,1])
        return {
            "ode": shuffled_equation(ypp,(-a-b)*yp,a*b*y),
            "form": "linear homogeneous with constant coefficients",
            "strategy": "using D-notation and factoring",
        }
    def folinear():
        # pick n for y=kx^n
        n = randrange(2,6)*choice([-1,1])
        # pick coefficient
        k = randrange(1,5)*choice([-1,1])
        # particular solution
        kp = randrange(1,6)*choice([-1,1])
        m = n
        while m==n:
            m = randrange(1,5)
        part_sol = kp*t^m
        ts = n*part_sol-t*part_sol.diff()
        return {
            "ode": shuffled_equation(ts,t*yp,-n*y),
            "form": "linear first-order",
            "strategy": "solving its homogeneous form and "+\
                "then using variation of parameters, or using an integrating factor",
        }
    def ccdis():
        # pick a,b for (D+a)(D-a)
        a = randrange(2,10)
        # pick d(t-b) or u(t-b)
        b = randrange(1,8)
        dis = choice([dirac_delta(t-b),unit_step(t-b)])*choice([-1,1])*randrange(2,8)
        return {
            "ode": shuffled_equation(ypp,-a^2*y,dis),
            "form": "linear constant-coefficient with a discontinuous function",
            "strategy": "using Laplace transforms",
        }
    def exact():
        terms = [
            randrange(1,6)*choice([-1,1])*t^randrange(2,5),
            randrange(1,6)*choice([-1,1])*y^randrange(2,5),
        ]
        extra_terms = [
            randrange(1,6)*choice([-1,1])*t*y,
            randrange(1,6)*choice([-1,1])*t*y^2,
            randrange(1,6)*choice([-1,1])*t^2*y,
            randrange(1,6)*choice([-1,1])*t^2*y^2
        ]
        terms.append(choice(extra_terms))
        # pick initial values
        ode = shuffled_equation(
            terms[0].diff(t),
            terms[1].diff(t),
            terms[2].diff(t),
            terms[0].diff(y)*yp,
            terms[1].diff(y)*yp,
            terms[2].diff(y)*yp,
        )
        return {
            "ode": ode,
            "form": "exact",
            "strategy": "finding a potential function",
        }

    odes = [cclinear(),folinear(),ccdis(),exact()]
    shuffle(odes)
    return {
        "odes": odes,
    }