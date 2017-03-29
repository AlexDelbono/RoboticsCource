; Auto-generated. Do not edit!


(cl:in-package delbono_kobra-msg)


;//! \htmlinclude Ptz.msg.html

(cl:defclass <Ptz> (roslisp-msg-protocol:ros-message)
  ((p
    :reader p
    :initarg :p
    :type cl:float
    :initform 0.0)
   (t
    :reader t
    :initarg :t
    :type cl:float
    :initform 0.0)
   (z
    :reader z
    :initarg :z
    :type cl:float
    :initform 0.0))
)

(cl:defclass Ptz (<Ptz>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Ptz>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Ptz)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name delbono_kobra-msg:<Ptz> is deprecated: use delbono_kobra-msg:Ptz instead.")))

(cl:ensure-generic-function 'p-val :lambda-list '(m))
(cl:defmethod p-val ((m <Ptz>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader delbono_kobra-msg:p-val is deprecated.  Use delbono_kobra-msg:p instead.")
  (p m))

(cl:ensure-generic-function 't-val :lambda-list '(m))
(cl:defmethod t-val ((m <Ptz>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader delbono_kobra-msg:t-val is deprecated.  Use delbono_kobra-msg:t instead.")
  (t m))

(cl:ensure-generic-function 'z-val :lambda-list '(m))
(cl:defmethod z-val ((m <Ptz>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader delbono_kobra-msg:z-val is deprecated.  Use delbono_kobra-msg:z instead.")
  (z m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Ptz>) ostream)
  "Serializes a message object of type '<Ptz>"
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'p))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 't))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'z))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Ptz>) istream)
  "Deserializes a message object of type '<Ptz>"
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'p) (roslisp-utils:decode-single-float-bits bits)))
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
    (cl:setf (cl:slot-value msg 'z) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Ptz>)))
  "Returns string type for a message object of type '<Ptz>"
  "delbono_kobra/Ptz")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Ptz)))
  "Returns string type for a message object of type 'Ptz"
  "delbono_kobra/Ptz")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Ptz>)))
  "Returns md5sum for a message object of type '<Ptz>"
  "7d67c83f522ade3e3af5cf25a4c6fe96")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Ptz)))
  "Returns md5sum for a message object of type 'Ptz"
  "7d67c83f522ade3e3af5cf25a4c6fe96")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Ptz>)))
  "Returns full string definition for message of type '<Ptz>"
  (cl:format cl:nil "float32 p~%float32 t~%float32 z~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Ptz)))
  "Returns full string definition for message of type 'Ptz"
  (cl:format cl:nil "float32 p~%float32 t~%float32 z~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Ptz>))
  (cl:+ 0
     4
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Ptz>))
  "Converts a ROS message object to a list"
  (cl:list 'Ptz
    (cl:cons ':p (p msg))
    (cl:cons ':t (t msg))
    (cl:cons ':z (z msg))
))
