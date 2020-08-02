def generator():
    t = var("t")
    y, yp = mi_vars("y", "y'")

    # pick a for y'-ay
    a = randrange(1,6)*choice([-1,1])

    # particular solution
    b=a
    while (b==a):
        b = randrange(1,6)*choice([-1,1])
    c = choice([-3,-2,2,3])
    part_sol = choice([
        c*exp(b*t),
        c*exp(a*t)*t,
        c*exp(a*t)*sin(b*t),
        c*exp(a*t)*cos(b*t)
    ])
    d = choice([-1,1])*randrange(1,5)
    ode = shuffled_equation(yp,-a*y,-part_sol.diff()+a*part_sol)*d
    k = var("k")
    ode_sol = (y==k*exp(a*t)+part_sol)

    return {
      "ode": ode,
      "ode_sol": ode_sol
    }
