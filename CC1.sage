def generator():
    t = var("t")
    y, yp = mi_vars("y", "y'")

    # pick a for y'-ay
    a = randrange(2,4)*choice([-1,1])
    b = choice([-1,1])*randrange(2,6)
    ode = shuffled_equation(b*yp,-b*a*y)
    k = var("k")
    ode_sol = (y==k*exp(a*t))
    t0 = ln(randrange(2,4))
    k0 = choice([-1,1])*randrange(2,5)
    y0 = k0*exp(a*t0)
    ivp_sol = (y==k0*exp(a*t))

    return {
        "ode": ode,
        "ode_sol": ode_sol,
        "ivp_sol": ivp_sol,
        "y0": y0,
        "t0": t0,
    }