;; Auto-generated. Do not edit!


(when (boundp 'delbono_kobra::Ptz)
  (if (not (find-package "DELBONO_KOBRA"))
    (make-package "DELBONO_KOBRA"))
  (shadow 'Ptz (find-package "DELBONO_KOBRA")))
(unless (find-package "DELBONO_KOBRA::PTZ")
  (make-package "DELBONO_KOBRA::PTZ"))

(in-package "ROS")
;;//! \htmlinclude Ptz.msg.html


(defclass delbono_kobra::Ptz
  :super ros::object
  :slots (_p _t _z ))

(defmethod delbono_kobra::Ptz
  (:init
   (&key
    ((:p __p) 0.0)
    ((:t __t) 0.0)
    ((:z __z) 0.0)
    )
   (send-super :init)
   (setq _p (float __p))
   (setq _t (float __t))
   (setq _z (float __z))
   self)
  (:p
   (&optional __p)
   (if __p (setq _p __p)) _p)
  (:t
   (&optional __t)
   (if __t (setq _t __t)) _t)
  (:z
   (&optional __z)
   (if __z (setq _z __z)) _z)
  (:serialization-length
   ()
   (+
    ;; float32 _p
    4
    ;; float32 _t
    4
    ;; float32 _z
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float32 _p
       (sys::poke _p (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _t
       (sys::poke _t (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _z
       (sys::poke _z (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float32 _p
     (setq _p (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _t
     (setq _t (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _z
     (setq _z (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get delbono_kobra::Ptz :md5sum-) "7d67c83f522ade3e3af5cf25a4c6fe96")
(setf (get delbono_kobra::Ptz :datatype-) "delbono_kobra/Ptz")
(setf (get delbono_kobra::Ptz :definition-)
      "float32 p
float32 t
float32 z

")



(provide :delbono_kobra/Ptz "7d67c83f522ade3e3af5cf25a4c6fe96")


