def generator():
    t = var("t")
    s = var("s")
    a = randrange(1,6)*choice([-1,1])
    b = randrange(6,10)*choice([-1,1])
    primes = [2,3,5,7]
    shuffle(primes)
    transform = primes[0]/(primes[1]*(s-a)*(s-b))
    pretransform = inverse_laplace(transform,s,t)

    return {
        "transform": transform,
        "pretransform": pretransform,
    }