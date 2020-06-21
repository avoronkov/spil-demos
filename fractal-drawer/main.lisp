#!/usr/bin/env spil
(use std)
(use "fractal.lisp")
(use "snake.lisp")


; ;; point
; (deftype :point :list[float])
; 
; (def point (x:float y:float) :point
; 	 (list x y) :point)
; 
; (def px (p:point) :float (head p) :float)
; (def py (p:point) :float (head (tail p)) :float)
; 
; (def pxint (p:point) :int (int (+ (head p) 0.5)))
; (def pyint (p:point) :int (int (+ (head (tail p)) 0.5)))
; 
; (def padd (p1:point p2:point) :point
; 	 (point (+ (px p1) (px p2)) (+ (py p1) (py p2))))
; 
; (def psub (p1:point p2:point) :point
; 	 (point (- (px p1) (px p2)) (- (py p1) (py p2))))
; 
; 
; 
; ;; angle is in degrees (!)
; (def rotate (dir:point angle:float) :point
; 	 (set x (px dir))
; 	 (set y (py dir))
; 	 (set sina (sin (/ (* 3.1416 angle) 180.0)))
; 	 (set cosa (cos (/ (* 3.1416 angle) 180.0)))
; 	 (point (- (* x cosa) (* y sina)) (+ (* x sina) (* y cosa))))
; 
; 
; ;; make-snake
; (def make-snake (moves:str angle:float dir:point) :list[point]
; 	 (make-snake moves (point 0.0 0.0) angle dir (do '() :list[point])))
; 
; (def make-snake ('()       prev:point angle:float dir:point acc:list[point]) :list[point]
; 	 (append acc prev))
; (def make-snake (moves:str prev:point angle:float dir:point acc:list[point]) :list[point]
; 	 (set h (head moves))
; 	 (set t (tail moves) :str)
; 	 (if (= h "F")
; 	   (make-snake t (padd prev dir) angle dir (do (append acc prev) :list[point]))
; 	   (if (= h "+")
; 		 (do
; 		   (set ndir (rotate dir angle))
; 		   (make-snake t prev angle ndir acc))
; 		 (if (= h "-")
; 		   (do
; 			 (set ndir (rotate dir (- 0.0 angle)))
; 			 (make-snake t prev angle ndir acc))
; 		   (do
; 			 (print "Unsupported symbol (skipping):" h)
; 			 (make-snake t prev angle dir acc))))))
; 
; ;; draw-snake
; (def draw-snake (d:drawer s:list[point])
; 	 (draw-snake d (head s) (tail s)))
; (def draw-snake (d:drawer p:point '()) '())
; (def draw-snake (d:drawer p:point s:list[point])
; 	 (set color (rgb 225 225 255))
; 	 (set h (head s))
; 	 (set t (tail s))
; 	 (draw.line d (pxint p) (pyint p) (pxint h) (pyint h) color)
; 	 (draw-snake d h t))
; 
; (def min (a:float b:float) :float
; 	 (if (< a b) a b))
; 
; (def max (a:float b:float) :float
; 	 (if (> a b) a b))
; 
; ;; extremum points
; (def extremum-point (fn:func p:point '()) :point p)
; (def extremum-point (fn:func p:point snake:list[point]) :point
; 	 (set h (head snake))
; 	 (extremum-point
; 	   fn
; 	   (point
; 		 (fn (px p) (px h))
; 		 (fn (py p) (py h)))
; 	   (tail snake)))
; 
; (def minimum-point (ps:list[point]) :point (extremum-point min (head ps) ps))
; (def maximum-point (ps:list[point]) :point (extremum-point max (head ps) ps))
; 
; ;; normalize-snake
; (def normalize-snake (snake:list[point] offset:float) :list[point]
; 	 (set m (minimum-point snake))
; 	 (apply list (map \(padd (psub _1 m) (point offset offset)) snake)) :list[point])
; 
; (def canvas-size (snake:list[point] offset) :list[int]
; 	 (set mx (padd (maximum-point snake) (point offset offset)))
; 	 (print "canvas-size:" mx snake)
; 	 (list (int (px mx)) (int (py mx))))

; (set moves "F-F+F+F-F")
; (set angle 90.0)
; (set dir (point 10.0 0.0))
; 
; (print (type angle))
; 
; (set snake (make-snake moves angle dir))
; (set nsnake (normalize-snake snake 10.0))
; (set size (canvas-size nsnake 10.0))
; 
; (print "minimal:" (minimum-point snake))
; (print "normalized:" nsnake)
; 
; (print "size:" size)

(set' file (open "koch-snowflake.txt"))
(set fr (fractal-parse file))
(set moves (expand-fractal fr))

(set dir (point 10.0 0.0))
(set snake (make-snake moves (angle fr) dir))
(set nsnake (normalize-snake snake 10.0))
(set size (canvas-size nsnake 10.0))

(set' drawer (drawer.new "example.png" (inc (first size)) (second size)))
(draw-snake drawer nsnake)
