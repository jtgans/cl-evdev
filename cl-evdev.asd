;;;; evdev.asd

(asdf:defsystem #:cl-evdev
    :description "Linux keyboard event input driver."
    :author "June Tate-Gans <june@theonelab.com>"
    :license "Simplified BSD License"
    :serial t
    :depends-on (#:binary-types
                 #:alexandria)
    :components ((:file "package")
                 (:file "evdev")))
