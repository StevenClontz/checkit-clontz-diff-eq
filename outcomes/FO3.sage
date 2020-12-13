def generator():
    t,y,u = var("t y u")
    yp = var("yp", latex_name="y'")
    up = var("up", latex_name="u'")
    cons = list(srange(3,9))
    shuffle(cons)
    m,n,p,q,a,b=cons
    linear = (up+m*t^p*u==n*t^q)
    odes = [
        {
            "ode": shuffled_equation(yp*t,-y,m*t^(p+1)*y,-n*t^(q+2)),
            "sub": (u==y/t)
        },
        {
            "ode": shuffled_equation(a,b*yp,a*m*t^(p+1),b*m*y*t^p,-n*t^q),
            "sub": (u==a*t+b*y)
        },
        {
            "ode": shuffled_equation((1-a)*yp,m*t^p*y,-n*t^q*y^a),
            "sub": (u==y^(1-a))
        },
    ]
    shuffle(odes)

    return {"odes":odes, "linear":linear}
