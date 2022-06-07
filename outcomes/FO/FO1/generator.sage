class Generator(BaseGenerator):
    def data(self):
        t = var("t")
        y,yp,ypp = CheckIt.vars("y","y'","y''")

        roll = randrange(3)
        if roll==0:
            # pick n for y=kx^n
            n = randrange(2,4)*choice([-1,1])
            # pick initial value
            t0 = randrange(1,5)*choice([-1,1])
            # pick coefficient
            k = randrange(1,5)*choice([-1,1])
            ode = CheckIt.shuffled_equation(t*yp,-n*y)*choice([2,3])
            ivp_sol = (y == k*t^n)
            y0 = k*t0^n
        elif roll==1:
            # pick p(t) for y=e^p(t)
            p = choice([
            randrange(1,4)*choice([-1,1])*
                t^2+randrange(-3,4)*t+randrange(-5,6),
            randrange(1,4)*choice([-1,1])*cos(t),
            randrange(1,4)*choice([-1,1])*sin(t)
            ])
            # pick coefficient
            k = randrange(1,5)*choice([-1,1])
            ode = CheckIt.shuffled_equation(yp,-p.diff()*y)*choice([2,3])
            ivp_sol = (y==k*exp(p))
            t0=0
            y0 = k*exp(p(t=t0))
        else:
            # solves to y^n=(t poly)
            y0 = randrange(2,5)
            n = randrange(2,4)
            t0 = randrange(2,4)*choice([-1,1])
            first_coeff = randrange(1,4)
            second_coeff = randrange(1,4)
            constant = y0^n-first_coeff*t0^2-second_coeff*t0
            ode = CheckIt.shuffled_equation(-n*yp*y^(n-1),2*first_coeff*t,second_coeff)*randrange(2,4)/y^randrange(1,n)
            ode = ode.expand()
            ivp_sol = (y==(first_coeff*t^2+second_coeff*t+constant)^(1/n))

        return {
            "ode": ode,
            "t0": t0,
            "y0": y0,
            "ivp_sol": ivp_sol,
        }
