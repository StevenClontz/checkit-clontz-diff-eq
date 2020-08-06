def generator():
    t,y,u = var("t y u")
    yp = var("yp", latex_name="y'")
    up = var("up", latex_name="u'")
    def y_over_t():
        constant = randrange(1,6)*choice([-1,1])
        return {
            "ode": shuffled_equation(
                yp*y*t,
                y^2,
                constant*t^2,
            ),
            "ode_simp": ((u/(u^2+constant))*up==1/t),
        }
    def y_bt_c():
        b,c,r = [randrange(1,6)*choice([-1,1]) for _ in range(3)]
        return {
            "ode": shuffled_equation(
                -yp,
                y,
                b*t,
                b+c,
                r/(y+b*t+c),
            ),
            "ode_simp": ((u/(u^2+r))*up==1),
        }
    odes = [y_over_t(), y_bt_c()]
    shuffle(odes)

    return {
        "odes": odes,
    }
