def generator():
    t = var("t")

    def trig_ivp(y,yp,ypp):
        # pick a for D^2+a^2
        a = randrange(2,11)
        # pick particular solution
        k1 = randrange(-5,6)
        k2 = k1
        while k2==k1:
            k2 = randrange(-5,6)
        ode = shuffled_equation(ypp,a^2*y)
        ivp_sol = (y == k1*sin(a*t)+k2*cos(a*t))
        iv1 = k2
        iv2 = a*k1
        return {
            "ode": ode,
            "iv1": iv1,
            "iv2": iv2,
            "ivp_sol": ivp_sol,
            "var": y,
        }

    def exp_ivp(y,yp,ypp):
        # pick a,b for (D-a)(D-b)
        a = randrange(1,6)*choice([-1,1])
        b=a
        while a==b:
            b = randrange(1,6)*choice([-1,1])
        # pick particular solution
        k1 = randrange(-5,6)
        k2 = k1
        while k2==k1:
            k2 = randrange(-5,6)
        ode = shuffled_equation(ypp,-(a+b)*yp,a*b*y)
        ivp_sol = (y == k1*exp(a*t)+k2*exp(b*t))
        iv1 = k1+k2
        iv2 = a*k1+b*k2
        return {
            "ode": ode,
            "iv1": iv1,
            "iv2": iv2,
            "ivp_sol": ivp_sol,
            "var": y,
        }

    x,xp,xpp = mi_vars("x", "x'", "x''")
    y,yp,ypp = mi_vars("y", "y'", "y''")
    ivps = choice([
        [trig_ivp(x,xp,xpp),exp_ivp(y,yp,ypp)],
        [exp_ivp(x,xp,xpp),trig_ivp(y,yp,ypp)],
    ])

    return {"ivps": ivps}

