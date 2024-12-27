(in-package :cl-evdev)

(define-constant +input-event-types+
  '((#x00 . :ev-syn)
    (#x01 . :ev-key)
    (#x02 . :ev-rel)
    (#x03 . :ev-abs)
    (#x04 . :ev-msc)
    (#x05 . :ev-sw)
    (#x11 . :ev-led)
    (#x12 . :ev-snd)
    (#x14 . :ev-rep)
    (#x15 . :ev-ff)
    (#x16 . :ev-pwr)
    (#x17 . :ev-ff-status))
  :test #'equal
  :documentation "The type of an input event stored in the type field of the
Linux input_event struct in linux/include/uapi/linux/input.h. Not expected to be
used outside of this package.")

(define-constant +input-syn-codes+
    '((0 . :syn-report)
      (1 . :syn-config)
      (2 . :syn-mt-report)
      (3 . :syn-dropped))
  :test #'equal
  :documentation "The code of a Linux EV_SYN event type.

SYN_REPORT is used to synchronize events between the kernel and this driver.
They don't actually contain anything useful other than that.

SYN_DROPPED indicates we've dropped input events because we weren't reading fast
enough, and that we should skip events until the next SYN_REPORT type, and query
via an ioctl to get the current state.")

(define-constant +input-key-states+
  '((0 . :released)
    (1 . :pressed)
    (2 . :repeat))
  :test #'equal
  :documentation "Keyboard input key states as stored in the value field of the
Linux input_event struct in linux/include/uapi/linux/input.h. Not expected to be
used outside of this package.")

(define-constant +input-key-codes+
    '((0 .   (:name reserved         :glyph nil))
      (1 .   (:name esc              :glyph nil))
      (2 .   (:name 1                :glyph #\1))
      (3 .   (:name 2                :glyph #\2))
      (4 .   (:name 3                :glyph #\3))
      (5 .   (:name 4                :glyph #\4))
      (6 .   (:name 5                :glyph #\5))
      (7 .   (:name 6                :glyph #\6))
      (8 .   (:name 7                :glyph #\7))
      (9 .   (:name 8                :glyph #\8))
      (10 .  (:name 9                :glyph #\9))
      (11 .  (:name 0                :glyph #\0))
      (12 .  (:name minus            :glyph #\-))
      (13 .  (:name equal            :glyph #\=))
      (14 .  (:name backspace        :glyph #\Backspace))
      (15 .  (:name tab              :glyph #\Tab))
      (16 .  (:name q                :glyph #\q))
      (17 .  (:name w                :glyph #\w))
      (18 .  (:name e                :glyph #\e))
      (19 .  (:name r                :glyph #\r))
      (20 .  (:name t                :glyph #\t))
      (21 .  (:name y                :glyph #\y))
      (22 .  (:name u                :glyph #\u))
      (23 .  (:name i                :glyph #\i))
      (24 .  (:name o                :glyph #\o))
      (25 .  (:name p                :glyph #\p))
      (26 .  (:name leftbrace        :glyph #\[))
      (27 .  (:name rightbrace       :glyph #\]))
      (28 .  (:name enter            :glyph #\Newline))
      (29 .  (:name leftctrl         :glyph nil))
      (30 .  (:name a                :glyph #\a))
      (31 .  (:name s                :glyph #\s))
      (32 .  (:name d                :glyph #\d))
      (33 .  (:name f                :glyph #\f))
      (34 .  (:name g                :glyph #\g))
      (35 .  (:name h                :glyph #\h))
      (36 .  (:name j                :glyph #\j))
      (37 .  (:name k                :glyph #\k))
      (38 .  (:name l                :glyph #\l))
      (39 .  (:name semicolon        :glyph #\;))
      (40 .  (:name apostrophe       :glyph #\'))
      (41 .  (:name grave            :glyph #\`))
      (42 .  (:name leftshift        :glyph nil))
      (43 .  (:name backslash        :glyph #\\))
      (44 .  (:name z                :glyph #\z))
      (45 .  (:name x                :glyph #\x))
      (46 .  (:name c                :glyph #\c))
      (47 .  (:name v                :glyph #\v))
      (48 .  (:name b                :glyph #\b))
      (49 .  (:name n                :glyph #\n))
      (50 .  (:name m                :glyph #\m))
      (51 .  (:name comma            :glyph #\,))
      (52 .  (:name dot              :glyph #\.))
      (53 .  (:name slash            :glyph #\/))
      (54 .  (:name rightshift       :glyph nil))
      (55 .  (:name kpasterisk       :glyph #\*))
      (56 .  (:name leftalt          :glyph nil))
      (57 .  (:name space            :glyph #\Space))
      (58 .  (:name capslock         :glyph nil))
      (59 .  (:name f1               :glyph nil))
      (60 .  (:name f2               :glyph nil))
      (61 .  (:name f3               :glyph nil))
      (62 .  (:name f4               :glyph nil))
      (63 .  (:name f5               :glyph nil))
      (64 .  (:name f6               :glyph nil))
      (65 .  (:name f7               :glyph nil))
      (66 .  (:name f8               :glyph nil))
      (67 .  (:name f9               :glyph nil))
      (68 .  (:name f10              :glyph nil))
      (69 .  (:name numlock          :glyph nil))
      (70 .  (:name scrolllock       :glyph nil))
      (71 .  (:name kp7              :glyph nil))
      (72 .  (:name kp8              :glyph nil))
      (73 .  (:name kp9              :glyph nil))
      (74 .  (:name kpminus          :glyph nil))
      (75 .  (:name kp4              :glyph nil))
      (76 .  (:name kp5              :glyph nil))
      (77 .  (:name kp6              :glyph nil))
      (78 .  (:name kpplus           :glyph nil))
      (79 .  (:name kp1              :glyph nil))
      (80 .  (:name kp2              :glyph nil))
      (81 .  (:name kp3              :glyph nil))
      (82 .  (:name kp0              :glyph nil))
      (83 .  (:name kpdot            :glyph #\.))
      (85 .  (:name zenkakuhankaku   :glyph nil))
      (86 .  (:name 102nd            :glyph nil))
      (87 .  (:name f11              :glyph nil))
      (88 .  (:name f12              :glyph nil))
      (96 .  (:name kpenter          :glyph #\Newline))
      (97 .  (:name rightctrl        :glyph nil))
      (98 .  (:name kpslash          :glyph nil))
      (99 .  (:name sysrq            :glyph nil))
      (100 . (:name rightalt         :glyph nil))
      (101 . (:name linefeed         :glyph nil))
      (102 . (:name home             :glyph nil))
      (103 . (:name up               :glyph nil))
      (104 . (:name pageup           :glyph nil))
      (105 . (:name left             :glyph nil))
      (106 . (:name right            :glyph nil))
      (107 . (:name end              :glyph nil))
      (108 . (:name down             :glyph nil))
      (109 . (:name pagedown         :glyph nil))
      (110 . (:name insert           :glyph nil))
      (111 . (:name delete           :glyph #\Delete))
      (112 . (:name macro            :glyph nil))
      (113 . (:name mute             :glyph nil))
      (114 . (:name volumedown       :glyph nil))
      (115 . (:name volumeup         :glyph nil))
      (116 . (:name power            :glyph nil))
      (117 . (:name kpequal          :glyph #\=))
      (118 . (:name kpplusminus      :glyph nil))
      (119 . (:name pause            :glyph nil))
      (277 . (:name btnforward      :glyph nil))
      (278 . (:name btnback         :glyph nil)))
   :test #'equal
  :documentation "List of key code to key symbol name and printable character.
Used to decode the code field of the Linux input_event struct defined in
linux/include/uapi/linux/input.h.")

(define-constant +input-abs-codes+
 '((0 . (:name ABS_X))
   (1 . (:name ABS_Y))
   (24 . (:name ABS_PRESSURE))
   (40 . (:name ABS_MISC)))
  :test #'equal
  :documentation "Absolute device values for pointer and tablet hardware."
)

(define-constant +input-rel-codes+
 '((8 . (:name REL_WHEEL)))
  :test #'equal
  :documentation "Relative motion types."
)


(cond ((equal (machine-type) "X86")
       (define-unsigned unsigned-long-int 4))
      ((equal (machine-type) "X86-64")
       (define-unsigned unsigned-long-int 8))
      (t 4))
(define-unsigned unsigned-short 2)
(define-unsigned unsigned-int 4)

(define-binary-class input-event-struct ()
  ((tv_sec  :binary-type unsigned-long-int)
   (tv_usec :binary-type unsigned-long-int)
   (type    :binary-type unsigned-short)
   (code    :binary-type unsigned-short)
   (value   :binary-type unsigned-int))
  (:documentation "This is a verbaticm copy of the input_event struct defined in
linux/include/uapi/linux/input.h. This is used to read in each event straight
from raw evdev data. Unix time values bit widths differ on 32/64bit systems and
based on the return value of (machine-type) in SBCL."))

(defclass input-event (event)
  ((timestamp :initarg :timestamp
              :type duration))
  (:documentation "The base class for evdev input events."))

(defmethod print-object ((object input-event-struct) stream)
  (print-unreadable-object (object stream :type t)
    (with-slots (tv_sec tv_usec type code value) object
      (let ((type (cdr (assoc type +input-event-types+))))
        (format stream ":TV_SEC ~a :TV_USEC ~a :TYPE ~a :CODE ~a :VALUE ~a"
                tv_sec tv_usec type code value)))))

(defmethod print-object ((object input-event) stream)
  (print-unreadable-object (object stream :type t)
    (with-slots (timestamp) object
      (format stream ":TIMESTAMP ~a"
              timestamp))))

(defclass keyboard-event (input-event)
  ((state :initarg :state
          :type (or :released :pressed :repeat)
          :documentation
          "The state of the key for this event. One of :RELEASED, :PRESSED, or
:REPEAT.")
   (name :initarg :name
         :accessor :name
         :documentation
         "The human-readable name for the key. Every key event has one.")
   (glyph :initarg :glyph
          :accessor :glyph
          :documentation
          "The character code point for this key. May be NIL."))
  (:documentation "An INPUT-EVENT that contains keyboard-specific state data."))

(defmethod print-object ((object keyboard-event) stream)
  (print-unreadable-object (object stream :type t)
    (with-slots (name glyph state) object
      (format stream ":NAME ~a :GLYPH ~a :STATE ~a" name glyph state))))

(defclass sync-event (input-event)
  ((dropped-events :initarg :dropped-events
                   :type boolean
                   :documentation
                   "Whether or not events have been dropped between this event
and the next SYNC-EVENT."))
  (:documentation "An INPUT-EVENT that contains synchronization state data."))

(defmethod print-object ((object sync-event) stream)
  (print-unreadable-object (object stream :type t)
    (with-slots (dropped-events) object
      (format stream ":DROPPED-EVENTS ~a" dropped-events))))

(defclass misc-event (input-event)
  ()
  (:documentation "Represents a miscellaneous evdev event."))

(defclass absolute-event (input-event)
  ((value :initarg :value
          :type integer)
   (type  :initarg :type
          :type (or :x :y :pressure :misc)))
  (:documentation "An INPUT-EVENT that contains absolute position data."))

(defmethod print-object ((object absolute-event) stream)
  (print-unreadable-object (object stream :type t)
    (with-slots (type value) object
      (format stream ":TYPE ~a :VALUE ~a" type value))))

(defclass relative-event (input-event)
  ((value :initarg :value
          :type integer)
   (type  :initarg :type
          :type (or :wheel :misc)))
  (:documentation "An INPUT-EVENT that contains relative motion data."))

(defmethod print-object ((object relative-event) stream)
  (print-unreadable-object (object stream :type t)
    (with-slots (type value) object
      (format stream ":TYPE ~a :VALUE ~a " type value))))


(defun read-raw-event (stream)
  "Reads in a single INPUT-EVENT-STRUCT from STREAM."
  (let ((*endian* :little-endian))
    (read-binary 'input-event-struct stream)))

(defun raw-event-struct-type (struct)
  "Returns a symbol denoting the event type for the given STRUcT."
  (with-slots (type) struct
    (rest (assoc type +input-event-types+))))

(defun usecs-to-nsecs (usecs)
  "converts evdev tv_usec microseconds to nanoseconds."
  (* usecs 1000))

(defun read-event (stream)
  "Reads an event from the evdev data STREAM and returns an instance of INPUT-EVENT."
  (let* ((*endian* :little-endian)
         (event (read-raw-event stream)))
    (with-slots (tv_sec tv_usec type code value) event
      (let ((event-type (raw-event-struct-type event))
            (timestamp (unix-to-timestamp tv_sec :nsec (usecs-to-nsecs tv_usec))))
        (cond ((eq event-type :ev-key)
               (let* ((key-code (rest (assoc code +input-key-codes+)))
                      (name (getf key-code :name))
                      (glyph (getf key-code :glyph))
                      (state (rest (assoc value +input-key-states+))))
                 (make-instance 'keyboard-event
                                :timestamp timestamp
                                :name name
                                :glyph glyph
                                :state state)))
              ((eq event-type :ev-abs)
               (let* ((abs-code (rest (assoc code +input-abs-codes+)))
                      (type (getf abs-code :type)))
                 (make-instance 'absolute-event
                                :timestamp timestamp
                                :type abs-code
                                :value value)))
              ((eq event-type :ev-msc)
               (make-instance 'misc-event
                              :timestamp timestamp))
              ((eq event-type :ev-rel)
               (let* ((abs-code (rest (assoc code +input-rel-codes+)))
                      (type (getf abs-code :type)))
                 (make-instance 'relative-event
                                :timestamp timestamp
                                :type abs-code
                                :value value)))
              ((eq event-type :ev-syn)
               (let ((syn-code (rest (assoc code +input-syn-codes+))))
                 (make-instance 'sync-event
                                :timestamp timestamp
                                :dropped-events (eq syn-code :syn-dropped))))
              (t (warn "Unknown evdev event type ~S" event-type) nil))))))

(defmacro with-evdev-device ((event-var device-path)
                             &body body)
  "Opens DEVICE-PATH for reading, reads in individual events into EVENT-VAR and
calls BODY for each event passed in. DEVICE-PATH must exist, otherwise an error
condition is signaled."
  (let ((stream (gensym)))
    `(with-open-file (,stream ,device-path
                              :element-type '(unsigned-byte 8)
                              :direction :io
                              :if-does-not-exist :error
                              :if-exists :append)
       (loop
         for ,event-var = (read-event ,stream)
         while ,event-var
         do (progn ,@body)))))
