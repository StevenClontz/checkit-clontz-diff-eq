def generator():
    t,y = var("t y")
    yp = var("yp", latex_name="y'")

    terms = [
        randrange(1,6)*choice([-1,1])*t^randrange(2,5),
        randrange(1,6)*choice([-1,1])*y^randrange(2,5),
        randrange(1,6)*choice([-1,1])*t*y,
        randrange(1,6)*choice([-1,1])*t*y^2,
        randrange(1,6)*choice([-1,1])*t^2*y,
        randrange(1,6)*choice([-1,1])*t^2*y^2
    ]
    shuffle(terms)
    f = sum(terms[:3])
    # pick initial values
    ivs = [-1,1]
    shuffle(ivs)
    t0,y0=ivs
    f0 = f(t=t0,y=y0)
    exact_ode =    shuffled_equation(
        terms[0].diff(t),
        terms[1].diff(t),
        terms[2].diff(t),
        terms[0].diff(y)*yp,
        terms[1].diff(y)*yp,
        terms[2].diff(y)*yp,
    )
    nonexact_ode = shuffled_equation(
        terms[0].diff(t),
        terms[2].diff(t),
        terms[4].diff(t),
        terms[1].diff(y)*yp,
        terms[3].diff(y)*yp,
        terms[5].diff(y)*yp,
    )
    odes = [
        exact_ode,
        nonexact_ode,
    ]
    shuffle(odes)

    return {
        "odes": odes,
        "exact_ode": exact_ode,
        "t0": t0,
        "y0": y0,
        "solution": (f==f0),
    }
