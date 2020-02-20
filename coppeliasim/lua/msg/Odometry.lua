-- # This represents an estimate of a position and velocity in free space.  
-- # The pose in this message should be specified in the coordinate frame given by header.frame_id.
-- # The twist in this message should be specified in the coordinate frame given by the child_frame_id
-- Header header
-- string child_frame_id
-- geometry_msgs/PoseWithCovariance pose
-- geometry_msgs/TwistWithCovariance twist
require 'msg/Header'
require 'msg/PoseWithCovariance'
require 'msg/TwistWithCovariance'

function createOdometry(objHandler)
	
	return {
            pose=createPoseWithCovariance(objHandler),
            twist=createTwistWithCovariance(objHandler)
            }
end

function createOdometryWithHeader(objHandler,frameId,childFrameId)
	
	return {    header=createHeader(simROS.getTime(),frameId),
                child_frame_id=childFrameId,
                pose=createPoseWithCovariance(objHandler),
                twist=createTwistWithCovariance(objHandler)
            }
end
