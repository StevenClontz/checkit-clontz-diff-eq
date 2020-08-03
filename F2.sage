def generator():
    x,xp = mi_vars("x", "x'")

    # pick a,b for x'=k*t^p(t-a)(t-b)
    k = choice([-1,1])*randrange(2,4)
    p = randrange(4)
    a = randrange(-6,-1)
    b = randrange(2,6)
    f = k*x^p*(x-a)*(x-b)
    ode = (xp == f.expand())

    version = choice(["zero","even","odd"])
    if version == "zero":
        p = 0
    elif version == "even":
        p = choice([2,4])
    else:
        p = choice([1,3])

    t0 = (a + 0.5 + random()*(-a-1)).n(digits=2)
    x0 = (0.5 + random()*(b-1)).n(digits=2)
    if choice([True,False]):
        t0,x0 = x0,t0

    if (version == "zero") and (k<0):
        a_label = "source/unstable"
        z_label = "NA"
        b_label = "sink/stable"
        math_lim = b
        real_lim = b
    elif (version == "zero") and (k>0):
        a_label = "sink/stable"
        z_label = "NA"
        b_label = "source/unstable"
        math_lim = a
        real_lim = a
    elif (version == "even") and (k<0):
        a_label = "source/unstable"
        z_label = "neither/unstable"
        b_label = "sink/stable"
        if x0 < 0:
            math_lim = 0
        else:
            math_lim = b
        real_lim = b
    elif (version == "even") and (k>0):
        a_label = "sink/stable"
        z_label = "neither/unstable"
        b_label = "source/unstable"
        if x0 < 0:
            math_lim = a
        else:
            math_lim = 0
        real_lim = a
    elif (version == "odd") and (k<0):
        a_label = "sink/stable"
        z_label = "source/unstable"
        b_label = "sink/stable"
        if x0 < 0:
            math_lim = a
            real_lim = a
        else:
            math_lim = b
            real_lim = b
    else:
        a_label = "source/unstable"
        z_label = "sink/stable"
        b_label = "source/unstable"
        math_lim = 0
        real_lim = 0


    return {
      "ode": ode,
      "t0": t0,
      "x0": x0,
      "a": a,
      "b": b,
      "a_label": a_label,
      "b_label": b_label,
      "z_label": z_label,
      "math_lim": math_lim,
      "real_lim": real_lim,
    }
