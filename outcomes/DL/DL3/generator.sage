def generator():
    t = var("t")
    s = var("s")
    nums = list(srange(2,10))
    shuffle(nums)
    a = nums[0]*choice([-1,1])
    b = nums[1]*choice([-1,1])
    transform = nums[2]/((s-a)*(s-b)).expand()
    pretransform = inverse_laplace(transform,s,t)

    return {
        "transform": transform,
        "pretransform": pretransform,
    }