require 'msg/Vector3'

function createTwist(objHandler)
    local lin,ang = sim.getObjectVelocity(objHandler)
  
    return {
            linear=createVector3(lin[1],lin[2],lin[3]),
            angular=createVector3(ang[1],ang[2],ang[3])
            }
end
