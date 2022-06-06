def generator():
    t = var("t")
    y = var("y")
    d = dirac_delta
    u = unit_step
    avals = [choice([1,2])]
    f = e^(randrange(2,6)*t)*randrange(2,4)
    for _ in range(6):
        avals.append(avals[-1]+choice([1,1,2]))
    def d_nont():
        b = avals[0]
        a = avals[2]
        c = avals[4]
        integrand = f.diff()*d(t-a)
        value = f.diff(t)(t=a)
        return {"b":b,"c":c,"integrand":integrand,"value":value}
    def u_int():
        b = avals[1]
        a = avals[2]
        c = avals[5]
        integrand = f.diff()*u(t-a)
        value = f(t=c)-f(t=a)
        return {"b":b,"c":c,"integrand":integrand,"value":value}
    def d_t():
        b = avals[3]
        a = avals[2]
        c = avals[6]
        integrand = f.diff()*d(t-a)
        value = 0
        return {"b":b,"c":c,"integrand":integrand,"value":value}
    ints = [d_nont(),u_int(),d_t()]
    shuffle(ints)

    return {"integrals":ints}
