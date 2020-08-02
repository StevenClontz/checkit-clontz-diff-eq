def generator():
    """
    Produces a dirac-delta y=k*d(t-a)
    and step y=k*u(t-a).
    Asks for integrals for each around a.
    """
    t = var("t")
    y = var("y")
    a = randrange(3,7)
    b = a - randrange(1,4)
    c = a + randrange(2,5)
    d = dirac_delta
    u = unit_step
    k = randrange(2,6)
    d_integrand = (k*d(t-a))
    u_integrand = (k*u(t-a))

    return {
        "d_integrand": d_integrand,
        "u_integrand": u_integrand,
        "b": b,
        "c": c,
        "d_int_value": k,
        "u_int_value": k*(c-a),
    }