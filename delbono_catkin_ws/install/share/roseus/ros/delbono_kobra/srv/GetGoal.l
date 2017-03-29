;; Auto-generated. Do not edit!


(when (boundp 'delbono_kobra::GetGoal)
  (if (not (find-package "DELBONO_KOBRA"))
    (make-package "DELBONO_KOBRA"))
  (shadow 'GetGoal (find-package "DELBONO_KOBRA")))
(unless (find-package "DELBONO_KOBRA::GETGOAL")
  (make-package "DELBONO_KOBRA::GETGOAL"))
(unless (find-package "DELBONO_KOBRA::GETGOALREQUEST")
  (make-package "DELBONO_KOBRA::GETGOALREQUEST"))
(unless (find-package "DELBONO_KOBRA::GETGOALRESPONSE")
  (make-package "DELBONO_KOBRA::GETGOALRESPONSE"))

(in-package "ROS")



(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))


(defclass delbono_kobra::GetGoalRequest
  :super ros::object
  :slots (_go ))

(defmethod delbono_kobra::GetGoalRequest
  (:init
   (&key
    ((:go __go) nil)
    )
   (send-super :init)
   (setq _go __go)
   self)
  (:go
   (&optional __go)
   (if __go (setq _go __go)) _go)
  (:serialization-length
   ()
   (+
    ;; bool _go
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; bool _go
       (if _go (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; bool _go
     (setq _go (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(defclass delbono_kobra::GetGoalResponse
  :super ros::object
  :slots (_goal ))

(defmethod delbono_kobra::GetGoalResponse
  (:init
   (&key
    ((:goal __goal) (instance geometry_msgs::Pose :init))
    )
   (send-super :init)
   (setq _goal __goal)
   self)
  (:goal
   (&rest __goal)
   (if (keywordp (car __goal))
       (send* _goal __goal)
     (progn
       (if __goal (setq _goal (car __goal)))
       _goal)))
  (:serialization-length
   ()
   (+
    ;; geometry_msgs/Pose _goal
    (send _goal :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; geometry_msgs/Pose _goal
       (send _goal :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; geometry_msgs/Pose _goal
     (send _goal :deserialize buf ptr-) (incf ptr- (send _goal :serialization-length))
   ;;
   self)
  )

(defclass delbono_kobra::GetGoal
  :super ros::object
  :slots ())

(setf (get delbono_kobra::GetGoal :md5sum-) "6b1bac8b4cbb7d20ffd1b4c31b91d825")
(setf (get delbono_kobra::GetGoal :datatype-) "delbono_kobra/GetGoal")
(setf (get delbono_kobra::GetGoal :request) delbono_kobra::GetGoalRequest)
(setf (get delbono_kobra::GetGoal :response) delbono_kobra::GetGoalResponse)

(defmethod delbono_kobra::GetGoalRequest
  (:response () (instance delbono_kobra::GetGoalResponse :init)))

(setf (get delbono_kobra::GetGoalRequest :md5sum-) "6b1bac8b4cbb7d20ffd1b4c31b91d825")
(setf (get delbono_kobra::GetGoalRequest :datatype-) "delbono_kobra/GetGoalRequest")
(setf (get delbono_kobra::GetGoalRequest :definition-)
      "bool go
---
geometry_msgs/Pose goal


================================================================================
MSG: geometry_msgs/Pose
# A representation of pose in free space, composed of postion and orientation. 
Point position
Quaternion orientation

================================================================================
MSG: geometry_msgs/Point
# This contains the position of a point in free space
float64 x
float64 y
float64 z

================================================================================
MSG: geometry_msgs/Quaternion
# This represents an orientation in free space in quaternion form.

float64 x
float64 y
float64 z
float64 w
")

(setf (get delbono_kobra::GetGoalResponse :md5sum-) "6b1bac8b4cbb7d20ffd1b4c31b91d825")
(setf (get delbono_kobra::GetGoalResponse :datatype-) "delbono_kobra/GetGoalResponse")
(setf (get delbono_kobra::GetGoalResponse :definition-)
      "bool go
---
geometry_msgs/Pose goal


================================================================================
MSG: geometry_msgs/Pose
# A representation of pose in free space, composed of postion and orientation. 
Point position
Quaternion orientation

================================================================================
MSG: geometry_msgs/Point
# This contains the position of a point in free space
float64 x
float64 y
float64 z

================================================================================
MSG: geometry_msgs/Quaternion
# This represents an orientation in free space in quaternion form.

float64 x
float64 y
float64 z
float64 w
")



(provide :delbono_kobra/GetGoal "6b1bac8b4cbb7d20ffd1b4c31b91d825")


