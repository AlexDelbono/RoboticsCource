;; Auto-generated. Do not edit!


(when (boundp 'delbono_kobra::OdomInfo)
  (if (not (find-package "DELBONO_KOBRA"))
    (make-package "DELBONO_KOBRA"))
  (shadow 'OdomInfo (find-package "DELBONO_KOBRA")))
(unless (find-package "DELBONO_KOBRA::ODOMINFO")
  (make-package "DELBONO_KOBRA::ODOMINFO"))

(in-package "ROS")
;;//! \htmlinclude OdomInfo.msg.html


(defclass delbono_kobra::OdomInfo
  :super ros::object
  :slots (_t _linearVel _angularVel _dx _dy _dtheta ))

(defmethod delbono_kobra::OdomInfo
  (:init
   (&key
    ((:t __t) 0.0)
    ((:linearVel __linearVel) 0.0)
    ((:angularVel __angularVel) 0.0)
    ((:dx __dx) 0.0)
    ((:dy __dy) 0.0)
    ((:dtheta __dtheta) 0.0)
    )
   (send-super :init)
   (setq _t (float __t))
   (setq _linearVel (float __linearVel))
   (setq _angularVel (float __angularVel))
   (setq _dx (float __dx))
   (setq _dy (float __dy))
   (setq _dtheta (float __dtheta))
   self)
  (:t
   (&optional __t)
   (if __t (setq _t __t)) _t)
  (:linearVel
   (&optional __linearVel)
   (if __linearVel (setq _linearVel __linearVel)) _linearVel)
  (:angularVel
   (&optional __angularVel)
   (if __angularVel (setq _angularVel __angularVel)) _angularVel)
  (:dx
   (&optional __dx)
   (if __dx (setq _dx __dx)) _dx)
  (:dy
   (&optional __dy)
   (if __dy (setq _dy __dy)) _dy)
  (:dtheta
   (&optional __dtheta)
   (if __dtheta (setq _dtheta __dtheta)) _dtheta)
  (:serialization-length
   ()
   (+
    ;; float32 _t
    4
    ;; float32 _linearVel
    4
    ;; float32 _angularVel
    4
    ;; float32 _dx
    4
    ;; float32 _dy
    4
    ;; float32 _dtheta
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float32 _t
       (sys::poke _t (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _linearVel
       (sys::poke _linearVel (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _angularVel
       (sys::poke _angularVel (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _dx
       (sys::poke _dx (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _dy
       (sys::poke _dy (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _dtheta
       (sys::poke _dtheta (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float32 _t
     (setq _t (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _linearVel
     (setq _linearVel (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _angularVel
     (setq _angularVel (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _dx
     (setq _dx (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _dy
     (setq _dy (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _dtheta
     (setq _dtheta (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get delbono_kobra::OdomInfo :md5sum-) "9844e4d0505bb71cef8082d5d9d1d1dc")
(setf (get delbono_kobra::OdomInfo :datatype-) "delbono_kobra/OdomInfo")
(setf (get delbono_kobra::OdomInfo :definition-)
      "float32 t
float32 linearVel
float32 angularVel
float32 dx
float32 dy
float32 dtheta

")



(provide :delbono_kobra/OdomInfo "9844e4d0505bb71cef8082d5d9d1d1dc")


