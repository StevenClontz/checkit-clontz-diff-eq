def generator():
    """
    ke^{ct}+m*delta(t-a)+n*u(t-b)
    """
    t = var("t")
    s = var("s")
    d = dirac_delta
    u = unit_step
    k = choice([-1,1])*randrange(2,6)
    m = choice([-1,1])*randrange(2,6)
    n = choice([-1,1])*randrange(2,6)
    a = randrange(1,6)
    b = randrange(1,6)
    c = randrange(2,6)
    pretransform = k*exp(c*t)+m*d(t-a)+n*u(t-b)
    transform = k/(s-c)+m*exp(-a*s)+n*exp(-b*s)/s

    return {
        "pretransform": pretransform,
        "transform": transform,
    }