class Generator(BaseGenerator):
    def data(self):
        t = var("t")
        y,yp = CheckIt.vars("y","y'")
        t0 = randrange(-2,3)
        y0 = randrange(-2,3)
        offset_t = randrange(-5,6)
        offset_y = randrange(-5,6)
        slopes = choice([
            sin(t-offset_t+y-offset_y),
            cos(t-offset_t+y-offset_y),
            (y-offset_y)/15-(t-offset_t)/3,
            (t-offset_t)/3-(y-offset_y)/15,
            sin((y-offset_y)/2),
            cos((y-offset_y)/2),
            (t-offset_t)*(y-offset_y)/9-(t-offset_t)/3,
            (t-offset_t)*(y-offset_y)/9+(t-offset_t)/3,
        ])
        dt = choice([-1,1])/4
        tn = t0+offset_t
        yn = y0+offset_y
        for _ in range(8):
            dydtn = slopes.subs({t:tn,y:yn}).n(digits=5)
            tn = (tn + dt).n(digits=5)
            yn = (yn + dydtn*dt).n(digits=5)

        return {
            "slopes": slopes,
            "y0": y0+offset_y,
            "t0": t0+offset_t,
            "othert": t0+offset_t+8*dt,
            "othery": yn.n(digits=2),
            "offset_t": offset_t,
            "offset_y": offset_y,
            "t": t,
            "y": y,
        }

    @provide_data
    def graphics(data):
        return {
            "field": plot_slope_field(
                data["slopes"], 
                (data["t"],-6+data["offset_t"],6+data["offset_t"]), 
                (data["y"],-6+data["offset_y"],6+data["offset_y"])
            )
        }
