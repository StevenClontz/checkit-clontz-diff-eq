class Generator(BaseGenerator):
    def data(self):
        t = var("t")
        y,yp = CheckIt.vars("y","y'")
        t0 = randrange(-2,3)
        y0 = randrange(-2,3)
        _,slopes = choice([
            ("sin(t+y)",sin(t+y)),
            ("cos(t+y)",cos(t+y)),
            ("y/15-t/3",y/15-t/3),
            ("t/3-y/15",t/3-y/15),
            ("sin(y/2)",sin(y/2)),
            ("cos(y/2)",cos(y/2)),
            ("t*y/9-t/3",t*y/9-t/3),
            ("t*y/9+t/3",t*y/9+t/3),
        ])
        dt = choice([-1,1])/4
        tn = t0
        yn = y0
        for _ in range(8):
            dydtn = slopes.subs({t:tn,y:yn}).n(digits=5)
            tn = (tn + dt).n(digits=5)
            yn = (yn + dydtn*dt).n(digits=5)

        return {
            "slopes": slopes,
            "ode": yp==slopes,
            "y0": y0,
            "t0": t0,
            "othert": t0+8*dt,
            "othery": yn.n(digits=2),
            "t": t,
            "y": y,
        }

    @provide_data
    def graphics(data):
        return {
            "field": plot_slope_field(
                data["slopes"], 
                (data["t"],-5,5), 
                (data["y"],-5,5)
            )
        }