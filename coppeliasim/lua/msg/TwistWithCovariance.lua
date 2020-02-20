require 'msg/Twist'

function createTwistWithCovariance(objHandler)
    local cov={}
 
    return {twist=createTwist(objHandler),covariance=cov}
end
