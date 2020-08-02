def generator():
    t = var("t")
    y,yp = mi_vars("y","y'")
    t0 = randrange(-2,3)
    y0 = randrange(-2,3)
    field_sage,ode = choice([
        ("sin(t+y)",yp==sin(t+y)),
        ("cos(t+y)",yp==cos(t+y)),
        ("y/15-t/3",yp==y/15-t/3),
        ("t/3-y/15",yp==-t/3-y/15),
        ("sin(y/2)",yp==sin(y/2)),
        ("cos(y/2)",yp==cos(y/2)),
        ("t*y/9-t/3",yp==t*y/9-t/3),
        ("t*y/9+t/3",yp==t*y/9+t/3),
    ])
    othert = t0+choice([-2,2])
    othery = SR(desolve_rk4(ode.rhs(),y,ivar=t,ics=[t0,y0],end_points=othert,step=0.25)[-1][-1]).n(digits=2)

    return {
        "field_sage": field_sage,
        "ode": ode,
        "y0": y0,
        "t0": t0,
        "othert": othert,
        "othery": othery,
    }
