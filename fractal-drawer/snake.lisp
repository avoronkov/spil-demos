; (use std)
(use "point.lisp")
(use "lib/drawer.lisp")

;; make-snake
(def make-snake (moves:str angle:float dir:point) :list[point]
	 (make-snake moves (point 0.0 0.0) angle dir (do '() :list[point])))

(def make-snake ('()       prev:point angle:float dir:point acc:list[point]) :list[point]
	 (append acc prev))
(def make-snake (moves:str prev:point angle:float dir:point acc:list[point]) :list[point]
	 (set h (head moves))
	 (set t (tail moves) :str)
	 (if (= h "F")
	   (make-snake t (padd prev dir) angle dir (do (append acc prev) :list[point]))
	   (if (= h "+")
		 (do
		   (set ndir (rotate dir angle))
		   (make-snake t prev angle ndir acc))
		 (if (= h "-")
		   (do
			 (set ndir (rotate dir (- 0.0 angle)))
			 (make-snake t prev angle ndir acc))
		   (do
			 (print "Unsupported symbol (skipping):" h)
			 (make-snake t prev angle dir acc))))))

;; draw-snake
(def draw-snake (d:drawer s:list[point])
	 (draw-snake d (head s) 1 (length s) (tail s)))
(def draw-snake (d:drawer p:point cur:int tot:int '()) '())
(def draw-snake (d:drawer p:point cur:int tot:int s:list[point])
	 (set color (color-of cur tot))
	 (set h (head s))
	 (set t (tail s))
	 (draw.line d (pxint p) (pyint p) (pxint h) (pyint h) color)
	 (draw-snake d h (inc cur) tot t))

(def min (a:float b:float) :float
	 (if (< a b) a b))

(def max (a:float b:float) :float
	 (if (> a b) a b))

;; extremum points
(def extremum-point (fn:func p:point '()) :point p)
(def extremum-point (fn:func p:point snake:list[point]) :point
	 (set h (head snake))
	 (extremum-point
	   fn
	   (point
		 (fn (px p) (px h))
		 (fn (py p) (py h)))
	   (tail snake)))

(def minimum-point (ps:list[point]) :point (extremum-point min (head ps) ps))
(def maximum-point (ps:list[point]) :point (extremum-point max (head ps) ps))

;; normalize-snake
(def normalize-snake (snake:list[point] offset:float) :list[point]
	 (set m (minimum-point snake))
	 (apply list (map \(padd (psub _1 m) (point offset offset)) snake)) :list[point])

(def canvas-size (snake:list[point] offset) :list[int]
	 (set mx (padd (maximum-point snake) (point offset offset)))
	 ; (print "canvas-size:" mx snake)
	 (list (inc (int (px mx))) (int (py mx))))

;; gradient color
(def color-of (total:int total:int) :rgb (rgb 255 0 0))
(def color-of (i:int total:int) :rgb
     (set l (/ total 3))
     (set sec (/ (- i 1) l))
     (set pos (mod (- i 1) l))
     (if (= sec 0)
       (rgb (- 255 (/ (* 255 pos) l)) (/ (* 255 pos) l) 0)
       (if (= sec 1)
         (rgb 0 (- 255 (/ (* 255 pos) l)) (/ (* 255 pos) l))
         (rgb (/ (* 255 pos) l) 0 (- 255 (/ (* 255 pos) l))))))
