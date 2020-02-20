require 'msg/Pose'

function createPoseWithCovariance(objHandler)
    local cov={}
   
    return {pose=createPose(objHandler),covariance=cov}
end
