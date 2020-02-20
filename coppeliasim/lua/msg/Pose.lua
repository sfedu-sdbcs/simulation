require 'msg/Point'
require 'msg/Quaternion'

function createPose(objHandler)
    local pos = sim.getObjectPosition(objHandler,-1)
    local orient = sim.getObjectQuaternion(objHandler,-1)
    return {
            position=createPoint(pos[1],pos[2],pos[3]),
            orientation=createQuaternion(orient[1],orient[2],orient[3],orient[4])
            }
end
