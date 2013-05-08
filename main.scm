(load "classes/player.scm")
(load "graphics.scm")
(load "classes/keyboard-handler.scm")
(load "classes/shot.scm")
(load "creator-of-power-ups.scm")
(load "classes/power-up.scm")
(load "classes/game-board.scm")
(load "classes/map.scm")
(load "classes/map-tile.scm")


(define *game-board* (new game-board%
                          [_width 1000]
                          [_height 1000]
                          [_map (new map%
                                     [*list-of-tiles* (list
                                                       (new map-tile%
                                                            [_x 250]
                                                            [_y 275]
                                                            [_width 200]
                                                            [_height 50])
                                                       (new map-tile%
                                                            [_x 375]
                                                            [_y 225]
                                                            [_width 50]
                                                            [_height 150])
                                                       (new map-tile%
                                                            [_x 850]
                                                            [_y 150]
                                                            [_width 100]
                                                            [_height 100])
                                                       (new map-tile%
                                                            [_x 500]
                                                            [_y 500]
                                                            [_width 300]
                                                            [_height 50])
                                                       (new map-tile%
                                                            [_x 150]
                                                            [_y 850]
                                                            [_width 100]
                                                            [_height 100])
                                                       (new map-tile%
                                                            [_x 750]
                                                            [_y 725]
                                                            [_width 200]
                                                            [_height 50])
                                                       (new map-tile%
                                                            [_x 625]
                                                            [_y 775]
                                                            [_width 50]
                                                            [_height 150]))])]
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
     (right-key #\b)
     (left-key #\c)
     (up-key #\g)
     (down-key #\v)
     (tower-cw-key 'numpad2)
     (tower-ccw-key 'numpad1)
     (shoot-key 'numpad3))

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

