def generator():
    '''
    Produces systems of the form
    (D-a)x+(-c)y=0
    (-d)x+(D-b)y=0
    for nice values of a,b,c,d; namely, resulting in general solutions
    k_1e^(mt)+k_2e^(nt)
    for integers m,n
    '''
    x,xp,y,yp = mi_vars("x","x'","y","y'")
    t = var("t")
    # nice a-d
    switch = randrange(3)
    if switch == 0:
        a = 3*randrange(-1,2)+randrange(1,3)
        b = a+choice([-1,1])*3
        while a*b==4:
            b = a+choice([-1,1])*3
        c = choice([1,2,4])*choice([-1,1])
        d = 4/c 
    elif switch == 1:
        a = 5*randrange(-1,1)+randrange(1,5)
        b = a+choice([-1,1])*5
        while a*b==-4:
            b = a+choice([-1,1])*5
        c = choice([1,2,4])*choice([-1,1])
        d = -4/c
    elif switch == 2:
        a = 5*randrange(-1,1)+randrange(1,5)
        b = a+choice([-1,1])*5
        while a*b==36:
            b = a+choice([-1,1])*5
        c = choice([3,4,6,9,12])*choice([-1,1])
        d = 36/c 
    x_ode = shuffled_equation(xp,-a*x,-c*y)
    y_ode = shuffled_equation(yp,-d*x,-b*y)
    m = (a+b+sqrt((a-b)^2+4*c*d))/2
    n = (a+b-sqrt((a-b)^2+4*c*d))/2
    k1 = lcm(m-a,c)/(m-a)*choice([-1,1])
    k2 = lcm(n-a,c)/(n-a)*choice([-1,1])
    x_sol = k1*exp(m*t)+k2*exp(n*t)
    y_sol = (derivative(x_sol)-a*x_sol)/c
    x0 = x_sol(t=0)
    y0 = y_sol(t=0)

    return {
        "x_ode": x_ode,
        "y_ode": y_ode,
        "x0": x0,
        "y0": y0,
        "x_sol": x_sol,
        "y_sol": y_sol,
    }
