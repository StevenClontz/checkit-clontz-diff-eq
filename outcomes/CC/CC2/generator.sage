class Generator(BaseGenerator):
    def data(self):
        t = var("t")
        y, yp = CheckIt.vars("y", "y'")

        # pick a for y'-ay
        a = randrange(1,6)*choice([-1,1])

        # particular solution
        b=a
        while (b==a):
            b = randrange(1,6)
        c = choice([-3,-2,2,3])
        part_sol = choice([
            c*exp(b*t),
            c*exp(a*t)*t,
            c*exp(a*t)*sin(b*t),
            c*exp(a*t)*cos(b*t)
        ])
        d = randrange(2,5)
        ode = CheckIt.shuffled_equation(yp,-a*y,-part_sol.diff()+a*part_sol)*d
        k = randrange(1,6)*choice([-1,1])
        ivp_sol = (k*exp(a*t)+part_sol)
        iv = ivp_sol(t=0)

        return {
            "ode": ode,
            "iv": iv,
            "ivp_sol": ivp_sol,
        }
