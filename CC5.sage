def generator():
    t = var("t")
    y,yp,ypp = mi_vars("y","y'","y''")

    # pick a,b for (D-a)(D-b)
    a = randrange(1,5)*choice([-1,1])
    b=a
    while a==b:
        b = randrange(1,5)*choice([-1,1])
    # pick particular solution
    c=a
    while c in [a,b]:
        c = choice([2,3,5])
    d = randrange(1,4)*choice([-1,1])
    d2 = randrange(1,4)*choice([-1,1])
    ypart = choice([
        d*exp(c*t)+d2,
        d*sin(c*t),
        d*cos(c*t),
    ])
    k1 = var("k_1")
    k2 = var("k_2")
    ode = shuffled_equation(ypp-(a+b)*yp,a*b*y,-ypart.diff().diff()+(a+b)*ypart.diff()-a*b*ypart)
    ode_sol = (y==k1*exp(a*t)+k2*exp(b*t)+ypart)

    return {
        "ode": ode,
        "ode_sol": ode_sol,
    }