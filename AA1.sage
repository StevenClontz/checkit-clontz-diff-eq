def generator():
    def exp_ivp(t,y,yp,ypp):
        # pick a,b for (D-a)(D-b)
        a = randrange(1,6)*choice([-1,1])
        b=a
        while a==b:
            b = randrange(1,6)*choice([-1,1])
        # pick particular solution
        k1 = choice([-1,1])*randrange(1,6)
        k2 = 0
        ode = shuffled_equation(ypp,-(a+b)*yp,a*b*y)
        ivp_sol = (y == k1*exp(a*t)+k2*exp(b*t))
        iv1 = k1+k2
        iv2 = a*k1+b*k2
        return {
            "ode": ode,
            "order": "2nd",
            "y0": iv1,
            "t0": 0,
            "yp0": iv2,
            "sol": ivp_sol,
            "y": y,
            "t": t,
            "ex_im": "explicit",
        }
    def exact(t,y,yp,ypp):
        n=randrange(2,5)
        k=randrange(1,6)*choice([-1,1])
        terms = [
            y^n,
            k*t*y,
        ]
        f = sum(terms)
        # pick initial values
        ivs = [-1,1]
        shuffle(ivs)
        t0,y0=ivs
        f0 = y0^n+k*t0*y0
        ode = shuffled_equation(
            terms[0].diff(t),
            terms[1].diff(t),
            terms[0].diff(y)*yp,
            terms[1].diff(y)*yp,
        )
        return {
                "ode": ode,
                "order": "1st",
                "t0": t0,
                "y0": y0,
                "sol": (f==f0),
                "ex_im": "implicit",
                "y": y,
                "t": t,
        }
    def folin(t,y,yp,ypp):
        # pick n for y=kx^n
        n = randrange(2,6)
        # pick initial value
        t0 = choice([-1,1])
        # pick coefficient
        k = randrange(1,5)*choice([-1,1])
        hom_sol = k*t^n
        # particular solution
        kp = randrange(1,6)*choice([-1,1])
        m = n
        while m==n:
            m = randrange(1,5)
        part_sol = kp*t^m
        ts = n*part_sol-t*part_sol.diff()
        ode = shuffled_equation(ts,t*yp,-n*y)
        ivp_sol = (y==k*t^n+part_sol)
        y0 = k*t0^n+kp*t0^m

        return {
            "ode": ode,
            "order": "1st",
            "t0": t0,
            "y0": y0,
            "sol": ivp_sol,
            "ex_im": "explicit",
            "y": y,
            "t": t,
        }

    t,x,y = var("t x y")
    xp = var("xp",latex_name="x'")
    yp = var("yp",latex_name="y'")
    xpalt = var("xpalt",latex_name="\\frac{dx}{dt}")
    ypalt = var("ypalt",latex_name="\\frac{dy}{dt}")
    ypalx = var("ypalx",latex_name="\\frac{dy}{dx}")
    xpp = var("xpp",latex_name="x''")
    ypp = var("ypp",latex_name="y''")
    xppalt = var("xppalt",latex_name="\\frac{d^2x}{dt^2}")
    yppalt = var("yppalt",latex_name="\\frac{d^2y}{dt^2}")
    yppalx = var("yppalx",latex_name="\\frac{d^2y}{dx^2}")
    variables = [
        [t,y,yp,ypp],
        [x,y,yp,ypp],
        [t,x,xp,xpp],
        [t,y,ypalt,yppalt],
        [x,y,ypalx,yppalx],
        [t,x,xpalt,xppalt],
    ]
    shuffle(variables)
    ivps = [
        exact(*variables[0]),
        folin(*variables[1]),
        exp_ivp(*variables[2]),
    ]
    shuffle(ivps)
    return {"ivps": ivps,"foo":variables}
