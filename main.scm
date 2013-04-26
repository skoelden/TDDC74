(load "classes/player.scm")
(load "graphics.scm")
(load "classes/keyboard-handler.scm")
(load "classes/shot.scm")
(load "creator-of-power-ups.scm")
(load "classes/power-up.scm")
(load "classes/game-board.scm")
(load "classes/map.scm")

(require picturing-programs)


(define *game-board* (new game-board%
                          [_width 1000]
                          [_height 1000]
                          [_map (new map%
                                     [path "maps/level1.png"])]
                          [_amount-of-allowed-power-ups 5]))
(define *kh* (new keyboard-handler%))

(new player%
     (right-key #\d)
     (left-key #\a)
     (up-key #\w)
     (down-key #\s)
     (tower-cw-key #\y)
     (tower-ccw-key #\t)
     (shoot-key #\u))

(new player%
     (right-key #\l)
     (left-key #\j)
     (up-key #\i)
     (down-key #\k)
     (tower-cw-key #\p)
     (tower-ccw-key #\o)
     (shoot-key #\å))

;(define (tick!)
 ; (send *canvas* refresh))

;(define *my-timer* (new timer% [notify-callback tick!]))
;(send *my-timer* start 16)

