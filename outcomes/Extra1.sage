def generator():
    t = var("t")
    c1 = var("c_1")
    c2 = var("c_2")
    i = var('i')
    k1,k2,k3 = var("k_1 k_2 k_3")
    y,yp,ypp,yppp = mi_vars("y","y'","y''","y'''")
    odes = []

    # pick a,b for (D^2+a^2)(D-b)y=0
    a = randrange(2,7)
    b = randrange(2,7)*choice([-1,1])
    ode = (shuffled_equation(yppp,-b*ypp,a^2*yp,(a^2-b)*y)*randrange(2,4))
    psols = [cos(a*t),sin(a*t),exp(b*t)]
    shuffle(psols)
    ode_sol = (y==k1*psols[0]+k2*psols[1]+k3*psols[2])

    return {
        "y1": psols[0],
        "y2": psols[1],
        "y3": psols[2],
        "ode": ode,
        "wronskian": wronskian(*psols).simplify_trig(),
        "sol": ode_sol,
    }