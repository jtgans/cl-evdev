;;;; package.lisp

(defpackage #:cl-evdev
  (:use #:cl #:binary-types #:alexandria #:local-time #:cl-event-handler)
  (:documentation "Linux keyboard event input driver.")
  (:export #:with-evdev-device
	   #:with-evdev-devices

           #:input-event
           #:keyboard-event
           #:misc-event
           #:read-event

           #:timestamp
           #:state
           #:name
           #:glyph
           #:dropped-events
           #:value
           #:type))
