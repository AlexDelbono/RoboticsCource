
(cl:in-package :asdf)

(defsystem "delbono_kobra-srv"
  :depends-on (:roslisp-msg-protocol :roslisp-utils :geometry_msgs-msg
)
  :components ((:file "_package")
    (:file "GetGoal" :depends-on ("_package_GetGoal"))
    (:file "_package_GetGoal" :depends-on ("_package"))
  ))