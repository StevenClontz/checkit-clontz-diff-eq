class Generator(BaseGenerator):
    def data(self):
        """
        Generates
        p(t)y^(n)+ky^(<n)+q(t)y=r(t).
        """
        t,y = var('t y')
        y0 = randrange(-6,7)
        yp0 = randrange(-6,7)
        if choice([True,False]):
            yp = var("yp", latex_name="y'")
            ypp = var("ypp", latex_name="y''")
            ypp0 = False
        else:
            yp = var("ypp", latex_name="y''")
            ypp = var("yppp", latex_name="y'''")
            ypp0 = randrange(-6,7)
        zero = sample(range(-9,10),7)
        t0 = zero[0]
        nonzeros = [
            1,
            exp(t*randrange(1,6)*choice([-1,1])),
            t^2+randrange(1,6)^2
        ]
        shuffle(nonzeros)
        p = (t-zero[1])*(t-zero[2])*nonzeros[0]
        q = (t-zero[3])*(t-zero[4])*nonzeros[1]
        r = (t-zero[5])*(t-zero[6])*nonzeros[2]
        a = min([zero[1],zero[2]])
        b = max([zero[1],zero[2]])
        constant = randrange(1,10)*choice([-1,1])
        if t0 < a:
            interval = f"(-\\infty,{a})"
        elif t0 < b:
            interval = f"({a},{b})"
        else:
            interval = f"({b},+\\infty)"
        ode = CheckIt.shuffled_equation(p*ypp,q*y,r,constant*yp)

        return {
            "ode": ode,
            "interval": interval,
            "t0": t0,
            "y0": y0,
            "yp0": yp0,
            "ypp0": ypp0,
            "y":y,
        }
