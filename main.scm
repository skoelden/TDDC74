(load "classes/player.scm")
(load "graphics.scm")
(load "classes/keyboard-handler.scm")
(load "classes/shot.scm")
(load "classes/power-up.scm")
(load "creator-of-power-ups.scm")

(define *kh* (new keyboard-handler%))
(define *list-of-shots* '())
(define *list-of-power-ups* '())
(define *list-of-players* '())

(define p (new player%
               (right-key #\d)
               (left-key #\a)
               (up-key #\w)
               (down-key #\s)
               (tower-cw-key #\y)
               (tower-ccw-key #\t)
               (shoot-key #\u)))

(define p2 (new player%
               (right-key #\l)
               (left-key #\j)
               (up-key #\i)
               (down-key #\k)
               (tower-cw-key #\p)
               (tower-ccw-key #\o)
               (shoot-key #\å)))

(define (tick!)
  (send p update)
  (send p2 update)
  (send *canvas* refresh))

(define *my-timer* (new timer% [notify-callback tick!]))
(send *my-timer* start 16)

