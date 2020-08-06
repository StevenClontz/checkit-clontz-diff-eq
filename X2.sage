def generator():
    """
    Generates
    p(t)y'+q(t)y=r(t).
    One function has no zeros,
    one function has a unique zero,
    the last has two zeros.
    """
    t,y = var('t y')
    order = choice([2,3])
    if choice([True,False]):
        yp = var("yp", latex_name="y'")
        ypp = var("ypp", latex_name="y''")
    else:
        yp = var("yp", latex_name="y''")
        ypp = var("ypp", latex_name="y'''")
    zeros = [
        randrange(-6,-3),
        randrange(-2,3),
        randrange(5,7)
    ]
    shuffle(zeros)
    pqr = [
        choice([
            exp(t*randrange(1,6)*choice([-1,1])),
            t^2+randrange(1,6)^2
        ]),
        choice([
            t-zeros[0],
#            exp(randrange(2,6)*(t-zeros[0]))-1,
            exp(t)*(t-zeros[0])
        ]),
        choice([
            (t-zeros[1])*(t-zeros[2]),
        ]),
    ]
    constant = randrange(1,6)*choice([-1,1])
    roll = randrange(1,3)
    if roll == 0: #dummied out
        # p has no zeroes, thm says all real numbers
        p = pqr[0]
        others = [pqr[1],pqr[2]]
        shuffle(others)
        q,r=others
        t0 = randrange(-6,7)
        x0 = randrange(-6,7)
        interval = "(-\\infty,+\\infty)"
    elif roll == 1:
        # p has one zero, zeros[0], randomly choose left or right
        p = pqr[1]
        others = [pqr[0],pqr[2]]
        shuffle(others)
        q,r=others
        if choice([True,False]):
            t0 = zeros[0] - randrange(1,5)
            x0 = zeros[0] + randrange(1,5)
            interval = f"(-\\infty,{zeros[0]})"
        else:
            t0 = zeros[0] + randrange(1,5)
            x0 = zeros[0] - randrange(1,5)
            interval = f"({zeros[0]},+\\infty)"
    else:
        # p has two zeros, zeros[1] and zeros[2], choose random between them
        p = pqr[2]
        others = [pqr[0],pqr[1]]
        shuffle(others)
        q,r=others
        z1 = min([zeros[1],zeros[2]])
        z2 = max([zeros[1],zeros[2]])
        t0 = randrange(z1+1,z2)
        x0 = choice([z1-randrange(1,5),z2+randrange(1,5)])
        interval = f"({z1},{z2})"
    ode = shuffled_equation(p*ypp,q*y,r,constant*yp)

    return {
        "ode": ode,
        "interval": interval,
        "t0": t0,
        "x0": x0,
    }
