-- This represents a vector in free space. 
-- It is only meant to represent a direction. Therefore, it does not
-- make sense to apply a translation to it (e.g., when applying a 
-- generic rigid transformation to a Vector3, tf2 will only apply the
-- rotation). If you want your data to be translatable too, use the
-- geometry_msgs/Point message instead.
function createVector3(_x,_y,_z)
  return {x=_x,y=_y,z=_z}
end
