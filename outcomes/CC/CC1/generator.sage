class Generator(BaseGenerator):
    def data(self):
        t = var("t")
        y, yp = CheckIt.vars("y", "y'")

        # pick a for y'-ay
        a = randrange(2,10)*choice([-1,1])
        b = choice([-1,1])*randrange(2,5)
        ode = CheckIt.shuffled_equation(b*yp,-b*a*y)
        k = var("k")
        ode_sol = (y==k*exp(a*t))
        k0 = choice([-1,1])*randrange(2,5)
        ivp_sol = (y==k0*exp(a*t))

        return {
            "ode": ode,
            "ode_sol": ode_sol,
            "ivp_sol": ivp_sol,
            "y0": k0,
        }
