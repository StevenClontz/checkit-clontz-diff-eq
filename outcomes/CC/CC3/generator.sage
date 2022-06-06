class Generator(BaseGenerator):
    def data(self):
        t = var("t")
        c1 = var("c_1")
        c2 = var("c_2")
        i = var('i')
        k1,k2,k3 = var("k_1 k_2 k_3")
        y,yp,ypp,yppp = CheckIt.vars("y","y'","y''","y'''")
        odes = []

        # pick a,b for (D-a)^2y+b^2=y''-2ay'+a^2+b^2=0
        a = randrange(1,6)*choice([-1,1])
        b = randrange(1,6)
        ode = (CheckIt.shuffled_equation(ypp,-2*a*yp,(a^2+b^2)*y)*randrange(2,4))
        ode_sol = (y==exp(a*t)*(k1*cos(b*t)+k2*sin(b*t)))
        complex_sol = (y==c1*e^(a*t+b*i*t)+c2*e^(a*t-b*i*t))
        odes.append({"ode":ode,"sol":ode_sol,"complex":complex_sol})

        # pick c for (D-c)^2y=0
        c = randrange(1,11)*choice([-1,1])
        ode = (CheckIt.shuffled_equation(ypp,-2*c*yp,c^2*y)*randrange(2,4))
        ode_sol = (y==k2*exp(c*t)+k1*t*exp(c*t))
        odes.append({"ode":ode,"sol":ode_sol})

        # pick a,b for D(D-a)(D-b)y=0
        a = randrange(1,6)*choice([-1,1])
        b=a
        while b==a:
            b = randrange(1,6)*choice([-1,1])
        ode = (CheckIt.shuffled_equation(yppp,(-a-b)*ypp,a*b*yp)*randrange(2,4))
        ode_sol = (y==k2*exp(a*t)+k1*exp(b*t)+k3)
        odes.append({"ode":ode,"sol":ode_sol})

        shuffle(odes)

        return {
            "odes": odes,
        }