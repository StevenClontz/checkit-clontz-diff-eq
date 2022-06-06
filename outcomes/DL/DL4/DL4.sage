def generator():
    t = var("t")
    s = var("s")
    x = var("x")
    y,yp,ypp = mi_vars("y","y'","y''")
    d = dirac_delta
    u = unit_step

    def gen_delta():
        """
        Generates a nice IVP involving delta(t-a)
        """
        a = randrange(1,4)
        b = randrange(1,4)
        m = choice([-1,1])*randrange(1,5)
        n=m
        while n==m:
            n = choice([-1,1])*randrange(1,5)
        k=m*b^2
        y_0=choice([-1,1])*randrange(1,6)
        if randrange(0,2)==0:
            y_0=0
        else:
            n=0
        yp_0 = n*b
        ode = shuffled_equation(ypp,b^2*y,-k*u(t-a))*randrange(2,4)
        ly = (y_0*s+yp_0)/(s^2+b^2)+k*exp(-a*s)/(s*(s^2+b^2))
        ly_simp = y_0*s/(s^2+b^2)+yp_0/(s^2+b^2)+m*exp(-a*s)/s-m*s*exp(-a*s)/(s^2+b^2)
        partial_fractions = (1/(x^3+x*b^2)==(m/k)/x-(m*x/k)/(x^2+b^2))
        sol = (y==y_0*cos(b*t)+n*sin(b*t)+m*u(t-a)-m*cos(b*(t-a))*u(t-a))

        return {
            "ode": ode,
            "y0": y_0,
            "yp0": yp_0,
            "ly": ly,
            "ly_simp": ly_simp,
            "sol": sol,
            "partial_fractions": partial_fractions
        }

    def gen_u():
        """
        Generates a nice IVP involving u(t-a)
        """
        a = randrange(1,4)
        m = choice([-1,1])*randrange(1,5)
        n=m
        while n==m:
            n = choice([-1,1])*randrange(1,5)
        alpha = choice([-1,1])*randrange(1,5)
        beta = choice([-1,1])*randrange(1,5)
        k=alpha*(m-n)
        yp_0 = beta*(m-n)
        y_0=0
        b=-m-n
        c=m*n
        ode = shuffled_equation(ypp,b*yp+c*y,-k*d(t-a))*randrange(2,4)
        ly = (y_0*s+yp_0)/(s^2+b*s+c)+k*exp(-a*s)/(s^2+b*s+c)
        ly_simp = beta/(s-m)-beta/(s-n)+exp(-a*s)*alpha/(s-m)-exp(-a*s)*alpha/(s-n)
        partial_fractions = (1/(x^2+b*x+c)==(alpha/k)/(x-m)-(alpha/k)/(x-n))
        sol = (y==beta*exp(m*t)-beta*exp(n*t)+alpha*exp(m*(t-a))*u(t-a)\
            -alpha*exp(n*(t-a))*u(t-a))

        return {
            "ode": ode,
            "y0": y_0,
            "yp0": yp_0,
            "ly": ly,
            "ly_simp": ly_simp,
            "sol": sol,
            "partial_fractions": partial_fractions
        }

    return choice([gen_delta(),gen_u()])