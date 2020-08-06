def generator():
    """
    Generates
    y'=F(t,y)
    where F is discontinuous/nondifferentiable
    at certain points
    """
    t = var('t')
    y,yp = mi_vars("y","y'")
    t0,y0,b = [randrange(2,7)*choice([-1,1]) for _ in range(3)]
    a = randrange(2,4)
    powerd = choice([3,5])
    powern = choice([1,2,4,7,8])
    F = choice([
       randrange(2,7)*(a*y+b*t-a*y0-b*t0)^(powern/powerd),
    ])
    unique = (powerd<powern)

    return {
        "F": F,
        "Fy": F.diff(y),
        "t0": t0,
        "y0": y0,
        "unique": unique,
    }
