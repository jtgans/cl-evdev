;;;; evdev.asd

(asdf:defsystem #:cl-evdev
    :description "Linux keyboard event input driver."
    :author "June Tate-Gans <june@theonelab.com>"
    :license "Simplified BSD License"
    :serial t
    :depends-on (#:binary-types
                 #:alexandria
                 #:local-time
                 #:cl-event-handler)
    :components ((:file "package")
                 (:file "evdev")))
