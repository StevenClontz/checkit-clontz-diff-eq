load("CC1.sage")
cc1 = generator

load("CC2.sage")
cc2 = generator

load("CC4.sage")
cc4 = generator

def cc5_alt():
    t = var("t")
    y,yp,ypp = mi_vars("y","y'","y''")

    # pick a,b for (D-a)(D-b)
    a = randrange(1,5)*choice([-1,1])
    b=a
    while a==b:
        b = randrange(1,5)*choice([-1,1])
    # pick particular solution
    c=a
    while c in [a,b]:
        c = choice([2,3,5])
    d = randrange(1,4)*choice([-1,1])
    d2 = randrange(1,4)*choice([-1,1])
    ypart = d*exp(c*t)+d2
    k1 = var("k_1")
    k2 = var("k_2")
    ode = shuffled_equation(ypp-(a+b)*yp,a*b*y,-ypart.diff().diff()+(a+b)*ypart.diff()-a*b*ypart)
    ode_sol = (y==k1*exp(a*t)+k2*exp(b*t)+ypart)

    return {
        "ode": ode,
        "ode_sol": ode_sol,
    }

load("FO2.sage")
fo2 = generator

load("FO4.sage")
fo4 = generator

def dl4_alt():
    t = var("t")
    s = var("s")
    y,yp = mi_vars("y","y'")
    d = dirac_delta
    u = unit_step

    # y'+ay=k delta(t-b)
    a,b,k,y0 = sample(range(2,7),4)
    a = a*choice([-1,1])
    k = k*choice([-1,1])
    y0 = y0*choice([-1,1])
    return {
        "ode": shuffled_equation(yp,a*y,-k*d(t-b)),
        "y0": y0,
        "t0": 0,
        "ivp_sol": y==y0*exp(-a*t)+k*exp(-a*(t-b))*u(t-b),
    }

def generator():
    problems = [cc1()]

    temp = cc2()
    temp["ivp_sol"] = "y = "+latex(temp["ivp_sol"])
    temp["y0"]=temp["iv"]
    del temp["iv"]
    temp["t0"]=0
    problems+=[temp]

    for ivp in cc4()["ivps"]:
        problems+=[
            {
                "ode":ivp["ode"],
                "y0":ivp["iv1"],
                "yp0":ivp["iv2"],
                "t0":0,
                "ivp_sol":ivp["ivp_sol"]
            }
        ]
    
    problems+=[cc5_alt()]

    problems+=[dl4_alt()]
    
    problems+=[fo2()]

    temp = fo4()
    del temp["odes"]
    temp["ode"] = temp["exact_ode"]
    del temp["exact_ode"]
    temp["ivp_sol"] = temp["solution"]
    del temp["solution"]
    problems+=[temp]

    shuffle(problems)
    return {
        "problems": problems,
    }