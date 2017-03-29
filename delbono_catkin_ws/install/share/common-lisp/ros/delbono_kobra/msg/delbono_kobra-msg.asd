
(cl:in-package :asdf)

(defsystem "delbono_kobra-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "Ptz" :depends-on ("_package_Ptz"))
    (:file "_package_Ptz" :depends-on ("_package"))
    (:file "OdomInfo" :depends-on ("_package_OdomInfo"))
    (:file "_package_OdomInfo" :depends-on ("_package"))
  ))