class Generator(BaseGenerator):
    def data(self):
        t = var("t")
        y,yp = CheckIt.vars("y","y'")

        # pick n for y=kx^n
        n = randrange(2,6)*choice([-1,1])
        # pick initial value
        t0 = choice([-1,1])
        # pick coefficient
        k = randrange(1,5)*choice([-1,1])
        hom_sol = k*t^n
        # particular solution
        kp = randrange(1,6)*choice([-1,1])
        m = n
        while m==n:
            m = randrange(1,5)*choice([-1,1])
        part_sol = kp*t^m
        ts = n*part_sol-t*part_sol.diff()
        ode = CheckIt.shuffled_equation(ts,t*yp,-n*y)
        ivp_sol = (y==k*t^n+part_sol)
        y0 = k*t0^n+kp*t0^m

        return {
            "ode": ode,
            "t0": t0,
            "y0": y0,
            "ivp_sol": ivp_sol,
        }
