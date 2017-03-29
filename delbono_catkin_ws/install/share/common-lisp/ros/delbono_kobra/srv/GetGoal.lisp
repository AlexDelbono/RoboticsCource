; Auto-generated. Do not edit!


(cl:in-package delbono_kobra-srv)


;//! \htmlinclude GetGoal-request.msg.html

(cl:defclass <GetGoal-request> (roslisp-msg-protocol:ros-message)
  ((go
    :reader go
    :initarg :go
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass GetGoal-request (<GetGoal-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <GetGoal-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'GetGoal-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name delbono_kobra-srv:<GetGoal-request> is deprecated: use delbono_kobra-srv:GetGoal-request instead.")))

(cl:ensure-generic-function 'go-val :lambda-list '(m))
(cl:defmethod go-val ((m <GetGoal-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader delbono_kobra-srv:go-val is deprecated.  Use delbono_kobra-srv:go instead.")
  (go m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <GetGoal-request>) ostream)
  "Serializes a message object of type '<GetGoal-request>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'go) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <GetGoal-request>) istream)
  "Deserializes a message object of type '<GetGoal-request>"
    (cl:setf (cl:slot-value msg 'go) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<GetGoal-request>)))
  "Returns string type for a service object of type '<GetGoal-request>"
  "delbono_kobra/GetGoalRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'GetGoal-request)))
  "Returns string type for a service object of type 'GetGoal-request"
  "delbono_kobra/GetGoalRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<GetGoal-request>)))
  "Returns md5sum for a message object of type '<GetGoal-request>"
  "6b1bac8b4cbb7d20ffd1b4c31b91d825")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'GetGoal-request)))
  "Returns md5sum for a message object of type 'GetGoal-request"
  "6b1bac8b4cbb7d20ffd1b4c31b91d825")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<GetGoal-request>)))
  "Returns full string definition for message of type '<GetGoal-request>"
  (cl:format cl:nil "bool go~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'GetGoal-request)))
  "Returns full string definition for message of type 'GetGoal-request"
  (cl:format cl:nil "bool go~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <GetGoal-request>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <GetGoal-request>))
  "Converts a ROS message object to a list"
  (cl:list 'GetGoal-request
    (cl:cons ':go (go msg))
))
;//! \htmlinclude GetGoal-response.msg.html

(cl:defclass <GetGoal-response> (roslisp-msg-protocol:ros-message)
  ((goal
    :reader goal
    :initarg :goal
    :type geometry_msgs-msg:Pose
    :initform (cl:make-instance 'geometry_msgs-msg:Pose)))
)

(cl:defclass GetGoal-response (<GetGoal-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <GetGoal-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'GetGoal-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name delbono_kobra-srv:<GetGoal-response> is deprecated: use delbono_kobra-srv:GetGoal-response instead.")))

(cl:ensure-generic-function 'goal-val :lambda-list '(m))
(cl:defmethod goal-val ((m <GetGoal-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader delbono_kobra-srv:goal-val is deprecated.  Use delbono_kobra-srv:goal instead.")
  (goal m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <GetGoal-response>) ostream)
  "Serializes a message object of type '<GetGoal-response>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'goal) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <GetGoal-response>) istream)
  "Deserializes a message object of type '<GetGoal-response>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'goal) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<GetGoal-response>)))
  "Returns string type for a service object of type '<GetGoal-response>"
  "delbono_kobra/GetGoalResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'GetGoal-response)))
  "Returns string type for a service object of type 'GetGoal-response"
  "delbono_kobra/GetGoalResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<GetGoal-response>)))
  "Returns md5sum for a message object of type '<GetGoal-response>"
  "6b1bac8b4cbb7d20ffd1b4c31b91d825")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'GetGoal-response)))
  "Returns md5sum for a message object of type 'GetGoal-response"
  "6b1bac8b4cbb7d20ffd1b4c31b91d825")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<GetGoal-response>)))
  "Returns full string definition for message of type '<GetGoal-response>"
  (cl:format cl:nil "geometry_msgs/Pose goal~%~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of postion and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'GetGoal-response)))
  "Returns full string definition for message of type 'GetGoal-response"
  (cl:format cl:nil "geometry_msgs/Pose goal~%~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of postion and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <GetGoal-response>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'goal))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <GetGoal-response>))
  "Converts a ROS message object to a list"
  (cl:list 'GetGoal-response
    (cl:cons ':goal (goal msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'GetGoal)))
  'GetGoal-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'GetGoal)))
  'GetGoal-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'GetGoal)))
  "Returns string type for a service object of type '<GetGoal>"
  "delbono_kobra/GetGoal")