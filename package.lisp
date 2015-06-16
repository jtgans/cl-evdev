;;;; package.lisp

(defpackage #:cl-evdev
  (:use #:cl #:binary-types #:alexandria #:local-time #:cl-event-handler)
  (:documentation "Linux keyboard event input driver.")
  (:export input-event
           keyboard-event
           misc-event
           read-event))
