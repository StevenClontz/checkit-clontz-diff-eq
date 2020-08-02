def generator():
    t = var("t")
    c1 = var("c_1")
    c2 = var("c_2")
    k1 = var("k_1")
    k2 = var("k_2")
    d1,d2 = var("d1 d2")
    if choice([True,False]):
        x,xp,xpp = mi_vars("x","x'","x''")
        y,yp,ypp = mi_vars("y","y'","y''")
    else:
        y,yp,ypp = mi_vars("x","x'","x''")
        x,xp,xpp = mi_vars("y","y'","y''")
    odes = []

    # pick a,b for (D-a)^2y+b^2=y''-2ay'+a^2+b^2=0
    a = randrange(1,6)*choice([-1,1])
    b = randrange(1,6)
    odes.append(shuffled_equation(xpp,-2*a*xp,(a^2+b^2)*x)*randrange(2,4))
    xode_sol = (x==exp(a*t)*(d1*cos(b*t)+d2*sin(b*t)))
    complex_sol = (x==c1*exp((a+b*i)*t)+c2*exp((a-b*i)*t))

    # pick c for (D-a)^2y=0
    c = randrange(1,11)*choice([-1,1])
    odes.append(shuffled_equation(ypp,-2*c*yp,c^2*y)*randrange(2,4))
    yode_sol = (y==k2*exp(c*t)+k1*t*exp(c*t))

    shuffle(odes)

    return {
        "odes": odes,
        "xode_sol": xode_sol,
        "complex_sol": complex_sol,
        "yode_sol": yode_sol,
    }