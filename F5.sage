def generator():
    t,y,u = var("t y u")
    yp = var("yp", latex_name="y'")
    up = var("up", latex_name="u'")
    a = randrange(1,6)*choice([-1,1])
    b = randrange(1,6)*choice([-1,1])
    f = randrange(2,4)*choice([-1,1])*choice([
        sin(t),
        cos(t),
    ])
    y_over_t = shuffled_equation(
        y*yp*t,
        -y^2,
        y^2*t*f,
        a^2*t^3*f
    )*randrange(2,4)
    at_y = shuffled_equation(
        b,
        yp,
        b*t*f,
        y*f,
        a^2*f/(b*t+y)
    )*randrange(2,4)
    at_y_sub = (u==b*t+y)
    separated = (u/(u^2+a^2)*up==-f)
    swapped = choice([True,False])

    return {
        "y_over_t": y_over_t,
        "at_y": at_y,
        "at_y_sub": at_y_sub,
        "separated": separated,
        "swapped": swapped,
    }
