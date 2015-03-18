;;;; evdev.asd

(asdf:defsystem #:evdev
    :description "Linux keyboard event input driver."
    :author "June Tate-Gans <june@theonelab.com>"
    :license "Apache"
    :serial t
    :depends (:binary-types :alexandria)
    :components ((:file "package")
                 (:file "evdev")))
