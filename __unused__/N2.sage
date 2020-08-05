def generator():
    """
    Generates
    x' = _t^_x^_+_t^_y^_+_x^_y^_+_
    y' = _t^_x^_+_t^_y^_+_x^_y^_+_
    with one term zeroed, and asks for
    x,y at t=t_0+2h for h=0.1
    """

    def random_ode(t,x,y):
        cs = [randrange(1,5)*choice([-1,1]) for _ in range(3)]
        cs[choice([0,1,2])]=0
        return cs[0]*t^randrange(1,3)*x^randrange(1,3) + \
            cs[1]*t^randrange(1,3)*y^randrange(1,3) + \
            cs[2]*x^randrange(1,3)*y^randrange(1,3) + randrange(-3,4)


    rerolling=True
    while rerolling:
        t,x,y=var('t x y')
        xp,yp=(random_ode(t,x,y) for _ in range(2))
        t_0,x_0,y_0 = (randrange(-2,3) for _ in range(3))
        h=(1/10).n(digits=2)
        vals=[{"t":t_0,"x":x_0,"y":y_0}]
        for i in range(2):
            t_n=vals[i]["t"]
            x_n=vals[i]["x"]
            y_n=vals[i]["y"]
            vals.append({
                "t": (t_n+h).n(digits=2),
                "x": (x_n+h*xp(t=t_n,x=x_n,y=y_n)).n(digits=3),
                "y": (y_n+h*yp(t=t_n,x=x_n,y=y_n)).n(digits=3),
            })
        if vals[-1]["x"].abs() < 100 and vals[-1]["x"].abs() > 1/100 and vals[-1]["y"].abs() < 100 and vals[-1]["y"].abs() > 1/100:
            rerolling=False

    return {
        "xp": xp,
        "yp": yp,
        "init": vals[0],
        "final": vals[-1],
        "vals": vals[1:],
        "h": h,
    }