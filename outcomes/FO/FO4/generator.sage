class Generator(BaseGenerator):
    def data(self):
        t,y = var("t y")
        yp = var("yp", latex_name="y'")

        mult_terms = [
            randrange(1,6)*choice([-1,1])*t*y,
            randrange(1,6)*choice([-1,1])*t*y^2,
            randrange(1,6)*choice([-1,1])*t^2*y,
            randrange(1,6)*choice([-1,1])*t^2*y^2
        ]
        shuffle(mult_terms)
        sing_terms = [
            randrange(1,6)*choice([-1,1])*t^randrange(2,5),
            randrange(1,6)*choice([-1,1])*y^randrange(2,5),
        ]
        f = mult_terms[0]+mult_terms[1]+sing_terms[0]+sing_terms[1]
        # pick initial values
        ivs = [-1,1]
        shuffle(ivs)
        t0,y0=ivs
        f0 = f(t=t0,y=y0)
        exact_ode = CheckIt.shuffled_equation(
            mult_terms[0].diff(t),
            mult_terms[1].diff(t),
            sing_terms[0].diff(t),
            sing_terms[1].diff(t),
            mult_terms[0].diff(y)*yp,
            mult_terms[1].diff(y)*yp,
            sing_terms[0].diff(y)*yp,
            sing_terms[1].diff(y)*yp,
        )
        nonexact_ode = CheckIt.shuffled_equation(
            mult_terms[0].diff(t),
            mult_terms[2].diff(t),
            sing_terms[0].diff(t),
            mult_terms[1].diff(y)*yp,
            mult_terms[3].diff(y)*yp,
            sing_terms[1].diff(y)*yp,
        )
        odes = [
            exact_ode,
            nonexact_ode,
        ]
        shuffle(odes)

        return {
            "odes": odes,
            "exact_ode": exact_ode,
            "t0": t0,
            "y0": y0,
            "solution": (f==f0),
        }
