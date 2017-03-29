; Auto-generated. Do not edit!


(cl:in-package delbono_kobra-msg)


;//! \htmlinclude OdomInfo.msg.html

(cl:defclass <OdomInfo> (roslisp-msg-protocol:ros-message)
  ((t
    :reader t
    :initarg :t
    :type cl:float
    :initform 0.0)
   (linearVel
    :reader linearVel
    :initarg :linearVel
    :type cl:float
    :initform 0.0)
   (angularVel
    :reader angularVel
    :initarg :angularVel
    :type cl:float
    :initform 0.0)
   (dx
    :reader dx
    :initarg :dx
    :type cl:float
    :initform 0.0)
   (dy
    :reader dy
    :initarg :dy
    :type cl:float
    :initform 0.0)
   (dtheta
    :reader dtheta
    :initarg :dtheta
    :type cl:float
    :initform 0.0))
)

(cl:defclass OdomInfo (<OdomInfo>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <OdomInfo>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'OdomInfo)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name delbono_kobra-msg:<OdomInfo> is deprecated: use delbono_kobra-msg:OdomInfo instead.")))

(cl:ensure-generic-function 't-val :lambda-list '(m))
(cl:defmethod t-val ((m <OdomInfo>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader delbono_kobra-msg:t-val is deprecated.  Use delbono_kobra-msg:t instead.")
  (t m))

(cl:ensure-generic-function 'linearVel-val :lambda-list '(m))
(cl:defmethod linearVel-val ((m <OdomInfo>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader delbono_kobra-msg:linearVel-val is deprecated.  Use delbono_kobra-msg:linearVel instead.")
  (linearVel m))

(cl:ensure-generic-function 'angularVel-val :lambda-list '(m))
(cl:defmethod angularVel-val ((m <OdomInfo>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader delbono_kobra-msg:angularVel-val is deprecated.  Use delbono_kobra-msg:angularVel instead.")
  (angularVel m))

(cl:ensure-generic-function 'dx-val :lambda-list '(m))
(cl:defmethod dx-val ((m <OdomInfo>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader delbono_kobra-msg:dx-val is deprecated.  Use delbono_kobra-msg:dx instead.")
  (dx m))

(cl:ensure-generic-function 'dy-val :lambda-list '(m))
(cl:defmethod dy-val ((m <OdomInfo>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader delbono_kobra-msg:dy-val is deprecated.  Use delbono_kobra-msg:dy instead.")
  (dy m))

(cl:ensure-generic-function 'dtheta-val :lambda-list '(m))
(cl:defmethod dtheta-val ((m <OdomInfo>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader delbono_kobra-msg:dtheta-val is deprecated.  Use delbono_kobra-msg:dtheta instead.")
  (dtheta m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <OdomInfo>) ostream)
  "Serializes a message object of type '<OdomInfo>"
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 't))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'linearVel))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'angularVel))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'dx))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'dy))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'dtheta))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <OdomInfo>) istream)
  "Deserializes a message object of type '<OdomInfo>"
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 't) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'linearVel) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'angularVel) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'dx) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'dy) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'dtheta) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<OdomInfo>)))
  "Returns string type for a message object of type '<OdomInfo>"
  "delbono_kobra/OdomInfo")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'OdomInfo)))
  "Returns string type for a message object of type 'OdomInfo"
  "delbono_kobra/OdomInfo")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<OdomInfo>)))
  "Returns md5sum for a message object of type '<OdomInfo>"
  "9844e4d0505bb71cef8082d5d9d1d1dc")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'OdomInfo)))
  "Returns md5sum for a message object of type 'OdomInfo"
  "9844e4d0505bb71cef8082d5d9d1d1dc")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<OdomInfo>)))
  "Returns full string definition for message of type '<OdomInfo>"
  (cl:format cl:nil "float32 t~%float32 linearVel~%float32 angularVel~%float32 dx~%float32 dy~%float32 dtheta~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'OdomInfo)))
  "Returns full string definition for message of type 'OdomInfo"
  (cl:format cl:nil "float32 t~%float32 linearVel~%float32 angularVel~%float32 dx~%float32 dy~%float32 dtheta~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <OdomInfo>))
  (cl:+ 0
     4
     4
     4
     4
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <OdomInfo>))
  "Converts a ROS message object to a list"
  (cl:list 'OdomInfo
    (cl:cons ':t (t msg))
    (cl:cons ':linearVel (linearVel msg))
    (cl:cons ':angularVel (angularVel msg))
    (cl:cons ':dx (dx msg))
    (cl:cons ':dy (dy msg))
    (cl:cons ':dtheta (dtheta msg))
))
