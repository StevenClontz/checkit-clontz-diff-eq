def generator():
    '''
    Produces systems of the form
    (D-a)x+(-c)y=0
    (-d)x+(D-b)y=0
    for nice values of a,b,c,d; namely, resulting in general solutions
    k_1e^(mt)+k_2e^(nt)
    for integers m,n
    '''

    def cardinal(dxdt,dydt,x,y):
        if dydt(x=x,y=y)>0:
            direction = "north"
        elif dydt(x=x,y=y)<0:
            direction = "south"
        if dxdt(x=x,y=y)>0:
            direction += "east"
        elif dxdt(x=x,y=y)<0:
            direction += "west"
        return direction


    x_int = randrange(-5,6)
    y_int = randrange(-5,6)
    dxdt_rise_sign = choice([-1,1])
    dxdt_rise = dxdt_rise_sign*randrange(1,6)
    dxdt_run = randrange(1,6)
    dydt_rise = -dxdt_rise_sign*randrange(1,6) 
    dydt_run = randrange(1,6)
    x = var("x")
    y = var("y")
    dxdt = dxdt_rise*(x-x_int)-dxdt_run*(y-y_int)
    if dxdt_rise_sign>0:
        dxdt_slope = "positive"
        dydt_slope = "negative"
    else:
        dydt_slope = "positive"
        dxdt_slope = "negative"
    dydt = choice([-1,1])*(dydt_rise*(x-x_int)-dydt_run*(y-y_int))
    if choice([True,False]):
        dxdt,dydt = dydt,dxdt
        dxdt_slope,dydt_slope = dydt_slope,dxdt_slope
    top_arrows = cardinal(dxdt,dydt,x_int,y_int+1)
    bottom_arrows = cardinal(dxdt,dydt,x_int,y_int-1)
    right_arrows = cardinal(dxdt,dydt,x_int+1,y_int)
    left_arrows = cardinal(dxdt,dydt,x_int-1,y_int)

    return {
        "dxdt": dxdt.expand(),
        "dydt": dydt.expand(),
        "intersection": (x_int,y_int),
        "dxdt_slope": dxdt_slope,
        "dydt_slope": dydt_slope,
        "top_arrows": top_arrows,
        "bottom_arrows": bottom_arrows,
        "right_arrows": right_arrows,
        "left_arrows": left_arrows,
    }