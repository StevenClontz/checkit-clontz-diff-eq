def generator():
    t = var("t")
    y,yp,ypp = mi_vars("y","y'","y''")

    if choice([True,False]):
        # pick n for y=kx^n
        n = randrange(2,4)*choice([-1,1])
        # pick initial value
        t0 = randrange(1,5)*choice([-1,1])
        # pick coefficient
        k = randrange(1,5)*choice([-1,1])
        ode = shuffled_equation(t*yp,-n*y)*choice([2,3])
        ivp_sol = (y == k*t^n)
        y0 = k*t0^n
    else:
        # pick p(t) for y=e^p(t)
        p = choice([
          randrange(1,4)*choice([-1,1])*
            t^2+randrange(-3,4)*t+randrange(-5,6),
          randrange(1,4)*choice([-1,1])*cos(t),
          randrange(1,4)*choice([-1,1])*sin(t)
        ])
        # pick coefficient
        k = randrange(1,5)*choice([-1,1])
        ode = shuffled_equation(yp,-p.diff()*y)*choice([2,3])
        ivp_sol = (y==k*exp(p))
        t0=0
        y0 = k*exp(p(t=t0))

    return {
        "ode": ode,
        "t0": t0,
        "y0": y0,
        "ivp_sol": ivp_sol,
    }
